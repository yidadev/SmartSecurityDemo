//
//  TYNotificaitonSettingCategoryModel.h
//  TuyaSecuritySDK
//
//  Created by MokZF on 2019/10/23.
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

@interface TuyaSmartSecurityNotificaitonSettingCategoryModel : NSObject

@property (nonatomic, assign) BOOL sms;
@property (nonatomic, assign) BOOL voicecall;
@property (nonatomic, assign) BOOL push;
@property (nonatomic, assign) BOOL email;
@end

NS_ASSUME_NONNULL_END
