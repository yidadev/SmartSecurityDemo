//
//  TYOpenedGeoMemberModel.h
//  BlocksKit
//
//  Created by MokZF on 2019/9/25.
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

@interface TuyaSmartSecurityGeofenceMemberModel : NSObject

/// 用户手机号 / User's Phone Number
@property (nonatomic, copy) NSString *mobile;

/// 用户邮箱 / User's Email
@property (nonatomic, copy) NSString *email;

/// 用户昵称 / User's Nickname
@property (nonatomic, copy) NSString *nickname;

/// 用户ID / User's ID
@property (nonatomic, copy) NSString *uid;

/// 用户名称 / User's name
@property (nonatomic, copy) NSString *username;

/// 设备Id（唯一识别码） / Mobile Phone identification ID
@property (nonatomic, copy) NSString *deviceId;

/// 是否参与 / Whether to join in
@property (nonatomic, assign) NSInteger isEffective;

/// 用户头像 / User‘s head address
@property (nonatomic, copy) NSString *headerUrl;

@end

NS_ASSUME_NONNULL_END
