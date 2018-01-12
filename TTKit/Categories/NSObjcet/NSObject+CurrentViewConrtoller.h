//
//  NSObject+CurrentViewConrtoller.h
//  TTKitDemo
//
//  Created by apple on 2017/11/16.
//  Copyright © 2017年 shang. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface NSObject (CurrentViewConrtoller)

/**
 获取当前屏幕显示的viewcontroller

 @return 前屏幕显示的viewcontroller
 */
- (UIViewController *)getCurrentVC;


/**
 获取当前屏幕中present出来的viewcontroller

 @return 当前屏幕中present出来的viewcontroller
 */
- (UIViewController *)getPresentedViewController;

/**
 切换rootViewController

 @param rootViewController rootViewController
 */
- (void)restoreRootViewController:(UIViewController *)rootViewController;
@end
