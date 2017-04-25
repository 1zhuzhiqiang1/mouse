//
//  AppDelegate.m
//  luming
//
//  Created by anyware on 17/2/21.
//  Copyright © 2017年 zhuzhiqiaqng. All rights reserved.
//

#import "AppDelegate.h"
#import "IWTabBarViewController.h"
#import "ZZChooseShopVC.h"
#import "ZZMainTabBarController.h"
#import "MJExtension.h"
#import "UpDataNewData.h"
#import "WineData.h"
#import "WineTypeData.h"
#import "WineData.h"
#import "PackageData.h"
#import "ZZDBCacheTool.h"
#import "ZZMaskView.h"
#import "UpDataNewData.h"
#import "ZZPackageInfoUpdateData.h"
#import "ZZUpdateWineTypeData.h"
#import "ZZUpdateWineData.h"

@interface AppDelegate () {
    AFHTTPRequestOperationManager *manager;
    NSInteger requestCount;
}

@end

@implementation AppDelegate


- (BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions {
    // Override point for customization after application launch.
    
    self.window = [[UIWindow alloc] initWithFrame:[UIScreen mainScreen].bounds];
    [self.window makeKeyAndVisible];
    
    // 开启网络监测
    [self startNetworkMonitoring];
    
    manager = [AFHTTPRequestOperationManager manager];
    manager.requestSerializer.timeoutInterval = REQUEST_TIMEOUT;
    
    if([ZZDBCacheTool getAllWineTypeDatas].count <= 0) {
        requestCount = 0; // 初始请求次数为0
        [self firstDownload];
    }
    
    // 检查更新
    [self checkUpdate];
    
    if(![ZZNSPreferenceUtil getBoolWithKey:FIRST_IN]) {
        self.window.rootViewController = [[UINavigationController alloc] initWithRootViewController:[[ZZChooseShopVC alloc] init]];
    } else {
        self.window.rootViewController = [[IWTabBarViewController alloc] init];
    }
    
    return YES;
}

#pragma mark 第一次下载数据

- (void)firstDownload {
    NSArray *shops = [NSArray arrayWithObjects:SHANGHAI,HANGZHOU, nil];
    for (NSString *shopid in shops) {
        // 获取酒品类型
        [self getAllWineTypeByShopId:shopid];
        // 获取酒品
        [self getAllWineByShopId:shopid];
        // 获取套餐
        [self getAllPackageInfoByShopId:shopid];
    }
}

// 获取所有的酒品类型
- (void)getAllWineTypeByShopId:(NSString *)shopid {
    [self showMaskView];
    NSString *URL = [BASE_URL stringByAppendingString:[NSString stringWithFormat:@"api/GetAllMenuType?shopid=%@",shopid]];
    [manager GET:URL parameters:nil success:^(AFHTTPRequestOperation * _Nonnull operation, id  _Nonnull responseObject) {
        [self hideMaskView];
        NSArray *wineTypeData = [WineTypeData mj_objectArrayWithKeyValuesArray:responseObject];
        MyLog(@"%@：所有酒品类型数量--%lu",shopid,(unsigned long)wineTypeData.count);
        // 保存到数据库
        for (WineTypeData *data in wineTypeData) {
            [ZZDBCacheTool addWineTypeData:data shopId:shopid];
        }
    } failure:^(AFHTTPRequestOperation * _Nullable operation, NSError * _Nonnull error) {
        [self hideMaskView];
    }];
}

// 获取所有的酒品信息
- (void)getAllWineByShopId:(NSString *)shopid {
    [self showMaskView];
    NSString *URL = [BASE_URL stringByAppendingString:[NSString stringWithFormat:@"api/GetAllMenuItem?shopid=%@",shopid]];
    [manager GET:URL parameters:nil success:^(AFHTTPRequestOperation * _Nonnull operation, id  _Nonnull responseObject) {
        [self hideMaskView];
        NSArray *wineDatas = [WineData mj_objectArrayWithKeyValuesArray:responseObject];
        MyLog(@"%@:所有酒品数量--%lu",shopid,(unsigned long)wineDatas.count);
        // 保存到数据库
        for (WineData *data in wineDatas) {
            [ZZDBCacheTool addWineData:data shopId:shopid typeId:data.OwerTypeId];
        }
    } failure:^(AFHTTPRequestOperation * _Nullable operation, NSError * _Nonnull error) {
        [self hideMaskView];
    }];
    
}

// 获取所有的套餐信息
- (void)getAllPackageInfoByShopId:(NSString *)shopid {
    [self showMaskView];
    NSString *URL = [BASE_URL stringByAppendingString:[NSString stringWithFormat:@"api/GetAllPackage?shopid=%@",shopid]];
    [manager GET:URL parameters:nil success:^(AFHTTPRequestOperation * _Nonnull operation, id  _Nonnull responseObject) {
        [self hideMaskView];
        NSArray *packageDatas = [PackageData mj_objectArrayWithKeyValuesArray:responseObject];
        MyLog(@"%@:所有套餐数量--%lu",shopid,(unsigned long)packageDatas.count);
        // 保存到数据库
        for (PackageData *data in packageDatas) {
            [ZZDBCacheTool addPackageData:data shopId:shopid];
        }
    } failure:^(AFHTTPRequestOperation * _Nullable operation, NSError * _Nonnull error) {
        [self hideMaskView];
    }];
}

#pragma mark 统计请求次数

- (void)addRequestCount {
    requestCount++;
}

- (void)reduceRequestCount {
    requestCount--;
}

#pragma mark 添加、显示遮罩层

// 显示遮罩层
- (void)showMaskView {
    if(requestCount == 0) {
        [MBProgressHUD showMessage:nil];
    }
    [self addRequestCount];
}

// 隐藏第一次下载的遮罩层
- (void)hideMaskView {
    [self reduceRequestCount];
    if(requestCount == 1) {
        if([ZZDBCacheTool getAllWineTypeDatas].count > 0) {
            [ZZNSPreferenceUtil setBool:TRUE key:FIRST_IN];
        }
        [MBProgressHUD hideHUD];
    }
}

// 隐藏检查更新的遮罩层
- (void)hideCheckUpdateMaskView {
    [self reduceRequestCount];
    if(requestCount == 0) {
        [MBProgressHUD hideHUD];
    }
}

#pragma mark 检查更新

- (void)checkUpdate {
    NSString *shopid = [ZZNSPreferenceUtil getObjectWithKey:CURRENT_SHOP_ID];
    if(!shopid) {
        return;
    }
    NSString *updateLastId = [ZZNSPreferenceUtil getObjectWithKey:UPDATE_LAST_ID];
    if(!updateLastId) {
        updateLastId = @"0";
    }
    NSString *URL = [BASE_URL stringByAppendingString:[NSString stringWithFormat:@"api/CheckUpdate?shopid=%@&id=%@",shopid,updateLastId]];
    
    [manager GET:URL parameters:nil success:^(AFHTTPRequestOperation * _Nonnull operation, id  _Nonnull responseObject) {
        NSDictionary *dic = responseObject;
        
        // 第一次保存最大ID值
        if([updateLastId isEqualToString:@"0"]) {
            int ID = [[dic valueForKey:@"NewDataId"] intValue];
            [ZZNSPreferenceUtil setObject:[NSString stringWithFormat:@"%d",ID] key:UPDATE_LAST_ID];
        }
        
        int isUpdate = [[dic valueForKey:@"IsUpdated"] intValue];
        if(isUpdate > 0) {
            [self requestUpdateInterfaceWithShopId:shopid];
        }
    } failure:^(AFHTTPRequestOperation * _Nullable operation, NSError * _Nonnull error) {
        MyLog(@"获取更新数据出错：%@",error);
    }];
}

- (void)requestUpdateInterfaceWithShopId:(NSString *)shopid {
    
    [self showMaskView];
    
    NSString *updateLastId = [ZZNSPreferenceUtil getObjectWithKey:UPDATE_LAST_ID];
    if(!updateLastId) {
        updateLastId = @"0";
    }
    NSString *url = [BASE_URL stringByAppendingString:[NSString stringWithFormat:@"api/GetNewData?shopid=%@&id=%@",shopid,updateLastId]];
    
    [manager GET:url parameters:nil success:^(AFHTTPRequestOperation * _Nonnull operation, id  _Nonnull responseObject) {
        
        [self hideCheckUpdateMaskView];
        
        NSArray *updatas = [UpDataNewData mj_objectArrayWithKeyValuesArray:responseObject];
        
        // 保存最后一个Id
        if(updatas && updatas.count > 0) {
            UpDataNewData *data = [updatas lastObject];
            [ZZNSPreferenceUtil setObject:[NSString stringWithFormat:@"%d",data.Id] key:UPDATE_LAST_ID];
        }
        
        // 根据类型判断需要更新的数据
        for (UpDataNewData *data in updatas) {
            if(!data.DataStr){
                continue;
            }
            if([data.Module isEqualToString:@"PackageInfo"]) {//套餐
                [self updatePackageInfo:data];
            }
            else if([data.Module isEqualToString:@"MenuType"]) {//酒品类型
                [self updateWineTypeInfo:data];
            }
            else if([data.Module isEqualToString:@"MenuDetail"]) {//酒品
                [self updateWineInfo:data];
            }
        }
        MyLog(@"更新数量为:%lu",(unsigned long)updatas.count);
    } failure:^(AFHTTPRequestOperation * _Nullable operation, NSError * _Nonnull error) {
        
        [self hideCheckUpdateMaskView];
        
    }];
}

// 更新套餐
- (void)updatePackageInfo:(UpDataNewData *)data {
    id obj = [NSJSONSerialization JSONObjectWithData:[data.DataStr dataUsingEncoding:NSUTF8StringEncoding] options:NSJSONReadingAllowFragments error:nil];
    ZZPackageInfoUpdateData *detailData = [ZZPackageInfoUpdateData mj_objectWithKeyValues:obj];
    if(detailData) {
        NSString *action = data.Function;
        if([action isEqualToString:@"Delete"]) {//删除
            [ZZDBCacheTool deletePackageWithShopId:data.ShopId uid:detailData.Id];
        }else if([action isEqualToString:@"Update"]) {//更新
            PackageData *packageData = [ZZDBCacheTool getPackageDataById:detailData.Id];
            packageData.NameCN = detailData.NameCN;
            packageData.NameEN = detailData.NameEN;
            packageData.DetailCN = detailData.DetailCN;
            packageData.DetailEN = detailData.DetailEN;
            packageData.Price = [NSString stringWithFormat:@"%f",detailData.Price];
            packageData.SortOrder = detailData.SortOrder;
            [ZZDBCacheTool updataPackageDataWithShopId:data.ShopId uid:detailData.Id data:packageData];
        }else if([action isEqualToString:@"Create"]) {//添加
            PackageData *packageData = [[PackageData alloc] init];
            packageData.Id = detailData.Id;
            packageData.NameCN = detailData.NameCN;
            packageData.NameEN = detailData.NameEN;
            packageData.DetailCN = detailData.DetailCN;
            packageData.DetailEN = detailData.DetailEN;
            packageData.SortOrder = detailData.SortOrder;
            [ZZDBCacheTool addPackageData:packageData shopId:data.ShopId];
        }
        [self postCombosNotification];
    }
}

// 更新酒品类型
- (void)updateWineTypeInfo:(UpDataNewData *)data {
    id obj = [NSJSONSerialization JSONObjectWithData:[data.DataStr dataUsingEncoding:NSUTF8StringEncoding] options:NSJSONReadingAllowFragments error:nil];
    ZZUpdateWineTypeData *detailData = [ZZUpdateWineTypeData mj_objectWithKeyValues:obj];
    if(detailData) {
        NSString *action = data.Function;
        if([action isEqualToString:@"Delete"]) {//删除
            [ZZDBCacheTool deleteWineTypeWithShopId:data.ShopId uid:detailData.Id];
        }else if([action isEqualToString:@"Update"]) {//更新
            WineTypeData *typeData = [ZZDBCacheTool getWineTypeDataWithShopId:data.ShopId uid:detailData.Id];
            typeData.NameCN = detailData.NameCN;
            typeData.NameEN = detailData.NameEN;
            typeData.ImgPath = detailData.ImgPath;
            typeData.SortOrder = [NSString stringWithFormat:@"%d",detailData.SortOrder];
            [ZZDBCacheTool updataWineTypeDataWithShopId:data.ShopId uid:detailData.Id data:typeData];
        }else if([action isEqualToString:@"Create"]) {//添加
            WineTypeData *typeData = [[WineTypeData alloc] init];
            typeData.Id = detailData.Id;
            typeData.NameCN = detailData.NameCN;
            typeData.NameEN = detailData.NameEN;
            typeData.ImgPath = detailData.ImgPath;
            typeData.SortOrder = [NSString stringWithFormat:@"%d",detailData.SortOrder];
            [ZZDBCacheTool addWineTypeData:typeData shopId:data.ShopId];
        }
        [self postHomeNotification];
    }
}

// 更新酒品
- (void)updateWineInfo:(UpDataNewData *)data {
    id obj = [NSJSONSerialization JSONObjectWithData:[data.DataStr dataUsingEncoding:NSUTF8StringEncoding] options:NSJSONReadingAllowFragments error:nil];
    ZZUpdateWineData *detailData = [ZZUpdateWineData mj_objectWithKeyValues:obj];
    if(detailData) {
        NSString *action = data.Function;
        if([action isEqualToString:@"Delete"]) {//删除
            [ZZDBCacheTool deleteWineWithShopId:data.ShopId uid:detailData.Id];
        }else if([action isEqualToString:@"Update"]) {//更新
            WineData *wineData = [ZZDBCacheTool getWineDataById:detailData.Id];
            wineData.NameCN = detailData.NameCN;
            wineData.NameEN = detailData.NameEN;
            wineData.Price = [NSString stringWithFormat:@"%f",detailData.Price];
            wineData.SpecPropTextEN = detailData.SpecPropTextEN;
            wineData.Currency = detailData.Currency;
            wineData.UnitPropTextEN = detailData.UnitPropTextEN;
            wineData.SortOrder = detailData.SortOrder;
            [ZZDBCacheTool updataWineDataWithShopId:data.ShopId uid:detailData.Id data:wineData];
        }else if([action isEqualToString:@"Create"]) {//添加
            // 1.获取酒品类型
            WineTypeData *wineTypeData = [ZZDBCacheTool getWineTypeDataWithShopId:data.ShopId uid:detailData.OwerTypeId];
            NSMutableArray * array = [NSMutableArray arrayWithArray:wineTypeData.MenuDetailIds];
            [array addObject:detailData.Id];
            wineTypeData.MenuDetailIds = array;
            [ZZDBCacheTool updataWineTypeDataWithShopId:data.ShopId uid:detailData.OwerTypeId data:wineTypeData];
            
            WineData *wineData = [[WineData alloc] init];
            wineData.Id = detailData.Id;
            wineData.NameEN = detailData.NameEN;
            wineData.NameCN = detailData.NameCN;
            wineData.UnitPropTextEN = detailData.UnitPropTextEN;
            wineData.Price = [NSString stringWithFormat:@"%f",detailData.Price];
            wineData.SpecPropTextEN = detailData.SpecPropTextEN;
            wineData.Currency = detailData.Currency;
            wineData.SortOrder = detailData.SortOrder;
            [ZZDBCacheTool addWineData:wineData shopId:data.ShopId typeId:detailData.OwerTypeId];
        }
        [self postHomeNotification];
    }
}

#pragma mark 发出通知

- (void)postHomeNotification {
    // 发出通知刷新数据
    [[NSNotificationCenter defaultCenter] postNotificationName:ZZHOME_VC_CENETR object:nil];
}
- (void)postCombosNotification {
    // 发出通知刷新数据
    [[NSNotificationCenter defaultCenter] postNotificationName:ZZCombosControllerADD_NOTIFICATION object:nil];
}

+ (BOOL)netWorkConnect {
    return [AFNetworkReachabilityManager sharedManager].networkReachabilityStatus > 0;
}

// 开启网络监测
- (void)startNetworkMonitoring {
    [[AFNetworkReachabilityManager sharedManager] setReachabilityStatusChangeBlock:^(AFNetworkReachabilityStatus status) {
        switch (status) {
            case AFNetworkReachabilityStatusUnknown:
            case AFNetworkReachabilityStatusNotReachable:
                [self showToast:@"提示" message:@"没有网络连接"];
                break;
            case AFNetworkReachabilityStatusReachableViaWWAN:
                NSLog(@"2G,3G,4G...的网络");
                break;
            case AFNetworkReachabilityStatusReachableViaWiFi:
                NSLog(@"wifi的网络");
                break;
            default:
                break;
        }
    }];
    // 开始监听
    [[AFNetworkReachabilityManager sharedManager] startMonitoring];
}


- (void)showToast:(NSString *)title message:(NSString *)message {
    UIAlertView *toast = [[UIAlertView alloc] initWithTitle:title message:message delegate:nil cancelButtonTitle:@"OK" otherButtonTitles:nil, nil];
    [toast show];
}

- (void)applicationWillResignActive:(UIApplication *)application {
    // Sent when the application is about to move from active to inactive state. This can occur for certain types of temporary interruptions (such as an incoming phone call or SMS message) or when the user quits the application and it begins the transition to the background state.
    // Use this method to pause ongoing tasks, disable timers, and invalidate graphics rendering callbacks. Games should use this method to pause the game.
}


- (void)applicationDidEnterBackground:(UIApplication *)application {
    // Use this method to release shared resources, save user data, invalidate timers, and store enough application state information to restore your application to its current state in case it is terminated later.
    // If your application supports background execution, this method is called instead of applicationWillTerminate: when the user quits.
}


- (void)applicationWillEnterForeground:(UIApplication *)application {
    // Called as part of the transition from the background to the active state; here you can undo many of the changes made on entering the background.
}


- (void)applicationDidBecomeActive:(UIApplication *)application {
    // Restart any tasks that were paused (or not yet started) while the application was inactive. If the application was previously in the background, optionally refresh the user interface.
}


- (void)applicationWillTerminate:(UIApplication *)application {
    // Called when the application is about to terminate. Save data if appropriate. See also applicationDidEnterBackground:.
}


@end
