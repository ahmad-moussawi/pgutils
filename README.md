cordova-plugin-utils
===========================================================================

Phonegap 3.*.* plugin that contains many helpful utils.


Install: ```cordova plugin add https://github.com/ahmad-moussawi/org.apache.cordova.pgutils.git```

Delete:  ```cordova plugin rm org.apache.cordova.pgutils```

use: 

**get Unique Device Id**

```js
navigator.pgUtils.getUniqueDeviceId(function(deviceId) { /* success */
	console.log(deviceId); // => OK
}, 
function(error) { /* error */
	console.log(error);
});
```