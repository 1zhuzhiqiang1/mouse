//
//  ZZChooseShopVC.m
//  luming
//
//  Created by anyware on 17/2/27.
//  Copyright © 2017年 zhuzhiqiaqng. All rights reserved.
//

#import "ZZChooseShopVC.h"
#import "ZZMainTabBarController.h"
#import "IWTabBarViewController.h"


@interface ZZChooseShopVC ()<NSURLSessionDataDelegate>

@property (weak, nonatomic) IBOutlet UIButton *chooseMuse;
@property (weak, nonatomic) IBOutlet UIButton *shanghaiBtn;
@property (weak, nonatomic) IBOutlet UIButton *hangzhouBtn;


@end

@implementation ZZChooseShopVC

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
    
//    [_chooseMuse setBackgroundColor:ZQColor(89, 124, 169)];
//    _chooseMuse.titleLabel.font = [UIFont systemFontOfSize:20];
//    _chooseMuse.tintColor = [UIColor whiteColor];
//    [_shanghaiBtn setBackgroundColor:ZQColor(206, 40, 38)];
//    _shanghaiBtn.titleLabel.font = [UIFont systemFontOfSize:15];
//    _shanghaiBtn.tintColor = [UIColor whiteColor];
//    [_hangzhouBtn setBackgroundColor:ZQColor(206, 40, 38)];
//    _hangzhouBtn.titleLabel.font = [UIFont systemFontOfSize:15];
//    _hangzhouBtn.tintColor = [UIColor whiteColor];
//    
//    [self setButtonRound:_chooseMuse];
//    [self setButtonRound:_hangzhouBtn];
//    [self setButtonRound:_shanghaiBtn];
    
    //隐藏导航栏
    [self.navigationController setNavigationBarHidden:YES];
    
    [_shanghaiBtn addTarget:self action:@selector(shanghaiBtnClick) forControlEvents:UIControlEventTouchUpInside];
    [_hangzhouBtn addTarget:self action:@selector(hangzhouBtnClick) forControlEvents:UIControlEventTouchUpInside];
    
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

// 设置圆角
- (void)setButtonRound:(UIButton*)button {
    [button.layer setMasksToBounds:YES];
    [button.layer setCornerRadius:10.0]; //设置矩形四个圆角半径
    [button.layer setBorderWidth:1.0]; //边框宽度
    //    [button.layer setBorderColor:ZQColor(149, 153, 160)];//边框颜色
}

#pragma mark 按钮点击事件

- (void)shanghaiBtnClick {
//    NSDictionary *dataDic = [NSDictionary dictionaryWithContentsOfFile:SHOP_ID_FILE];
//    NSArray *shopIds =[dataDic objectForKey:@"ShopId"];
//    ZZMainTabBarController *shanghaiMain = [[ZZMainTabBarController alloc] init];
//    [ZZNSPreferenceUtil setObject:shopIds[0] key:CURRENT_SHOP_ID];
    IWTabBarViewController *shanghaiMain = [[IWTabBarViewController alloc] init];
    [ZZNSPreferenceUtil setObject:SHANGHAI key:CURRENT_SHOP_ID];
    [self.navigationController pushViewController:shanghaiMain animated:YES];
}

- (void)hangzhouBtnClick {
//    NSDictionary *dataDic = [NSDictionary dictionaryWithContentsOfFile:SHOP_ID_FILE];
//    NSArray *shopIds =[dataDic objectForKey:@"ShopId"];
    IWTabBarViewController *hangzhouMain = [[IWTabBarViewController alloc] init];
    [ZZNSPreferenceUtil setObject:HANGZHOU key:CURRENT_SHOP_ID];
    [self.navigationController pushViewController:hangzhouMain animated:YES];
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
