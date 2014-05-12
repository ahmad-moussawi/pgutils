PhoneGap Utils
===========================================================================

Phonegap 3.\*.\* plugin that contains many helpful utils.

## Installation
Install ```phonegap plugin add https://github.com/ahmad-moussawi/pgutils.git```

Remove ```phonegap plugin rm org.apache.cordova.pgUtils```

## Usage: 

**get Unique Device Id**

```js
navigator.PGUtils.getUniqueDeviceId(function(deviceId) {
	console.log(deviceId);
}, 
function(error) {
	console.log(error);
});
```

## Permissions:
Android:
This plugin requires the **android.permission.READ_PHONE_STATE** permission 

## iOS note
- Add the following flag `-fno-objc-arc` to `KeychainItemWrapper.m` and `DeviceManager.m` (Build Phases >> Compile Sources Section)
- Add the `Security.framework` (Project settings >> Linked Frameworks and Libraries section)
- Change the APP_ID to something unique, i.e. the bundle id in `PGUtils.m` Line 25

## Copyright
This plugin is developed By [FOO](http://foo.mobi), all copyright are reserved.
Thanks to Mona Mouteirek, Grace Ohanian, Hassan Kassem and Rami Fatayri