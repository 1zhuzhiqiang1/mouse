//
//  AppDelegate.h
//  luming
//
//  Created by anyware on 17/2/21.
//  Copyright © 2017年 zhuzhiqiaqng. All rights reserved.
//

#import <UIKit/UIKit.h>

static BOOL networkConnect = true;

@interface AppDelegate : UIResponder <UIApplicationDelegate>

@property (strong, nonatomic) UIWindow *window;

// -----方法-----
+ (BOOL)netWorkConnect;
- (void)checkUpdate;

@end

