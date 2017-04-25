//
//  ZZNSPreferenceUtil.h
//  luming
//
//  Created by anyware on 17/3/1.
//  Copyright © 2017年 zhuzhiqiaqng. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface ZZNSPreferenceUtil : NSObject

+ (void)setObject:(NSString *)value key:(NSString *)key;
+ (NSString *)getObjectWithKey:(NSString *)key;

+ (void)setBool:(BOOL)value key:(NSString *)key;
+ (BOOL)getBoolWithKey:(NSString *)key;

@end
