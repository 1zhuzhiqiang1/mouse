//
//  WineTypeData.h
//  luming
//
//  Created by anyware on 17/3/1.
//  Copyright © 2017年 zhuzhiqiaqng. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface WineTypeData : NSObject

//{
//    "MenuDetailIds":[
//                     "879ca5b4-cd69-4fd3-8de0-24010a01a5ff"
//                     ],
//    "Id":"83d12fc1-7e29-48bc-9b99-10636cf3209b",
//    "NameEN":"FTJ",
//    "NameCN":"伏特加",
//    "ImgPath":"2017-02/28/-1574158584.png",
//    "CreateDate":null,
//    "SortOrder":1,
//    "Description":null,
//    "OwnerShop":"5071e50b-172a-4065-b3fe-44d0052b5b24"
//}

@property (nonatomic,copy) NSArray *MenuDetailIds;
@property (nonatomic,copy) NSString *Id;
@property (nonatomic,copy) NSString *NameEN;
@property (nonatomic,copy) NSString *NameCN;
@property (nonatomic,copy) NSString *ImgPath;
@property (nonatomic,copy) NSString *CreateDate;
@property (nonatomic,copy) NSString *SortOrder;
@property (nonatomic,copy) NSString *Description;
@property (nonatomic,copy) NSString *OwnerShop;

@end
