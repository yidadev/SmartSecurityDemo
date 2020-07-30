//
//  TuyaSecuritySceneManager.h
//  TuyaSecuritySceneKit
//
//  Created by MokZF on 2020/5/13.
//

#import <TuyaSmartBaseKit/TuyaSmartBaseKit.h>
#import <TuyaSmartSceneKit/TuyaSmartSceneKit.h>
@class TuyaSmartSceneModel;
@class TuyaSmartSecuritySceneAlarmTypeModel;


NS_ASSUME_NONNULL_BEGIN

typedef void(^AddNewSceneSuccessBlock)(TuyaSmartSceneModel *sceneModel);
typedef void(^AlarmTypeListBlock)(NSArray<TuyaSmartSecuritySceneAlarmTypeModel *> *dataArray);


@interface TuyaSmartSecuritySceneManager : TuyaSmartRequest

/// singleInstance
/// 单例
+ (instancetype)sharedInstance;

/// 创建场景
/// @param homeId 家庭id
/// @param sceneModel 场景实体类
/// @param success 成功回调
/// @param failure 失败回调
- (void)createSceneWithHomeId:(long long)homeId
                   sceneModel:(TuyaSmartSceneModel *)sceneModel
                      success:(nullable AddNewSceneSuccessBlock)success
                      failure:(nullable void(^)(NSError *error))failure;

/// 拉取场景列表
/// @param homeId 家庭id
/// @param success 成功回调
/// @param failure 失败回调
- (void)getSceneListWithHomeId:(long long)homeId
                       success:(nullable void(^)(NSArray<TuyaSmartSceneModel *> *list))success
                       failure:(nullable void(^)(NSError *error))failure;

/// 删除场景
/// @param homeId 家庭id
/// @param sceneId 场景id
/// @param success 成功回调
/// @param failure 失败回调
- (void)deleteSceneWithHomeId:(long long)homeId
                      sceneId:(NSString *)sceneId
                      success:(nullable void(^)(BOOL success))success
                      failure:(nullable void(^)(NSError *error))failure;

/// 编辑场景
/// @param homeId 家庭id
/// @param sceneModel 场景实体类
/// @param success 成功回调
/// @param failure 失败回调
- (void)modifySceneWithHomeId:(long long)homeId
                   sceneModel:(TuyaSmartSceneModel *)sceneModel
                      success:(nullable void(^)(void))success
                      failure:(nullable void(^)(NSError *error))failure;
/**
获取场景condition下的设备列表

@param homeId homeId
@param success 成功回调
@param failure 失败回调
*/
- (void)getSceneConditionDeviceListWithHomeId:(long long)homeId
                                      success:(void(^)(NSArray<TuyaSmartDeviceModel *> *list,NSArray<NSString *> *deviceIds))success
                                      failure:(TYFailureError)failure;

/**
 获取场景action下的设备列表

 @param homeId homeId
 @param success 成功回调
 @param failure 失败回调
 */
- (void)getSceneActionDeviceListWithHomeId:(long long)homeId
                                      success:(void(^)(NSArray<TuyaSmartDeviceModel *> *list,NSArray<NSString *> *deviceIds))success
                                      failure:(TYFailureError)failure;

/// 场景获取报警类型列表
/// @param homeId homeId
/// @param success 成功回调
/// @param failure 失败回调
- (void)getSceneAlarmTypeListWithHomeId:(long long)homeId
                                 success:(AlarmTypeListBlock)success
                                 failure:(TYFailureError)failure;




@end

NS_ASSUME_NONNULL_END
