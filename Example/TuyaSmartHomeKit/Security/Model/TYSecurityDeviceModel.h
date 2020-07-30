//
//  TYSecurityDeviceModel.h
//  BlocksKit
//
//  Created by Wei Zhang on 2020/4/4.
//

#import <Foundation/Foundation.h>
#import <TuyaSmartDeviceKit/TuyaSmartDeviceKit.h>
#import <TuyaSmartDeviceKit/TuyaSmartDeviceModel.h>

@class TYHomeIndexModel,TYTPHomeDataEntity;

NS_ASSUME_NONNULL_BEGIN

@interface TYSecurityDeviceModel : NSObject

@property (nonatomic, strong) TYTPHomeDataEntity *dataEntity;
//@property (nonatomic, assign) BOOL isOpen;
@property (nonatomic, strong) NSArray<TYTPHomeDataEntity *> *subDevices;

//- (void)setStatusWith:(BOOL)isOpen;

//- (BOOL)getStatus;

@end

NS_ASSUME_NONNULL_END
