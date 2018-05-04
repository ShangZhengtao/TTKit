//
//  NotificationService.m
//  imageNotification
//
//  Created by apple on 2017/12/28.
//  Copyright © 2017年 shang. All rights reserved.
//

#import "NotificationService.h"
#import <UIKit/UIKit.h>
@interface NotificationService ()

@property (nonatomic, strong) void (^contentHandler)(UNNotificationContent *contentToDeliver);
@property (nonatomic, strong) UNMutableNotificationContent *bestAttemptContent;

@end

@implementation NotificationService

- (void)didReceiveNotificationRequest:(UNNotificationRequest *)request withContentHandler:(void (^)(UNNotificationContent * _Nonnull))contentHandler {
    self.contentHandler = contentHandler;
    // copy发来的通知，开始做一些处理
    self.bestAttemptContent = [request.content mutableCopy]; //赋值通知内容
    //    self.bestAttemptContent.title = [NSString stringWithFormat:@"%@ [modified]", self.bestAttemptContent.title];
    // 附件
    NSDictionary *dict =  self.bestAttemptContent.userInfo;
    NSString *imgUrl = [NSString stringWithFormat:@"%@",dict[@"img"]];
    if (imgUrl.length == 0) {
        self.contentHandler(self.bestAttemptContent);
    }
    
    [self loadAttachmentForUrlString:imgUrl withType:@"jpg" completionHandle:^(UNNotificationAttachment *attach) {
        if (attach != nil) {
            self.bestAttemptContent.attachments = [NSArray arrayWithObject:attach];
        }
        self.contentHandler(self.bestAttemptContent);
    }];
}

- (void)serviceExtensionTimeWillExpire {
    // Called just before the extension will be terminated by the system.
    // Use this as an opportunity to deliver your "best attempt" at modified content, otherwise the original push payload will be used.
    NSLog(@"附件下载超时！");
    self.contentHandler(self.bestAttemptContent);
}

#pragma mark - Private

//下载附件保存本地
- (void)loadAttachmentForUrlString:(NSString *)urlStr
                          withType:(NSString *)type
                  completionHandle:(void(^)(UNNotificationAttachment *attach))completionHandler{
    __block UNNotificationAttachment *attachment = nil;
    NSURL *attachmentURL = [NSURL URLWithString:urlStr];
    NSString *fileExt = [self fileExtensionForMediaType:type];
    
    NSURLSession *session = [NSURLSession sessionWithConfiguration:[NSURLSessionConfiguration defaultSessionConfiguration]];
    [[session downloadTaskWithURL:attachmentURL
                completionHandler:^(NSURL *temporaryFileLocation, NSURLResponse *response, NSError *error) {
                    if (error != nil) {
                        NSLog(@"%@", error.localizedDescription);
                    } else {
                        NSFileManager *fileManager = [NSFileManager defaultManager];
                        NSURL *localURL = [NSURL fileURLWithPath:[temporaryFileLocation.path stringByAppendingString:fileExt]];
                        [fileManager moveItemAtURL:temporaryFileLocation toURL:localURL error:&error];
                        
                        NSError *attachmentError = nil;
                        attachment = [UNNotificationAttachment attachmentWithIdentifier:@"" URL:localURL options:nil error:&attachmentError];
                        if (attachmentError) {
                            NSLog(@"%@", attachmentError.localizedDescription);
                        }
                    }
                    completionHandler(attachment);
                }] resume];
    
}
// 附件类型判断，建议服务器给出文件类型
- (NSString *)fileExtensionForMediaType:(NSString *)type {
    NSString *ext = type;
    if ([type isEqualToString:@"image"]) {
        ext = @"jpg";
    }
    if ([type isEqualToString:@"video"]) {
        ext = @"mp4";
    }
    if ([type isEqualToString:@"audio"]) {
        ext = @"mp3";
    }
    return [@"." stringByAppendingString:ext];
}

@end
