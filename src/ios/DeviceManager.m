//
//  DeviceManager.m
//  Cloud3
//
//  Created by Mona Mouteirek on 4/10/13.
//  Copyright (c) 2013 FOO. All rights reserved.
//

#import "DeviceManager.h"
#import "KeychainItemWrapper.h"

#define DEVICE_ID_KEY @"DEVICE_ID"

static DeviceManager *defaultManager = nil;

@interface DeviceManager ()
@property (nonatomic, retain) NSString *applicationId;

+ (NSString *)genRandStringWithLength:(int)len;

@end

@implementation DeviceManager

+ (DeviceManager *)defaultManager {
	if (defaultManager == nil) {
		defaultManager = [[DeviceManager alloc] init];
	}
	return defaultManager;
}

+ (void)setAppId:(NSString *)appId {
	[[DeviceManager defaultManager] setApplicationId:appId];
}

+ (NSString *)generateDeviceId {
	if ([[NSBundle mainBundle] bundleIdentifier]) {
		NSString *deviceId = [DeviceManager GetUUID];
		return deviceId;
	}
	return nil;
}

+ (BOOL)storeDeviceIdInKeychain:(NSString *)deviceId {
	NSString *appId = [[NSBundle mainBundle] bundleIdentifier];
	if (appId) {
		KeychainItemWrapper *wrapper = [[KeychainItemWrapper alloc] initWithIdentifier:DEVICE_ID_KEY accessGroup:nil];
		[wrapper setObject:appId forKey:(id)kSecAttrService];
		[wrapper resetKeychainItem];
		[wrapper setObject:deviceId forKey:(id)kSecValueData];
		[wrapper release];
		return YES;
	}
	return NO;
}

+ (BOOL)deleteDeviceIdFromKeychain {
	NSString *appId = [[NSBundle mainBundle] bundleIdentifier];
	if (appId) {
		KeychainItemWrapper *wrapper = [[KeychainItemWrapper alloc] initWithIdentifier:DEVICE_ID_KEY accessGroup:nil];
		[wrapper setObject:appId forKey:(id)kSecAttrService];
		[wrapper resetKeychainItem];
		[wrapper release];
		return YES;
	}
	return NO;
}

+ (NSString *)getDeviceIdFromKeychain {
	NSString *appId = [[NSBundle mainBundle] bundleIdentifier];
	if (appId) {
		KeychainItemWrapper *wrapper = [[KeychainItemWrapper alloc] initWithIdentifier:DEVICE_ID_KEY accessGroup:nil];
		[wrapper setObject:appId forKey:(id)kSecAttrService];
		NSString *savedSecret = [wrapper objectForKey:(id)kSecValueData];
		[wrapper release];
        if (savedSecret.length > 0)
            return savedSecret;
        else
            return nil;
	}
	return nil;
}

+ (NSString *)GetUUID
{
    CFUUIDRef theUUID = CFUUIDCreate(NULL);
    CFStringRef string = CFUUIDCreateString(NULL, theUUID);
    CFRelease(theUUID);
    return [(NSString *)string autorelease];
}

+ (NSString *)genRandStringWithLength:(int)len {
	NSString *letters = @"abcdefghijklmnopqrstuvwxyzABCDEFGHIJKLMNOPQRSTUVWXYZ0123456789";
	NSMutableString *randomString = [NSMutableString stringWithCapacity: len];
	
    for (int i=0; i<len; i++) {
		[randomString appendFormat: @"%C", [letters characterAtIndex: arc4random() % [letters length]]];
    }
    return randomString;
}

+ (NSString *)getDeviceName {
	return [[UIDevice currentDevice] name];
}

@end
