//
//  ZZWineTypeCacheTool.m
//  luming
//
//  Created by anyware on 17/3/1.
//  Copyright © 2017年 zhuzhiqiaqng. All rights reserved.
//

#import "ZZDBCacheTool.h"
#import "FMDB.h"

#import "WineTypeData.h"
#import "WineData.h"
#import "PackageData.h"

@implementation ZZDBCacheTool

#define TABLE_WINETYPE  @"TABLE_WINETYPE"
#define TABLE_WINE      @"TABLE_WINE"
#define TABLE_PACKAGE   @"TABLE_PACKAGE"

static FMDatabaseQueue *_queue;

+(void)initialize {
    // 0.获得沙盒中的数据库文件名
    NSString *path = [[NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES) lastObject] stringByAppendingPathComponent:@"wineType.sqlite"];
    MyLog(@"数据库地址是%@",path);
    
    // 1.创建队列
    _queue = [FMDatabaseQueue databaseQueueWithPath:path];
    
    // 2.创表
    [_queue inDatabase:^(FMDatabase *db) {
        
        // 酒品类型表
        if([db executeUpdate:@"create table if not exists TABLE_WINETYPE (id integer primary key autoincrement, uid text not null UNIQUE, shopid text not null, wineTypeData blob not null, SortOrder integer not null);"]) {
            MyLog(@"Create Table：%@",@"YES");
        }
        
        // 酒品表
        if([db executeUpdate:@"create table if not exists TABLE_WINE (id integer primary key autoincrement, uid text not null UNIQUE,shopid text not null, wineData blob not null, SortOrder integer not null, typeId text not null);"]) {
            MyLog(@"Create Table：%@",@"YES");
        }
        
        // 套餐表
        if([db executeUpdate:@"create table if not exists TABLE_PACKAGE (id integer primary key autoincrement, uid text not null UNIQUE,shopid text not null, packageData blob not null, SortOrder integer not null);"]) {
            MyLog(@"Create Table：%@",@"YES");
        }
        
    }];
}

#pragma mark 酒品类型 TABLE_WINETYPE

+ (void)addWineTypeData:(WineTypeData *)wineTypeData shopId:(NSString *)shopId {
    [_queue inDatabase:^(FMDatabase *db) {
        // 1.获得需要存储的数据
        NSString* uid = wineTypeData.Id;
        NSData *data = [NSKeyedArchiver archivedDataWithRootObject:wineTypeData];
        NSNumber *sortOrder = @([wineTypeData.SortOrder intValue]);
        
        // 2.存储数据
        if([db executeUpdate:@"insert into TABLE_WINETYPE (uid, wineTypeData, shopid, SortOrder) values(?,?,?,?)",uid,data,shopId,sortOrder]) {
            MyLog(@"添加酒品类型：%@",@"YES");
        }
    }];
}

+ (NSArray *)getAllWineTypeDatasByShopId:(NSString *)shopId {
    // 1.定义数组
    __block NSMutableArray *datas = nil;
    
    [_queue inDatabase:^(FMDatabase *db) {
        datas = [NSMutableArray array];
        FMResultSet *sets = [db executeQuery:@"select * from TABLE_WINETYPE where shopid = ? order by SortOrder ASC",shopId];
        while (sets.next) {
            NSData *data = [sets dataForColumn:@"wineTypeData"];
            WineTypeData *typeData = [NSKeyedUnarchiver unarchiveObjectWithData:data];
            [datas addObject:typeData];
        }
    }];
    
    return datas;
}

+ (NSArray *)getAllWineTypeDatas {
    // 1.定义数组
    __block NSMutableArray *datas = nil;
    
    [_queue inDatabase:^(FMDatabase *db) {
        datas = [NSMutableArray array];
        FMResultSet *sets = [db executeQuery:@"select * from TABLE_WINETYPE"];
        while (sets.next) {
            NSData *data = [sets dataForColumn:@"wineTypeData"];
            [datas addObject:[NSKeyedUnarchiver unarchiveObjectWithData:data]];
        }
    }];
    
    return datas;
}

+ (void)deleteWineTypeWithShopId:(NSString *)shopId uid:(NSString *)uid {
    [_queue inDatabase:^(FMDatabase *db) {
        if([db executeUpdate:@"delete from TABLE_WINETYPE where shopid=? and uid=?",shopId,uid]) {
            MyLog(@"删除酒品类型成功");
        }
    }];
}

+ (void)updataWineTypeDataWithShopId:(NSString *)shopId uid:(NSString *)uid data:(WineTypeData *)data{
    NSData *wineTypeData = [NSKeyedArchiver archivedDataWithRootObject:data];
    NSNumber *sortOrder = @([data.SortOrder intValue]);
    [_queue inDatabase:^(FMDatabase *db) {
        if([db executeUpdate:@"update TABLE_WINETYPE set wineTypeData=?,SortOrder=? where shopid=? and uid=?",wineTypeData,sortOrder,shopId,uid]) {
            MyLog(@"更新酒品类型成功");
        }
    }];
}
// 获取一个数据
+ (WineTypeData *)getWineTypeDataWithShopId:(NSString *)shopId uid:(NSString *)uid {
    __block WineTypeData *typeData = nil;
    [_queue inDatabase:^(FMDatabase *db) {
        FMResultSet *sets = [db executeQuery:@"select * from TABLE_WINETYPE where shopid=? and uid=?",shopId,uid];
        while (sets.next) {
            NSData *data = [sets dataForColumn:@"wineTypeData"];
            typeData = [NSKeyedUnarchiver unarchiveObjectWithData:data];
        }
    }];
    return typeData;
}

#pragma mark 酒品 TABLE_WINE

+ (void)addWineData:(WineData *)wineData shopId:(NSString *)shopId typeId:(NSString *)typeId{
    [_queue inDatabase:^(FMDatabase *db) {
        // 1.获得需要存储的数据
        NSString* uid = wineData.Id;
        NSData *data = [NSKeyedArchiver archivedDataWithRootObject:wineData];
        NSNumber *sortOrder = @([wineData.SortOrder intValue]);
        
        // 2.存储数据
        if([db executeUpdate:@"insert into TABLE_WINE (uid,wineData,shopid,SortOrder,typeId) values(?,?,?,?,?)",uid,data,shopId,sortOrder,typeId]) {
            MyLog(@"添加酒品：%@",@"YES");
        }
    }];
}

+ (NSArray *)getAllWineDatasByShopId:(NSString *)shopId {
    // 1.定义数组
    __block NSMutableArray *datas = nil;
    
    [_queue inDatabase:^(FMDatabase *db) {
        datas = [NSMutableArray array];
        FMResultSet *sets = [db executeQuery:@"select * from TABLE_WINE where shopid=? order by SortOrder ASC",shopId];
        while (sets.next) {
            NSData *data = [sets dataForColumn:@"wineData"];
            [datas addObject:[NSKeyedUnarchiver unarchiveObjectWithData:data]];
        }
    }];
    return datas;
}

// 根据店面号和类型获取对应的明细
+ (NSArray *)getAllWineDatasByShopId:(NSString *)shopId typeId:(NSString *)typeId {
    // 1.定义数组
    __block NSMutableArray *datas = nil;
    
    [_queue inDatabase:^(FMDatabase *db) {
        datas = [NSMutableArray array];
        FMResultSet *sets = [db executeQuery:@"select * from TABLE_WINE where shopid=? and typeId=? order by SortOrder ASC",shopId,typeId];
        while (sets.next) {
            NSData *data = [sets dataForColumn:@"wineData"];
            [datas addObject:[NSKeyedUnarchiver unarchiveObjectWithData:data]];
        }
    }];
    return datas;
}

+ (WineData *)getWineDataById:(NSString *)uid {
    __block WineData *data = nil;
    [_queue inDatabase:^(FMDatabase *db) {
        FMResultSet *sets = [db executeQuery:@"select * from TABLE_WINE where uid = ?",uid];
        while (sets.next) {
            data = [NSKeyedUnarchiver unarchiveObjectWithData:[sets dataForColumn:@"wineData"]];
        }
    }];
    return data;
}

// 增删改

+ (void)updataWineDataWithShopId:(NSString *)shopid uid:(NSString *)uid data:(WineData *)wineData {
    NSData *data = [NSKeyedArchiver archivedDataWithRootObject:wineData];
    NSNumber *sortOrder = @([wineData.SortOrder intValue]);
    [_queue inDatabase:^(FMDatabase *db) {
        if([db executeUpdate:@"update TABLE_WINE set wineData=?,SortOrder=? where shopid=? and uid=?",data,sortOrder,shopid,uid]) {
            MyLog(@"更新酒品成功");
        }
    }];
}

+ (void)deleteWineWithShopId:(NSString *)shopId uid:(NSString *)uid {
    [_queue inDatabase:^(FMDatabase *db) {
        if([db executeUpdate:@"delete from TABLE_WINE where shopid=? and uid=?",shopId,uid]) {
            MyLog(@"删除酒品成功");
        }
    }];
}

#pragma mark 套餐 TABLE_PACKAGE

+ (void)addPackageData:(PackageData *)packageData shopId:(NSString *)shopId {
    [_queue inDatabase:^(FMDatabase *db) {
        // 1.获得需要存储的数据
        NSString* uid = packageData.Id;
        NSData *data = [NSKeyedArchiver archivedDataWithRootObject:packageData];
        NSNumber *sortOrder = @(packageData.SortOrder);
        
        // 2.存储数据
        if([db executeUpdate:@"insert into TABLE_PACKAGE (uid,packageData,shopid,SortOrder) values(?,?,?,?)",uid,data,shopId,sortOrder]) {
            MyLog(@"添加套餐：%@",@"YES");
        }
    }];
}

+ (NSArray *)getAllPackageDatasByShopId:(NSString *)shopId {
    // 1.定义数组
    __block NSMutableArray *datas = nil;
    
    [_queue inDatabase:^(FMDatabase *db) {
        datas = [NSMutableArray array];
        FMResultSet *sets = [db executeQuery:@"select * from TABLE_PACKAGE where shopid = ? order by SortOrder ASC",shopId];
        while (sets.next) {
            NSData *data = [sets dataForColumn:@"packageData"];
            [datas addObject:[NSKeyedUnarchiver unarchiveObjectWithData:data]];
        }
    }];
    
    return datas;
}

+ (PackageData *)getPackageDataById:(NSString *)uid {
    __block PackageData *data;
    [_queue inDatabase:^(FMDatabase *db) {
        FMResultSet *sets = [db executeQuery:@"select * from TABLE_PACKAGE where uid = ?",uid];
        while (sets.next) {
            data = [NSKeyedUnarchiver unarchiveObjectWithData:[sets dataForColumn:@"packageData"]];
        }
    }];
    return data;
}

// 增删改
+ (PackageData *)getPackageDataWithShopId:(NSString *)shopid uid:(NSString *)uid {
    __block PackageData *data = nil;
    [_queue inDatabase:^(FMDatabase *db) {
        FMResultSet *sets = [db executeQuery:@"select * from TABLE_PACKAGE where shopid=? uid=?",shopid,uid];
        while (sets.next) {
            NSData *data2  = [sets dataForColumn:@"packageData"];
            data = [NSKeyedUnarchiver unarchiveObjectWithData:data2];
        }
    }];
    return data;
}
+ (void)updataPackageDataWithShopId:(NSString *)shopid uid:(NSString *)uid data:(PackageData *)packageData {
    NSData *data = [NSKeyedArchiver archivedDataWithRootObject:packageData];
    NSNumber *sortOrder = @(packageData.SortOrder);
    [_queue inDatabase:^(FMDatabase *db) {
        if([db executeUpdate:@"update TABLE_PACKAGE set packageData = ?,SortOrder = ? where shopid=? and uid=?",data,sortOrder,shopid,uid]) {
            MyLog(@"更新套餐成功");
        }
    }];
}
+ (void)deletePackageWithShopId:(NSString *)shopId uid:(NSString *)uid{
    [_queue inDatabase:^(FMDatabase *db) {
        if([db executeUpdate:@"delete from TABLE_PACKAGE where shopid=? and uid=?",shopId,uid]) {
            MyLog(@"删除套餐成功");
        }
    }];
}

@end
