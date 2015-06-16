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


#import <Cordova/CDV.h>
#import "PGUtils.h"
#import "DeviceManager.h"

#define APP_ID NSString [[NSBundle mainBundle] bundleIdentifier]


@interface PGUtils () {}
@end

@implementation PGUtils

- (void)getUniqueDeviceId:(CDVInvokedUrlCommand*)command
{
    [DeviceManager setAppId:APP_ID];
    
    NSString *deviceID = [DeviceManager getDeviceIdFromKeychain];

    if(!deviceID){
        deviceID = [DeviceManager generateDeviceId];
        // Store the key in the KeyChain
        [DeviceManager storeDeviceIdInKeychain:deviceID];
    }
    
    CDVPluginResult* pluginResult = [CDVPluginResult resultWithStatus:CDVCommandStatus_OK messageAsString:deviceID];
    [self.commandDelegate sendPluginResult:pluginResult callbackId:command.callbackId];
}

- (void) openStore:(CDVInvokedUrlCommand*) command {
    
    NSString* argument = [command.arguments objectAtIndex:0];
    NSArray *arg = [argument componentsSeparatedByString:@"/"];
    NSString *ID = [arg lastObject];

    CDVPluginResult* pluginResult = nil;
    UIApplication *myApp = [UIApplication sharedApplication];
    NSString * appStoreUrl = [NSString stringWithFormat: @"itms-apps://itunes.apple.com/us/app/%@", ID];
    [myApp openURL:[NSURL URLWithString:appStoreUrl]];
    pluginResult = [CDVPluginResult resultWithStatus:CDVCommandStatus_OK messageAsString:("MARKET")];
    [self.commandDelegate sendPluginResult:pluginResult callbackId:command.callbackId];
}

- (void) openApp:(CDVInvokedUrlCommand*) command {
    
    CDVPluginResult* pluginResult = nil;
    
    NSString* argument = [command.arguments objectAtIndex:0];
    NSArray *arg = [argument componentsSeparatedByString:@"/"];
    NSString *scheme = [[arg firstObject] stringByAppendingString:@"://"];

    UIApplication *myApp = [UIApplication sharedApplication];
    
    if ([myApp canOpenURL:[NSURL URLWithString:scheme]]) {
        [myApp openURL:[NSURL URLWithString:scheme]];
        pluginResult = [CDVPluginResult resultWithStatus:CDVCommandStatus_OK messageAsString:("OK")];
        [self.commandDelegate sendPluginResult:pluginResult callbackId:command.callbackId];
    }
    
    else {
        [self openStore:command];
    }
    
}
@end