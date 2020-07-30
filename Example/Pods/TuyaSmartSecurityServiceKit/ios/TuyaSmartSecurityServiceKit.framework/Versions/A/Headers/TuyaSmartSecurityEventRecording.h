//
//  TuyaSecurityEventRecording.h
//  BlocksKit
//
//  Created by Wei Zhang on 2020/5/18.
//

#import <Foundation/Foundation.h>
#import <TuyaSmartBaseKit/TuyaSmartBaseKit.h>
#import <TuyaSmartUtil/TuyaSmartUtil.h>

@class TuyaSmartSecurityEventRecordingSensorModel;
@class TuyaSmartSecurityEventRecordingLinkRuleModel;
@class TuyaSmartSecurityEventRecordingLinkTaskModel;


typedef void (^EventRecordingSensorList)(NSArray<TuyaSmartSecurityEventRecordingSensorModel *> * _Nullable sensorList);

typedef void (^EventRecordingCameraLink)(TuyaSmartSecurityEventRecordingLinkRuleModel * _Nullable linkRuleModel);

typedef void (^EventRecordingStorageBindCameraList)(NSArray<NSString *> * _Nullable cameraList);



NS_ASSUME_NONNULL_BEGIN

@interface TuyaSmartSecurityEventRecording : NSObject

/// singleInstance
/// 单例
+ (instancetype)sharedInstance;


/// 获取传感设备列表
/// Gets a list of sensing devices
///
/// @param homeId 家庭Id / Home ID
/// @param success 成功回调 / Success Callback
/// @param failure 失败回调 / Fauilre Callback
- (void)getSensorList:(long long)homeId
              success:(EventRecordingSensorList)success
              failure:(TYFailureError)failure;


/// 获取传感器绑定的摄像头列表
/// Gets a list of cameras for the specified sensor bindings
///
/// @param homeId 家庭Id / Home ID
/// @param deviceId 传感器设备Id
/// @param success 成功回调 / Success Callback
/// @param failure 失败回调 / Fauilre Callback
- (void)getLinkedCameras:(long long)homeId
                deviceId:(NSString *)deviceId
                 success:(EventRecordingCameraLink)success
                 failure:(TYFailureError)failure;


/// 绑定摄像头
/// Bind Cameras
///
/// @param homeId 家庭Id / Home ID
/// @param taskModel 绑定摄像头数据的模型
/// @param success 成功回调 / Success Callback
/// @param failure 失败回调 / Fauilre Callback
- (void)linkCamera:(long long)homeId
         taskModel:(TuyaSmartSecurityEventRecordingLinkTaskModel *)taskModel
           success:(TYSuccessBOOL)success
           failure:(TYFailureError)failure;


/// 获取已绑定云存储的摄像头列表
/// Gets the list of cameras that have been bound to the cloud storage
///
/// @param homeId 家庭Id / Home ID
/// @param nCameraIdList 摄像头设备列表 
/// @param success 成功回调 / Success Callback
/// @param failure 失败回调 / Fauilre Callback
- (void)getStorageBindCameraList:(long long)homeId
                    cameraIdList:(NSArray<NSString *> *)nCameraIdList
                         success:(EventRecordingStorageBindCameraList)success
                         failure:(TYFailureError)failure;



@end

NS_ASSUME_NONNULL_END
