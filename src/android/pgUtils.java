/*
       Licensed to the Apache Software Foundation (ASF) under one
       or more contributor license agreements.  See the NOTICE file
       distributed with this work for additional information
       regarding copyright ownership.  The ASF licenses this file
       to you under the Apache License, Version 2.0 (the
       "License"); you may not use this file except in compliance
       with the License.  You may obtain a copy of the License at

         http://www.apache.org/licenses/LICENSE-2.0

       Unless required by applicable law or agreed to in writing,
       software distributed under the License is distributed on an
       "AS IS" BASIS, WITHOUT WARRANTIES OR CONDITIONS OF ANY
       KIND, either express or implied.  See the License for the
       specific language governing permissions and limitations
       under the License.
 */
package org.apache.cordova.pgUtils;

import java.util.UUID;

import org.apache.cordova.CallbackContext;
import org.apache.cordova.CordovaPlugin;
import org.json.JSONArray;
import org.json.JSONException;

import android.content.Context;
import android.telephony.TelephonyManager;

/**
 * This class provides access to vibration on the device.
 */
public class pgUtils extends CordovaPlugin {

  /**
   * Constructor.
   */
  public pgUtils() { }

  /**
   * Executes the request and returns PluginResult.
   *
   * @param action            The action to execute.
   * @param args              JSONArray of arguments for the plugin.
   * @param callbackContext   The callback context used when calling back into JavaScript.
   * @return                  True when the action was valid, false otherwise.
   */
  public boolean execute(String action, JSONArray args, CallbackContext callbackContext) throws JSONException {
    if (action.equals("getUniqueDeviceId")) {
      this.getUniqueDeviceId(callbackContext, this.cordova.getActivity().getApplicationContext());
    }

    return true;
  }

  //--------------------------------------------------------------------------
  // LOCAL METHODS
  //--------------------------------------------------------------------------


  public void getUniqueDeviceId(CallbackContext callback, Context context){

    try {
      final TelephonyManager tm = (TelephonyManager) 
          context.getSystemService(Context.TELEPHONY_SERVICE);

      String tmDevice = "" + tm.getDeviceId(),
          androidId = "" + android.provider.Settings.Secure.getString(context.getContentResolver(), android.provider.Settings.Secure.ANDROID_ID);
      UUID deviceUuid = new UUID(androidId.hashCode(), ((long)tmDevice.hashCode()));
      String deviceId = deviceUuid.toString();

      callback.success(deviceId);
    } catch (Exception e) {
      callback.error(e.toString());
    }

  }

}
