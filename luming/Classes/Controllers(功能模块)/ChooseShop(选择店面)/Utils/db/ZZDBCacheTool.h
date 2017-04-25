//
//  ZZWineTypeCacheTool.h
//  luming
//
//  Created by anyware on 17/3/1.
//  Copyright © 2017年 zhuzhiqiaqng. All rights reserved.
//

#import <Foundation/Foundation.h>

@class WineTypeData;
@class WineData;
@class PackageData;

@interface ZZDBCacheTool : NSObject

// -----方法-----

// 酒品类型
+ (void)addWineTypeData:(WineTypeData *)wineTypeData shopId:(NSString *)shopId;
+ (NSArray *)getAllWineTypeDatasByShopId:(NSString *)shopId;
+ (NSArray *)getAllWineTypeDatas; //获取所有的酒品分类数据

+ (void)updataWineTypeDataWithShopId:(NSString *)shopId uid:(NSString *)uid data:(WineTypeData *)data;
+ (void)deleteWineTypeWithShopId:(NSString *)shopId uid:(NSString *)uid;
+ (WineTypeData *)getWineTypeDataWithShopId:(NSString *)shopId uid:(NSString *)uid;

// 酒品
+ (void)addWineData:(WineData *)wineData shopId:(NSString *)shopId typeId:(NSString *)typeId;
+ (NSArray *)getAllWineDatasByShopId:(NSString *)shopId;
+ (NSArray *)getAllWineDatasByShopId:(NSString *)shopId typeId:(NSString *)typeId;
+ (WineData *)getWineDataById:(NSString *)uid;

+ (void)updataWineDataWithShopId:(NSString *)shopid uid:(NSString *)uid data:(WineData *)wineData;
+ (void)deleteWineWithShopId:(NSString *)shopId uid:(NSString *)uid;

// 套餐
+ (void)addPackageData:(PackageData *)packageData shopId:(NSString *)shopId;
+ (NSArray *)getAllPackageDatasByShopId:(NSString *)shopId;
+ (PackageData *)getPackageDataById:(NSString *)uid;

+ (PackageData *)getPackageDataWithShopId:(NSString *)shopid uid:(NSString *)uid;
+ (void)updataPackageDataWithShopId:(NSString *)shopid uid:(NSString *)uid data:(PackageData *)packageData;
+ (void)deletePackageWithShopId:(NSString *)shopId uid:(NSString *)uid;

@end
