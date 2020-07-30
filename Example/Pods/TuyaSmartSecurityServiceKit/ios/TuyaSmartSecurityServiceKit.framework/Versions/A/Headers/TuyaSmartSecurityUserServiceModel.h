//
//  TYUserServiceModel.h
//  BlocksKit
//
//  Created by Wei Zhang on 2020/5/7.
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

@interface TuyaSmartSecurityUserServiceModel : NSObject

/// 是否绑定
@property (nonatomic, assign) NSInteger isBind;

/// 激活码
@property (nonatomic, copy) NSString *code;

/// 绑定的渠道
@property (nonatomic, copy) NSString *channelId;

/// 绑定的服务商
@property (nonatomic, copy) NSString *dealerId;

@end

NS_ASSUME_NONNULL_END
