//
//  ZZMaskView.m
//  luming
//
//  Created by anyware on 17/3/2.
//  Copyright © 2017年 zhuzhiqiaqng. All rights reserved.
//
// 遮罩层

#import "ZZMaskView.h"

@implementation ZZMaskView

/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing code
}
*/



- (BOOL)isInScreen {
    // 若view 隐藏
    if (self.hidden) {
        return FALSE;
    }
    // 若没有superview
    if (self.superview == nil) {
        return FALSE;
    }
    return true;
}

@end
