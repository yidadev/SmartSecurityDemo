//
//  TYGeoDeviceModel.h
//  TYKABaseComponents
//
//  Created by MokZF on 2019/9/26.
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

@interface TuyaSmartSecurityGeofenceCommonlyUsedMobileModel : NSObject

/// 用户ID / User ID
@property(nonatomic, copy) NSString *uid;

/// 用户名称 / User Name
@property(nonatomic, copy) NSString *name;

/// 用户设备的UUID /  User Mobile Phone's unique identification ID
@property(nonatomic, copy) NSString *uuid;

/// 选中的设备 / Active Mobile Phone
@property(nonatomic, strong) NSNumber *active;

/// 用户最后登录时间 / The last time the user logged in
@property(nonatomic, assign) NSTimeInterval lastLoginTime;


@end

NS_ASSUME_NONNULL_END
