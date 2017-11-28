//
//  UIView+TTKit.h
//  TTKitDemo
//
//  Created by apple on 2017/11/28.
//  Copyright © 2017年 shang. All rights reserved.
//

#import <UIKit/UIKit.h>


typedef NS_OPTIONS(NSUInteger, TTMotionEffectOptions) {
    TTMotionEffectOptionHorizontal    = 1 << 0,
    TTMotionEffectOptionVertical      = 1 << 1,
};

@interface UIView (TTKit)


/**
 请在frame 设置之后调用
 设置圆角（半径为默认为短边的一半）
 */
- (void)setCircleCorner;

- (void)setCornerWithRadius:(CGFloat)radius;

/**
 设置指定拐角的圆角
 
 @param corner 指定的拐角
 @param radius 圆角半径
 */
- (void)setCornerAtCorner:(UIRectCorner)corner withRadius:(CGFloat)radius;


/**
 为 view 添加 透视特效

 @param value 相对移动距离值 不建议设置太大
 @param options 移动方向
 */
- (void)addMotionEffectWithRelativeValue:(CGFloat)value effectOptions:(TTMotionEffectOptions)options;

@end
