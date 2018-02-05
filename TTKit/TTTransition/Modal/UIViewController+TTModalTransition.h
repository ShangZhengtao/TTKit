//
//  UIViewController+TTModalTransition.h
//  TTKitDemo
//
//  Created by apple on 2018/1/15.
//  Copyright © 2018年 shang. All rights reserved.
//

#import <UIKit/UIKit.h>

UIKIT_EXTERN NSString *const kTTTouchEventPointXKey;
UIKIT_EXTERN NSString *const kTTTouchEventPointYKey;

typedef NS_ENUM(NSUInteger, TTModalTransitionStyle) {
    TTModalTransitionStyleDefault = 0,
    TTModalTransitionStyleOpenDoor,
    TTModalTransitionStyleGradient,
    TTModalTransitionStyleCircleZoom
};

@interface UIViewController (TTModalTransition)

@property (nonatomic, assign) TTModalTransitionStyle  tt_modalTransitionStyle;

@end
