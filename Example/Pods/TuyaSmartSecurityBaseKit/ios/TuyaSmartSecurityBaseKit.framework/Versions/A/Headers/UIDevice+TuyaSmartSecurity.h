//
//  UIDevice+TuyaSmartSecurity.h
//  TYKABaseComponents
//
//  Created by MokZF on 2019/9/2.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@interface UIDevice (TuyaSmartSecurity)

+ (BOOL)ty_advertisingTrackingEnabled;

+ (NSString *)ty_getDeviceUniqueIdentifier;

+ (NSString *)ty_deviceName;

+ (NSString *)ty_userDeviceName;

@end

NS_ASSUME_NONNULL_END
