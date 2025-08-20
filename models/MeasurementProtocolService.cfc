component {
	
	MeasurementProtocolService function init(){
		return this;
	}

	/**
	* Generate a UUID v4 for client_id
	*/
	String function CreateUUIDv4(){
		return createobject("java", "java.util.UUID").randomUUID().toString();
	}

	/**
	* Send GA4 event(s) via Measurement Protocol
	* @MeasurementProtocol The MeasurementProtocol object containing GA4 data
	* @threaded Whether to send the request asynchronously
	*/	
	public boolean function send(required MeasurementProtocol, boolean threaded=false) {
		
		// Validate the measurement protocol object
		if (!arguments.MeasurementProtocol.isValid()) {
			throw(message="Invalid MeasurementProtocol object. Missing required fields: measurement_id, api_secret, client_id, or events.", type="GA4.ValidationError");
		}

		var measurementId = arguments.MeasurementProtocol.getMeasurement_id();
		var apiSecret = arguments.MeasurementProtocol.getApi_secret();
		var payload = arguments.MeasurementProtocol.getPayload();

		// Build the GA4 endpoint URL
		var endpointUrl = buildGA4Endpoint(measurementId, apiSecret);

		// Convert payload to JSON (preserve case for GA4 compatibility)
		var jsonPayload = serializeJSON(payload, false, false);

		if (!arguments.threaded) {
			return httpPostJSON(endpointUrl, jsonPayload);
		}
		
		httpPostJSONThreaded(endpointUrl, jsonPayload);
		return true;
	}
	
	/**
	* Send GA4 debug event (for testing/validation)
	* @MeasurementProtocol The MeasurementProtocol object containing GA4 data
	*/
	public struct function sendDebug(required MeasurementProtocol) {
		
		// Validate the measurement protocol object
		if (!arguments.MeasurementProtocol.isValid()) {
			throw(message="Invalid MeasurementProtocol object. Missing required fields: measurement_id, api_secret, client_id, or events.", type="GA4.ValidationError");
		}

		var measurementId = arguments.MeasurementProtocol.getMeasurement_id();
		var apiSecret = arguments.MeasurementProtocol.getApi_secret();
		var payload = arguments.MeasurementProtocol.getPayload();

		// Build the GA4 debug endpoint URL
		var debugUrl = buildGA4DebugEndpoint(measurementId, apiSecret);

		// Convert payload to JSON (preserve case for GA4 compatibility)
		var jsonPayload = serializeJSON(payload, false, false);

		// Send and return the debug response
		return httpPostJSONDebug(debugUrl, jsonPayload);
	}

	/**
	* Build the GA4 Measurement Protocol endpoint URL
	* @measurementId The GA4 Measurement ID (G-XXXXXXXXXX)
	* @apiSecret The GA4 API Secret
	*/
	private string function buildGA4Endpoint(required string measurementId, required string apiSecret) {
		return "https://www.google-analytics.com/mp/collect?measurement_id=" & arguments.measurementId & "&api_secret=" & arguments.apiSecret;
	}

	/**
	* Build the GA4 Measurement Protocol debug endpoint URL
	* @measurementId The GA4 Measurement ID (G-XXXXXXXXXX)
	* @apiSecret The GA4 API Secret
	*/
	private string function buildGA4DebugEndpoint(required string measurementId, required string apiSecret) {
		return "https://www.google-analytics.com/debug/mp/collect?measurement_id=" & arguments.measurementId & "&api_secret=" & arguments.apiSecret;
	}

	/**
	* HTTP POST with JSON payload for GA4
	* @uri The endpoint URL
	* @jsonPayload The JSON payload to send
	*/
	private boolean function httpPostJSON(required string uri, required string jsonPayload) {
		try {
			var httpService = new http(); 
			httpService.setMethod('POST'); 
			httpService.setUrl(arguments.uri);
			httpService.setTimeOut(10); 
			httpService.addParam(type="header", name="Content-Type", value="application/json");
			httpService.addParam(type="body", value=arguments.jsonPayload);

			var result = httpService.send().getPrefix();

			// GA4 returns 204 No Content on success
			if (structKeyExists(result, 'status_code') && (result.status_code == "204" || result.status_code == "200")) {
				return true;
			}

			// Log error for debugging
			if (structKeyExists(result, 'filecontent')) {
				writeLog(file="ga4_errors", text="GA4 API Error: " & result.filecontent);
			}

			return false;

		} catch (any e) {
			writeLog(file="ga4_errors", text="GA4 HTTP Error: " & e.message);
			return false;
		}
	}

	/**
	* HTTP POST with JSON payload for GA4 debug endpoint
	* @uri The debug endpoint URL
	* @jsonPayload The JSON payload to send
	*/
	private struct function httpPostJSONDebug(required string uri, required string jsonPayload) {
		var debugResult = {
			"success": false,
			"response": "",
			"validationMessages": []
		};

		try {
			var httpService = new http(); 
			httpService.setMethod('POST'); 
			httpService.setUrl(arguments.uri);
			httpService.setTimeOut(10); 
			httpService.addParam(type="header", name="Content-Type", value="application/json");
			httpService.addParam(type="body", value=arguments.jsonPayload);

			var result = httpService.send().getPrefix();

			debugResult.response = result.filecontent ?: "";
			
			if (structKeyExists(result, 'status_code') && (result.status_code == "200" || result.status_code == "204")) {
				debugResult.success = true;
				
				// Parse validation messages from debug response
				if (len(debugResult.response)) {
					try {
						var responseData = deserializeJSON(debugResult.response);
						if (structKeyExists(responseData, 'validationMessages')) {
							debugResult.validationMessages = responseData.validationMessages;
						}
					} catch (any e) {
						// Response might not be JSON
					}
				}
			}

		} catch (any e) {
			debugResult.response = "HTTP Error: " & e.message;
		}

		return debugResult;
	}

	/**
	* HTTP POST with JSON payload (threaded) for GA4
	* @uri The endpoint URL
	* @jsonPayload The JSON payload to send
	*/
	private boolean function httpPostJSONThreaded(required string uri, required string jsonPayload) {
		thread
			action="run"
			name=createUuid()
			uri=arguments.uri
			jsonPayload=arguments.jsonPayload
		{
			try {
				var httpService = new http(); 
				httpService.setMethod('POST'); 
				httpService.setUrl(uri);
				httpService.setTimeOut(10); 
				httpService.addParam(type="header", name="Content-Type", value="application/json");
				httpService.addParam(type="body", value=jsonPayload);
				
				var result = httpService.send().getPrefix();

				// Log errors in threaded mode
				if (!structKeyExists(result, 'status_code') || (result.status_code != "204" && result.status_code != "200")) {
					if (structKeyExists(result, 'filecontent')) {
						writeLog(file="ga4_errors", text="GA4 Threaded Error: " & result.filecontent);
					}
				}

			} catch (any e) {
				writeLog(file="ga4_errors", text="GA4 Threaded HTTP Error: " & e.message);
			}
		}
		return true;
	}

	/**
	* Helper method to create a basic page view measurement protocol object
	* @measurementId GA4 Measurement ID
	* @apiSecret GA4 API Secret  
	* @clientId Client ID (UUID)
	* @pageTitle Page title
	* @pageLocation Page URL
	* @pageReferrer Page referrer (optional)
	*/
	public MeasurementProtocol function createPageViewEvent(
		required string measurementId,
		required string apiSecret,
		required string clientId,
		required string pageTitle,
		required string pageLocation,
		string pageReferrer=""
	) {
		var mp = new MeasurementProtocol();
		mp.setMeasurementId(arguments.measurementId);
		mp.setApiSecret(arguments.apiSecret);
		mp.setClientId(arguments.clientId);
		mp.addPageViewEvent(arguments.pageTitle, arguments.pageLocation, arguments.pageReferrer);
		
		return mp;
	}

	/**
	* Helper method to create a basic custom event measurement protocol object
	* @measurementId GA4 Measurement ID
	* @apiSecret GA4 API Secret
	* @clientId Client ID (UUID)
	* @eventName Event name
	* @eventParameters Event parameters struct
	*/
	public MeasurementProtocol function createCustomEvent(
		required string measurementId,
		required string apiSecret,
		required string clientId,
		required string eventName,
		struct eventParameters={}
	) {
		var mp = new MeasurementProtocol();
		mp.setMeasurementId(arguments.measurementId);
		mp.setApiSecret(arguments.apiSecret);
		mp.setClientId(arguments.clientId);
		mp.addCustomEvent(arguments.eventName, arguments.eventParameters);
		
		return mp;
	}
}