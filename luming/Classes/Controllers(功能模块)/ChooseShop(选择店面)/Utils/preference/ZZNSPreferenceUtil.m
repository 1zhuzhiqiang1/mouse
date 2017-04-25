//
//  ZZNSPreferenceUtil.m
//  luming
//
//  Created by anyware on 17/3/1.
//  Copyright © 2017年 zhuzhiqiaqng. All rights reserved.
//

#import "ZZNSPreferenceUtil.h"

@implementation ZZNSPreferenceUtil

+ (void)setObject:(NSString *)value key:(NSString *)key {
    NSUserDefaults *user = [NSUserDefaults standardUserDefaults];
    [user setObject:value forKey:key];
    [user synchronize];
}
+ (NSString *)getObjectWithKey:(NSString *)key {
    NSUserDefaults *user = [NSUserDefaults standardUserDefaults];
    return [user objectForKey:key];
}

+ (void)setBool:(BOOL)value key:(NSString *)key {
    NSUserDefaults *user = [NSUserDefaults standardUserDefaults];
    [user setBool:value forKey:key];
    [user synchronize];
}
+ (BOOL)getBoolWithKey:(NSString *)key {
    NSUserDefaults *user = [NSUserDefaults standardUserDefaults];
    return [user boolForKey:key];
}

@end
