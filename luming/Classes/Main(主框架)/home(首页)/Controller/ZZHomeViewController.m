//
//  ZZHomeViewController.m
//  luming
//
//  Created by anyware on 17/2/27.
//  Copyright © 2017年 zhuzhiqiaqng. All rights reserved.
//

#import "ZZHomeViewController.h"
#import "ZQMainCell.h"
#import "WineTypeData.h"
#import "UIImageView+WebCache.h"
#import "ZZDBCacheTool.h"
#import "ZZCombosDetailVC.h"

#define IDENTIFIER_MAINCELL @"mainCell"

@interface ZZHomeViewController ()

@property (nonatomic,strong) NSArray *datas;

@end

@implementation ZZHomeViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    UIImageView *backImageView=[[UIImageView alloc] initWithFrame:self.view.bounds];
    [backImageView setImage:[UIImage imageNamed:@"bg-home"]];
    self.collectionView.backgroundView=backImageView;
    
    [self.collectionView registerClass:[ZQMainCell class] forCellWithReuseIdentifier:IDENTIFIER_MAINCELL];
    
    // 获取所有的酒品类型
    self.datas = [ZZDBCacheTool getAllWineTypeDatasByShopId:[ZZNSPreferenceUtil getObjectWithKey:CURRENT_SHOP_ID]];
    
}

- (instancetype)initWithCollectionViewLayout:(UICollectionViewLayout *)layout {
    if(self = [super initWithCollectionViewLayout:layout]) {
        // ...注册一个通知，下载完成之后自动刷新
        [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(UpdateData) name:ZZHOME_VC_CENETR object:nil];
    }
    return self;
}

// 刷新数据
- (void)UpdateData {
    _datas = [ZZDBCacheTool getAllWineTypeDatasByShopId:[ZZNSPreferenceUtil getObjectWithKey:CURRENT_SHOP_ID]];
    [self.collectionView reloadData];
}

- (NSArray *)datas {
    if(_datas == nil) {
        _datas = [NSArray array];
    }
    return _datas;
}

- (void)backAction {
    [self.navigationController.navigationController popViewControllerAnimated:YES];
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

#pragma mark <UICollectionViewDataSource>

- (NSInteger)numberOfSectionsInCollectionView:(UICollectionView *)collectionView {
    return 1;
}


- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section {
    return self.datas.count;
}

- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath {
    
    // 获取数据
    WineTypeData *data = self.datas[indexPath.row];
    
    // 组件赋值
    ZQMainCell *cell = (ZQMainCell *)[collectionView dequeueReusableCellWithReuseIdentifier:IDENTIFIER_MAINCELL forIndexPath:indexPath];
    cell.backgroundColor = [UIColor clearColor];
    NSString *imgPath = data.ImgPath;
    if(!imgPath) {
        imgPath = @"";
    }
    [cell.topImage sd_setImageWithURL:[NSURL URLWithString:[BASE_IMG stringByAppendingString:imgPath]] placeholderImage:[UIImage imageNamed:@"whiteWine"]];
    if(data.NameEN){
        cell.englishNameLabel.text = data.NameEN;
    }
    if(data.NameCN){
        cell.chineseNameLabel.text = data.NameCN;
    }
    
    return cell;
}

#pragma mark <UICollectionViewDelegate>

- (void)collectionView:(UICollectionView *)collectionView didSelectItemAtIndexPath:(NSIndexPath *)indexPath {
    // 1.获取点击的位置
    NSInteger row = indexPath.row;
    
    // 2.获取对应的模型数据
    WineTypeData *data = self.datas[row];
    
    // 3.跳转到详情也
    NSString *shopid = [ZZNSPreferenceUtil getObjectWithKey:CURRENT_SHOP_ID];
    NSArray *ids = [ZZDBCacheTool getAllWineDatasByShopId:shopid typeId:data.Id];
    ZZCombosDetailVC *detail = [[ZZCombosDetailVC alloc] initWithIds:ids];
    detail.title = @"详情";
    [self.navigationController pushViewController:detail animated:YES];
}

- (void)collectionView:(UICollectionView *)collectionView didDeselectItemAtIndexPath:(NSIndexPath *)indexPath {
    
    
}

- (void)collectionView:(UICollectionView *)collectionView didHighlightItemAtIndexPath:(NSIndexPath *)indexPath {
    
    
}

- (void)collectionView:(UICollectionView *)collectionView didUnhighlightItemAtIndexPath:(NSIndexPath *)indexPath {
    
    
}

@end
