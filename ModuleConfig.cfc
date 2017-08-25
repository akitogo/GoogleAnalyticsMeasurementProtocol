/**


*/
component {

	// Module Properties
	this.title 				= "GoogleAnalyticsMeasurementProtocol";
	this.author 			= "Akitogo Internet and Media Applications GmbH";
	this.webURL 			= "https://www.akitogo.com";
	this.description 		= "";
	this.version			= "0.9.0";
	// If true, looks for views in the parent first, if not found, then in the module. Else vice-versa
	this.viewParentLookup 	= true;
	// If true, looks for layouts in the parent first, if not found, then in module. Else vice-versa
	this.layoutParentLookup = true;
	// Module Entry Point
	this.entryPoint			= "GoogleAnalyticsMeasurementProtocol";
	// Model Namespace
	this.modelNamespace		= "GoogleAnalyticsMeasurementProtocol";
	// CF Mapping
	this.cfmapping			= "GoogleAnalyticsMeasurementProtocol";
	// Auto-map models
	this.autoMapModels		= true;
	// Module Dependencies
	this.dependencies 		= [];

	function configure(){

		// parent settings
		parentSettings = {

		};

		// module settings - stored in modules.name.settings
		settings = {

		};

		// Layout Settings
		layoutSettings = {
			defaultLayout = ""
		};

		// datasources
		datasources = {

		};

		// SES Routes
		routes = [
			// Module Entry Point
			{ pattern="/", handler="home", action="index" },
			// Convention Route
			{ pattern="/:handler/:action?" }
		];

		// Custom Declared Points
		interceptorSettings = {
			customInterceptionPoints = ""
		};

		// Custom Declared Interceptors
		interceptors = [
		];

		// Binder Mappings
		// binder.map("Alias").to("#moduleMapping#.model.MyService");
		binder.map("MeasurementProtocolService").to("#moduleMapping#.models.MeasurementProtocolService");		
		binder.map("MeasurementProtocol").to("#moduleMapping#.models.MeasurementProtocol");		


	}

	/**
	* Fired when the module is registered and activated.
	*/
	function onLoad(){

	}

	/**
	* Fired when the module is unregistered and unloaded
	*/
	function onUnload(){

	}

}