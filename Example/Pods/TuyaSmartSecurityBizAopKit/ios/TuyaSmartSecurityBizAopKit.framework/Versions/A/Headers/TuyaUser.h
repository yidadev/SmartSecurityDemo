//
//  TuyaUser.h
//  TuyaSmart
//
//  Created by fengyu on 15/3/13.
//  Copyright (c) 2015年 Tuya. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "TYDomainModel.h"

#define kDefaultTuyaUserV4          @"kDefaultTuyaUserV4"
#define kDefaultTuyaUserCurrentKey  kDefaultTuyaUserV4

typedef enum : NSUInteger {
    TYLoginFromQQ = 1,
    TYLoginFromWX,
    TYLoginFromFB,
    TYLoginFromTW,
    TYLoginFromIG,
    TYLoginFromPhone,//手机号验证码登录 和手机密码登录
    TYLoginFromEmail,
    TYLoginFromUid,
} TYLoginSource;

@interface TuyaUser : NSObject

+ (instancetype)sharedInstance;

@property (nonatomic, strong) NSString *sid;
@property (nonatomic, strong) NSString *ecode;
@property (nonatomic, strong) NSString *nickname;
@property (nonatomic, strong) NSString *username;
@property (nonatomic, strong) NSString *mobile;
@property (nonatomic, strong) NSString *headPic;
@property (nonatomic, strong) NSString *uid;
@property (nonatomic, strong) NSString *phoneCode;
@property (nonatomic, strong) NSString *partnerIdentity;
@property (nonatomic, strong) NSString *email;
@property (nonatomic, strong) NSString *timezoneId;
@property (nonatomic, assign) NSInteger tempUnit;
@property (nonatomic, assign) TYLoginSource source;
@property (nonatomic, strong) TYDomainModel *domain;
@property (nonatomic, strong) NSString *env;
@property (nonatomic, assign) int dataVersion;
@property (nonatomic, assign) NSInteger regFrom;
@property (nonatomic, strong) NSString *snsNickname;

//登录成功以后调用
+ (void)resetWithUserInfo:(NSDictionary *)info source:(TYLoginSource)source;

+ (void)updateUserInfo:(NSDictionary *)info;

+ (void)clearUserInfo;

+ (BOOL)isLogin;

+ (void)setup __deprecated_msg("Just remove it directly");

+ (void)resetInstance;

// 保存TuyaUser到UserDefaults
+ (void)synchronize;

@end
