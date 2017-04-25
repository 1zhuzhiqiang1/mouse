//
//  PackageData.h
//  luming
//
//  Created by anyware on 17/3/1.
//  Copyright © 2017年 zhuzhiqiaqng. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface PackageData : NSObject
//
//{
//    "MenuDetailIds":[
//    
//    ],
//    "Id":"418f15f6-eb11-426c-8830-51388e9dd00d",
//    "NameEN":"5 BOTTLE HENNESSY VSOP（15 BOTTLE WATER)",
//    "NameCN":"5瓶轩尼诗vsop(配15瓶矿水)",
//    "Price":9980,
//    "Currency":"RMB ",
//    "Description":"1",
//    "SortOrder":1,
//    "OwnerShop":"5071e50b-172a-4065-b3fe-44d0052b5b24",
//    "CreateDate":"/Date(1488348593897)/",
//    "DetailCN":"1undefined 酩悦香槟+1undefined 长岛冰茶+1undefined 懒虫金+1undefined 雪树伏特加+",
//    "DetailEN":"1undefined MOET CHANDON IMPERIAL+1undefined LONG ISLAND ICE TEA+1undefined CAMINO GOLD+1undefined BELVEDERE VODKA+",
//    "IsEnable":null,
//    "ImgPath":null
//}
@property (nonatomic,copy) NSArray *MenuDetailIds;
@property (nonatomic,copy) NSString *Id;
@property (nonatomic,copy) NSString *NameEN;
@property (nonatomic,copy) NSString *NameCN;
@property (nonatomic,copy) NSString *Price;
@property (nonatomic,copy) NSString *Currency;
@property (nonatomic,copy) NSString *Description;
@property (nonatomic,assign) int SortOrder;
@property (nonatomic,copy) NSString *OwnerShop;
@property (nonatomic,copy) NSString *CreateDate;
@property (nonatomic,copy) NSString *DetailCN;
@property (nonatomic,copy) NSString *DetailEN;
@property (nonatomic,copy) NSString *IsEnable;
@property (nonatomic,copy) NSString *ImgPath;

@end
