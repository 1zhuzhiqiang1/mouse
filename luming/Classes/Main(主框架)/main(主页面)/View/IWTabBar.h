//
//  IWTabBar.h
//  ItcastWeibo
//
//  Created by apple on 14-5-5.
//  Copyright (c) 2014年 itcast. All rights reserved.
//

#import <UIKit/UIKit.h>

@class IWTabBar;
@class IWTabBarButton;

@protocol IWTabBarDelegate <NSObject>

@optional
- (void)tabBar:(IWTabBar *)tabBar didSelectedButtonFrom:(NSInteger)from to:(NSInteger)to;
- (void)tabBarDidClickedPlusButton:(IWTabBar *)tabBar;

@end

@interface IWTabBar : UIView

//-----属性-----
@property (nonatomic, strong) NSMutableArray *tabBarButtons;

//-----方法-----
- (void)buttonClick:(IWTabBarButton *)button;
- (void)addTabBarButtonWithItem:(UITabBarItem *)item;

@property (nonatomic, weak) id<IWTabBarDelegate> delegate;

@end
