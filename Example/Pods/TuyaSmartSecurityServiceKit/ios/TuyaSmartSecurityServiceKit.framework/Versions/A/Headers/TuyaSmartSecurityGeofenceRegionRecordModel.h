//
//  TYGeofenceRecordInfoModel.h
//  BlocksKit
//
//  Created by MokZF on 2019/9/19.
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

@interface TuyaSmartSecurityGeofenceRegionRecordModel : NSObject


/// 设备唯一识别信息 / Device unique identification ID
@property(nonatomic, copy) NSString *deviceId;

/// 经度(精度到小数点10位) / longitude（Precision to 10 decimal places）
@property(nonatomic, copy) NSString *lon;

/// 纬度(精度到小数点10位) / latitude Precision to 10 decimal places）
@property(nonatomic, copy) NSString *lat;

/// 半径(精度到小数点2位) / radius Precision to 2 decimal places）
@property(nonatomic, copy) NSString *radius;

/// 位置名称 / Location's Name
@property(nonatomic, copy) NSString *title;

@end

NS_ASSUME_NONNULL_END
