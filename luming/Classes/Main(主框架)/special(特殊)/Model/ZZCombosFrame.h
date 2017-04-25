//
//  ZZCombosFrame.h
//  luming
//
//  Created by anyware on 17/2/23.
//  Copyright © 2017年 zhuzhiqiaqng. All rights reserved.
//
//  结构模型(包含数据模型)

#import <Foundation/Foundation.h>

@class ZZCombos;

@interface ZZCombosFrame : NSObject

@property (nonatomic, strong) ZZCombos *combos;// 数据模型

@property (nonatomic, assign) CGFloat cellHeight;//Cell的高度
@property (nonatomic, assign) CGRect englishLabelF;
@property (nonatomic, assign) CGRect chineseLabelF;
@property (nonatomic, assign) CGRect preiceLabelF;

@end
