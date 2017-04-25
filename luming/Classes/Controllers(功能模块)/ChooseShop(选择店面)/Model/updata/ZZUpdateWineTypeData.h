//
//  ZZUpdateWineTypeData.h
//  luming
//
//  Created by anyware on 17/3/3.
//  Copyright © 2017年 zhuzhiqiaqng. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface ZZUpdateWineTypeData : NSObject

//{
//    "Id":"a5bffbf1-a300-4c83-9146-d4c7ebc678cd",
//    "NameEN":"22",
//    "NameCN":"test11",
//    "CreateDate":"/Date(1488603647425+0800)/",
//    "SortOrder":22,
//    "Description":"2",
//    "OwnerShop":"5071e50b-172a-4065-b3fe-44d0052b5b24"
//}

@property (nonatomic,copy) NSString *Id;
@property (nonatomic,copy) NSString *NameEN;
@property (nonatomic,copy) NSString *NameCN;
@property (nonatomic,copy) NSString *ImgPath;
@property (nonatomic,assign) int SortOrder;
@property (nonatomic,copy) NSString *Description;
@property (nonatomic,copy) NSString *OwnerShop;

@end
