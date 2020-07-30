//
//  TuyaSmartSecurityUser.h
//  BlocksKit
//
//  Created by Wei Zhang on 2020/5/7.
//

#import <Foundation/Foundation.h>
#import <TuyaSmartBaseKit/TuyaSmartBaseKit.h>

@class TuyaSmartSecurityUserServiceModel;

typedef void (^GetUserServiceHandler)(TuyaSmartSecurityUserServiceModel * _Nullable userServiceModel);

NS_ASSUME_NONNULL_BEGIN

@interface TuyaSmartSecurityUser : NSObject

/// 单例
/// Single instance
+ (instancetype)sharedInstance;

/// 使用uid登录注册
/// uid login or register users
///
/// @param countryCode 国家码 / countryCode
/// @param uid 三方的唯一识别ID / Union identify ID
/// @param password  密码 / password
/// @param success 成功回调 / Success Callback
/// @param failure 失败回调 / Failure Callback
- (void)loginOrRegisterWithCountryCode:(NSString *)countryCode
                                   uid:(NSString *)uid
                              password:(NSString *)password
                               success:(TYSuccessID)success
                               failure:(TYFailureError)failure;

/// 获取用户的服务信息
/// get user service information.
///
/// 如果用户已经绑定激活码，当前服务信息会记录在本地
/// If the user has already bound the activation code, the current service information is recorded locally
///
/// @param success 成功回调 / Success Callback
/// @param failure 失败回调 / Failure Callback
- (void)getServiceInfoWithSuccess:(GetUserServiceHandler)success
                          failure:(TYFailureError)failure;


/// 绑定服务激活码
/// Binding service activation code
///
/// @param aCode 激活码 / Activation code
/// @param success 成功回调 / Success Callback
/// @param failure 失败回调 / Failure Callback
- (void)bindServiceWithCode:(NSString *)aCode
                    success:(TYSuccessID)success
                    failure:(TYFailureError)failure;

@end

NS_ASSUME_NONNULL_END
