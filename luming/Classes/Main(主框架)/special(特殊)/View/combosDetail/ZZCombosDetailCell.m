//
//  ZZCombosDetailCell.m
//  luming
//
//  Created by anyware on 17/2/24.
//  Copyright © 2017年 zhuzhiqiaqng. All rights reserved.
//

#import "ZZCombosDetailCell.h"
#import "ZZCombosDetailCell.h"

#define CellWidth WIDTH * 0.97
#define FontSize 20
#define JianJu 5

@implementation ZZCombosDetailCell

+ (instancetype)cellWithTableView:(UITableView *)tableView {
    static NSString *ID = @"combosDetail";
    ZZCombosDetailCell *cell = [tableView dequeueReusableCellWithIdentifier:ID];
    if (cell == nil) {
        cell = [[ZZCombosDetailCell alloc] initWithStyle:UITableViewCellStyleSubtitle reuseIdentifier:ID];
    }
    return cell;
}

- (id)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier {
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        // 添加view
        [self setupView];
    }
    return self;
}

- (void)setupView {
    //contentView居中
   
    // 1.英文名称
    UILabel *enLabel = [[UILabel alloc] init];
    enLabel.numberOfLines = 0;
    enLabel.font = [UIFont systemFontOfSize:FontSize];
    [enLabel setTextColor:[UIColor whiteColor]];
    [self.contentView addSubview:enLabel];
    //布局
    [enLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.mas_offset(JianJu);
        make.left.mas_offset(10);
        make.width.mas_equalTo(CellWidth * 0.8);
    }];
    _enNameLabel = enLabel;
    
    // 2.中文名称
    UILabel *cnLabel = [[UILabel alloc] init];
    cnLabel.numberOfLines = 0;
    cnLabel.font = [UIFont systemFontOfSize:FontSize-3];
    [cnLabel setTextColor:[UIColor whiteColor]];
    [self.contentView addSubview:cnLabel];
    //布局
    [cnLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.mas_equalTo(_enNameLabel.mas_bottom).mas_offset(JianJu * 2);
        make.left.mas_equalTo(_enNameLabel.mas_left);
        make.width.mas_equalTo(_enNameLabel.mas_width);
    }];
    _cnNameLabel = cnLabel;
    
    // 3.价格
    UILabel *priceL = [[UILabel alloc] init];
    priceL.textAlignment = NSTextAlignmentRight;
    priceL.font = [UIFont systemFontOfSize:FontSize];
    [priceL setTextColor:[UIColor whiteColor]];
    [self.contentView addSubview:priceL];
    //布局
    [priceL mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.mas_equalTo(_enNameLabel.mas_top);
        make.right.mas_offset(-10);
    }];
    _priceLabel = priceL;
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end
