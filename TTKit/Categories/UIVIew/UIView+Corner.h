//
//  UIView+Corner.h
//  GoldLiving
//
//  Created by 海中金信息中心mac2 on 2017/8/19.
//  Copyright © 2017年 lhb. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface UIView (Corner)

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

@end
