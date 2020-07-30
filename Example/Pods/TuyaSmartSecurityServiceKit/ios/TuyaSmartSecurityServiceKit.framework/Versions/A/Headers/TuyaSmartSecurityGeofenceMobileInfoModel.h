//
//  TYSecurityDeviceInfoModel.h
//  TYKABaseComponents
//
//  Created by MokZF on 2019/9/2.
//

#import <Foundation/Foundation.h>

@interface TuyaSmartSecurityGeofenceMobileInfoModel : NSObject

/// 移动设备id / mobile device n
@property(nonatomic, copy, nonnull) NSString *deviceId;

/// 移动设备名称
@property(nonatomic, copy, nonnull) NSString *deviceName;

@end
