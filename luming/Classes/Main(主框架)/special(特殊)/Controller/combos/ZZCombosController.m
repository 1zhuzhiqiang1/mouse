//
//  ZZCombosController.m
//  luming
//
//  Created by anyware on 17/2/27.
//  Copyright © 2017年 zhuzhiqiaqng. All rights reserved.
//

#import "ZZCombosController.h"
#import "ZZCombosCell.h"
#import "ZZCombosDetailVC.h"
#import "PackageData.h"
#import "ZZDBCacheTool.h"
#import "WineData.h"

@interface ZZCombosController () {
    NSNotificationCenter *notification;
}

@property (nonatomic, strong) NSArray *datas;

@end

@implementation ZZCombosController

//-(instancetype)initNotification {
//    if(self){
//        // 注册通知
//        notification = [NSNotificationCenter defaultCenter];
//        [notification addObserver:self selector:@selector(changeData:) name:@"ZZCombosControllerChangeData" object:nil];
//    }
//    return self;
//}

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.tableView.separatorStyle = UITableViewCellSeparatorStyleNone;
    
    UIImageView *backImageView=[[UIImageView alloc] initWithFrame:self.view.bounds];
    [backImageView setImage:[UIImage imageNamed:@"bg-home"]];
    self.tableView.backgroundView=backImageView;
    
    // Uncomment the following line to preserve selection between presentations.
    // self.clearsSelectionOnViewWillAppear = NO;
    
    // Uncomment the following line to display an Edit button in the navigation bar for this view controller.
    // self.navigationItem.rightBarButtonItem = self.editButtonItem;
    // 加载数据
    if([ZZNSPreferenceUtil getObjectWithKey:CURRENT_SHOP_ID]) {
        _datas = [ZZDBCacheTool getAllPackageDatasByShopId:[ZZNSPreferenceUtil getObjectWithKey:CURRENT_SHOP_ID]];
    }
    
    
}

// 初始化广播
- (instancetype)initWithNotification {
    if(self) {
        [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(updateData) name:ZZCombosControllerADD_NOTIFICATION object:nil];
    }
    return self;
}

// 刷新数据
- (void)updateData {
    _datas = [ZZDBCacheTool getAllPackageDatasByShopId:[ZZNSPreferenceUtil getObjectWithKey:CURRENT_SHOP_ID]];
    [self.tableView reloadData];
}

- (NSArray *)datas {
    if(_datas == nil) {
        _datas = [NSArray array];
    }
    return _datas;
}

//- (void)changeData:(NSNotification*) notification2 {
//    [self.datas removeAllObjects];
//    NSArray *ids = [notification2 object];//通过这个获取到传递的对象
//    for (NSString *uid in ids) {
//        WineData *data = [ZZDBCacheTool getWineDataById:uid];
//        if(data) {
//            [_datas addObject:data];
//        }
//    }
//    //加上套餐数据
//    NSArray *packages = [ZZDBCacheTool getAllPackageDatasByShopId:[ZZNSPreferenceUtil getObjectWithKey:@"shopId"]];
//    for (PackageData *packageData in packages) {
//        [self.datas addObject:packageData];
//    }
//    [self.tableView reloadData];
//}


- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark - Table view data source

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return self.datas.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    // 1.创建cell
    ZZCombosCell *cell = [ZZCombosCell cellWithTableView:tableView];
    cell.backgroundColor = [UIColor clearColor];
    cell.selectionStyle = UITableViewCellSelectionStyleNone;//去掉点击效果
    // 2.获取数据
    PackageData *packageData = self.datas[indexPath.row];
    // 3.给cell赋值
    if(packageData.NameEN) {
        cell.englishLabel.text = [NSString stringWithFormat:@"%@",packageData.NameEN];
    }
    if(packageData.NameCN){
        cell.chineseLabel.text = [NSString stringWithFormat:@"%@",packageData.NameCN];
    }
    if(packageData.DetailEN){
        cell.EnSubLabel.text = packageData.DetailEN;
    }
    if(packageData.DetailCN) {
        cell.CNSubLabel.text = packageData.DetailCN;
    }
    //数字千分位显示
    if(packageData.Price){
        NSNumberFormatter *formatter = [[NSNumberFormatter alloc] init];
        formatter.numberStyle = NSNumberFormatterDecimalStyle;
        NSString *newAmount = [formatter stringFromNumber:[NSNumber numberWithFloat:[packageData.Price floatValue]]];
        if(packageData.Currency) {
            newAmount = [newAmount stringByAppendingString:[NSString stringWithFormat:@" %@",packageData.Currency]];
        }
        cell.preiceLabel.text = newAmount;
    }
    
    return cell;
}

#pragma mark UITableViewDelegate

// 点击
- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    // 获取数据
//    PackageData *packageData = self.datas[indexPath.row];
//    ZZCombosDetailVC *detail = [[ZZCombosDetailVC alloc] initWithIds:packageData.MenuDetailIds];
//    detail.title = @"详情";
//    [self.navigationController pushViewController:detail animated:YES];
}

// Cell-高度
- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return 150;
}

/*
// Override to support conditional editing of the table view.
- (BOOL)tableView:(UITableView *)tableView canEditRowAtIndexPath:(NSIndexPath *)indexPath {
    // Return NO if you do not want the specified item to be editable.
    return YES;
}
*/

/*
// Override to support editing the table view.
- (void)tableView:(UITableView *)tableView commitEditingStyle:(UITableViewCellEditingStyle)editingStyle forRowAtIndexPath:(NSIndexPath *)indexPath {
    if (editingStyle == UITableViewCellEditingStyleDelete) {
        // Delete the row from the data source
        [tableView deleteRowsAtIndexPaths:@[indexPath] withRowAnimation:UITableViewRowAnimationFade];
    } else if (editingStyle == UITableViewCellEditingStyleInsert) {
        // Create a new instance of the appropriate class, insert it into the array, and add a new row to the table view
    }   
}
*/

/*
// Override to support rearranging the table view.
- (void)tableView:(UITableView *)tableView moveRowAtIndexPath:(NSIndexPath *)fromIndexPath toIndexPath:(NSIndexPath *)toIndexPath {
}
*/

/*
// Override to support conditional rearranging of the table view.
- (BOOL)tableView:(UITableView *)tableView canMoveRowAtIndexPath:(NSIndexPath *)indexPath {
    // Return NO if you do not want the item to be re-orderable.
    return YES;
}
*/

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
