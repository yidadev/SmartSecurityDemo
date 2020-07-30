//
//  TYSecurityAlarmMessageModel.h
//  BlocksKit
//
//  Created by MokZF on 2020/5/6.
//

#import <Foundation/Foundation.h>

typedef NS_ENUM(NSInteger,TYSecurityLocationAlarmMessageState){
    TYSecurityLocationAlarmMessageState_Open = 1,
    TYSecurityLocationAlarmMessageState_Cancel = 2,
    TYSecurityLocationAlarmMessageState_Done = 3,
    TYSecurityLocationAlarmMessageState_MC = 4,
    TYSecurityLocationAlarmMessageState_Dealed = 5
};

NS_ASSUME_NONNULL_BEGIN

@interface TuyaSmartSecurityAlarmMessageModel : NSObject

@property (nonatomic, copy) NSString *alarmId;
@property (nonatomic, copy) NSString *msgId;
@property (nonatomic, copy) NSString *msgContent;
@property (nonatomic, copy) NSString *msgTitle;
@property (nonatomic, copy) NSString *productType;
@property (nonatomic, copy) NSString *productId;
@property (nonatomic, strong) NSArray<NSString *> *deviceIds;
@property (nonatomic, copy) NSString *monitoringDeadline;
@property(nonatomic, copy) NSString *type;
@property(nonatomic, copy) NSString *typeDesc;
@property(nonatomic, copy) NSString *gmtCreate;
@property(nonatomic, assign) TYSecurityLocationAlarmMessageState state;

//@property(nonatomic, strong) NSMutableArray<TYAlarmDetailModel *> *details;

@property(nonatomic, assign) NSInteger alarmLeavel;
@end

NS_ASSUME_NONNULL_END
