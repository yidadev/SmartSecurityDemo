//
//  TYEmergencyListModel.h
//  BlocksKit
//
//  Created by zhangF on 2019/5/16.
//

#import <Foundation/Foundation.h>
NS_ASSUME_NONNULL_BEGIN

/**
 areaCode = "1",
 phone = "7236042558",
 gmtCreate = 1557804514287,
 id = 10001,
 order = 1,
 name = "test_1",
 locationId = 2900,
 */

@interface TuyaSmartSecurityEmergencyListModel : NSObject

@property (copy, nonatomic) NSString *areaCode;
@property (copy, nonatomic) NSString *areaName;
@property (copy, nonatomic) NSString *phone;
@property (assign, nonatomic) NSTimeInterval gmtCreate;
@property (strong, nonatomic) NSNumber *memberId;
@property (strong, nonatomic) NSNumber *sequence;
@property (strong, nonatomic) NSNumber *homeId;
@property (copy, nonatomic) NSString *name;

@property(nonatomic, copy) NSString *firstName;
@property(nonatomic, copy) NSString *lastName;

@end

NS_ASSUME_NONNULL_END
