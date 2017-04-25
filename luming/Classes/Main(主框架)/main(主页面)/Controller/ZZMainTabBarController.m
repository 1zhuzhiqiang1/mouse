//
//  ZZMainTabBarController.m
//  luming
//
//  Created by anyware on 17/2/27.
//  Copyright © 2017年 zhuzhiqiaqng. All rights reserved.
//

#import "ZZMainTabBarController.h"
#import "IWNavigationController.h"
#import "ZZCombosController.h"
#import "ZZHomeViewController.h"
#import "ZZCombosController.h"

@interface ZZMainTabBarController ()

@end

@implementation ZZMainTabBarController

+ (void)initialize {
    
    // 设置为不透明
    [[UITabBar appearance] setTranslucent:NO];
    
    // 设置背景颜色
    [UITabBar appearance].barTintColor = ZQColor(33, 14, 8);
    
    // 拿到整个导航控制器的外观
    UITabBarItem * item = [UITabBarItem appearance];
    item.titlePositionAdjustment = UIOffsetMake(0, 1.5);
    
    // 普通状态
    NSMutableDictionary * normalAtts = [NSMutableDictionary dictionary];
    normalAtts[NSFontAttributeName] = [UIFont systemFontOfSize:13];
    normalAtts[NSForegroundColorAttributeName] = [UIColor colorWithRed:0.62f green:0.62f blue:0.63f alpha:1.00f];
    [item setTitleTextAttributes:normalAtts forState:UIControlStateNormal];
    
    // 选中状态
    NSMutableDictionary *selectAtts = [NSMutableDictionary dictionary];
    selectAtts[NSFontAttributeName] = [UIFont systemFontOfSize:13];
    selectAtts[NSForegroundColorAttributeName] = [UIColor colorWithRed:0.42f green:0.33f blue:0.27f alpha:1.00f];
    [item setTitleTextAttributes:selectAtts forState:UIControlStateSelected];
}

- (UICollectionViewLayout*)setupLayout {
    // 1.创建流水布局
    UICollectionViewFlowLayout *layout = [[UICollectionViewFlowLayout alloc] init];
    // 2.设置每个格子的尺寸
    NSLog(@"WIDTH/5=%f",WIDTH/5);
    layout.itemSize = CGSizeMake(154, 130);
    // 4.设置每一行之间的间距
    layout.minimumLineSpacing = 10;
    return layout;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    
    // 1.酒品类别
    ZZHomeViewController *home = [[ZZHomeViewController alloc] initWithCollectionViewLayout:[self setupLayout]];
    [self addChildViewController:home imagename:@"tab-winelist-nor" selectImage:@"tab-winelist-sel" title:@"Drinks"];
    
    // 2.酒品页
    ZZCombosController *combos = [[ZZCombosController alloc] init];
    [self addChildViewController:combos imagename:@"tab-taocan-nor" selectImage:@"tab-taocan-sel" title:@"Combos"];
    
    // 4.关于我们
//    ZZMineVC *mine = [[ZZMineVC alloc] init];
//    [self addChildViewController:mine imagename:@"tab-about-nor" selectImage:@"tab-about-sel" title:@"About Us"];
    
}

- (void)addChildViewController:(UIViewController *)controller
                                  imagename:(NSString *)imagename
                                selectImage:(NSString *)selectName
                                      title:(NSString *)title {
    controller.title = title;
    IWNavigationController *nav = [[IWNavigationController alloc] initWithRootViewController:controller];
    nav.tabBarItem.image = [[UIImage imageNamed:imagename] imageWithRenderingMode:UIImageRenderingModeAlwaysOriginal];
    nav.tabBarItem.selectedImage = [[UIImage imageNamed:selectName] imageWithRenderingMode:UIImageRenderingModeAlwaysOriginal];
    [self addChildViewController:nav];
}

// 添加子控制器
- (void)addChildViewControllerWithClassname:(NSString *)classname
                                  imagename:(NSString *)imagename
                                selectImage:(NSString *)selectName
                                      title:(NSString *)title {
    
    UIViewController *vc = [[NSClassFromString(classname) alloc] init];
    vc.title = title;
    IWNavigationController *nav = [[IWNavigationController alloc] initWithRootViewController:vc];
    nav.tabBarItem.image = [[UIImage imageNamed:imagename] imageWithRenderingMode:UIImageRenderingModeAlwaysOriginal];
    nav.tabBarItem.selectedImage = [[UIImage imageNamed:selectName] imageWithRenderingMode:UIImageRenderingModeAlwaysOriginal];
    [self addChildViewController:nav];
}

@end
