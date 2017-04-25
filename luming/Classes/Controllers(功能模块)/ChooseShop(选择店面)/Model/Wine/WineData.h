//
//  WineData.h
//  luming
//
//  Created by anyware on 17/3/1.
//  Copyright © 2017年 zhuzhiqiaqng. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface WineData : NSObject

//{
//    "UnitPropTextCN":"瓶",
//    "UnitPropTextEN":"BOT",
//    "SpecPropTextCN":"750ml",
//    "SpecPropTextEN":"750ml",
//    "OwerTypeId":"1f5369b2-3115-4913-aaf7-17f5a9ad94aa",
//    "OwnerTypeNameCN":"干邑白兰地",
//    "OwnerTypeNameEN":"Cognac & Brandy",
//    "Id":"d08f5239-d613-46fe-8fc0-b3f588de1c50",
//    "NameCN":"轩尼诗XO",
//    "NameEN":"HENNESSY XO",
//    "SpecProp":"edecc19f-0c0a-4604-bc88-b4cc06dcbfb8",
//    "NameEN2":null,
//    "Price":3280,
//    "Currency":"RMB ",
//    "ImgPath":null,
//    "SortOrder":3,
//    "Description":null,
//    "CreateDate":"/Date(1488601028420)/",
//    "IsEnable":1,
//    "UniProp":"25fe88e0-ef5b-4209-8174-8098df55d73e",
//    "OwnerShop":"5071e50b-172a-4065-b3fe-44d0052b5b24"
//}
@property (nonatomic,copy) NSString *UnitPropTextCN;
@property (nonatomic,copy) NSString *UnitPropTextEN;
@property (nonatomic,copy) NSString *SpecPropTextCN;
@property (nonatomic,copy) NSString *SpecPropTextEN;
@property (nonatomic,copy) NSString *OwerTypeId;
@property (nonatomic,copy) NSString *OwnerTypeNameCN;
@property (nonatomic,copy) NSString *Id;
@property (nonatomic,copy) NSString *NameCN;
@property (nonatomic,copy) NSString *NameEN;
@property (nonatomic,copy) NSString *SpecProp;
@property (nonatomic,copy) NSString *NameEN2;
@property (nonatomic,copy) NSString *Price;
@property (nonatomic,copy) NSString *Currency;
@property (nonatomic,copy) NSString *ImgPath;
@property (nonatomic,copy) NSString *SortOrder;
@property (nonatomic,copy) NSString *Description;
@property (nonatomic,copy) NSString *CreateDate;
@property (nonatomic,copy) NSString *IsEnable;
@property (nonatomic,copy) NSString *UniProp;

@end
