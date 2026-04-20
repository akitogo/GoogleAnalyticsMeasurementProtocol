/**
* GA4 Measurement Protocol Event Structure
*/
component accessors="true" {

	// Required GA4 properties
	property name="measurement_id" default="";		// GA4 Measurement ID (G-XXXXXXXXXX)
	property name="api_secret" default="";			// GA4 API Secret (required for server-side)
	property name="client_id" default="";			// Client ID (required)
	property name="user_id" default="";				// User ID (optional)
	property name="timestamp_micros" default="";	// Timestamp in microseconds (optional)
	property name="user_properties" default="";		// User properties object (optional)
	property name="non_personalized_ads" default="false";	// Non-personalized ads flag
	property name="events" default="";				// Array of events

	// Event properties
	property name="event_name" default="";			// Event name (e.g., 'page_view', 'purchase')
	property name="event_parameters" default="";	// Event parameters struct

	// Common event parameters
	property name="page_title" default="";
	property name="page_location" default="";
	property name="page_referrer" default="";
	property name="language" default="";
	property name="screen_resolution" default="";
	property name="engagement_time_msec" default="";

	// E-commerce parameters
	property name="currency" default="";
	property name="value" default="";
	property name="transaction_id" default="";
	property name="items" default="";				// Array of item objects

	// Custom parameters
	property name="custom_parameters" default="";	// Struct for custom event parameters

	MeasurementProtocol function init() {
		setEvents([]);
		setEvent_parameters({});
		setUser_properties({});
		setCustom_parameters({});
		setItems([]);
		return this;
	}

	// Helper methods for GA4

	/**
	* Set the GA4 Measurement ID
	*/
	function setMeasurementId(required string measurementId) {
		setMeasurement_id(arguments.measurementId);
		return this;
	}

	/**
	* Set the API Secret (required for server-side events)
	*/
	function setApiSecret(required string apiSecret) {
		setApi_secret(arguments.apiSecret);
		return this;
	}

	/**
	* Set the Client ID (required)
	*/
	function setClientId(required string clientId) {
		setClient_id(arguments.clientId);
		return this;
	}

	/**
	* Set the User ID (optional)
	*/
	function setUserId(string userId) {
		setUser_id(arguments.userId);
		return this;
	}

	/**
	* Add a page view event
	*/
	function addPageViewEvent(required string pageTitle, required string pageLocation, string pageReferrer="") {
		var event = {
			"name": "page_view",
			"params": {
				"page_title": arguments.pageTitle,
				"page_location": arguments.pageLocation
			}
		};
		
		if (len(arguments.pageReferrer)) {
			event.params["page_referrer"] = arguments.pageReferrer;
		}

		addLanguageIfSet(event.params);
		addScreenResolutionIfSet(event.params);
		addCustomParameters(event.params);

		arrayAppend(getEvents(), event);
		return this;
	}

	/**
	* Add a custom event
	*/
	function addCustomEvent(required string eventName, struct parameters={}) {
		var event = {
			"name": arguments.eventName,
			"params": arguments.parameters
		};

		addCustomParameters(event.params);

		arrayAppend(getEvents(), event);
		return this;
	}

	/**
	* Add an e-commerce purchase event
	*/
	function addPurchaseEvent(required string transactionId, required numeric value, string currency="USD", array items=[]) {
		var event = {
			"name": "purchase",
			"params": {
				"transaction_id": arguments.transactionId,
				"value": arguments.value,
				"currency": arguments.currency,
				"items": arguments.items
			}
		};

		addCustomParameters(event.params);

		arrayAppend(getEvents(), event);
		return this;
	}

	/**
	* Add an item to the items array
	*/
	function addItem(required string itemId, required string itemName, required string category, numeric quantity=1, numeric price=0) {
		var item = {
			"item_id": arguments.itemId,
			"item_name": arguments.itemName,
			"item_category": arguments.category,
			"quantity": arguments.quantity,
			"price": arguments.price
		};

		arrayAppend(getItems(), item);
		return this;
	}

	/**
	* Set user property
	*/
	function setUserProperty(required string propertyName, required any value) {
		var userProps = getUser_properties();
		if (!isStruct(userProps)) {
			userProps = {};
		}
		userProps[arguments.propertyName] = {"value": arguments.value};
		setUser_properties(userProps);
		return this;
	}

	/**
	* Add custom parameter to all events
	*/
	function addCustomParameter(required string parameterName, required any value) {
		var customParams = getCustom_parameters();
		if (!isStruct(customParams)) {
			customParams = {};
		}
		customParams[arguments.parameterName] = arguments.value;
		setCustom_parameters(customParams);
		return this;
	}

	/**
	* Set page location URL
	*/
	function setPageLocation(required string url) {
		setPage_location(arguments.url);
		return this;
	}

	/**
	* Set page title
	*/
	function setPageTitle(required string title) {
		setPage_title(arguments.title);
		return this;
	}

	/**
	* Set page referrer
	*/
	function setPageReferrer(string referrer) {
		setPage_referrer(arguments.referrer);
		return this;
	}

	/**
	* Set language
	*/
	function setLanguage(string language) {
		variables.language = arguments.language;
		return this;
	}

	/**
	* Set screen resolution
	*/
	function setScreenResolution(string resolution) {
		setScreen_resolution(arguments.resolution);
		return this;
	}

	/**
	* Set engagement time in milliseconds
	*/
	function setEngagementTime(numeric milliseconds) {
		setEngagement_time_msec(arguments.milliseconds);
		return this;
	}

	// Private helper methods

	private function addLanguageIfSet(required struct params) {
		if (len(getLanguage())) {
			arguments.params["language"] = getLanguage();
		}
	}

	private function addScreenResolutionIfSet(required struct params) {
		if (len(getScreen_resolution())) {
			arguments.params["screen_resolution"] = getScreen_resolution();
		}
	}

	private function addCustomParameters(required struct params) {
		var customParams = getCustom_parameters();
		if (isStruct(customParams)) {
			structAppend(arguments.params, customParams);
		}
	}

	/**
	* Build the complete GA4 payload
	*/
	function getPayload() {
		// IMPORTANT: always assign keys via bracket notation. CFML uppercases
		// dot-notation struct keys, and GA4 MP rejects the whole payload when it
		// sees keys like USER_PROPERTIES instead of user_properties.
		var payload = {
			"client_id": getClient_id()
		};

		if (len(getUser_id())) {
			payload["user_id"] = getUser_id();
		}

		if (len(getTimestamp_micros())) {
			payload["timestamp_micros"] = getTimestamp_micros();
		}

		if (getNon_personalized_ads() == "true") {
			payload["non_personalized_ads"] = true;
		}

		var userProps = getUser_properties();
		if (isStruct(userProps) && !structIsEmpty(userProps)) {
			payload["user_properties"] = userProps;
		}

		payload["events"] = getEvents();

		return payload;
	}

	/**
	* Validate required fields
	*/
	function isValid() {
		if (!len(getMeasurement_id())) return false;
		if (!len(getApi_secret())) return false;
		if (!len(getClient_id())) return false;
		if (arrayIsEmpty(getEvents())) return false;
		
		return true;
	}
}