//
//  UIViewController+TTModalTransition.h
//  TTKitDemo
//
//  Created by apple on 2018/1/15.
//  Copyright © 2018年 shang. All rights reserved.
//

#import <UIKit/UIKit.h>

typedef NS_ENUM(NSUInteger, TTModalTransitionStyle) {
    TTModalTransitionStyleDefault = 0,
    TTModalTransitionStyleOpenDoor,
    TTModalTransitionStyleGradient
};

@interface UIViewController (TTModalTransition)

@property (nonatomic, assign) TTModalTransitionStyle  tt_modalTransitionStyle;

@end
