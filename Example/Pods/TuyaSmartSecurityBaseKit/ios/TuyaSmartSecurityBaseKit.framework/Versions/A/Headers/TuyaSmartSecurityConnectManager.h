//
//  TuyaSecurityConnectManager.h
//  TuyaSmartSecurityBaseKit
//
//  Created by MokZF on 2020/5/11.
//

#import <Foundation/Foundation.h>

@class TuyaSmartSecurityEmergencyListModel;

NS_ASSUME_NONNULL_BEGIN

typedef void(^TYEmergencyConnectListBlock)(NSArray<TuyaSmartSecurityEmergencyListModel *> *dataArray);

@interface TuyaSmartSecurityConnectManager : NSObject

/// 单例初始化
/// Singleton initialization
+ (instancetype)sharedInstance;

/// 获取家庭紧急联系人列表
/// Get the family emergency contact list
/// @param homeId 家庭id / Location id
/// @param success 成功回调 / Success Callback
/// @param failure 失败回调 / Failure Callback
- (void)getLocationEmergencyConnectWithHomeId:(long long)homeId
                                      success:(nullable TYEmergencyConnectListBlock)success
                                      failure:(nullable void(^)(NSError *error))failure;

/// 添加紧急联系人
/// Add an emergency contact
/// @param homeId 家庭id / Location id
/// @param infoModel 联系人信息 / Contact information
/// @param success 成功回调 / Success Callback
/// @param failure 失败回调 / Failure Callback
- (void)addNewConnectWithHomeId:(long long)homeId
                   connectModel:(TuyaSmartSecurityEmergencyListModel *)infoModel
                        success:(nullable void(^)(BOOL success))success
                        failure:(nullable void(^)(NSError *error))failure;

/// 编辑联系人
/// Edit contact
/// @param homeId 家庭id / Location id
/// @param infoString 联系人信息 / Contact information
/// @param success 成功回调 / Success Callback
/// @param failure 失败回调 / Failure Callback

- (void)editConnectWithHomeId:(long long)homeId
                  connectInfo:(NSString *)infoString
                      success:(nullable void(^)(BOOL success))success
                      failure:(nullable void(^)(NSError *error))failure;

/// 删除紧急联系人
/// Delete emergency contact
/// @param homeId 家庭id / Location id
/// @param ids 联系人id / The contact id
/// @param success 成功回调 / Success Callback
/// @param failure 失败回调 / Failure Callback
- (void)deleteConnectWithHomeId:(long long)homeId
               withConnectIds:(NSString *)ids
                      success:(nullable void(^)(BOOL success))success
                      failure:(nullable void(^)(NSError *error))failure;



@end

NS_ASSUME_NONNULL_END
