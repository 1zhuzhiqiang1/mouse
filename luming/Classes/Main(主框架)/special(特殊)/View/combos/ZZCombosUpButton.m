//
//  ZZCombosNextButton.m
//  luming
//
//  Created by anyware on 17/2/24.
//  Copyright © 2017年 zhuzhiqiaqng. All rights reserved.
//

#import "ZZCombosUpButton.h"

@implementation ZZCombosUpButton

/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing code
}
*/

// 内部图片的frame
- (CGRect)imageRectForContentRect:(CGRect)contentRect
{
    CGFloat imageW = contentRect.size.width * 0.4;
    CGFloat imageH = contentRect.size.height;
    return CGRectMake(0, 0, imageW, imageH);
}

// 内部文字的frame
- (CGRect)titleRectForContentRect:(CGRect)contentRect
{
    CGFloat titleX = contentRect.size.width * 0.4;
    CGFloat titleW = contentRect.size.width*0.6;
    CGFloat titleH = contentRect.size.height;
    return CGRectMake(titleX, 0, titleW, titleH);
}

@end
