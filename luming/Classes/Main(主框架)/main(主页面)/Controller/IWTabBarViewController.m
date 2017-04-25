//
//  IWTabBarViewController.m
//  ItcastWeibo
//
//  Created by apple on 14-5-5.
//  Copyright (c) 2014年 itcast. All rights reserved.
//

#import "IWTabBarViewController.h"
#import "IWTabBar.h"
#import "IWNavigationController.h"
#import "IWTabBarButton.h"

//四个子控制器
#import "ZZHomeViewController.h"
#import "ZZCombosController.h"
#import "ZZEventController.h"
#import "ZZMineViewController.h"

@interface IWTabBarViewController () <IWTabBarDelegate>
/**
 *  自定义的tabbar
 */
@property (nonatomic, weak) IWTabBar *customTabBar;

@end

@implementation IWTabBarViewController

- (void)viewDidLoad
{
    [super viewDidLoad];
    
    // 初始化tabbar
    [self setupTabbar];
    // 初始化所有的子控制器
    [self setupAllChildViewControllers];
    
//    NSNotificationCenter.defaultCenter().addObserver(self, selector: #selector(willOritate(_:), name: UIApplicationWillChangeStatusBarOrientationNotification, object: nil)
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(willScreenChange:) name:UIApplicationWillChangeStatusBarOrientationNotification object:nil];
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(didScreenChange:) name:UIApplicationDidChangeStatusBarOrientationNotification object:nil];
}

-(void)viewWillLayoutSubviews {
    CGRect tabFrame = self.tabBar.frame; //self.TabBar is IBOutlet of your TabBar
    tabFrame.size.height = TABBAR_HEIGHT;
    tabFrame.origin.y = self.view.frame.size.height - TABBAR_HEIGHT;
    self.tabBar.frame = tabFrame;
}

- (void)willScreenChange:(NSNotification*)tongzhi {}

- (void)didScreenChange:(NSNotification *)cation {
    self.customTabBar.frame = self.tabBar.bounds;
}

- (void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
    
    // 删除系统自动生成的UITabBarButton
    for (UIView *child in self.tabBar.subviews) {
        if ([child isKindOfClass:[UIControl class]]) {
            [child removeFromSuperview];
        }
    }
    
    // 注册通知
//    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(jump2Special) name:IWTabBarViewControllerJump2Special object:nil];
}

- (void)jump2Special {
    [self.customTabBar buttonClick:self.customTabBar.tabBarButtons[1]];
}

- (void)viewWillDisappear:(BOOL)animated {
    [super viewWillDisappear:animated];
    [[NSNotificationCenter defaultCenter] removeObserver:self];
}

/**
 *  初始化tabbar
 */
- (void)setupTabbar
{
    IWTabBar *customTabBar = [[IWTabBar alloc] init];
    customTabBar.frame = self.tabBar.bounds;
    
    CGRect rect = customTabBar.frame;
    rect.size.height = TABBAR_HEIGHT;
    customTabBar.frame = rect;
    
    customTabBar.delegate = self;
    [self.tabBar addSubview:customTabBar];
    
    self.customTabBar = customTabBar;
}

#pragma mark - tabbar的代理方法

/**
 *  监听tabbar按钮的改变
 *  @param from   原来选中的位置
 *  @param to     最新选中的位置
 */
- (void)tabBar:(IWTabBar *)tabBar didSelectedButtonFrom:(NSInteger)from to:(NSInteger)to
{
    self.selectedIndex = to;
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

/**
 *  初始化所有的子控制器
 */
- (void)setupAllChildViewControllers
{
    // 1.类别列表
     ZZHomeViewController *home = [[ZZHomeViewController alloc] initWithCollectionViewLayout:[self setupLayout]];
    if(iPhone){
        [self setupChildViewController:home title:@"Drinks" imageName:@"tab-about-nor-iphone" selectedImageName:@"tab-about-sel-iphone"];
    } else {
        [self setupChildViewController:home title:@"Drinks" imageName:@"tab-about-nor" selectedImageName:@"tab-about-sel"];
    }
    
    
    // 2.酒品详情页
    ZZCombosController *message = [[ZZCombosController alloc] initWithNotification];
    if(iPhone){
        [self setupChildViewController:message title:@"Combos" imageName:@"tab-taocan-nor-iphone" selectedImageName:@"tab-taocan-sel-iphone"];
    }else{
        [self setupChildViewController:message title:@"Combos" imageName:@"tab-taocan-nor" selectedImageName:@"tab-taocan-sel"];
    }
    
    
    // 4.关于我们
    ZZMineViewController *me = [[ZZMineViewController alloc] init];
    if(iPhone) {
        [self setupChildViewController:me title:@"About Us" imageName:@"tab-winelist-nor-iphone" selectedImageName:@"tab-winelist-sel-iphone"];
    } else {
        [self setupChildViewController:me title:@"About Us" imageName:@"tab-winelist-nor" selectedImageName:@"tab-winelist-sel"];
    }
    
}

/**
 *  初始化一个子控制器
 *
 *  @param childVc           需要初始化的子控制器
 *  @param title             标题
 *  @param imageName         图标
 *  @param selectedImageName 选中的图标
 */
- (void)setupChildViewController:(UIViewController *)childVc title:(NSString *)title imageName:(NSString *)imageName selectedImageName:(NSString *)selectedImageName
{
    // 1.设置控制器的属性
    childVc.title = title;
    // 设置图标
    childVc.tabBarItem.image = [[UIImage imageWithName:imageName] imageWithRenderingMode:UIImageRenderingModeAlwaysOriginal];
    // 设置选中的图标
    UIImage *selectedImage = [[UIImage imageWithName:selectedImageName] imageWithRenderingMode:UIImageRenderingModeAlwaysOriginal];
    if (iOS7) {
        childVc.tabBarItem.selectedImage = [selectedImage imageWithRenderingMode:UIImageRenderingModeAlwaysOriginal];
    } else {
        childVc.tabBarItem.selectedImage = selectedImage;
    }
    
    // 2.包装一个导航控制器
    IWNavigationController *nav = [[IWNavigationController alloc] initWithRootViewController:childVc];
    nav.tabbar = self;
    [self addChildViewController:nav];
    
    // 3.添加tabbar内部的按钮
    [self.customTabBar addTabBarButtonWithItem:childVc.tabBarItem];
}



@end
