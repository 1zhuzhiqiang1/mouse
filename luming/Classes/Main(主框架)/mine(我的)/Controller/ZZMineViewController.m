//
//  ZZMineViewController.m
//  luming
//
//  Created by anyware on 17/3/4.
//  Copyright © 2017年 zhuzhiqiaqng. All rights reserved.
//

#import "ZZMineViewController.h"

@interface ZZMineViewController ()

@property (weak, nonatomic) IBOutlet UIButton *btn_check;


@end

@implementation ZZMineViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
    
    [_btn_check addTarget:self action:@selector(checkUpdate) forControlEvents:UIControlEventTouchUpInside];
    
}

- (void)checkUpdate {
    AppDelegate *appDel = (AppDelegate *)[UIApplication sharedApplication].delegate;
    [appDel checkUpdate];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
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
