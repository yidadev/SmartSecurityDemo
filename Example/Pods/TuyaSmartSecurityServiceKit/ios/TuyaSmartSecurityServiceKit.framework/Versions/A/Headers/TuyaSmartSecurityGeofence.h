//
//  TuyaSecurityGeofence.h
//  BlocksKit
//
//  Created by Wei Zhang on 2020/5/12.
//

#import <Foundation/Foundation.h>
#import <TuyaSmartBaseKit/TuyaSmartBaseKit.h>
#import <TuyaSmartUtil/TuyaSmartUtil.h>


@class TuyaSmartSecurityGeofenceMobileInfoModel;
@class TuyaSmartSecurityGeofenceCommonlyUsedMobileModel;
@class TuyaSmartSecurityGeofenceMemberModel;
@class TuyaSmartSecurityGeofenceRegionDataModel;
@class TuyaSmartSecurityGeofenceRegionRecordModel;


typedef void(^GeofenceMobileList)(NSArray<TuyaSmartSecurityGeofenceCommonlyUsedMobileModel *> * _Nullable mobileList);


typedef void(^GeofenceMemberList)(NSArray<TuyaSmartSecurityGeofenceMemberModel *> * _Nullable memberList);


typedef void(^GeofenceRegionData)(TuyaSmartSecurityGeofenceRegionDataModel * _Nullable dataModel);


typedef void(^AllHomeGeofenceList)(NSArray<TuyaSmartSecurityGeofenceRegionDataModel *> * _Nullable geofenceList);


NS_ASSUME_NONNULL_BEGIN

@interface TuyaSmartSecurityGeofence : NSObject

/// singleInstance
/// 单例
+ (instancetype)sharedInstance;


/// 上传手机设备信息
/// Upload mobile device information
///
/// @param homeId 家庭Id / Home ID
/// @param deviceModel 设备信息Model / Mobile phone information
/// @param success 成功回调 / Success Callback
/// @param failure 失败回调 / Failure Callback
- (void)uploadMobileInfo:(long long)homeId
             deviceModel:(TuyaSmartSecurityGeofenceMobileInfoModel *)deviceModel
                 success:(TYSuccessDict)success
                 failure:(TYFailureError)failure;


/// 查询登录过当前家庭的设备列表
/// Query the list of devices logged into the current home
///
/// @param homeId 家庭Id / Home ID
/// @param success 成功回调 / Success Callback
/// @param failure 失败回调 / Failure Callback
- (void)getMobileList:(long long)homeId
              success:(GeofenceMobileList)success
              failure:(TYFailureError)failure;

/// 设置常用手机
/// Set up commonly used mobile phone
///
/// @param homeId 家庭Id / Home ID
/// @param deviceId 设备Id / Device ID
/// @param success 成功回调 / Success Callback
/// @param failure 失败回调 / Failure Callback
- (void)setCommonlyUsedMobile:(long long)homeId
                     deviceId:(NSString *)deviceId
                      success:(TYSuccessBOOL)success
                      failure:(TYFailureError)failure;


/// 删除用户手机
/// Delete user's phone
///
/// @param homeId 家庭Id / Home ID
/// @param deviceId 设备Id / Device ID
/// @param success 成功回调 / Success Callback
/// @param failure 失败回调 / Failure Callback
- (void)deleteMobile:(long long)homeId
            deviceId:(NSString *)deviceId
             success:(TYSuccessBOOL)success
             failure:(TYFailureError)failure;


/// 获取个人地理围栏服务状态
/// Get the status of personal geographic fence service
///
/// @param homeId 家庭ID / Home ID
/// @param success 成功回调 / Success Callback
/// @param failure 失败回调 / Failure Callback
- (void)getGeoServiceStatus:(long long)homeId
                    success:(TYSuccessBOOL)success
                    failure:(TYFailureError)failure;


/// 切换个人地理围栏服务状态
/// Toggle individual geographic fence service status
///
/// @param homeId 家庭id / Home ID
/// @param geoStatus 地理围栏开关 / Geofence status
/// @param success 成功回调 / Success Callback
/// @param failure 失败回调 / Failure Callback
- (void)switchGeoService:(long long)homeId
               geoStatus:(BOOL)geoStatus
                 success:(TYSuccessBOOL)success
                 failure:(TYFailureError)failure;


/// 获取家庭地理围栏的开关状态
/// Gets the on-off status of the home geographic fence
///
/// @param homeId 家庭Id / Home ID
/// @param success 成功回调 / Success Callback
/// @param failure 失败回调 / Failure Callback
- (void)getGeoFenceStatus:(long long)homeId
                  success:(TYSuccessBOOL)success
                  failure:(TYFailureError)failure;


/// 切换家庭地理围栏的开关
/// Switch the home geographic fence switch
///
/// @param homeId 家庭Id / Home ID
/// @param fenceStatus 地理围栏的状态
/// @param success 成功回调 / Success Callback
/// @param failure 失败回调 / Failure Callback
- (void)switchGeoFence:(long long)homeId
         fenceStatus:(BOOL)fenceStatus
               success:(TYSuccessBOOL)success
               failure:(TYFailureError)failure;


/// 查询可以参与家庭地理围栏的家庭成员
/// Search for family members who can participate in the family geographic fence
///
/// @param homeId 家庭Id / Home ID
/// @param success 成功回调 / Success Callback
/// @param failure 失败回调 / Failure Callback
- (void)getGeoFenceMemberList:(long long)homeId
                      success:(GeofenceMemberList)success
                      failure:(TYFailureError)failure;


/// 查询地理围栏详情
/// For details of geographical fencing
///
/// @param homeId 家庭id / Home ID
/// @param success 成功回调 / Success Callback
/// @param failure 失败回调 / Failure Callback
- (void)getHomeGeoFencingData:(long long)homeId
                      success:(GeofenceRegionData)success
                      failure:(TYFailureError)failure;


/// 查询当前设备下，开启的地理围栏的家庭及信息
/// Inquire the home and information of the geographical fence opened under the current equipment
///
/// @param homeId 家庭Id / Home ID
/// @param deviceId 本地设备唯一值 / Local device Unique identification ID
/// @param success 成功回调 / Success Callback
/// @param failure 失败回调 / Failure Callback
- (void)getAllHomeGeoFence:(long long)homeId
                  deviceId:(NSString *)deviceId
                   success:(AllHomeGeofenceList)success
                   failure:(TYFailureError)failure;


/// 保存地理围栏信息
/// Save the information from geofence
///
/// @param homeId 家庭id / Home ID
/// @param recordModel 地理围栏信息 / Geofence information
/// @param success 成功回调 / Success Callback
/// @param failure 失败回调 / Failure Callback
- (void)recordInitialDeviceStatus:(long long)homeId
                      recordModel:(TuyaSmartSecurityGeofenceRegionRecordModel *)recordModel
                          success:(TYSuccessBOOL)success
                          failure:(TYFailureError)failure;


/// 手机离开或者进入地理围栏区域
/// The phone leaves or enters a geologically fenced area
///
/// @param homeId 家庭id / Home ID
/// @param geofenceHomeId 触发地理围栏的homeId / The homeId that triggered the geographic fence
/// @param deviceId 手机的唯一标识 / Unique identification of mobile phone
/// @param isLeaving 是否是离家 / Leave home or not
/// @param success 成功回调 / Success Callback
/// @param failure 失败回调 / Failure Callback
- (void)processMobileInfo:(long long)homeId
           geofenceHomeId:(long long)geofenceHomeId
                 deviceId:(NSString *)deviceId
                 isLeving:(BOOL)isLeaving
                  success:(TYSuccessBOOL)success
                  failure:(TYFailureError)failure;


@end

NS_ASSUME_NONNULL_END
