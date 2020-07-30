//
//  TYLocaitonStateModel.h
//  TuyaSecuritySDK
//
//  Created by MokZF on 2020/4/14.
//

#import <Foundation/Foundation.h>
#import "TuyaSmartSecurityBaseKitDefinition.h"

typedef NS_ENUM(NSUInteger, TYSecurityLocationVoiceState) {
    TYSecurityLocationVoiceState_Silence = 0,
    TYSecurityLocationVoiceState_Normal
};

typedef NS_ENUM(NSUInteger, TYSecurityLocationLineState) {
    TYSecurityLocationLineState_Init = 0,
    TYSecurityLocationLineState_AllGatewayOnline = 1,
    TYSecurityLocationLineState_AllGatewayOffline = 2,
    TYSecurityLocationLineState_SomeGatewayOffline = 3,
};
NS_ASSUME_NONNULL_BEGIN

@interface TuyaSmartSecurityLocaitonStateModel : NSObject

@property (nonatomic, copy) NSString *homeId;
@property (nonatomic, assign) TYSecurityLocationAlarmState alarmState;
@property (nonatomic, assign) TYSecurityLocationVoiceState alarmVoice;
@property (nonatomic, assign) TYSecurityLocationLineState onlineState;
@property (nonatomic, assign) NSInteger alarmCountdown;

@end

NS_ASSUME_NONNULL_END
