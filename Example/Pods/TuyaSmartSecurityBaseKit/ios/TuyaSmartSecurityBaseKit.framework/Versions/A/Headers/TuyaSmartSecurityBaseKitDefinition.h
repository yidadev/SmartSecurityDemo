//
//  TuyaSmartSecurityBaseKitDefination.h
//  Pods
//
//  Created by Wei Zhang on 2020/5/9.
//


#import <Foundation/Foundation.h>

#ifndef TuyaSmartSecurityBaseKitDefinition_h
#define TuyaSmartSecurityBaseKitDefinition_h

#ifndef security_weakify
    #define security_weakify(object)  __weak __typeof__(object) weak##_##object = object;
#endif

#ifndef security_strongify
    #define security_strongify(object)  __typeof__(object) object = weak##_##object;
#endif


typedef NS_ENUM(NSInteger,ArmModeStatus){
    ArmModeStatusDisarmed = 0,
    ArmModeStatusStaying = 1,
    ArmModeStatusLeaving = 2,
    ArmModeStatusUndefine = 100
};

typedef NS_ENUM(NSInteger,TYHSSwitchModeStep){
    SwitchModeStep_Continue = 2,//继续
    SwitchModeStep_Termination//终止
};

//更新家庭状态类型
typedef NS_ENUM(NSUInteger, TYHSGatewayStateUpdateType) {
    TYHSGatewayStateUpdateType_CancelAlarm = 0,//取消报警
    TYHSGatewayStateUpdateType_CancelAlarmAndDisarm = 1,//撤防并取消报警
    TYHSGatewayStateUpdateType_SoundOpen = 10,//开启声音
    TYHSGatewayStateUpdateType_SoundOff = 11,//关闭声音
};

//SOS报警类型
typedef NS_ENUM(NSUInteger, TYHSGatewaySOSType) {
    TYHSGatewaySOSType_Fire = 5,//火警
    TYHSGatewaySOSType_Panic = 8,//盗窃
    TYHSGatewaySOSType_Emergency = 9//紧急
};

//设置网关语音passcode维度类型
typedef NS_ENUM(NSUInteger, TYSecurityGatewayVoicePassCodeType) {
    TYSecurityGatewayVoicePassCodeType_Location = 1,//家庭维度
    TYSecurityGatewayVoicePassCodeType_Personal = 2//个人维度
};

//单个网关布撤防结果
typedef NS_ENUM(NSUInteger, TYSecurityGatewayDeviceArmResultType) {
    TYSecurityGatewayDeviceArmResultType_Success = 1,//布防成功
    TYSecurityGatewayDeviceArmResultType_Failed      //布防失败
};

//报警状态改变
typedef NS_ENUM(NSUInteger, TYSecurityLocationAlarmState) {
    TYSecurityLocationState_Normal = 0,
    TYSecurityLocationState_Alarm
};


//场景一键执行布撤防完成
static NSString * _Nonnull kSecuritySceneDidSwitchArmMode = @"kSecuritySceneDidSwitchArmMode";
//报警状态改变(发生报警、取消报警)
static NSString * _Nonnull kSecurityModeManagerGatewayAlarmStatusChange = @"SecurityNotiZigbeeGatewayAlarmStatusChange";
//报警声音状态
static NSString * _Nonnull kSecurityModeManagerGatewayVoiceSwitchChange = @"SecurityNotiZigbeeGatewayVoiceSwitchChange";

#endif /* TuyaSmartSecurityBaseKitDefinition_h */
