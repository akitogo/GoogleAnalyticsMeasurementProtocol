/**
* Measurement Protocol Parameter Reference
*/
component accessors="true"  {



	property name="v"	default="1";	// Protocol Version
										// Required for all hit types.

										// The Protocol version. The current value is '1'. This will only change when there are changes made that are not backwards compatible.


	property name="tid"	default="";		//Tracking ID / Web Property ID
										//Required for all hit types.
										//The tracking ID / web property ID. The format is UA-XXXX-Y. All collected data is associated by this ID.


	property name="aip";				//Anonymize IP
										//Optional.
										//When present, the IP address of the sender will be anonymized. For example, the IP will be anonymized if any of the following parameters are present in the payload: &aip=, &aip=0, or &aip=1


	property name="ds";					//Data Source
										//Optional.
										//Indicates the data source of the hit. Hits sent from analytics.js will have data source set to 'web'; hits sent from one of the mobile SDKs will have data source set to 'app'.

	property name="qt";					//
										//Optional.
										//Used to collect offline / latent hits. The value represents the time delta (in milliseconds) between when the hit being reported occurred and the time the hit was sent. The value must be greater than or equal to 0. Values greater than four hours may lead to hits not being processed.


	property name="z";					//Cache Buster
										//Optional.
										//Used to send a random number in GET requests to ensure browsers and proxies don't cache hits. It should be sent as the final parameter of the request since we've seen some 3rd party internet filtering software add additional parameters to HTTP requests incorrectly. This value is not used in reporting.


// User

	property name="cid";				//Client ID
										//Required for all hit types.
										//This anonymously identifies a particular user, device, or browser instance. For the web, this is generally stored as a first-party cookie with a two-year expiration. For mobile apps, this is randomly generated for each particular instance of an application install. The value of this field should be a random UUID (version 4) as described in http://www.ietf.org/rfc/rfc4122.txt

	property name="uid";				//User ID
										//Optional.
										//This is intended to be a known identifier for a user provided by the site owner/tracking library user. It must not itself be PII (personally identifiable information). The value should never be persisted in GA cookies or other Analytics provided storage.

//Session

	property name="sc";					//Session Control
										//Optional.
										//Used to control the session duration. A value of 'start' forces a new session to start with this hit and 'end' forces the current session to end with this hit. All other values are ignored.

	property name="uip";				// IP Override
										//Optional.
										//The IP address of the user. This should be a valid IP address in IPv4 or IPv6 format. It will always be anonymized just as though &aip (anonymize IP) had been used.


	property name="ua";					// User Agent Override
										//Optional.
										//The User Agent of the browser. Note that Google has libraries to identify real user agents. Hand crafting your own agent could break at any time.


	property name="geoid";				//Geographical Override
										//Optional.
										//The geographical location of the user. The geographical ID should be a two letter country code or a criteria ID representing a city or region (see http://developers.google.com/analytics/devguides/collection/protocol/v1/geoid). This parameter takes precedent over any location derived from IP address, including the IP Override parameter. An invalid code will result in geographical dimensions to be set to '(not set)'.


//Traffic Sources


	property name="dr" ;					//Document Referrer
										//Optional.
										//Specifies which referral source brought traffic to a website. This value is also used to compute the traffic source. The format of this value is a URL.
										// dr	text	None	2048 Bytes	all

	property name="cn";					//Campaign Name
										//Optional.
										//Specifies the campaign name.

										//cn	text	None	100 Bytes	all

	property name="cs";					//Campaign Source
										//Optional.
										//Specifies the campaign source.

										//cs	text	None	100 Bytes	all

	property name="cm";					// Campaign Medium
										//Optional.
										//Specifies the campaign medium.

										// cm	text	None	50 Bytes	all

	property name="ck";					//Campaign Keyword
										//Optional.
										//Specifies the campaign keyword.

										//ck	text	None	500 Bytes	all


	property name="cc";					//Campaign Content
										//Optional.
										//Specifies the campaign content.

										// cc	text	None	500 Bytes	all


	property name="ci";					//Campaign ID
										//Optional.
										//Specifies the campaign ID.

										// ci	text	None	100 Bytes	all

	property name="gclid";				// Google AdWords ID
										//Optional.

										// Specifies the Google AdWords Id.

										//Parameter	Value Type	Default Value	Max Length	Supported Hit Types


	property name="dclid";				//Google Display Ads ID

										//Optional.

										//Specifies the Google Display Ads Id.



//System Info

	property name="sr";					//Screen Resolution
										//Optional.
										//Specifies the screen resolution.

										// sr	text	None	20 Bytes	all


	property name="vp";					//Viewport size
										//Optional.
										//Specifies the viewable area of the browser / device.

										//vp	text	None	20 Bytes	all


	property name="de";					//Document Encoding
										//Optional.
										//Specifies the character set used to encode the page / document.

										//de	text	UTF-8	20 Bytes	all


	property name="sd";					//Screen Colors
										//Optional.
										//Specifies the screen color depth.

										//sd	text	None	20 Bytes	all


	property name="ul";					//User Language
										//Optional.
										//Specifies the language.
										//ul	text	None	20 Bytes	all

	property name="je";					//Java Enabled
										//Optional.
										//Specifies whether Java was enabled.


	property name="fv";					//Flash Version
										//Optional.
										//Specifies the flash version.

										// fl	text	None	20 Bytes	all

//Hit

	property name="t";					//Hit type
										//Required for all hit types.
										//The type of hit. Must be one of 'pageview', 'screenview', 'event', 'transaction', 'item', 'social', 'exception', 'timing'.


	property name="ni";					//Non-Interaction Hit
										//Optional.
										//Specifies that a hit be considered non-interactive.


//Content Information


	property name="dl";					//Document location URL					
										//Optional.
										//Use this parameter to send the full URL (document location) of the page on which content resides. You can use the &dh and &dp parameters to override the hostname and path + query portions of the document location, accordingly. The JavaScript clients determine this parameter using the concatenation of the document.location.origin + document.location.pathname + document.location.search browser parameters. Be sure to remove any user authentication or other private information from the URL if present. For 'pageview' hits, either &dl or both &dh and &dp have to be specified for the hit to be valid.

										// dl	text	None	2048 Bytes	all

	property name="dh";					//Document Host Name
										//Optional.
										//Specifies the hostname from which content was hosted.
										//dh	text	None	100 Bytes	all

	property name="dp";					//Document Path
										//Optional.
										//The path portion of the page URL. Should begin with '/'. For 'pageview' hits, either &dl or both &dh and &dp have to be specified for the hit to be valid.

										// dp	text	None	2048 Bytes	all

	property name="dt";					//Document Title
										//Optional.
										//The title of the page / document.

										// dt	text	None	1500 Bytes	all


	property name="cd";					//Screen Name
										//Required for screenview hit type.
										//This parameter is optional on web properties, and required on mobile properties for screenview hits, where it is used for the 'Screen Name' of the screenview hit. On web properties this will default to the unique URL of the page by either using the &dl parameter as-is or assembling it from &dh and &dp.

										// cd	text	None	2048 Bytes	screenview


	property name="cg";					//Content Group
										//Optional.
										//Each content group has an associated index. There is a maximum of 10 contents groups. The group index must be a positive integer between 1 and 10, inclusive. The value of a content group is heirarchichal text delimited by '/" All leading and trailing slashes will be removed and any repeated slashes will be reduced to a single slash. For example, '/a//b/' will be converted to 'a/b'.
										// cg<groupIndex>	text	None	100 Bytes	all

	property name="linkId";				//Link ID
										//Optional.
										//The ID of a clicked DOM element, used to disambiguate multiple links to the same URL in In-Page Analytics reports when Enhanced Link Attribution is enabled for the property.


//App Tracking

	property name="an";					//Application Name
										//Optional.
										//Specifies the application name. This field is required for any hit that has app related data (i.e., app version, app ID, or app installer ID). For hits sent to web properties, this field is optional.

										//an	text	None	100 Bytes	all


	property name="aid";				//Application ID
										//Optional.
										//Application identifier.

										// aid	text	None	150 Bytes	all
										
	property name="av";					//Application Version
										//Optional.
										//Specifies the application version.
										// av	text	None	100 Bytes	all

	property name="aiid";				//Application Installer ID
										//Optional.
										//Application installer identifier.

										// aiid	text	None	150 Bytes	all

//Event Tracking

										//Event Category
										//Required for event hit type.
										//Specifies the event category. Must not be empty.


	property name="ea";					//Event Action
										//Required for event hit type.
										//Specifies the event action. Must not be empty.

										// ea	text	None	500 Bytes	event


	property name="el";					//Event Label
										//Optional.
										//Specifies the event label.
	
										//el	text	None	500 Bytes	event


	property name="ev";					//Event Value
										//Optional.
										//Specifies the event value. Values must be non-negative.


//E-Commerce

	property name="ti";					//Transaction ID

										//Required for transaction hit type. 
										//Required for item hit type.
										//A unique identifier for the transaction. This value should be the same for both the Transaction hit and Items hits associated to the particular transaction.
										// ti	text	None	500 Bytes	transaction, item


	property name="ta";					//Transaction Affiliation
										//Optional.
										//Specifies the affiliation or store name.

										//ta	text	None	500 Bytes	transaction


	property name="tr";					//Transaction Revenue
										//Optional.
										//Specifies the total revenue associated with the transaction. This value should include any shipping or tax costs.


	property name="ts";					//Transaction Shipping
										//Optional.
										//Specifies the total shipping cost of the transaction.


	property name="tt";					//Transaction Tax
										//Optional.
										//Specifies the total tax of the transaction.


	property name="in";					//Item Name
										//Required for item hit type.
										//Specifies the item name.

										// in	text	None	500 Bytes	item


	property name="ip";					//Item Price
										//Optional.
										//Specifies the price for a single item / unit.

	property name="iq";					//Item Quantity
										//Optional.
										//Specifies the number of items purchased.


	property name="ic";					//Item Code
										//Optional.
										//Specifies the SKU or item code.

										//ic	text	None	500 Bytes	item


	property name="iv";					//Item Category
										//Optional.
										//Specifies the category that the item belongs to.
										// iv	text	None	500 Bytes	item



//Enhanced E-Commerce

	property name="prid";				//Product SKU
										//Optional.
										//The SKU of the product. Product index must be a positive integer between 1 and 200, inclusive. For analytics.js the Enhanced Ecommerce plugin must be installed before using this field.
										// pr<productIndex>id	text	None	500 Bytes	all


	property name="prnm";				//Product Name
										//Optional.
										//The name of the product. Product index must be a positive integer between 1 and 200, inclusive. For analytics.js the Enhanced Ecommerce plugin must be installed before using this field.

										// pr<productIndex>nm	text	None	500 Bytes	all

	property name="prbr";				//Product Brand
										//Optional.
										//The brand associated with the product. Product index must be a positive integer between 1 and 200, inclusive. For analytics.js the Enhanced Ecommerce plugin must be installed before using this field.
										//pr<productIndex>br	text	None	500 Bytes	all


	property name="prca";				//Product Category
										//Optional.
										//The category to which the product belongs. Product index must be a positive integer between 1 and 200, inclusive. The product category parameter can be hierarchical. Use / as a delimiter to specify up to 5-levels of hierarchy. For analytics.js the Enhanced Ecommerce plugin must be installed before using this field.

										// pr<productIndex>ca	text	None	500 Bytes	all



	property name="prva";				//Product Variant
										//Optional.
										//The variant of the product. Product index must be a positive integer between 1 and 200, inclusive. For analytics.js the Enhanced Ecommerce plugin must be installed before using this field.
										// pr<productIndex>va	text	None	500 Bytes	all


	property name="prpr";				//Product Price
										//Optional.
										//The unit price of a product. Product index must be a positive integer between 1 and 200, inclusive. For analytics.js the Enhanced Ecommerce plugin must be installed before using this field.

										//pr<productIndex>pr	currency	None	None	all

	property name="prqt";				//Product Quantity
										//Optional.
										//The quantity of a product. Product index must be a positive integer between 1 and 200, inclusive. For analytics.js the Enhanced Ecommerce plugin must be installed before using this field.

										//pr<productIndex>qt	integer	None	None	all

	property name="prcc";				//Product Coupon Code
										//Optional.
										//The coupon code associated with a product. Product index must be a positive integer between 1 and 200, inclusive. For analytics.js the Enhanced Ecommerce plugin must be installed before using this field.

										//pr<productIndex>cc	text	None	500 Bytes	all


	property name="prps";				//Product Position
										//Optional.
										//The product's position in a list or collection. Product index must be a positive integer between 1 and 200, inclusive. For analytics.js the Enhanced Ecommerce plugin must be installed before using this field.

										//pr<productIndex>ps	integer	None	None	all

	property name="prcd";				//Product Custom Dimension
										//Optional.
										//A product-level custom dimension where dimension index is a positive integer between 1 and 200, inclusive. Product index must be a positive integer between 1 and 200, inclusive. For analytics.js the Enhanced Ecommerce plugin must be installed before using this field.
										//pr<productIndex>cd<dimensionIndex>	text	None	None	all


	property name="prcm";				//Product Custom Metric
										//Optional.
										//A product-level custom metric where metric index is a positive integer between 1 and 200, inclusive. Product index must be a positive integer between 1 and 200, inclusive. For analytics.js the Enhanced Ecommerce plugin must be installed before using this field.
										//pr<productIndex>cm<metricIndex>	integer	None	None	all

	property name="pa";					//Product Action
										//Optional.
										//The role of the products included in a hit. If a product action is not specified, all product definitions included with the hit will be ignored. Must be one of: detail, click, add, remove, checkout, checkout_option, purchase, refund. For analytics.js the Enhanced Ecommerce plugin must be installed before using this field.



	property name="ti";					//Transaction ID
										//Optional.
										//The transaction ID. This is an additional parameter that can be sent when Product Action is set to 'purchase' or 'refund'. For analytics.js the Enhanced Ecommerce plugin must be installed before using this field.


	property name="ta";					//Affiliation
										//Optional.
										//The store or affiliation from which this transaction occurred. This is an additional parameter that can be sent when Product Action is set to 'purchase' or 'refund'. For analytics.js the Enhanced Ecommerce plugin must be installed before using this field.

	property name="tr";					//Revenue
										//Optional.
										//The total value of the transaction, including tax and shipping. If not sent, this value will be automatically calculated using the product quantity and price fields of all products in the same hit. This is an additional parameter that can be sent when Product Action is set to 'purchase' or 'refund'. For analytics.js the Enhanced Ecommerce plugin must be installed before using this field.


	property name="tt";					//Tax
										//Optional.
										//The total tax associated with the transaction. This is an additional parameter that can be sent when Product Action is set to 'purchase' or 'refund'. For analytics.js the Enhanced Ecommerce plugin must be installed before using this field.
										//Parameter	Value Type	Default Value	Max Length	Supported Hit Types

	property name="ts";					//Shipping
										//Optional.
										//The shipping cost associated with the transaction. This is an additional parameter that can be sent when Product Action is set to 'purchase' or 'refund'. For analytics.js the Enhanced Ecommerce plugin must be installed before using this field.


	property name="tcc";				//Coupon Code
										//Optional.
										//The transaction coupon redeemed with the transaction. This is an additional parameter that can be sent when Product Action is set to 'purchase' or 'refund'. For analytics.js the Enhanced Ecommerce plugin must be installed before using this field.

	property name="pal";				//Product Action List
										//Optional.
										//The list or collection from which a product action occurred. This is an additional parameter that can be sent when Product Action is set to 'detail' or 'click'. For analytics.js the Enhanced Ecommerce plugin must be installed before using this field.



	property name="cos";				//Checkout Step
										//Optional.
										//The step number in a checkout funnel. This is an additional parameter that can be sent when Product Action is set to 'checkout'. For analytics.js the Enhanced Ecommerce plugin must be installed before using this field.

	property name="col";				//Checkout Step Option
										//Optional.
										//Additional information about a checkout step. This is an additional parameter that can be sent when Product Action is set to 'checkout'. For analytics.js the Enhanced Ecommerce plugin must be installed before using this field.


	property name="ilnm";				//Product Impression List Name
										//Optional.
										//The list or collection to which a product belongs. Impression List index must be a positive integer between 1 and 200, inclusive. For analytics.js the Enhanced Ecommerce plugin must be installed before using this field.

										// il<listIndex>nm	text	None	None	all
										//Product Impression SKU
										//Optional.

	property name="ilpiid";				//The product ID or SKU. Impression List index must be a positive integer between 1 and 200, inclusive. Product index must be a positive integer between 1 and 200, inclusive. For analytics.js the Enhanced Ecommerce plugin must be installed before using this field.
										//il<listIndex>pi<productIndex>id	text	None	None	all
										//Product Impression Name
										//Optional.

	property name="ilpinm";
										//The name of the product. Impression List index must be a positive integer between 1 and 200, inclusive. Product index must be a positive integer between 1 and 200, inclusive. For analytics.js the Enhanced Ecommerce plugin must be installed before using this field.

										//il<listIndex>pi<productIndex>nm	text	None	None	all

	property name="ilpibr";				//Product Impression Brand
										//Optional.
										//The brand associated with the product. Impression List index must be a positive integer between 1 and 200, inclusive. Product index must be a positive integer between 1 and 200, inclusive. For analytics.js the Enhanced Ecommerce plugin must be installed before using this field.

										// il<listIndex>pi<productIndex>br	text	None	None	all


	property name="ilpica";				//Product Impression Category
										//Optional.
										//The category to which the product belongs. Impression List index must be a positive integer between 1 and 200, inclusive. Product index must be a positive integer between 1 and 200, inclusive. For analytics.js the Enhanced Ecommerce plugin must be installed before using this field.

										//Parameter	Value Type	Default Value	Max Length	Supported Hit Types
										// il<listIndex>pi<productIndex>ca	text	None	None	all


	property name="ilpiva";				//Product Impression Variant
										//Optional.
										//The variant of the product. Impression List index must be a positive integer between 1 and 200, inclusive. Product index must be a positive integer between 1 and 200, inclusive. For analytics.js the Enhanced Ecommerce plugin must be installed before using this field.

										// il<listIndex>pi<productIndex>va	text	None	None	all


	property name="ilpips";				//Product Impression Position
										//Optional.
										//The product's position in a list or collection. Impression List index must be a positive integer between 1 and 200, inclusive. Product index must be a positive integer between 1 and 200, inclusive. For analytics.js the Enhanced Ecommerce plugin must be installed before using this field.

										//il<listIndex>pi<productIndex>ps	integer	None	None	all

	property name="ilpipr";				//Product Impression Price
										//Optional.
										//The price of a product. Impression List index must be a positive integer between 1 and 200, inclusive. Product index must be a positive integer between 1 and 200, inclusive. For analytics.js the Enhanced Ecommerce plugin must be installed before using this field.

										//il<listIndex>pi<productIndex>pr	currency	None	None	all

	property name="ilpicd";				//Product Impression Custom Dimension
										//Optional.
										//A product-level custom dimension where dimension index is a positive integer between 1 and 200, inclusive. Impression List index must be a positive integer between 1 and 200, inclusive. Product index must be a positive integer between 1 and 200, inclusive. For analytics.js the Enhanced Ecommerce plugin must be installed before using this field.

										// il<listIndex>pi<productIndex>cd<dimensionIndex>	text	None	None	all


	property name="ilpicm";				//Product Impression Custom Metric
										//Optional.
										//A product-level custom metric where metric index is a positive integer between 1 and 200, inclusive. Impression List index must be a positive integer between 1 and 200, inclusive. Product index must be a positive integer between 1 and 200, inclusive. For analytics.js the Enhanced Ecommerce plugin must be installed before using this field.

										// il<listIndex>pi<productIndex>cm<metricIndex>	integer	None	None	all

	property name="promoid";			//Promotion ID
										//Optional.
										//The promotion ID. Promotion index must be a positive integer between 1 and 200, inclusive. For analytics.js the Enhanced Ecommerce plugin must be installed before using this field.

										// promo<promoIndex>id	text	None	None	all


	property name="promonm";			//Promotion Name
										//Optional.
										//The name of the promotion. Promotion index must be a positive integer between 1 and 200, inclusive. For analytics.js the Enhanced Ecommerce plugin must be installed before using this field.
										//promo<promoIndex>nm	text	None	None	all


	property name="promocr";			//Promotion Creative
										//Optional.
										//The creative associated with the promotion. Promotion index must be a positive integer between 1 and 200, inclusive. For analytics.js the Enhanced Ecommerce plugin must be installed before using this field.

										// promo<promoIndex>cr	text	None	None	all


	property name="promoPs";			//Promotion Position
										//Optional.
										//The position of the creative. Promotion index must be a positive integer between 1 and 200, inclusive. For analytics.js the Enhanced Ecommerce plugin must be installed before using this field.

										//promo<promoIndex>ps	text	None	None	all


	property name="promoa";				//Promotion Action
										//Optional.
										//Specifies the role of the promotions included in a hit. If a promotion action is not specified, the default promotion action, 'view', is assumed. To measure a user click on a promotion set this to 'promo_click'. For analytics.js the Enhanced Ecommerce plugin must be installed before using this field.
										//Parameter	Value Type	Default Value	Max Length	Supported Hit Types
										// promoa	text	None	None	all


	property name="cu";					//Currency Code
										//Optional.
										//When present indicates the local currency for all transaction currency values. Value should be a valid ISO 4217 currency code.
	
										//cu	text	None	10 Bytes	all



//Social Interactions

	property name="sn";					//Social Network
										//Required for social hit type.
										//Specifies the social network, for example Facebook or Google Plus.

										// sn	text	None	50 Bytes	social


	property name="sa";					//Social Action
										//Required for social hit type.
										//Specifies the social interaction action. For example on Google Plus when a user clicks the +1 button, the social action is 'plus'.

										// sa	text	None	50 Bytes	social


	property name="st";					//Social Action Target
										//Required for social hit type.
										//Specifies the target of a social interaction. This value is typically a URL but can be any text.

										// st	text	None	2048 Bytes	social

//Timing
	property name="utc";				//User timing category
										//Required for timing hit type.
										//Specifies the user timing category.

										// utc	text	None	150 Bytes	timing


	property name="utv";				//User timing variable name
										//Required for timing hit type.
										//Specifies the user timing variable.

										//utv	text	None	500 Bytes	timing


	property name="utt";				//User timing time
										//Required for timing hit type.
										//Specifies the user timing value. The value is in milliseconds.


	property name="utl";				//User timing label
										//Optional.
										//Specifies the user timing label.

										// utl	text	None	500 Bytes	timing


	property name="plt";				//Page Load Time
										//Optional.
										//Specifies the time it took for a page to load. The value is in milliseconds.


	property name="dns";				//DNS Time
										//Optional.
										//Specifies the time it took to do a DNS lookup.The value is in milliseconds.


	property name="pdt";				//Page Download Time
										//Optional.
										//Specifies the time it took for the page to be downloaded. The value is in milliseconds.

										//Parameter	Value Type	Default Value	Max Length	Supported Hit Types


	property name="rrt";				//Redirect Response Time
										//Optional.
										//Specifies the time it took for any redirects to happen. The value is in milliseconds.



	property name="tcp";				//TCP Connect Time
										//Optional.
										//Specifies the time it took for a TCP connection to be made. The value is in milliseconds.


	property name="srt";				//Server Response Time
										//Optional.
										//Specifies the time it took for the server to respond after the connect time. The value is in milliseconds.


	property name="dit";				//DOM Interactive Time
										//Optional.
										//Specifies the time it took for Document.readyState to be 'interactive'. The value is in milliseconds.



	property name="clt";				//Content Load Time
										//Optional.
										//Specifies the time it took for the DOMContentLoaded Event to fire. The value is in milliseconds.


//Exceptions

	property name="exd";				//Exception Description
										//Optional.
										//Specifies the description of an exception.
										//Parameter	Value Type	Default Value	Max Length	Supported Hit Types
										// exd	text	None	150 Bytes	exception


	property name="exf";				//Is Exception Fatal?
										//Optional.
										//Specifies whether the exception was fatal.

										// exf	boolean	1	None	exception


//Custom Dimensions / Metrics

	property name="cd";					//Custom Dimension
										//Optional.
										//Each custom dimension has an associated index. There is a maximum of 20 custom dimensions (200 for Analytics 360 accounts). The dimension index must be a positive integer between 1 and 200, inclusive.

										// cd<dimensionIndex>	text	None	150 Bytes	all


	property name="cm";					//Custom Metric
										//Optional.
										//Each custom metric has an associated index. There is a maximum of 20 custom metrics (200 for Analytics 360 accounts). The metric index must be a positive integer between 1 and 200, inclusive.

										// cm<metricIndex>	number	None	None	all


	property name="xid";				//Content Experiments
										//Experiment ID
										//Optional.

										//This parameter specifies that this user has been exposed to an experiment with the given ID. It should be sent in conjunction with the Experiment Variant parameter.

	property name="xid";				//xid	text	None	40 Bytes	all


	property name="xvar";				//Experiment Variant
										//Optional.
										//This parameter specifies that this user has been exposed to a particular variation of an experiment. It should be sent in conjunction with the Experiment ID parameter.

 										//xvar	text	None	None	all



	MeasurementProtocol function init(){
		
		return this;
	}
	

	function setProtocolVersion(toSet){
		 setv(arguments.toSet);
	}





	function setTrackingID (toSet){
		 settid(arguments.toSet);
	}




	function setAnonymizeIP(toSet){
		 setaip(arguments.toSet);
		}



	function setDataSource(toSet){
		 setds(arguments.toSet);
		}



	function setQueueTime(toSet){
		 setqt(arguments.toSet);
		}



	function setCacheBuster(toSet){
		 setz(arguments.toSet);
		}




	function setClientID(toSet){
		 setcid(arguments.toSet);
	}


	function setUserID(toSet){
		 setuid(arguments.toSet);
		}


//Session

	function setSessionControl(toSet){
		 setsc(arguments.toSet);
		}



	function setIPOverride(toSet){
		 setuip(arguments.toSet);
		}



	function setUserAgentOverride(toSet){
		 setua(arguments.toSet);
		}




	function setGeographicalOverride(toSet){
		 setgeoid(arguments.toSet);
		}



//Traffic Sources


	function setDocumentReferrer(toSet){
		 setdr(arguments.toSet);
		}




	function setCampaignName(toSet){
		 setcn(arguments.toSet);
		}





	function setCampaignSource(toSet){
		 setcs(arguments.toSet);
		}





	function setCampaignMedium(toSet){
		 setcm(arguments.toSet);
		}





	function setCampaignKeyword(toSet){
		 setck(arguments.toSet);
		}






	function setCampaignContent(toSet){
		 setcc(arguments.toSet);
		}






	function setCampaignID(toSet){
		 setci(arguments.toSet);
		}





	function setGoogleAdWordsID(toSet){
		 setgclid(arguments.toSet);
		}







	function setGoogleDisplayAdsID(toSet){
		 setdclid(arguments.toSet);
		}







//System Info

	function setScreenResolution(toSet){
		 setsr(arguments.toSet);
		}






	function setViewportsize(toSet){
		 setvp(arguments.toSet);
		}






	function setDocumentEncoding(toSet){
		 setde(arguments.toSet);
		}






	function setScreenColors(toSet){
		 setsd(arguments.toSet);
		}






	function setUserLanguage(toSet){
		 setul(arguments.toSet);
		}




	function setJavaEnabled(toSet){
		 setje(arguments.toSet);
		}




	function setFlashVersion(toSet){
		 setfv(arguments.toSet);
		}





//Hit

	function setHittype(toSet){
		 sett(arguments.toSet);
		}




	function setNon(toSet){
		 setni(arguments.toSet);
		}




//Content Information


	function setDocumentlocationURL(toSet){
		 setdl(arguments.toSet);
		}					




	function setDocumentHostName(toSet){
		 setdh(arguments.toSet);
		}




	function setDocumentPath(toSet){
		 setdp(arguments.toSet);
		}




	function setDocumentTitle(toSet){
		 setdt(arguments.toSet);
		}



	function setScreenName(toSet){
		 setcd(arguments.toSet);
		}



	function setContentGroup(toSet){
		 setcg(arguments.toSet);
		}

	function setLinkID(toSet){
		 setlinkId(arguments.toSet);
		}




//App Tracking

	function setApplicationName(toSet){
		 setan(arguments.toSet);
		}

	function setApplicationID(toSet){
		 setaid(arguments.toSet);
		}




										
	function setApplicationVersion(toSet){
		 setav(arguments.toSet);
		}




	function setApplicationInstallerID(toSet){
		 setaiid(arguments.toSet);
		}





//Event Tracking



	function setEventAction(toSet){
		 setea(arguments.toSet);
		}


	function setEventLabel(toSet){
		 setel(arguments.toSet);
		}


	function setEventValue(toSet){
		 setev(arguments.toSet);
		}


//E-Commerce

	function setTransactionID(toSet){
		 setti(arguments.toSet);
		}



	function setTransactionAffiliation(toSet){
		 setta(arguments.toSet);
		}






	function setTransactionRevenue(toSet){
		 settr(arguments.toSet);
		}




	function setTransactionShipping(toSet){
		 setts(arguments.toSet);
		}




	function setTransactionTax(toSet){
		 settt(arguments.toSet);
		}




	function setItemName(toSet){
		 setin(arguments.toSet);
		}






	function setItemPrice(toSet){
		 setip(arguments.toSet);
		}



	function setItemQuantity(toSet){
		 setiq(arguments.toSet);
		}




	function setItemCode(toSet){
		 setic(arguments.toSet);
		}






	function setItemCategory(toSet){
		 setiv(arguments.toSet);
		}






//Enhanced E-Commerce

	function setProductSKU(toSet){
		 setprid(arguments.toSet);
		}




	function setProductName(toSet){
		 setprnm(arguments.toSet);
		}




	function setProductBrand(toSet){
		 setprbr(arguments.toSet);
		}




	function setProductCategory(toSet){
		 setprca(arguments.toSet);
		}






	function setProductVariant(toSet){
		 setprva(arguments.toSet);
		}




	function setProductPrice(toSet){
		 setprpr(arguments.toSet);
		}




	function setProductQuantity(toSet){
		 setprqt(arguments.toSet);
		}




	function setProductCouponCode(toSet){
		 setprcc(arguments.toSet);
		}





	function setProductPosition(toSet){
		 setprps(arguments.toSet);
		}




	function setProductCustomDimension(toSet){
		 setprcd(arguments.toSet);
		}



	function setProductCustomMetric(toSet){
		 setprcm(arguments.toSet);
		}



	function setProductAction(toSet){
		 setpa(arguments.toSet);
		}


	function setAffiliation(toSet){
		 setta(arguments.toSet);
		}



	function setRevenue(toSet){
		 settr(arguments.toSet);
		}




	function setTax(toSet){
		 settt(arguments.toSet);
		}




	function setShipping(toSet){
		 setts(arguments.toSet);
		}




	function setCouponCode(toSet){
		 settcc(arguments.toSet);
		}



	function setProductActionList(toSet){
		 setpal(arguments.toSet);
		}





	function setCheckoutStep(toSet){
		 setcos(arguments.toSet);
		}



	function setCheckoutStepOption(toSet){
		 setcol(arguments.toSet);
		}




	function setProductImpressionListName(toSet){
		 setilnm(arguments.toSet);
		}



	function setTheproductIDorSKU(toSet){
		 setilpiid(arguments.toSet);
		}



	function setilpinm(toSet){
		 setilpinm(arguments.toSet);
	}

	function setProductImpressionBrand(toSet){
		 setilpibr(arguments.toSet);
		}



	function setProductImpressionCategory(toSet){
		 setilpica(arguments.toSet);
		}





	function setProductImpressionVariant(toSet){
		 setilpiva(arguments.toSet);
		}



	function setProductImpressionPosition(toSet){
		 setilpips(arguments.toSet);
		}



	function setProductImpressionPrice(toSet){
		 setilpipr(arguments.toSet);
		}



	function setProductImpressionCustomDimension(toSet){
		 setilpicd(arguments.toSet);
		}



	function setProductImpressionCustomMetric(toSet){
		 setilpicm(arguments.toSet);
		}



	function setPromotionID(toSet){
		 setpromoid(arguments.toSet);
		}



	function setPromotionName(toSet){
		 setpromonm(arguments.toSet);
		}


	function setPromotionCreative(toSet){
		 setpromocr(arguments.toSet);
		}




	function setPromotionPosition(toSet){
		 setpromoPs(arguments.toSet);
		}




	function setPromotionAction(toSet){
		 setpromoa(arguments.toSet);
		}





	function setCurrencyCode(toSet){
		 setcu(arguments.toSet);
		}


	




//Social Interactions

	function setSocialNetwork(toSet){
		 setsn(arguments.toSet);
		}



	function setSocialAction(toSet){
		 setsa(arguments.toSet);
		}




	function setSocialActionTarget(toSet){
		 setst(arguments.toSet);
		}





//Timing
	function setUsertimingcategory(toSet){
		 setutc(arguments.toSet);
		}






	function setUsertimingvariablename(toSet){
		 setutv(arguments.toSet);
		}






	function setUsertimingtime(toSet){
		 setutt(arguments.toSet);
		}




	function setUsertiminglabel(toSet){
		 setutl(arguments.toSet);
		}






	function setPageLoadTime(toSet){
		 setplt(arguments.toSet);
		}




	function setDNSTime(toSet){
		 setdns(arguments.toSet);
		}




	function setPageDownloadTime(toSet){
		 setpdt(arguments.toSet);
		}






	function setRedirectResponseTime(toSet){
		 setrrt(arguments.toSet);
		}





	function setTCPConnectTime(toSet){
		 settcp(arguments.toSet);
		}




	function setServerResponseTime(toSet){
		 setsrt(arguments.toSet);
		}




	function setDOMInteractiveTime(toSet){
		 setdit(arguments.toSet);
		}





	function setContentLoadTime(toSet){
		 setclt(arguments.toSet);
		}




//Exceptions

	function setExceptionDescription(toSet){
		 setexd(arguments.toSet);
		}






	function setIsExceptionFatal(toSet){
		 setexf(arguments.toSet);
	}






//Custom Dimensions / Metrics

	function setCustomDimension(toSet){
		 setcd(arguments.toSet);
		}


	function setCustomMetric(toSet){
		 setcm(arguments.toSet);
		}


	function setContentExperiments(toSet){
		 setxid(arguments.toSet);
		}





	function setxid(toSet){
		 setxid(arguments.toSet);
		}	

	function setExperimentVariant(toSet){
		 setxvar(arguments.toSet);
		}


}
