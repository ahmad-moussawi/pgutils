//
//  DeviceManager.h
//  Cloud3
//
//  Created by Mona Mouteirek on 4/10/13.
//  Copyright (c) 2013 FOO. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface DeviceManager : NSObject

+ (void)setAppId:(NSString *)appId;
+ (NSString *)generateDeviceId;
+ (BOOL)storeDeviceIdInKeychain:(NSString *)deviceId;
+ (BOOL)deleteDeviceIdFromKeychain;
+ (NSString *)getDeviceIdFromKeychain;

+ (NSString *)getDeviceName;

+ (NSString *)genRandStringWithLength:(int)len;

@end
