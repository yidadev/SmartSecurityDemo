//
//  NSString+Security.h
//  BlocksKit
//
//  Created by MokZF on 2019/6/13.
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

@interface NSString (TuyaSmartSecurity)

+ (NSString *)md5WithString:(NSString *)string;

@end

NS_ASSUME_NONNULL_END
