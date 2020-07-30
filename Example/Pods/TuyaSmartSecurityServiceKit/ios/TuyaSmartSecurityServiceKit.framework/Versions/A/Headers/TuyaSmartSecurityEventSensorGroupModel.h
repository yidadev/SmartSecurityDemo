//
//  TYEventSensorGroupModel.h
//  BlocksKit
//
//  Created by Wei Zhang on 2019/10/23.
//

#import <Foundation/Foundation.h>
#import "TuyaSmartSecurityEventRecordingSensorModel.h"


NS_ASSUME_NONNULL_BEGIN

@interface TuyaSmartSecurityEventSensorGroupModel : NSObject


/// 房间名称 / Room Name
@property (nonatomic, copy) NSString *roomName;

/// 传感器设备列表 /  Sensor List
@property (nonatomic, strong) NSArray<TuyaSmartSecurityEventRecordingSensorModel *> *sensorDeviceList;

@end

NS_ASSUME_NONNULL_END
