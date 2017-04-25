//
//  ZQMainCell.m
//  UICollectionViewTest
//
//  Created by anyware on 17/2/13.
//  Copyright © 2017年 chinasofti. All rights reserved.
//

#import "ZQMainCell.h"

#define CellWidth WIDTH / 5.0
#define FontSize 18
#define LabelHeight 20
#define ImageWidth 85

@interface ZQMainCell ()

@end

@implementation ZQMainCell

-(instancetype)initWithFrame:(CGRect)frame {
    if (self = [super initWithFrame:frame]) {
        [self setupUI];
    }
    return self;
}

#pragma mark Private
-(void)setupUI {
    
    // 1.图片
    _topImage = [[UIImageView alloc] init];
    [self.contentView addSubview:_topImage];
    [_topImage mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerX.mas_equalTo(self.contentView.mas_centerX);
        make.top.mas_offset(10);
        make.size.mas_equalTo(CGSizeMake(ImageWidth, ImageWidth));
    }];
    
    // 2.英文名称
    _englishNameLabel = [[UILabel alloc] init];
    [self.contentView addSubview:_englishNameLabel];
    _englishNameLabel.text = @"English";
    _englishNameLabel.font = [UIFont systemFontOfSize:FontSize];
    _englishNameLabel.textColor = [UIColor whiteColor];
    _englishNameLabel.textAlignment = NSTextAlignmentCenter;
    _englishNameLabel.backgroundColor = [UIColor clearColor];
    [_englishNameLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerX.mas_equalTo(self.contentView.mas_centerX);
        make.top.mas_equalTo(_topImage.mas_bottom).mas_offset(5);
    }];
    
    // 3.中文名称
    _chineseNameLabel = [[UILabel alloc] init];
    [self.contentView addSubview:_chineseNameLabel];
    _chineseNameLabel.text = @"中文";
    _chineseNameLabel.font = [UIFont systemFontOfSize:FontSize-3];
    _chineseNameLabel.textColor = [UIColor whiteColor];
    _chineseNameLabel.textAlignment = NSTextAlignmentCenter;
    [_chineseNameLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerX.mas_equalTo(self.contentView.mas_centerX);
        make.top.mas_equalTo(_englishNameLabel.mas_bottom).mas_offset(1);
    }];
}

@end
