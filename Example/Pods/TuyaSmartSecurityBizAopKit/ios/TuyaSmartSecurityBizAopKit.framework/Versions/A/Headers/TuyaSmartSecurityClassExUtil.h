//
//  TYClassExchangeUtil.h
//  BlocksKit
//
//  Created by 浩天 on 2019/5/24.
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN


#define  TuyaSmartSecurityExClass(aClassName) NSClassFromString(aClassName)
#define  TuyaSmartSecurityExSelector(aSelectorName) NSSelectorFromString(aSelectorName)

@interface TuyaSmartSecurityClassExUtil : NSObject


/**

 @param aClass 类
 @param originalSelector 原方法
 @param targetSelector 目标方法
 */
+ (void)exchangeWithClass:(Class)aClass
         originalSelector:(SEL)originalSelector
           targetSelector:(SEL)targetSelector;



/**

 @param originalClass 类1
 @param targetClass 类2
 @param originalSelector 原方法
 @param targetSelector 目标方法
 */
+ (void)exchangeWithOriginalClass:(Class)originalClass
                      targetClass:(Class)targetClass
                 originalSelector:(SEL)originalSelector
                   targetSelector:(SEL)targetSelector;

@end


@interface NSObject(TYClassExchangeUtil)


/**
 交换方法

 @param originalSelector 原方法
 @param targetSelector 目标方法
 */
- (void)ty_exchangeWithOriginalSelector:(SEL)originalSelector
                         targetSelector:(SEL)targetSelector;

@end

NS_ASSUME_NONNULL_END
