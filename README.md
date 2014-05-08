cordova-plugin-utils
===========================================================================

Phonegap 3.*.* plugin that contains many helpful utils.

## Installation
### Install: ```cordova plugin add https://github.com/ahmad-moussawi/pgutils.git```

### Remove:  ```cordova plugin rm org.apache.cordova.pgutils```

## Usage: 

**get Unique Device Id**

```js
navigator.pgUtils.getUniqueDeviceId(function(deviceId) {
	console.log(deviceId);
}, 
function(error) {
	console.log(error);
});
```

## Permissions:

This plugin requires the **android.permission.READ_PHONE_STATE** permission