//
//  CoreJPush.m
//  TTKitDemo
//
//  Created by apple on 2017/11/21.
//  Copyright © 2017年 shang. All rights reserved.
//

#import "CoreJPush.h"
#import "JPUSHService.h"
#import <UIKit/UIKit.h>
#import <UserNotifications/UserNotifications.h>
#import "AppDelegate+JPush.h"

#define JPushAppKey @"092c4cd3687381404725c339"
#define JPushChannel @"AppStore"

#ifdef DEBUG
#define JPushIsProduction NO  //NO测试环境
#else
#define JPushIsProduction YES //YES生产环境
#endif

@interface CoreJPush ()
@property (nonatomic,strong) NSMutableArray *observers;
@end

@implementation CoreJPush

static id _instace;

+ (id)allocWithZone:(struct _NSZone *)zone
{
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        _instace = [super allocWithZone:zone];
    });
    return _instace;
}

+ (instancetype)sharedCoreJPush {
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        _instace = [[self alloc] init];
    });
    return _instace;
}

- (id)copyWithZone:(NSZone *)zone {
    return _instace;
}

- (NSMutableArray *)observers {
    
    if(_observers==nil){
        _observers = [NSMutableArray array];
    }
    return _observers;
}

#pragma mark - Public

/** 注册JPush */
+ (void)registerJPush:(NSDictionary *)launchOptions{
    JPUSHRegisterEntity * entity = [[JPUSHRegisterEntity alloc] init];
    entity.types = JPAuthorizationOptionAlert|JPAuthorizationOptionBadge|JPAuthorizationOptionSound;
    if ([[UIDevice currentDevice].systemVersion floatValue] >= 8.0) {
        // 可以添加自定义categories
        //entity.categories = [NSSet setWithObjects:@"", nil];
        // NSSet<UNNotificationCategory *> *categories for iOS10 or later
        // NSSet<UIUserNotificationCategory *> *categories for iOS8 and iOS9
    }
    //注册
    id delegate = (id<JPUSHRegisterDelegate>)[UIApplication sharedApplication].delegate;
    [JPUSHService registerForRemoteNotificationConfig:entity delegate:delegate];

    //配置
    [JPUSHService setupWithOption:launchOptions appKey:JPushAppKey
                          channel:JPushChannel
                 apsForProduction:JPushIsProduction
            advertisingIdentifier:nil];
    
    //自定义消息通知
//    NSNotificationCenter *defaultCenter = [NSNotificationCenter defaultCenter];
//    [defaultCenter addObserver:self selector:@selector(networkDidReceiveMessage:) name:kJPFNetworkDidReceiveMessageNotification object:nil];
}

/** 添加监听者 */
+ (void)addJPushObserver:(id<CoreJPushDelegate>)observer{
    CoreJPush *jpush = [CoreJPush sharedCoreJPush];
    if([jpush.observers containsObject:observer]) return;
    [jpush.observers addObject:observer];
}

/** 移除监听者 */
+ (void)removeJPushObserver:(id<CoreJPushDelegate>)observer{
    
    CoreJPush *jpush = [CoreJPush sharedCoreJPush];
    if(![jpush.observers containsObject:observer]) return;
    [jpush.observers removeObject:observer];
}

- (void)didReceiveRemoteNotification:(NSDictionary *)userInfo{
    
    [self handleBadge:[userInfo[@"aps"][@"badge"] integerValue]];
    
    if(self.observers.count == 0) return;
    
    [self.observers enumerateObjectsUsingBlock:^(id<CoreJPushDelegate> observer, NSUInteger idx, BOOL *stop) {
        
        if([observer respondsToSelector:@selector(didReceiveRemoteNotification:)]) [observer didReceiveRemoteNotification:userInfo];
    }];
}

/** 处理badge */
+ (void)handleWithBadge:(NSInteger)badge {
#pragma clang diagnostic push
#pragma clang diagnostic ignored "-Wdeprecated-declarations"
    NSInteger now = badge;
    if (@available(iOS 10,*)) [[UNUserNotificationCenter currentNotificationCenter] removeAllPendingNotificationRequests];
    else [[UIApplication sharedApplication] cancelAllLocalNotifications];
    [UIApplication sharedApplication].applicationIconBadgeNumber = 0;
    [UIApplication sharedApplication].applicationIconBadgeNumber = now;
    [JPUSHService setBadge:now];
#pragma clang diagnostic pop
}

+ (void)setAlias:(NSString *)alias completionHandler:(JPUSHAliasOperationCompletion)hander {
    [JPUSHService setAlias:alias completion:hander seq:666];
}

+ (void)setTags:(NSSet<NSString *> *)tags completionHandler:(JPUSHTagsOperationCompletion)hander {
    [JPUSHService setTags:tags completion:hander seq:666];
}

#pragma mark - Private

/** 处理badge */
- (void)handleBadge:(NSInteger)badge{
#pragma clang diagnostic push
#pragma clang diagnostic ignored "-Wdeprecated-declarations"
    NSInteger now = badge - 1;
    if (@available(iOS 10,*)) [[UNUserNotificationCenter currentNotificationCenter] removeAllPendingNotificationRequests];
    else [[UIApplication sharedApplication] cancelAllLocalNotifications];
    [UIApplication sharedApplication].applicationIconBadgeNumber = 0;
    [UIApplication sharedApplication].applicationIconBadgeNumber = now;
    [JPUSHService setBadge:now];
#pragma clang diagnostic pop
}

/**
 只有在前端运行的时候才能收到自定义消息的推送。
 从jpush服务器获取用户推送的自定义消息内容和标题以及附加字段等。
 
 @param notification 自定义消息通知
 */
+ (void)networkDidReceiveMessage:(NSNotification *)notification {
    NSDictionary * userInfo = [notification userInfo];
    NSLog(@"自定义消息%@",userInfo);
}

@end
