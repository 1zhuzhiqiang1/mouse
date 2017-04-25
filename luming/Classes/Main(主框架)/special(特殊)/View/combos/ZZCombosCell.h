//
//  ZZCombosCell.h
//  luming
//
//  Created by anyware on 17/2/23.
//  Copyright © 2017年 zhuzhiqiaqng. All rights reserved.
//
//  自定义UITableViewCell

#import <UIKit/UIKit.h>

@class ZZCombosFrame;

@interface ZZCombosCell : UITableViewCell

//-----属性-----
@property (nonatomic, weak) UILabel *englishLabel;
@property (nonatomic, weak) UILabel *EnSubLabel;// 副标题
@property (nonatomic, weak) UILabel *chineseLabel;
@property (nonatomic, weak) UILabel *CNSubLabel;// 副标题
@property (nonatomic, weak) UILabel *preiceLabel;

//-----方法-----
+ (instancetype)cellWithTableView:(UITableView *)tableView;



@end
