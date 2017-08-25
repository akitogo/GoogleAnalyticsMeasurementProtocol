# Google Analytics Measurement Protocol
A wrapper for Coldfusion Coldbox

## What is it good for?
Imagine you want to track anything within Google Analytics which can not use the GA Javascript tracking code
E.g. track api traffic, events which are fired from your internal crm

## Installation 
This ColdBox Module can be installed using CommandBox:

```
box install GoogleAnalyticsMeasurementProtocol
```

## Usage
```
var mp=getModel('MeasurementProtocol');
mp.setTrackingId('UA-xxxxxx-x');
mp.setDocumentLocationUrl('http://yourdomain/yourUrl?q=test');
mp.setIpOverride('xx.xx.xx.xx');
mp.setClientId(MeasurementProtocolService.CreateUUIDv4());
//writeDump(mp);

MeasurementProtocolService.send(mp);

```

## Written by
www.akitogo.com

## Disclaimer
THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND, EXPRESS OR IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF MERCHANTABILITY, FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT. IN NO EVENT SHALL THE AUTHORS OR COPYRIGHT HOLDERS BE LIABLE FOR ANY CLAIM, DAMAGES OR OTHER LIABILITY, WHETHER IN AN ACTION OF CONTRACT, TORT OR OTHERWISE, ARISING FROM, OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR OTHER DEALINGS IN THE SOFTWARE.
