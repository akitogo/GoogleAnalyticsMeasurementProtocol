# Google Analytics 4 (GA4) Measurement Protocol
A ColdBox module for sending server-side events to Google Analytics 4 using the Measurement Protocol.

## What is it good for?
Track server-side events in Google Analytics 4 that cannot use the GA4 JavaScript tracking code:
- API traffic and server-side interactions
- Backend processes and cron jobs
- Events from internal CRM systems
- Server-side e-commerce transactions
- Custom business logic events

## Installation 
This ColdBox Module can be installed using CommandBox:

```
box install GoogleAnalyticsMeasurementProtocol
```

## Setup Requirements

### 1. Get your GA4 Measurement ID
Find your GA4 Measurement ID (format: `G-XXXXXXXXXX`) in Google Analytics:
- Go to Admin → Data Streams → Web
- Your Measurement ID is displayed at the top

### 2. Create an API Secret
Create an API Secret for server-side tracking:
- Go to Admin → Data Streams → Web → Measurement Protocol API secrets
- Click "Create" and give it a nickname
- Copy the generated API secret value

## Basic Usage

### Page View Event
```coldfusion
// Get the service
var mpService = getModel('MeasurementProtocolService');

// Create a page view event
var mp = mpService.createPageViewEvent(
    measurementId = 'G-XXXXXXXXXX',
    apiSecret = 'your-api-secret-here',
    clientId = mpService.CreateUUIDv4(),
    pageTitle = 'Home Page',
    pageLocation = 'https://yourdomain.com/',
    pageReferrer = 'https://google.com'
);

// Send the event
var success = mpService.send(mp);
```

### Custom Event
```coldfusion
// Create a custom event
var mp = mpService.createCustomEvent(
    measurementId = 'G-XXXXXXXXXX',
    apiSecret = 'your-api-secret-here',
    clientId = mpService.CreateUUIDv4(),
    eventName = 'user_signup',
    eventParameters = {
        'method': 'email',
        'user_type': 'premium'
    }
);

// Send the event
var success = mpService.send(mp);
```

### E-commerce Purchase Event
```coldfusion
var mp = getModel('MeasurementProtocol');
mp.setMeasurementId('G-XXXXXXXXXX');
mp.setApiSecret('your-api-secret-here');
mp.setClientId(getModel('MeasurementProtocolService').CreateUUIDv4());

// Add items to the purchase
mp.addItem('SKU001', 'Product Name', 'Electronics', 1, 99.99);
mp.addItem('SKU002', 'Another Product', 'Books', 2, 15.50);

// Add the purchase event
mp.addPurchaseEvent('ORDER-123', 131.49, 'USD', mp.getItems());

// Send the event
var success = getModel('MeasurementProtocolService').send(mp);
```

## Advanced Usage

### Multiple Events in One Request
```coldfusion
var mp = getModel('MeasurementProtocol');
mp.setMeasurementId('G-XXXXXXXXXX');
mp.setApiSecret('your-api-secret-here');
mp.setClientId(getModel('MeasurementProtocolService').CreateUUIDv4());

// Add multiple events
mp.addPageViewEvent('Product Page', 'https://yourdomain.com/products/123');
mp.addCustomEvent('product_view', {'product_id': '123', 'category': 'electronics'});
mp.addCustomEvent('scroll', {'percent_scrolled': 50});

// Send all events together
var success = getModel('MeasurementProtocolService').send(mp);
```

### User Properties
```coldfusion
var mp = getModel('MeasurementProtocol');
mp.setMeasurementId('G-XXXXXXXXXX');
mp.setApiSecret('your-api-secret-here');
mp.setClientId('existing-client-id-from-session');
mp.setUserId('user-123'); // Optional: link to authenticated user

// Set user properties
mp.setUserProperty('subscription_type', 'premium');
mp.setUserProperty('account_age_days', 30);

mp.addCustomEvent('feature_used', {'feature_name': 'advanced_search'});

var success = getModel('MeasurementProtocolService').send(mp);
```

### Asynchronous Sending
```coldfusion
// Send events in background thread (fire-and-forget)
var mp = getModel('MeasurementProtocol');
// ... configure the measurement protocol object ...

var success = getModel('MeasurementProtocolService').send(mp, true); // threaded = true
```

### Debug Mode (Testing)
```coldfusion
// Use debug endpoint to validate events before sending to production
var mp = getModel('MeasurementProtocol');
// ... configure the measurement protocol object ...

var debugResult = getModel('MeasurementProtocolService').sendDebug(mp);

if (debugResult.success) {
    writeOutput("Event is valid!");
    if (arrayLen(debugResult.validationMessages) > 0) {
        writeDump(debugResult.validationMessages);
    }
} else {
    writeOutput("Event validation failed: " & debugResult.response);
}
```

## Configuration Options

### Client ID Management
The `client_id` should be consistent for the same user across sessions. Consider:
- Storing in session/cookies for web users
- Using user ID hash for authenticated users
- Generating and storing in database for API users

```coldfusion
// Example: Get/create client ID from session
if (!structKeyExists(session, 'ga4_client_id')) {
    session.ga4_client_id = getModel('MeasurementProtocolService').CreateUUIDv4();
}
var clientId = session.ga4_client_id;
```

### Error Handling
```coldfusion
try {
    var mp = getModel('MeasurementProtocol');
    mp.setMeasurementId('G-XXXXXXXXXX');
    mp.setApiSecret('your-api-secret-here');
    mp.setClientId(clientId);
    mp.addPageViewEvent('Page Title', 'https://example.com/page');
    
    var success = getModel('MeasurementProtocolService').send(mp);
    
    if (!success) {
        writeLog(file="ga4", text="Failed to send GA4 event");
    }
    
} catch (GA4.ValidationError e) {
    writeLog(file="ga4", text="GA4 validation error: " & e.message);
} catch (any e) {
    writeLog(file="ga4", text="GA4 unexpected error: " & e.message);
}
```

## Migration from Universal Analytics

### Key Changes
- **Tracking ID**: `UA-XXXX-Y` → `G-XXXXXXXXXX`
- **API Secret**: Now required for server-side events
- **Endpoint**: `/collect` → `/mp/collect`
- **Data Format**: URL parameters → JSON payload
- **Event Structure**: Flat parameters → Structured events array

### Common Event Mappings
| Universal Analytics | GA4 Equivalent |
|-------------------|----------------|
| Pageview | `page_view` event |
| Event | Custom event with `event_name` |
| Ecommerce transaction | `purchase` event |
| Social interaction | Custom event |

## Troubleshooting

### Common Issues
1. **Events not appearing in GA4**: 
   - Check Measurement ID format (`G-XXXXXXXXXX`)
   - Verify API Secret is correct
   - Ensure client_id is a valid UUID format

2. **Validation errors**:
   - Use the debug endpoint to test events
   - Check that required fields are populated
   - Verify event parameter names follow GA4 conventions

3. **HTTP errors**:
   - Check server can reach `www.google-analytics.com`
   - Verify firewall/proxy settings
   - Check error logs in ColdFusion

### Debug Logging
The module logs errors to `ga4_errors.log`. Enable this in your ColdFusion admin or check:
- `/logs/ga4_errors.log` for detailed error messages
- HTTP response codes and validation messages

## Written by
www.akitogo.com

Updated for Google Analytics 4 (GA4) Measurement Protocol v2

## Disclaimer
THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND, EXPRESS OR IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF MERCHANTABILITY, FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT. IN NO EVENT SHALL THE AUTHORS OR COPYRIGHT HOLDERS BE LIABLE FOR ANY CLAIM, DAMAGES OR OTHER LIABILITY, WHETHER IN AN ACTION OF CONTRACT, TORT OR OTHERWISE, ARISING FROM, OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR OTHER DEALINGS IN THE SOFTWARE.