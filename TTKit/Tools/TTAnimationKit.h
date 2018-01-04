//
//  TTAnimationKit.h
//  TTKitDemo
//
//  Created by apple on 2018/1/2.
//  Copyright © 2018年 shang. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface TTAnimationKit : NSObject

/**
 漂浮效果

 @param views view数组
 */
+ (void)floatViews:(NSArray <__kindof UIView *>*)views;


/**                  _________
                    |         |
 沿边框移动动画。      |         |
                    |____<=___|

 @param view 目标view
 @param color 颜色
 @param duration 动画时间
 */
+ (void)pathAnimationForView:(UIView *)view color:(UIColor *)color duration:(NSTimeInterval) duration;



/**
 边框渐变闪光效果

 @param view 目标view
 @param color 颜色
 @param duration 动画时间
 */
+ (void)borderGradientAnimationForView:(UIView *)view color:(UIColor *)color duration:(NSTimeInterval) duration;

@end
