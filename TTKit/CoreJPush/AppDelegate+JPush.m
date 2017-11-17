//
//  AppDelegate+JPush.m
//  CoreJPush
//
//  Created by 冯成林 on 15/9/17.
//  Copyright (c) 2015年 冯成林. All rights reserved.
//

#import "AppDelegate+JPush.h"
#import "JPUSHService.h"
#import "CoreJPush.h"

@implementation AppDelegate (JPush)


- (void)application:(UIApplication *)application didRegisterForRemoteNotificationsWithDeviceToken:(NSData *)deviceToken {
    NSString *token = [NSString stringWithFormat:@"%@",deviceToken];
    token = [token stringByReplacingOccurrencesOfString:@" " withString:@""];
    token = [token stringByReplacingOccurrencesOfString:@">" withString:@""];
    token = [token stringByReplacingOccurrencesOfString:@"<" withString:@""];
    [[NSUserDefaults standardUserDefaults] setObject:token forKey:@"deviceToken"];

    // Required
    [JPUSHService registerDeviceToken:deviceToken];
}


- (void)application:(UIApplication *)application didReceiveRemoteNotification:(NSDictionary *)userInfo fetchCompletionHandler:(void (^)(UIBackgroundFetchResult))completionHandler {
    NSMutableDictionary *dictionary = [NSMutableDictionary dictionaryWithDictionary:userInfo];
    [dictionary setInteger:application.applicationState forKey:@"applicationState"];
    // IOS 7 Support Required
    [JPUSHService handleRemoteNotification:dictionary];
    completionHandler(UIBackgroundFetchResultNewData);
    
    CoreJPush *jpush = [CoreJPush sharedCoreJPush];
    [jpush didReceiveRemoteNotification:dictionary];
}


@end
