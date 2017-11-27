//
//  CoreJPush.h
//  TTKitDemo
//
//  Created by apple on 2017/11/21.
//  Copyright © 2017年 shang. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "JPUSHService.h"
@protocol CoreJPushDelegate <NSObject>
@required

/**
 有消息推送时 会调起次方法 （app在前台时也会调用需要自己判断）
 
 @param userInfo 通知信息
 */
-(void)didReceiveRemoteNotification:(NSDictionary *)userInfo;

@end

@interface CoreJPush : NSObject<CoreJPushDelegate>

+ (instancetype)sharedCoreJPush;
/** 注册JPush */
+ (void)registerJPush:(NSDictionary *)launchOptions;

/** 添加监听者 配合removeJPushObserver使用*/
+ (void)addJPushObserver:(id<CoreJPushDelegate>)observer;

/** 移除监听者 */
+ (void)removeJPushObserver:(id<CoreJPushDelegate>)observer;

/** 设置alias、tags */
+ (void)setAlias:(NSString *)alias completionHandler:(JPUSHAliasOperationCompletion)hander;
+ (void)setTags:(NSSet<NSString *>*)tags completionHandler:(JPUSHTagsOperationCompletion)hander;

+ (void)handleWithBadge:(NSInteger)badge;
@end
