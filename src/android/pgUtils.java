package org.apache.cordova.pgUtils;

import java.util.UUID;

import org.apache.cordova.CallbackContext;
import org.apache.cordova.CordovaPlugin;
import org.json.JSONArray;
import org.json.JSONException;

import android.app.Activity;
import android.content.Context;
import android.content.Intent;
import android.content.pm.PackageManager;
import android.net.Uri;
import android.telephony.TelephonyManager;


public class PGUtils extends CordovaPlugin {


  public PGUtils() {
  }

  
  /**
   * Executes the request and returns PluginResult.
   * 
   * @param action
   *            The action to execute.
   * @param args
   *            JSONArray of arguments for the plugin.
   * @param callbackContext
   *            The callback context used when calling back into JavaScript.
   * @return True when the action was valid, false otherwise.
   */
  public boolean execute(String action, JSONArray args,
      CallbackContext callbackContext) throws JSONException {

    Context context = this.cordova.getActivity().getApplicationContext();
    if (action.equals("getUniqueDeviceId")) {
      this.getUniqueDeviceId(context, callbackContext);
    } else if (action.equals("openStore")) {
      String uri = args.getString(0);
      this.openStore(uri, callbackContext);
      return true;
    } else if (action.equals("openApp")) {
      String uri = args.getString(0);
      this.openApp(uri, this.cordova.getActivity(), callbackContext);
      return true;
    }

    return true;
  }

  /**
   * Get device uniqueId
   * @param context
   * @param callback
   */
  private void getUniqueDeviceId(Context context, CallbackContext callback) {

    try {
      final TelephonyManager tm = (TelephonyManager) context
          .getSystemService(Context.TELEPHONY_SERVICE);

      String tmDevice = "" + tm.getDeviceId(), androidId = ""
          + android.provider.Settings.Secure.getString(
              context.getContentResolver(),
              android.provider.Settings.Secure.ANDROID_ID);
      UUID deviceUuid = new UUID(androidId.hashCode(),
          ((long) tmDevice.hashCode()));
      String deviceId = deviceUuid.toString();

      callback.success(deviceId);
    } catch (Exception e) {
      callback.error(e.toString());
    }
  }

  /**
   * Open the store, with fallback to browser if not installed
   * @param appPackage
   * @param callbackContext
   */
  private void openStore(String appPackage, CallbackContext callbackContext) {
    // open the store
    try {
      this.cordova.getActivity().startActivity(
          new Intent(Intent.ACTION_VIEW, Uri
              .parse("market://details?id=" + appPackage)));
      callbackContext.success("MARKET");
    } catch (android.content.ActivityNotFoundException anfe) {
      // App store is not installed
      this.cordova
      .getActivity()
      .startActivity(
          new Intent(
              Intent.ACTION_VIEW,
              Uri.parse("http://play.google.com/store/apps/details?id="
                  + appPackage)));
      callbackContext.success("MARKET-BROWSER");
    }
  }

  /**
   * Returns true if the app was opened, returns false if the store was opened.
   * @param appPackage
   * @param activity
   * @param callbackContext
   * @return
   */
  private boolean openApp(String appPackage, Activity activity, CallbackContext callbackContext) {
    boolean opened = false;
    try {
      PackageManager manager = activity.getPackageManager();
      Intent i = manager.getLaunchIntentForPackage(appPackage);
      if (i != null) {
        i.addCategory(Intent.CATEGORY_LAUNCHER);
        activity.startActivity(i);
        callbackContext.success("OK");
        opened = true;
      }
    } catch (Exception e) {
      e.printStackTrace();
      opened = false;
    }
    if(!opened) {
      openStore(appPackage, callbackContext);
    }
    return opened;
  }

}
