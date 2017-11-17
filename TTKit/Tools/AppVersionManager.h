//
//  AppVersionManager.h
//  TTKitDemo
//
//  Created by apple on 2017/11/16.
//  Copyright © 2017年 shang. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface AppVersionManager : NSObject

/**
 检查当前版本上线状态 同步方法

 @param urlString 完整的url请求路径
 */
+ (void)checkOnlineWithURL:(NSString *)urlString;

/**
 是否已经上线
 
 @return 上线状态
 */
+ (BOOL)alreadyOnLine;

/**
 更新APP
 
 @param appleId AppleId
 */
+ (void)updateAPPWithAppleId:(NSString *)appleId;

+ (NSString *)appDownloadURLWithAppleId:(NSString *)appleId;

@end
