//
//  TYEmergencyCellModel.h
//  BlocksKit
//
//  Created by MokZF on 2019/8/19.
//

#import <Foundation/Foundation.h>

typedef NS_ENUM(NSUInteger, TYConnectEditType) {
    TYConnectEditTypeFirstName,
    TYConnectEditTypeLastName,
    TYConnectEditTypePhone,
};

typedef void(^TextFieldValueChanged)(TYConnectEditType editType, NSString *valueString);

NS_ASSUME_NONNULL_BEGIN

@interface TuyaSmartSecurityEmergencyCellModel : NSObject

@property(nonatomic, copy) NSString *titleString;
@property(nonatomic, copy) NSString *valueString;
@property(nonatomic, copy) NSString *placeHolderString;
@property(nonatomic, copy) NSString *areaName;
@property(nonatomic, copy) NSString *areaCode;
@property(nonatomic, assign) TYConnectEditType editType;


@end

NS_ASSUME_NONNULL_END
