//
//  TYSecurityDeviceModel.m
//  BlocksKit
//
//  Created by Wei Zhang on 2020/4/4.
//

#import "TYSecurityDeviceModel.h"
//#import <TYSmartHouse/TYTPHomeDataMappingService.h>

@implementation TYSecurityDeviceModel


//- (void)setStatusWith:(BOOL)isOpen {
//    if (self.dataEntity.devId.length) {
//        [[NSUserDefaults standardUserDefaults]
//         setObject:[NSNumber numberWithBool:isOpen]
//         forKey:[self keyWithId:self.dataEntity.devId]];
//        [[NSUserDefaults standardUserDefaults] synchronize];
//    }
//}
//
//- (BOOL)getStatus {
//    if (self.dataEntity.devId.length) {
//        NSNumber *number= [[NSUserDefaults standardUserDefaults] objectForKey:[self keyWithId:self.dataEntity.devId]];
//        if (!number) {
//            return NO;
//        }
//        return [number boolValue];
//    }
//    return NO;
//}
//
//- (NSString *)keyWithId:(NSString *)devId {
//    return [NSString stringWithFormat:@"security_gateway_status_devid_%@",devId];
//}

@end
