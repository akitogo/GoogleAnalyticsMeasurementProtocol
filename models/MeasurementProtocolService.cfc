component {
	
	MeasurementProtocolService function init(){
		
		return this;
	}



	String function CreateUUIDv4(){
		
		return createobject("java", "java.util.UUID").randomUUID().toString();
	}
	/**
	* send
	*/	
	public boolean function send(MeasurementProtocol,boolean threaded=false) {
		var a=getPropertiesAsKeyValue(MeasurementProtocol);

		var payload=buildPayload(a);

		if(!arguments.threaded)
			return httpPost('www.google-analytics.com/collect',payload);
			
		httpPostThreaded('www.google-analytics.com/collect',payload);
		return true;
	}
	

	private string function buildPayload(arr) {
		var payload='';

		for(var i=1; i <= arrayLen(arr); i++){
			var concatby='&';
			if(i eq 1)
				concatby='';
				
			payload=payload&concatby&arr[i].key&'='&urlEncodedformat(arr[i].value);
		}
		return payload;
	}

	private array function getPropertiesAsKeyValue(cfComponent) {
		var propertyValues = [];
		var allProperties = getMetaData(cfComponent).properties;

		for(var i=1; i <= arrayLen(allProperties); i++){
			var property = {};
			property.key = allProperties[i].name;
			property.value = getPropertyValue(cfComponent,property.key);

			if(!isNull(property.value))
				arrayAppend(propertyValues,property);
		}
		return propertyValues;
	}
	
	private any function getPropertyValue(cfComponent,String key){
		var method = cfComponent["get#key#"];
		return method();
	}	
	
	
	/**
	* httpPost
	*/		
	boolean function httpPost(uri,body){
	    var httpService = new http(); 
	    httpService.setMethod('post'); 
	    httpService.setUrl(uri);
	    httpService.setTimeOut(5); 
	    httpService.addParam(type="body",  value=arguments.body);

	    var result = {};
	    result = httpService.send().getPrefix();

	    if(structkeyExists(result,'status_code') and result.status_code eq "200")
			return true;

		return false;
	}
	/**
	* httpPostThreaded
	*/		
	boolean function httpPostThreaded(uri,body){
		thread
			action="run"
			name=createUuid()
			uri=arguments.uri
			body=arguments.body
		{
		    var httpService = new http(); 
		    httpService.setMethod('post'); 
		    httpService.setUrl(uri);
		    httpService.setTimeOut(5); 
		    httpService.addParam(type="body",  value=body);
		    httpService.send().getPrefix();			
		}
		return true;
	}					
}

