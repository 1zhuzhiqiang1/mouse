//
//  ChooseShopData.h
//  luming
//
//  Created by anyware on 17/2/28.
//  Copyright © 2017年 zhuzhiqiaqng. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface UpDataNewData : NSObject

//{
//    "Id":33,
//    "Function":"Create",
//    "Module":"PackageInfo",
//    "DataStr":"{ "Id": "9bd41b0b-bcc9-4744-bb68-64f4179d0dfa", "NameEN": "5 BOTTLE HENNESSY VSOP（15 BOTTLE WATER)", "NameCN": "5瓶轩尼诗vsop(配15瓶矿水)", "Price": 9980.00, "Currency": "RMB", "Description": "1", "SortOrder": 1, "OwnerShop": "5071e50b-172a-4065-b3fe-44d0052b5b24", "CreateDate": "\/Date(1488348669212+0800)\/", "DetailCN": "1undefined 酩悦香槟+1undefined 长岛冰茶+1undefined 懒虫金+1undefined 雪树伏特加+", "DetailEN": "1undefined MOET CHANDON IMPERIAL+1undefined LONG ISLAND ICE TEA+1undefined CAMINO GOLD+1undefined BELVEDERE VODKA+", "IsEnable": 1 }",
//    "State":0,
//    "CreateDate":"/Date(1488348669787)/",
//    "UpdateDate":null,
//    "ShopId":"5071e50b-172a-4065-b3fe-44d0052b5b24"
//}

@property (nonatomic, assign) int Id;
@property (nonatomic,copy) NSString *Function;
@property (nonatomic,copy) NSString *Module;
@property (nonatomic,copy) NSString *DataStr;
@property (nonatomic,assign) int State;
@property (nonatomic,copy) NSString *CreateDate;
@property (nonatomic,copy) NSString *UpdateDate;
@property (nonatomic,copy) NSString *ShopId;

@end
