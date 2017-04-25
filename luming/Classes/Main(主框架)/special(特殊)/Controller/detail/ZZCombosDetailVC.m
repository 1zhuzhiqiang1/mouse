//
//  ZZCombosDetailVC.m
//  luming
//
//  Created by anyware on 17/2/27.
//  Copyright © 2017年 zhuzhiqiaqng. All rights reserved.
//

#import "ZZCombosDetailVC.h"
#import "ZZCombosDetailCell.h"
#import "WineData.h"
#import "ZZDBCacheTool.h"

@interface ZZCombosDetailVC ()

@property (nonatomic, strong) NSMutableArray *datas;

@end

@implementation ZZCombosDetailVC

- (instancetype)initWithIds:(NSArray *)ids {
    if(self) {
        if(ids) {
            for (WineData *data in ids) {
                if(data){
                    [self.datas addObject:data];
                }
            }
        }
    }
    return self;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    
    
    UIImageView *backImageView=[[UIImageView alloc] initWithFrame:self.view.bounds];
    [backImageView setImage:[UIImage imageNamed:@"bg-home"]];
    self.tableView.backgroundView=backImageView;
    
    self.tableView.showsVerticalScrollIndicator = YES;
    self.tableView.indicatorStyle = UIScrollViewIndicatorStyleWhite;
    self.tableView.separatorStyle = UITableViewCellSeparatorStyleNone;
    
    self.navigationController.navigationBar.barStyle = UIStatusBarStyleDefault;
    [self.navigationController.navigationBar setTintColor:[UIColor whiteColor]];

    
    // Uncomment the following line to preserve selection between presentations.
    // self.clearsSelectionOnViewWillAppear = NO;
    
    // Uncomment the following line to display an Edit button in the navigation bar for this view controller.
//     self.navigationItem.rightBarButtonItem = self.editButtonItem;
}

- (NSArray *)datas {
    if(_datas == nil) {
        _datas = [NSMutableArray array];
    }
    return _datas;
}

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
    // 1.初始化cell
    ZZCombosDetailCell *cell = [ZZCombosDetailCell cellWithTableView:tableView];
    cell.backgroundColor = [UIColor clearColor];
    cell.selectionStyle = UITableViewCellSelectionStyleNone;
    
    // 2.获取数据
    WineData *data = self.datas[indexPath.row];
    
    // 3.组件赋值
    if(data.NameEN){
        cell.enNameLabel.text = data.NameEN;
    }
    if(data.NameCN){
        cell.cnNameLabel.text = data.NameCN;
    }
    NSString *guiGe= @"";
    NSString *priceStr = @"";
    if(data.UnitPropTextEN) {
        guiGe = [guiGe stringByAppendingString:data.UnitPropTextEN];
    }
    if(data.SpecPropTextEN) {
        guiGe = [guiGe stringByAppendingString:[NSString stringWithFormat:@" %@",data.SpecPropTextEN]];
    }
    if(data.Price) {
        NSNumberFormatter *formatter = [[NSNumberFormatter alloc] init];
        formatter.numberStyle = NSNumberFormatterDecimalStyle;
        NSString *newAmount = [formatter stringFromNumber:[NSNumber numberWithFloat:[data.Price floatValue]]];
        priceStr = [priceStr stringByAppendingString:[NSString stringWithFormat:@" %@",newAmount]];
    }
    priceStr = [guiGe stringByAppendingString:[NSString stringWithFormat:@" %@",priceStr]];
    if(data.Currency) {
        priceStr = [priceStr stringByAppendingString:[NSString stringWithFormat:@" %@",data.Currency]];
    }
    // 分段设置字体颜色
    NSMutableAttributedString *hintString=[[NSMutableAttributedString alloc] initWithString:priceStr];
    NSRange range1=[[hintString string] rangeOfString:guiGe];
    [hintString addAttribute:NSForegroundColorAttributeName value:ZQColor(112,82,61) range:range1];
    
    cell.priceLabel.attributedText = hintString;
    return cell;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    return 130;
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
