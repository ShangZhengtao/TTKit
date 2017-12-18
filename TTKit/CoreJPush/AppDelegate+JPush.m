//
//  AppDelegate+JPush.m
//  TTKitDemo
//
//  Created by apple on 2017/11/21.
//  Copyright © 2017年 shang. All rights reserved.
//

#import "AppDelegate+JPush.h"
#import "JPUSHService.h"
#import "CoreJPush.h"
#import <UserNotifications/UserNotifications.h>

@implementation AppDelegate (JPush)

#pragma mark - 注册deviceToken
- (void)application:(UIApplication *)application didRegisterForRemoteNotificationsWithDeviceToken:(NSData *)deviceToken {
    NSString *token = [NSString stringWithFormat:@"%@",deviceToken];
    token = [token stringByReplacingOccurrencesOfString:@" " withString:@""];
    token = [token stringByReplacingOccurrencesOfString:@">" withString:@""];
    token = [token stringByReplacingOccurrencesOfString:@"<" withString:@""];
    [[NSUserDefaults standardUserDefaults] setObject:token forKey:@"deviceToken"];

    [JPUSHService registerDeviceToken:deviceToken];
}

#pragma mark - 注册deviceToken失败
- (void)application:(UIApplication *)application didFailToRegisterForRemoteNotificationsWithError:(NSError *)error {
    NSLog(@"did Fail To Register For Remote Notifications With Error: %@", error);
}

#pragma mark- JPUSHRegisterDelegate

#pragma clang diagnostic push
#pragma clang diagnostic ignored "-Wunguarded-availability"
// iOS 10+ Support app在前台时候调用
- (void)jpushNotificationCenter:(UNUserNotificationCenter *)center willPresentNotification:(UNNotification *)notification withCompletionHandler:(void (^)(NSInteger))completionHandler {
    // Required
    NSDictionary * userInfo = notification.request.content.userInfo;
    if([notification.request.trigger isKindOfClass:[UNPushNotificationTrigger class]]) {
        [JPUSHService handleRemoteNotification:userInfo];
        UIApplication *application = [UIApplication sharedApplication];
        NSMutableDictionary *dictionary = [NSMutableDictionary dictionaryWithDictionary:userInfo];
        [dictionary setObject:@(application.applicationState) forKey:@"applicationState"];
        CoreJPush *jpush = [CoreJPush sharedCoreJPush];
        [jpush didReceiveRemoteNotification:dictionary];
    }else{
        //本地通知
    }
    completionHandler(UNNotificationPresentationOptionAlert); // 需要执行这个方法，选择是否提醒用户，有Badge、Sound、Alert三种类型可以选择设置
}

// iOS 10+ Support
- (void)jpushNotificationCenter:(UNUserNotificationCenter *)center didReceiveNotificationResponse:(UNNotificationResponse *)response withCompletionHandler:(void (^)(void))completionHandler {
    // Required
    NSDictionary * userInfo = response.notification.request.content.userInfo;
    if([response.notification.request.trigger isKindOfClass:[UNPushNotificationTrigger class]]) {
        [JPUSHService handleRemoteNotification:userInfo];
        UIApplication *application = [UIApplication sharedApplication];
        NSMutableDictionary *dictionary = [NSMutableDictionary dictionaryWithDictionary:userInfo];
        [dictionary setObject:@(application.applicationState) forKey:@"applicationState"];
        CoreJPush *jpush = [CoreJPush sharedCoreJPush];
        [jpush didReceiveRemoteNotification:dictionary];
    }else{
        //本地通知
    }
    completionHandler();  // 系统要求执行这个方法
}
#pragma clang diagnostic pop

 // iOS 7 Support
- (void)application:(UIApplication *)application didReceiveRemoteNotification:(NSDictionary *)userInfo fetchCompletionHandler:(void (^)(UIBackgroundFetchResult))completionHandler {
    // IOS 7 Support Required
    [JPUSHService handleRemoteNotification:userInfo];
    completionHandler(UIBackgroundFetchResultNewData);
    
    NSMutableDictionary *dictionary = [NSMutableDictionary dictionaryWithDictionary:userInfo];
    [dictionary setObject:@(application.applicationState) forKey:@"applicationState"];
    CoreJPush *jpush = [CoreJPush sharedCoreJPush];
    [jpush didReceiveRemoteNotification:dictionary];
}

 // iOS 3 - iOS 9 Support
- (void)application:(UIApplication *)application didReceiveRemoteNotification:(NSDictionary *)userInfo {
    NSMutableDictionary *dictionary = [NSMutableDictionary dictionaryWithDictionary:userInfo];
    [dictionary setObject:@(application.applicationState) forKey:@"applicationState"];
    CoreJPush *jpush = [CoreJPush sharedCoreJPush];
    [jpush didReceiveRemoteNotification:dictionary];
    [JPUSHService handleRemoteNotification:userInfo];
}

@end
