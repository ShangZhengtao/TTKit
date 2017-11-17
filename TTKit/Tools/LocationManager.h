//
//  LocationManager.h
//  Eat
//
//  Created by apple on 2017/4/28.
//  Copyright © 2017年 shang. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <CoreLocation/CoreLocation.h>
@import MapKit;
@interface LocationManager : NSObject

+ (instancetype)shareManager;

/**
 获取当前位置信息 （定位失败 返回 nil）
 
 @param handler 回调
 */
- (void)getCurrentLocation:(void (^)(CLLocation *)) handler;

/**
 获取当前地标信息 （地理编码失败 返回 nil）

 @param handler 回调
 */
- (void)getCurrentPlacemark:(void (^)(CLPlacemark *)) handler;

/**
 搜索指定区域

 @param searchText 关键字
 @param region 指定区域
 @param handler 回调
 */
- (void)localSearchWithString:(NSString *)searchText
                       region:(CLCircularRegion *)region
            completionHandler:(void (^)(MKLocalSearchResponse *)) handler;


/**
 搜索附近

 @param searchText 关键字
 @param radius 半径 ，单位m
 @param handler 回调
 */
- (void)nearLocalSearchByString:(NSString *)searchText
                   searchRadius:(double)radius
              completionHandler:(void (^)(MKLocalSearchResponse *)) handler;

@end
