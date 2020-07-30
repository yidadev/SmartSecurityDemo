//
//  TYSecurityQueryStateModel.h
//  TuyaSecuritySDK
//
//  Created by MokZF on 2020/4/9.
//

#import <Foundation/Foundation.h>
#import "TuyaSmartSecurityBaseKitDefinition.h"

NS_ASSUME_NONNULL_BEGIN

typedef NS_ENUM(NSInteger,SecurityLocationState){
    SecurityLocationState_Create = 0,//初始状态
    SecurityLocationState_Begin,//开始任务
    SecurityLocationState_Continue,//继续任务
    SecurityLocationState_Terminate,//终止任务
    SecurityLocationState_Success,//全部成功
    SecurityLocationState_Failure,//全部失败
    SecurityLocationState_Abnormal//部分异常状态
};

typedef NS_ENUM(NSInteger,SecurityGatewayState) {
    SecurityGatewayState_Abnormal = 0,//abnormal
    SecurityGatewayState_Normal//normal
};

@interface TuyaSmartSecurityGatewayStatuModel : NSObject

@property (nonatomic, copy) NSString *gwId;
@property (nonatomic, assign) SecurityGatewayState state;
@property (nonatomic, assign) BOOL isArmGatewayDevcie;//本地标记是否该网关是否参与布撤防
@property (nonatomic, assign) BOOL isDefault;//是否是第一次展示的默认值
@end

@interface TuyaSmartSecurityQueryStateModel : NSObject

@property (nonatomic, assign) SecurityLocationState state;
@property (nonatomic, assign) ArmModeStatus mode;
@property (nonatomic, copy) NSString *majorId;//主网关id
@property (nonatomic, copy) NSString *tid;
@property (nonatomic, strong) NSArray<TuyaSmartSecurityGatewayStatuModel *> *detail;

@end

NS_ASSUME_NONNULL_END
