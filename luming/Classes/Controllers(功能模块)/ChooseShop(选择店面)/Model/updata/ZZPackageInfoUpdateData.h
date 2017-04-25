//
//  ZZPackageInfoUpdateData.h
//  luming
//
//  Created by anyware on 17/3/3.
//  Copyright © 2017年 zhuzhiqiaqng. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface ZZPackageInfoUpdateData : NSObject

//{
//    "Id":"6b3a2118-62cd-48de-9aeb-365ce34461a2",
//    "NameEN":"33",
//    "NameCN":"222",
//    "Price":33,
//    "Currency":"RMB",
//    "SortOrder":2,
//    "OwnerShop":"5071e50b-172a-4065-b3fe-44d0052b5b24",
//    "CreateDate":"/Date(1488603671117+0800)/",
//    "DetailCN":"test",
//    "DetailEN":"特斯特他说他是",
//    "IsEnable":1
//}

@property (nonatomic,copy) NSString *Id;
@property (nonatomic,copy) NSString *NameEN;
@property (nonatomic,copy) NSString *NameCN;
@property (nonatomic,assign) float Price;
@property (nonatomic,copy) NSString *Currency;
@property (nonatomic,assign) int SortOrder;
@property (nonatomic,copy) NSString *OwnerShop;
@property (nonatomic,copy) NSString *CreateDate;
@property (nonatomic,copy) NSString *DetailCN;
@property (nonatomic,copy) NSString *DetailEN;
@property (nonatomic,assign) int IsEnable;

@end
