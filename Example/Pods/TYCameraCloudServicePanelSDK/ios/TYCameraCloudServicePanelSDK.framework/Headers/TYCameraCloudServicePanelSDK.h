//
//  TYCameraCloudServicePanelSDK.h
//  TYCameraCloudServicePanelSDK
//
//  Created by 傅浪 on 2019/7/31.
//

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>

@class TuyaSmartDeviceModel;
NS_ASSUME_NONNULL_BEGIN

@interface TYCameraCloudServicePanelSDK : NSObject

/**
 初始化SDK，需要在 TuyaSmartSDK 初始化后调用

 @param scheme iot平台上的渠道标识符
 */
+ (void)setupWithAppScheme:(NSString *)scheme;

/**
 在用户登录登出的时候，需要调用此方法，同步用户状态
 */
+ (void)userStateChanged;

/**
 获取云存储购买页面

 @param deviceModel 设备
 @param success 成功回调
 @param failure 失败回调
 */
+ (void)cloudServicePanelWithDevice:(TuyaSmartDeviceModel *)deviceModel
                            success:(void(^)(UIViewController *vc))success
                            failure:(void(^)(NSError *error))failure;

@end

NS_ASSUME_NONNULL_END
