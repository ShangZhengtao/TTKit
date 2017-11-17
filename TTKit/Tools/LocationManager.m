//
//  LocationManager.m
//  Eat
//
//  Created by apple on 2017/4/28.
//  Copyright © 2017年 shang. All rights reserved.
//

#import "LocationManager.h"

@interface LocationManager ()<CLLocationManagerDelegate>
@property (nonatomic, strong) CLLocationManager *clmanager;
@property (nonatomic, copy) void(^placeMarkHandler)(CLPlacemark *placeMark);
@property (nonatomic, copy) void(^locationHandler)(CLLocation *location);
@property (nonatomic, strong) MKLocalSearch *localSearch;
@end

@implementation LocationManager

static LocationManager * manager = nil;

-(CLLocationManager *)clmanager{
    if (!_clmanager) {
        _clmanager = [[CLLocationManager alloc]init];
        _clmanager.delegate = self;
        //        _clmanager.desiredAccuracy = kCLLocationAccuracyBest;
    }
    return _clmanager;
}

- (MKLocalSearch *)localSearch {
    if (!_localSearch) {
        _localSearch = [[MKLocalSearch alloc]init];
    }
    return _localSearch;
}

+ (instancetype)shareManager{
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        manager = [[LocationManager alloc]init];
    });
    return manager;
}

- (void)getCurrentLocation:(void (^)(CLLocation *))handler {
    [self.clmanager requestWhenInUseAuthorization];
    [self.clmanager startUpdatingLocation];
    self.locationHandler = handler;
}

- (void)getCurrentPlacemark:(void (^)(CLPlacemark *))handler {
    [self.clmanager requestWhenInUseAuthorization];
    [self.clmanager startUpdatingLocation];
    self.placeMarkHandler = handler;
}


- (void)localSearchWithString:(NSString *)searchText
                       region:(CLCircularRegion *)region
            completionHandler:(void (^)(MKLocalSearchResponse *)) handler{
    
    MKCoordinateRegion mkregion = MKCoordinateRegionMakeWithDistance(region.center, region.radius, region.radius);
    MKLocalSearchRequest *request = [[MKLocalSearchRequest alloc]init];
    request.naturalLanguageQuery = searchText;
    request.region = mkregion;
    self.localSearch = [[MKLocalSearch alloc]initWithRequest:request];
    [self.localSearch startWithCompletionHandler:^(MKLocalSearchResponse * _Nullable response, NSError * _Nullable error) {
        if (error) {
            NSLog(@"搜索出错：%@",error.localizedDescription);
            !handler ?:  handler(nil);
        }else{
            !handler ?:  handler(response);
        }
    }];
}

- (void)nearLocalSearchByString:(NSString *)searchText
                   searchRadius:(double)radius
              completionHandler:(void (^)(MKLocalSearchResponse *)) handler{
    __weak typeof(self) weakSelf = self;
    [self getCurrentPlacemark:^(CLPlacemark *mark) {
        CLCircularRegion *region = [[CLCircularRegion alloc]initWithCenter:mark.location.coordinate radius:radius identifier:@""];
        
        [weakSelf localSearchWithString:searchText region:region completionHandler:^(MKLocalSearchResponse *response) {
            !handler ?: handler(response);
        }];
    }];
    
}

#pragma mark - CLLocationManagerDelegate

- (void)locationManager:(CLLocationManager *)manager didUpdateLocations:(NSArray<CLLocation *> *)locations {
    CLLocation *location = locations.firstObject;
    NSLog(@"\n%f,\n%f",location.coordinate.latitude,location.coordinate.longitude);
    !self.locationHandler ?:  self.locationHandler(location);
    CLGeocoder *geocoder = [[CLGeocoder alloc]init];
    [geocoder reverseGeocodeLocation:location completionHandler:^(NSArray<CLPlacemark *> * _Nullable placemarks, NSError * _Nullable error) {
        CLPlacemark *placeMark = placemarks.firstObject;
        
        !self.placeMarkHandler ?:  self.placeMarkHandler(placeMark);
    }];
    
    [self.clmanager stopUpdatingLocation];
    self.clmanager = nil;
}

-(void)locationManager:(CLLocationManager *)manager didFailWithError:(NSError *)error {
    NSLog(@"定位出错：%@",error.debugDescription);
    !self.placeMarkHandler ?:  self.placeMarkHandler(nil);
    !self.locationHandler ?:  self.locationHandler(nil);
}

@end
