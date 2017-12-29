//
//  CoreJPush.h
//  TTKitDemo
//
//  Created by apple on 2017/11/21.
//  Copyright © 2017年 shang. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "JPUSHService.h"
#import <UserNotifications/UserNotifications.h>

NS_ASSUME_NONNULL_BEGIN

UIKIT_EXTERN NSString *const kUserDefaultsDeviceToken;
UIKIT_EXTERN NSString *const kHandleActionUserTextKey; //通知交互时用户输入的内容 userInfo中的key

@protocol CoreJPushProtocal <NSObject>

@required
/**
 有消息推送时 会调起此方法 （app在前台时也会调用需要自己判断）
 
 @param userInfo 通知信息
 */
-(void)didReceiveRemoteNotification:(NSDictionary *)userInfo __IOS_AVAILABLE(3.0);

@optional
/**
  处理通知Action 事件 (如果注册多个分类，建议先判断 userInfo 中的 “category”字段)

 @param userInfo 通知信息. 用户输入的内容 key -> kHandleActionUserTextKey
 @param identifier 注册时指定的Action id
 */
-(void)handleAction:(NSDictionary *)userInfo actionIdentifier:(NSString *)identifier __IOS_AVAILABLE(9.0);

@end

@interface CoreJPush : NSObject<CoreJPushProtocal>

- (instancetype)init NS_UNAVAILABLE;

+ (instancetype)new NS_UNAVAILABLE;

+ (instancetype)sharedCoreJPush;



/**
 简便注册方法（使用预设宏配置key）

 @param launchOptions app启动参数
 */
+ (void)registerJPush:(NSDictionary *)launchOptions;

/**
 配置极光并注册通知（默认渠道为“appstore”）

 @param launchOptions   app启动参数
 @param JPushAppKey     极光appkey
 @param isProduction    是否是生产环境
 @param categories      NSSet<UNNotificationCategory *> *categories for iOS10 or later
                        NSSet<UIUserNotificationCategory *> *categories for iOS8 and iOS9
 */
+ (void)registerJPushWithOption:(NSDictionary *)launchOptions
                         appKey:(NSString *)JPushAppKey
               apsForProduction:(BOOL) isProduction
         notificationCategories:(NSSet * _Nullable )categories;


/** 添加监听者 配合removeJPushObserver使用*/
+ (void)addJPushObserver:(id<CoreJPushProtocal>)observer;

/** 移除监听者 */
+ (void)removeJPushObserver:(id<CoreJPushProtocal>)observer;

/** 设置alias、tags */
+ (void)setAlias:(NSString *)alias completionHandler:(JPUSHAliasOperationCompletion)hander;
+ (void)setTags:(NSSet<NSString *>*)tags completionHandler:(JPUSHTagsOperationCompletion)hander;

+ (void)handleWithBadge:(NSInteger)badge;

@end
NS_ASSUME_NONNULL_END
