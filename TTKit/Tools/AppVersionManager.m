//
//  AppVersionManager.m
//  TTKitDemo
//
//  Created by apple on 2017/11/16.
//  Copyright © 2017年 shang. All rights reserved.
//

#import "AppVersionManager.h"

static NSString *const APPLE_STORE_VERSION_API = @"https://itunes.apple.com/lookup?";
static NSString *const APPLE_STORE_UPDATE_API = @"https://itunes.apple.com/cn/app/id%@?mt=8";
static NSString *const VERSION_STATE = @"MY_APP_VERSION_STATE";

#define kIsOnline @"kIsOnline"

@implementation AppVersionManager

+ (BOOL)alreadyOnLine{
    NSUserDefaults * userDefaults = [NSUserDefaults standardUserDefaults];
    return [userDefaults boolForKey:kIsOnline];
}

+ (void)updateAPPWithAppleId:(NSString *)appleId{
    
    //http://fuckingclangwarnings.com/
#pragma clang diagnostic push
#pragma clang diagnostic ignored "-Wdeprecated-declarations"
    [[UIApplication sharedApplication]openURL:[NSURL URLWithString:\
                                               [NSString stringWithFormat:APPLE_STORE_UPDATE_API,appleId]]];
#pragma clang diagnostic pop
    
}

+ (NSString *)appDownloadURLWithAppleId:(NSString *)appleId {
    
    return [NSString stringWithFormat:APPLE_STORE_UPDATE_API,appleId];
}

+ (void)checkOnlineWithURL:(NSString *)urlString {
    
    __block dispatch_semaphore_t disp = dispatch_semaphore_create(0);
    NSURL *url = [NSURL URLWithString:urlString];
    NSMutableURLRequest *request = [NSMutableURLRequest requestWithURL:url];
    request.timeoutInterval = 10;
    NSURLSessionDataTask *dataTask = [[NSURLSession sharedSession] dataTaskWithRequest:request completionHandler:^(NSData * _Nullable data, NSURLResponse * _Nullable response, NSError * _Nullable error) {
        if (!error) {
            NSError *err;
            NSString *appBuild = [[[NSBundle mainBundle] infoDictionary] objectForKey:@"CFBundleVersion"];
            NSDictionary *dic = [NSJSONSerialization JSONObjectWithData:data options:0 error:&err];
            if (!err && [dic isKindOfClass:[NSDictionary class]]) {
                //根据具体后台返回的字段名取值
                NSInteger version = [[dic objectForKey:@"remark"] integerValue];
                if (appBuild.integerValue == version) {
                    [[NSUserDefaults standardUserDefaults] setBool:NO forKey:kIsOnline]; //审核中
                }else {
                    [[NSUserDefaults standardUserDefaults] setBool:YES forKey:kIsOnline];
                }
                [[NSUserDefaults standardUserDefaults] synchronize];
            }else{
                [[NSUserDefaults standardUserDefaults] setBool:YES forKey:kIsOnline];
            }
        }
        dispatch_semaphore_signal(disp);
    }];
    [dataTask resume];
    dispatch_semaphore_wait(disp, DISPATCH_TIME_FOREVER);
    
}

@end
