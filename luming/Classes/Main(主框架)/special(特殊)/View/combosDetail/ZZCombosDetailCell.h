//
//  ZZCombosDetailCell.h
//  luming
//
//  Created by anyware on 17/2/24.
//  Copyright © 2017年 zhuzhiqiaqng. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface ZZCombosDetailCell : UITableViewCell

//-----属性-----
@property (nonatomic, weak) UILabel *enNameLabel;
@property (nonatomic, weak) UILabel *cnNameLabel;
@property (nonatomic, weak) UILabel *priceLabel;

//-----方法-----
+ (instancetype)cellWithTableView:(UITableView *)tableView;

@end
