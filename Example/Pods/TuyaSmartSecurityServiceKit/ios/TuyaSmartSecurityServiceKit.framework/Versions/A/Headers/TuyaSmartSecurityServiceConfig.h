//
//  TuyaSecurityServiceConfig.h
//  BlocksKit
//
//  Created by Wei Zhang on 2020/5/7.
//

#import <Foundation/Foundation.h>
#import <TuyaSmartBaseKit/TuyaSmartBaseKit.h>

NS_ASSUME_NONNULL_BEGIN

@interface TuyaSmartSecurityServiceConfig : NSObject


/// singleInstance
/// 单例
+ (instancetype)sharedInstance;

/// 获取服务配置
/// Get service configuration
///
/// @param success 成功回调,目前有service_url（服务套餐地址） help_url（帮助页面连接） / Success Callback，service_url(Service plan URL)  help_url(Help Page URL)
/// @param failure 失败回调 / Failure Callback
- (void)getServiceConfigWithSuccess:(TYSuccessDict)success
                            failure:(TYFailureError)failure;

/// 根据userId的获取URL配置
/// Configuration based on the get URL of the userId
///
/// @param userId 用户ID / User ID
- (NSDictionary *)getServiceConfigURLMapFromCacheWithUid:(NSString *)userId;

@end

NS_ASSUME_NONNULL_END
