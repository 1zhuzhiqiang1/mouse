//
//  ZZUpdateWineData.h
//  luming
//
//  Created by anyware on 17/3/3.
//  Copyright © 2017年 zhuzhiqiaqng. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface ZZUpdateWineData : NSObject

//{
//    "UnitPropTextCN":"瓶",
//    "UnitPropTextEN":"BOT",
//    "SpecPropTextCN":"750ml",
//    "SpecPropTextEN":"750ml",
//    "OwerTypeId":"1f5369b2-3115-4913-aaf7-17f5a9ad94aa",
//    "OwnerTypeNameCN":"干邑白兰地",
//    "Id":"5ec87df9-81fa-45df-91cc-9fc65f2a8ef6",
//    "NameCN":"轩尼诗V.S.O.P.",
//    "NameEN":"HENNESSY V.S.O.P.",
//    "SpecProp":"edecc19f-0c0a-4604-bc88-b4cc06dcbfb8",
//    "Price":1380,
//    "Currency":"RMB",
//    "SortOrder":1,
//    "CreateDate":"/Date(1488600820370+0800)/",
//    "IsEnable":1,
//    "UniProp":"25fe88e0-ef5b-4209-8174-8098df55d73e",
//    "OwnerShop":"5071e50b-172a-4065-b3fe-44d0052b5b24"
//}

@property (nonatomic,copy) NSString *UnitPropTextCN;
@property (nonatomic,copy) NSString *UnitPropTextEN;
@property (nonatomic,copy) NSString *SpecPropTextCN;
@property (nonatomic,copy) NSString *SpecPropTextEN;
@property (nonatomic,copy) NSString *OwerTypeId;//所属的酒品类型
@property (nonatomic,copy) NSString *Id;
@property (nonatomic,copy) NSString *NameCN;
@property (nonatomic,copy) NSString *NameEN;
@property (nonatomic,copy) NSString *SpecProp;
@property (nonatomic,assign) float Price;
@property (nonatomic,copy) NSString *Currency;
@property (nonatomic,copy) NSString *SortOrder;
@property (nonatomic,copy) NSString *CreateDate;
@property (nonatomic,assign) int IsEnable;
@property (nonatomic,copy) NSString *UniProp;
@property (nonatomic,copy) NSString *OwnerShop;//所属的店铺

@end
