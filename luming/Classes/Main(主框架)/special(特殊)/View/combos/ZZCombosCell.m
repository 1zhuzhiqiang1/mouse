//
//  ZZCombosCell.m
//  luming
//
//  Created by anyware on 17/2/23.
//  Copyright © 2017年 zhuzhiqiaqng. All rights reserved.
//

#import "ZZCombosCell.h"
#import "ZZCombosFrame.h"

#define CellWidth WIDTH * 0.97
#define JianJu 5
#define FontSize 18

@interface ZZCombosCell ()

@end

@implementation ZZCombosCell

+ (instancetype)cellWithTableView:(UITableView *)tableView {
    static NSString *ID = @"combos";
    ZZCombosCell *cell = [tableView dequeueReusableCellWithIdentifier:ID];
    if (cell == nil) {
        cell = [[ZZCombosCell alloc] initWithStyle:UITableViewCellStyleSubtitle reuseIdentifier:ID];
    }
    return cell;
}

- (id)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        // 添加view
        [self setupView];
    }
    return self;
}

- (void)setupView {
    
    // 1.英文描述
    UILabel *enLabel = [[UILabel alloc] init];
    enLabel.font = [UIFont systemFontOfSize:FontSize];
    [enLabel setTextColor:[UIColor whiteColor]];
    [self.contentView addSubview:enLabel];
    //布局
    [enLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.mas_offset(JianJu);
        make.left.mas_equalTo(self.contentView.mas_left).mas_offset(10);
        make.width.mas_equalTo(CellWidth);
    }];
    _englishLabel = enLabel;
    
    // 1.1 副标题
    UILabel *enSubLabel = [[UILabel alloc] init];
    enSubLabel.font = [UIFont systemFontOfSize:FontSize];
    [enSubLabel setTextColor:[UIColor whiteColor]];
    [self.contentView addSubview:enSubLabel];
    //布局
    [enSubLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.mas_equalTo(_englishLabel.mas_bottom).mas_offset(JianJu);
        make.left.mas_equalTo(self.contentView.mas_left).mas_offset(10);
        make.width.mas_equalTo(CellWidth);
    }];
    _EnSubLabel = enSubLabel;
    
    // 2.中文描述
    UILabel *cnLabel = [[UILabel alloc] init];
    cnLabel.font = [UIFont systemFontOfSize:FontSize-4];
    [cnLabel setTextColor:[UIColor whiteColor]];
    [self.contentView addSubview:cnLabel];
    //布局
    [cnLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.mas_equalTo(_EnSubLabel.mas_bottom).mas_offset(JianJu*2);
        make.left.mas_equalTo(self.englishLabel.mas_left);
        make.width.mas_equalTo(self.englishLabel.mas_width);
    }];
    _chineseLabel = cnLabel;
    
    // 2.1 副标题
    UILabel *cnSubLabel = [[UILabel alloc] init];
    cnSubLabel.font = [UIFont systemFontOfSize:FontSize-4];
    [cnSubLabel setTextColor:[UIColor whiteColor]];
    [self.contentView addSubview:cnSubLabel];
    //布局
    [cnSubLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.mas_equalTo(_chineseLabel.mas_bottom).mas_offset(JianJu);
        make.left.mas_equalTo(self.englishLabel.mas_left);
        make.width.mas_equalTo(self.englishLabel.mas_width);
    }];
    _CNSubLabel = cnSubLabel;
    
    // 3.价格
    UILabel *priceL = [[UILabel alloc] init];
    priceL.textAlignment = NSTextAlignmentRight;
    priceL.font = [UIFont systemFontOfSize:FontSize];
    [priceL setTextColor:[UIColor whiteColor]];
    [self.contentView addSubview:priceL];
    //布局
    [priceL mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.mas_equalTo(_englishLabel.mas_top);
        make.right.mas_offset(-JianJu*2);
    }];
    self.preiceLabel = priceL;
}

- (void)awakeFromNib {
    [super awakeFromNib];
    // Initialization code
}

// 获取Cell高度
- (CGFloat)cellHeight {
    return CGRectGetMaxY(self.chineseLabel.frame) + JianJu;
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end
