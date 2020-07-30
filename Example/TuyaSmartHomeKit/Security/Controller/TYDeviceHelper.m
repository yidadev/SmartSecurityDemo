//
//  TYDeviceHelper.m
//  TuyaSmartHomeKit_Example
//
//  Created by MokZF on 2020/7/29.
//  Copyright © 2020 xuchengcheng. All rights reserved.
//

#import "TYDeviceHelper.h"

@implementation TYDeviceHelper

 - (NSArray<TYSecurityDeviceModel *> *)queryDevicesByParent {
     
     
//     TYSecurityDataCenterUtil *homeListUtil = [TYSecurityDataCenterUtil sharedInstance];
//     if (!homeListUtil) {
//         return @[];
//     }
//
//     TYHomeIndexModel *homeIndexModel = [homeListUtil getAllIndexModel];
//     if(homeIndexModel.simpleData.count == 0) {
//        return @[];
//     }
     
     NSMutableArray *mainDeviceList = [NSMutableArray new];
     NSMutableArray *subDeviceList = [NSMutableArray new];
     
//     NSMutableArray<TYTPHomeDataEntity *> *simpleData = [homeIndexModel.simpleData mutableCopy];
//
//     for (TYTPHomeDataEntity *entity in simpleData) {
//
//         NSLog(@"name:  %@  id:%@   parentId:%@  ", entity.deviceModel.name,entity.deviceModel.devId, entity.deviceModel.parentId);
//
//         if (entity.deviceModel.parentId.length) {
//             [subDeviceList addObject:entity];
//         } else {
//             [mainDeviceList addObject:entity];
//         }
//     }
//
//
//     NSMutableArray *securityDeviceList = [NSMutableArray new];
//     for (TYTPHomeDataEntity *entity in mainDeviceList) {
//         TYSecurityDeviceModel *deviceModel = [[TYSecurityDeviceModel alloc] init];
//         deviceModel.dataEntity = entity;
//         deviceModel.subDevices = [self getSubDevivesWith:entity.devId subDeviceList:subDeviceList];
//         [securityDeviceList addObject:deviceModel];
//     }
     return @[];
}


- (NSArray *)getSubDevivesWith:(NSString *)deviceId subDeviceList:(NSArray *)nDeviceList {
    
    NSMutableArray *subDeviceList = [[NSMutableArray alloc] init];
//    for (TYTPHomeDataEntity *entity in nDeviceList) {
//        if ([entity.deviceModel.parentId isEqualToString:deviceId]) {
//            [subDeviceList addObject:entity];
//        }
//    }
    return subDeviceList;
}

@end
