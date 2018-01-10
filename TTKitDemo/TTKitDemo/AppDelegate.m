//
//  AppDelegate.m
//  TTKitDemo
//
//  Created by apple on 2017/11/15.
//  Copyright © 2017年 shang. All rights reserved.
//

#import "AppDelegate.h"
#import "BaseTabBarViewController.h"
#import "CoreJPush.h"
#import "YYFPSLabel.h"
@interface AppDelegate ()

@end

@implementation AppDelegate


- (BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions {
    
    BaseTabBarViewController *rootVC = [[BaseTabBarViewController alloc]init];
    self.window.rootViewController = rootVC;
    [self.window makeKeyAndVisible];
    [CoreJPush registerJPush:launchOptions];
    //    [self setupNotification:launchOptions];
    [self setupFPSLable]; //测试FPS
    return YES;
}

- (void)setupFPSLable {
    YYFPSLabel* label = [[YYFPSLabel alloc]initWithFrame:CGRectMake(60, 20, 55, 20)];
    [self.window addSubview:label];
}
    
    
//注册带有分类的通知
- (void)setupNotification:(NSDictionary *) launchOptions{
    NSSet *categories = nil;
    if (@available(iOS 10, *)) {
        UNNotificationAction *closeAction = [UNNotificationAction actionWithIdentifier:@"close" title:@"关闭" options:UNNotificationActionOptionDestructive];
        UNNotificationAction *enterAction = [UNNotificationAction actionWithIdentifier:@"enter" title:@"进入" options:UNNotificationActionOptionForeground];
        UNNotificationAction *unLockAction = [UNNotificationAction actionWithIdentifier:@"unLock" title:@"解锁" options:UNNotificationActionOptionAuthenticationRequired];
        UNTextInputNotificationAction *inputAction = [UNTextInputNotificationAction actionWithIdentifier:@"input" title:@"输入" options:UNNotificationActionOptionAuthenticationRequired];
        UNNotificationCategory *category = [UNNotificationCategory categoryWithIdentifier:@"comment-reply" actions:@[inputAction,enterAction,unLockAction,closeAction] intentIdentifiers:@[] options:UNNotificationCategoryOptionNone];
        categories = [NSSet setWithObjects:category, nil];
    }else if (@available(iOS 9, *)) {
#pragma clang diagnostic push
#pragma clang diagnostic ignored "-Wdeprecated-declarations"
        UIMutableUserNotificationCategory * category = [[UIMutableUserNotificationCategory alloc]init];
        category.identifier = @"comment-reply";
        UIMutableUserNotificationAction *closeAction = [[UIMutableUserNotificationAction alloc]init];
        closeAction.identifier = @"close";
        closeAction.title = @"关闭";
        
        UIMutableUserNotificationAction *enterAction = [[UIMutableUserNotificationAction alloc]init];
        enterAction.identifier = @"enter";
        enterAction.title = @"进入";
        enterAction.behavior = UIUserNotificationActionBehaviorDefault;
        enterAction.activationMode = UIUserNotificationActivationModeForeground;
        
        UIMutableUserNotificationAction *inputAction = [[UIMutableUserNotificationAction alloc]init];
        inputAction.identifier = @"input";
        inputAction.title = @"输入";
        //         UIUserNotificationActionResponseTypedTextKey
        inputAction.behavior = UIUserNotificationActionBehaviorTextInput;
        [category setActions:@[enterAction, inputAction, closeAction] forContext:UIUserNotificationActionContextDefault];
        categories = [NSSet setWithObject:category];
#pragma clang diagnostic pop
        
    }
    [CoreJPush registerJPushWithOption: launchOptions appKey:@"092c4cd3687381404725c339" apsForProduction:NO notificationCategories:categories];
    
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
