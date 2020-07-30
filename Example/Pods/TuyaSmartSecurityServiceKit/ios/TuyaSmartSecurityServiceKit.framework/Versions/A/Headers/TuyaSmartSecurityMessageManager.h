//
//  TuyaSecurityMessageManager.h
//  TuyaSecurityMessageKit
//
//  Created by MokZF on 2020/5/12.
//

#import <Foundation/Foundation.h>
#import "TuyaSmartSecurityMessageKitDefinition.h"
#import "TuyaSmartSecurityActivityMessageModel.h"
#import "TuyaSmartSecurityNotificationCategoryListModel.h"

NS_ASSUME_NONNULL_BEGIN

typedef void(^TYSecurityMessageListBlcok)(NSArray<TuyaSmartSecurityActivityMessageModel *> *dataArray);
typedef void(^NotificationCategoryListBlock)(NSArray<TuyaSmartSecurityNotificationCategoryListModel *> *dataArray);

@interface TuyaSmartSecurityMessageManager : NSObject

+ (instancetype)sharedInstance;

/// 获取消息中心消息列表
///
///
/// @param homeId 家庭id
/// @param messageType 消息类型
/// @param isBatchesCollect 是否是收藏消息
/// @param startDate 开始时间
/// @param endDate 结束时间
/// @param offset 页码
/// @param success 成功回调
/// @param failure 失败回调
- (void)getCenterMessagesWithHomeId:(long long)homeId
                        messageType:(TYSecurityArmedMsgType)messageType
                   isBatchesCollect:(BOOL)isBatchesCollect
                          startDate:(nullable NSString *)startDate
                            endDate:(nullable NSString *)endDate
                             offset:(NSInteger)offset
                            success:(nullable TYSecurityMessageListBlcok)success
                            failure:(nullable void(^)(NSError *error))failure;

/**
 收藏消息/取消收藏消息

 @param homeId homeId
 @param messageIds 消息Id
 @param favoriteState 收藏状态
 @param success 成功回调
 @param failure 失败回调
 */
- (void)updateFavoriteMessageStateWithHomeId:(long long) homeId
                                  messageIds:(NSString *)messageIds
                               favoriteState:(TYSecurityMessageFavoriteState)favoriteState
                                     success:(nullable void(^)(BOOL success))success
                                     failure:(nullable void(^)(NSError *error))failure;

/**
 批量删除消息列表

 @param homeId 家庭id
 @param messageId 消息id
 @param messageType 消息type 1-CAMERA,2-SECURITY,3-GENERAL
 @param success 成功回调
 @param failure 失败回调
 */
- (void)removeCenterMessagesWithHomeId:(long long)homeId
                             messageId:(NSString *)messageId
                           withMsgType:(NSString *)messageType
                               success:(nullable void(^)(BOOL success))success
                               failure:(nullable void(^)(NSError *error))failure;

/// 更新消息已读状态
/// @param homeId 家庭id
/// @param messageId 消息id
/// @param messageType 消息类型
/// @param success 成功回调
/// @param failure 失败回调
- (void)updateMessageStateWithHomeId:(long long)homeId
                           messageId:(NSString *)messageId
                         messageType:(NSString *)messageType
                             success:(nullable void(^)(BOOL success))success
                             failure:(nullable void(^)(NSError *error))failure;


/// 获取通知设置页面默认信息
/// @param homeId 家庭id
/// @param success 成功回调
/// @param failure 失败回调
- (void)getNotificationCategoryListWithHomeId:(long long)homeId
                                      success:(nullable void(^)(NSDictionary *resultDictionary))success
                                      failure:(nullable void(^)(NSError *error))failure;

/// 更新通知开关设置
/// @param homeId 家庭id
/// @param bizId 通知类别id
/// @param bizValue 开关状态
/// @param success 成功回调
/// @param failure 失败回调
- (void)updateNotificationCategoryWithHomeId:(long long)homeId
                                       bizId:(NSString *)bizId
                                    bizValue:(BOOL)bizValue
                                     success:(nullable void(^)(BOOL success))success
                                     failure:(nullable void(^)(NSError *error))failure;

/// 拉取通知配置默认设置
/// @param homeId 家庭id
/// @param bizId 业务大类，push,email,sms,voicecall
/// @param bizKey 业务子类别（alarmAlerts, cameraAlerts, homeAutomationAlerts, bulletins）
/// @param success 成功回调
/// @param failure  失败回调
- (void)getNotificationConfigListWithHomeId:(long long)homeId
                                      bizId:(NSString *)bizId
                                     bizKey:(NSString *)bizKey
                                    success:(nullable NotificationCategoryListBlock)success
                                    failure:(nullable void(^)(NSError *error))failure;

/// 更新通知配置开关状态
/// @param homeId 家庭id
/// @param bizId 业务大类，push,email,sms,voicecall
/// @param messageType 配置项类型
/// @param bizValue 开关状态
/// @param success 成功回调
/// @param failure 失败回调
- (void)updateNotificationConfigWithHomeId:(long long)homeId
                                     bizId:(NSString *)bizId
                               messageType:(NSInteger)messageType
                                  bizValue:(BOOL)bizValue
                                   success:(nullable void(^)(BOOL success))success
                                   failure:(nullable void(^)(NSError *error))failure;

/// 重置通知配置状态
/// @param homeId 家庭id
/// @param bizId 业务大类，push,email,sms,voicecall
/// @param bizKey 业务子类别（alarmAlerts, cameraAlerts, homeAutomationAlerts, bulletins）
/// @param success 成功回调
/// @param failure 失败回调
- (void)resetNotificationConfigDefaultWithHomeId:(long long)homeId
                                           bizId:(NSString *)bizId
                                          bizKey:(NSString *)bizKey
                                         success:(nullable void(^)(BOOL success))success
                                         failure:(nullable void(^)(NSError *error))failure;

/// 获取push推送声音、震动配置
/// @param homeId homeId
/// @param bizId 业务id (push)
/// @param bizKey 业务key(customizeConfig)
/// @param success 成功回调
/// @param failure 失败回调
- (void)getNotDisturbConfigListWithHomeId:(long long)homeId
                                    bizId:(NSString *)bizId
                                   bizKey:(NSString *)bizKey
                                  success:(nullable NotificationCategoryListBlock)success
                                  failure:(nullable void(^)(NSError *error))failure;

/// 更新免打扰时间
/// @param homeId homeId
/// @param bizId 业务Id(push)
/// @param targetId Id
/// @param startTime 开始时间
/// @param endTime 结束时间
/// @param success 更新成功回调
/// @param failure 更新失败回调
 - (void)updateNotDisturbTimeWithHomeId:(long long)homeId
                                  bizId:(NSString *)bizId
                               targetId:(NSString *)targetId
                              startTime:(NSString *)startTime
                                endTime:(NSString *)endTime
                                success:(nullable void(^)(NSString *result))success
                                failure:(nullable void(^)(NSError *error))failure;
@end

NS_ASSUME_NONNULL_END
