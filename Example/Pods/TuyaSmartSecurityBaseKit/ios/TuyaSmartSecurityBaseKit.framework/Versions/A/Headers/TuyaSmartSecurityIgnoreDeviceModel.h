//
//  TYSecurityIgnoreDeviceModel.h
//  TuyaSecuritySDK
//
//  Created by MokZF on 2020/4/9.
//

#import <Foundation/Foundation.h>

@interface TuyaSmartSecurityIgnoreDeviceModel : NSObject

@property (nonatomic, assign) NSInteger state;
@property (nonatomic, copy) NSString *gwId;
@property (nonatomic, strong) NSArray<NSString *> *ignore;

@end

@interface TuyaSmartSecurityBypassDeviceModel : NSObject

@property (nonatomic, assign) NSInteger state;
@property (nonatomic, copy) NSString *gwId;
@property (nonatomic, strong) NSArray<NSString *> *bypass;//设备NodeId
@property (nonatomic, strong) NSArray<NSString *> *bypassDeviceIds;//设备deviceId


@end

