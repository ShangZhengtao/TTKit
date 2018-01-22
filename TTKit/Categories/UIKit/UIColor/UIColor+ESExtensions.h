//
//  UIColor+ESExtensions.h
//  ESGesturalInterfaces
//
//  Created by 空灵圣君 on 16/8/23.
//  Copyright © 2016年 空灵工作室. All rights reserved.

// http://en.wikipedia.org/wiki/Web_colors
#import <UIKit/UIKit.h>

@interface UIColor (ESExtensions)


#pragma mark UIColor 256 From R G B A Value 用十进制进制256色域设置UIColor
/** UIColor from  256 RGB alpha = 1.0 */
+ (UIColor *)es_colorWith256Red:(CGFloat)red green:(CGFloat)green blue:(CGFloat)blue;
/** UIColor from  256 RGBA  (R、G、B、 ->[0, 255] ) (A - [0.0, 1.0]) */
+ (UIColor *)es_colorWith256Red:(CGFloat)red green:(CGFloat)green blue:(CGFloat)blue alpha:(CGFloat)alpha;


#pragma mark  UIColor From Hex Value  用十六进制设置UIColor
/** 
 UIColor from hex  alpha default is 1.0
 */
+ (UIColor *)es_colorWithHex:(long)hex;

/** UIColor from hex  alpha = 1.0 */
+ (UIColor *)es_colorWithHex:(long)hex alpha:(float)alpha;

#pragma mark  UIColor From Hex String 颜色转十六进制字符串
/** UIColor from hex string  alpha = 1.0 */
+ (UIColor *)es_colorWithHexString: (NSString *)hexString;
/** UIColor from hex string  alpha string alphaString = @"0.5" */
+ (UIColor *)es_colorWithHexString: (NSString *)hexString alphaString:(NSString *)alphaString;


#pragma mark RGBA String 颜色转RGBA256字符串
/** RGB String From UIColor */
+ (NSString *)es_RGBStringWithUIColor:(UIColor *)color;

/** RGBA String From UIColor */
+ (NSString *)es_RGBAStringWithUIColor:(UIColor *)color;

#pragma mark Hex String From UIColor
/** hex String From UIColor */
+ (NSString *)es_hexStringWithUIColor:(UIColor *)color;


#pragma mark r g b a value
/** red From UIColor */
+ (CGFloat)es_redValueWithUIColor:(UIColor *)color;

/** green From UIColor */
+ (CGFloat)es_greenValueWithUIColor:(UIColor *)color;

/** blue From UIColor */
+ (CGFloat)es_blueValueWithUIColor:(UIColor *)color;

/** alpha From UIColor */
+ (CGFloat)es_alphaValueWithUIColor:(UIColor *)color;


#pragma mark r g b a string

/** Red From UIColor */
+ (NSString *)es_redStringWithUIColor:(UIColor *)color;

/** Green From UIColor */
+ (NSString *)es_greenStringWithUIColor:(UIColor *)color;

/** Blue From UIColor */
+ (NSString *)es_blueStringWithUIColor:(UIColor *)color;

/** Alpha From UIColor */
+ (NSString *)es_alphaStringWithUIColor:(UIColor *)color;

#pragma mark color transition

/**
 获取两种颜色的过渡颜色

 @param startColor 原始颜色
 @param endColor 要过渡到的颜色
 @param coefficient 过渡系数 [0,1]
 @return 指定过渡系数的颜色
 */
+ (UIColor *)es_transitionStartColor:(UIColor *)startColor
                            endColor:(UIColor *)endColor
                         coefficient:(double)coefficient;

@end
