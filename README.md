PhoneGap Utils
===========================================================================

Phonegap 3.\*.\* plugin that contains many helpful utils.

## Installation
Install ```phonegap plugin add https://github.com/ahmad-moussawi/pgutils.git```

Remove ```phonegap plugin rm org.apache.cordova.pgUtils```

## Usage: 

###getUniqueDeviceId

param|type|required|note
-----|----|--------|----
successCallback|`function(string deviceId)`|no|function with deviceId as argument
errorCallback|`function(object error)`|no|

```javascript
navigator.PGUtils.getUniqueDeviceId(function(deviceId) {
	console.log(deviceId);
}, 
function(error) {
	console.log(error);
});
```
------------------
###openApp
param|type|required|note
-----|----|--------|----
appId|string|yes| the package id for android i.e. `com.twitter.android` and the app schema for iOs i.e. `id8787663` or `myAppId`
successCallback|`function(string status)`|no| `status` can be on of `OK`, `MARKET` if the app is not found and the market has opened, `MARKET-BROWSER` (only for android) if the app is not found and the market is opened via the browser
errorCallback|`function(object error)`|no|
```javascript

// on iOS: the appId should be in the following format: <scheme>/<storeId>, e.g. `myapp/id876656`
navigator.PGUtils.openApp(appId, function(status){
    console.log(status);
},
function(error) {
    console.log(error);
});
```
----------------
###openStore
param|type|required|note
-----|----|--------|----
appId|string|yes| the package id for android i.e. `com.twitter.android` and the app schema for iOs i.e. `id8787663` or `myAppId`
successCallback|`function(string status)`|no| `status` can be on of `MARKET`, `MARKET-BROWSER` (only for android) if the market is opened via the browser
errorCallback|`function(object error)`|no|
```javascript

// on iOS: the appId should be in the following format: <scheme>/<storeId>, e.g. `myapp/id876656`
navigator.PGUtils.openStore(appId, function(status){
    console.log(status);
},
function(error) {
    console.log(error);
});
```

## Permissions:
Android:
This plugin requires the **android.permission.READ_PHONE_STATE** permission to calculate the deviceId

## iOS note
- Add the following flag `-fno-objc-arc` to `KeychainItemWrapper.m` and `DeviceManager.m` (Build Phases >> Compile Sources Section)
- Add the `Security.framework` (Project settings >> Linked Frameworks and Libraries section)

## Copyright
This plugin is developed By [FOO](http://foo.mobi), all copyright are reserved.
