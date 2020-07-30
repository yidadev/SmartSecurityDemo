//
//  TYEventSensorModel.h
//  BlocksKit
//
//  Created by Wei Zhang on 2019/10/23.
//

#import <Foundation/Foundation.h>
#import <TuyaSmartDeviceKit/TuyaSmartDeviceKit.h>
NS_ASSUME_NONNULL_BEGIN


typedef NS_ENUM(NSInteger,TYEventRecordingCameraBindingType) {
    // 配
    TYEventRecordingCameraBindingTypeImage = 1,
    TYEventRecordingCameraBindingTypeVideo = 2
};

typedef NS_ENUM(NSInteger, TYEventLinkCameraSupportType){
    TYEventLinkCameraSupportTypeOnlyImage = 1,
    TYEventLinkCameraSupportTypeBoth = 2
};

static NSString * const _Nullable kLinkTypeImage = @"image";
static NSString * const _Nullable kLinkTypeVedio = @"video";


@interface TuyaSmartSecurityEventRecordingLinkTaskCameraModel : NSObject


/// 摄像头ID
@property (nonatomic, copy) NSString *cameraId;

/// 绑定的类型
@property (nonatomic, assign) NSInteger type;

/// 是否选中
@property (nonatomic, assign) BOOL isSelected;

@end

@interface TuyaSmartSecurityEventRecordingLinkTaskModel : NSObject

/// 规则Id，第一次创建传nil, 再次编辑传上次的规则ID
@property (nonatomic, copy) NSString *ruleId;

/// 传感器设备ID
@property (nonatomic, copy) NSString *sensorId;

/// 传感器商品ID
@property (nonatomic, copy) NSString *productId;

/// 传感器绑定的摄像头列表
@property (nonatomic, strong) NSArray<TuyaSmartSecurityEventRecordingLinkTaskCameraModel *> *cameraModelList;

@end




@interface TuyaSmartSecurityEventRecordingBindCameraModel : NSObject

/// 摄像头识别Id / Camera Device ID
@property (nonatomic, copy) NSString *entityId;

/// 摄像头绑定类型  / Camera binding type
@property (nonatomic, assign) TYEventRecordingCameraBindingType type;

///设备信息 /  Device information
@property (nonatomic, strong) TuyaSmartDeviceModel *deviceModel;

/// 支持的绑定类型 / Supported binding types
@property (nonatomic, assign) TYEventLinkCameraSupportType linkCameraSupportType;

@end


@interface TuyaSmartSecurityEventRecordingSensorModel : NSObject

/// 设备Id / Device ID
@property (nonatomic, copy) NSString *deviceId;

/// 绑定的摄像头列表 / List of cameras
@property (nonatomic, strong) NSArray<TuyaSmartSecurityEventRecordingBindCameraModel *> *actionInfos;

/// 是否绑定过摄像头 / Whether it has been attached to the camera
@property (nonatomic, assign) BOOL linked;

/// 设备信息 /  Device information
@property (nonatomic, strong) TuyaSmartDeviceModel *deviceModel;

@end

NS_ASSUME_NONNULL_END
