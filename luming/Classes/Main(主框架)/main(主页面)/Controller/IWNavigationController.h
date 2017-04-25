//
//  IWNavigationController.h
//  ItcastWeibo
//
//  Created by apple on 14-5-6.
//  Copyright (c) 2014年 itcast. All rights reserved.
//

#import <UIKit/UIKit.h>

@class IWTabBarViewController;

@interface IWNavigationController : UINavigationController

//-----属性-----
@property (nonatomic, strong) IWTabBarViewController *tabbar;

@end
