//
//  ZZCombosDetailVC.h
//  luming
//
//  Created by anyware on 17/2/27.
//  Copyright © 2017年 zhuzhiqiaqng. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface ZZCombosDetailVC : UITableViewController

@property (nonatomic, strong) NSArray *ids;

- (instancetype)initWithIds:(NSArray *)ids;

@end
