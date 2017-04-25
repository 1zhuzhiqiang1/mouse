//
//  ZZCombosNextButton.m
//  luming
//
//  Created by anyware on 17/2/24.
//  Copyright © 2017年 zhuzhiqiaqng. All rights reserved.
//

#import "ZZCombosNextButton.h"

@implementation ZZCombosNextButton

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
    CGFloat width = contentRect.size.width;
    CGFloat height = contentRect.size.height;
    CGFloat imageX = width * 0.6;
    CGFloat imageW = 30;
    CGFloat imageH = imageW;
    return CGRectMake(imageX, (height-imageH)/2, imageW, imageH);
}

// 内部文字的frame
- (CGRect)titleRectForContentRect:(CGRect)contentRect
{
    CGFloat titleW = contentRect.size.width*0.5;
    CGFloat titleH = contentRect.size.height;
    return CGRectMake(0, 0, titleW, titleH);
}

@end
