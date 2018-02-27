//
//  UIColor+ESExtensions.m
//  ESGesturalInterfaces
//
//  Created by 空灵圣君 on 16/8/23.
//  Copyright © 2016年 空灵工作室. All rights reserved.
//

#define DEFAULT_VOID_COLOR [UIColor whiteColor]

#import "UIColor+ESExtensions.h"

@implementation UIColor (ESExtensions)

#pragma mark UIColor 256 From R G B A Value
+ (UIColor *)es_colorWith256Red:(CGFloat)red green:(CGFloat)green blue:(CGFloat)blue alpha:(CGFloat)alpha{
    return [UIColor colorWithRed:red/255.0 green:green/255.0 blue:blue/255.0 alpha:alpha];
}

+ (UIColor *)es_colorWith256Red:(CGFloat)red green:(CGFloat)green blue:(CGFloat)blue{
    return [UIColor colorWithRed:red/255.0 green:green/255.0 blue:blue/255.0 alpha:1.0];
}

#pragma mark  UIColor From Hex Value
+ (UIColor *)es_colorWithHex:(long)hex{
    return [UIColor es_colorWithHex:hex alpha:1.0];
}

+ (UIColor *)es_colorWithHex:(long)hex alpha:(float)alpha{
    float red   = ((float)((hex & 0xFF0000) >> 16))/255.0;
    float green = ((float)((hex & 0xFF00) >> 8))/255.0;
    float blue  = ((float)((hex & 0xFF)))/255.0;
    return [UIColor colorWithRed:red green:green blue:blue alpha:alpha];
}

#pragma mark  UIColor From Hex String
+ (UIColor *)es_colorWithHexString: (NSString *)hexString{
    NSString *cString = [[hexString stringByTrimmingCharactersInSet:[NSCharacterSet whitespaceAndNewlineCharacterSet]] uppercaseString];
    
    // String should be 6 or 8 characters
    if ([cString length] < 6) {
        return [UIColor clearColor];
    }
    
    // strip 0X if it appears
    if ([cString hasPrefix:@"0X"])
        cString = [cString substringFromIndex:2];
    if ([cString hasPrefix:@"#"])
        cString = [cString substringFromIndex:1];
    if ([cString length] != 6)
        return [UIColor clearColor];
    
    // Separate into r, g, b substrings
    NSRange range;
    range.location = 0;
    range.length = 2;
    
    //r
    NSString *rString = [cString substringWithRange:range];
    
    //g
    range.location = 2;
    NSString *gString = [cString substringWithRange:range];
    
    //b
    range.location = 4;
    NSString *bString = [cString substringWithRange:range];
    
    // Scan values
    unsigned int r, g, b;
    [[NSScanner scannerWithString:rString] scanHexInt:&r];
    [[NSScanner scannerWithString:gString] scanHexInt:&g];
    [[NSScanner scannerWithString:bString] scanHexInt:&b];
    
    return [UIColor colorWithRed:((float) r / 255.0f) green:((float) g / 255.0f) blue:((float) b / 255.0f) alpha:1.0f];
}

+ (UIColor *)es_colorWithHexString: (NSString *)hexString alphaString:(NSString *)alphaString{
    NSString *cString = [[hexString stringByTrimmingCharactersInSet:[NSCharacterSet whitespaceAndNewlineCharacterSet]] uppercaseString];
    
    // String should be 6 or 8 characters
    if ([cString length] < 6) {
        return [UIColor clearColor];
    }
    
    // strip 0X if it appears
    if ([cString hasPrefix:@"0X"])
        cString = [cString substringFromIndex:2];
    if ([cString hasPrefix:@"#"])
        cString = [cString substringFromIndex:1];
    if ([cString length] != 6)
        return [UIColor clearColor];
    
    // Separate into r, g, b substrings
    NSRange range;
    range.location = 0;
    range.length = 2;
    
    //r
    NSString *rString = [cString substringWithRange:range];
    
    //g
    range.location = 2;
    NSString *gString = [cString substringWithRange:range];
    
    //b
    range.location = 4;
    NSString *bString = [cString substringWithRange:range];
    
    // Scan values
    unsigned int r, g, b;
    [[NSScanner scannerWithString:rString] scanHexInt:&r];
    [[NSScanner scannerWithString:gString] scanHexInt:&g];
    [[NSScanner scannerWithString:bString] scanHexInt:&b];
    
    CGFloat a = [alphaString floatValue];
    if (a < 0.0 && a > 1.0) {
        a = 1.0;
    }
    
    return [UIColor colorWithRed:((float) r / 255.0f) green:((float) g / 255.0f) blue:((float) b / 255.0f) alpha:a];
}



#pragma mark RGBA String
+ (NSString *)es_RGBStringWithUIColor:(UIColor *)color{
    NSString *r = [NSString stringWithFormat:@"%@", [self decimalConvertToHexString:ceil([UIColor es_redValueWithUIColor:color]   * 255)]];
    NSString *g = [NSString stringWithFormat:@"%@", [self decimalConvertToHexString:ceil([UIColor es_greenValueWithUIColor:color] * 255)]];
    NSString *b = [NSString stringWithFormat:@"%@", [self decimalConvertToHexString:ceil([UIColor es_blueValueWithUIColor:color]  * 255)]];
    
    return [NSString stringWithFormat:@"#%@%@%@",r,g,b];
}

+ (NSString *)es_RGBAStringWithUIColor:(UIColor *)color{
    NSString *r = [NSString stringWithFormat:@"%@", [self decimalConvertToHexString:ceil([UIColor es_redValueWithUIColor:color]   * 255)]];
    NSString *g = [NSString stringWithFormat:@"%@", [self decimalConvertToHexString:ceil([UIColor es_greenValueWithUIColor:color] * 255)]];
    NSString *b = [NSString stringWithFormat:@"%@", [self decimalConvertToHexString:ceil([UIColor es_blueValueWithUIColor:color]  * 255)]];
    NSString *a = [NSString stringWithFormat:@"%@", [self decimalConvertToHexString:ceil([UIColor es_alphaValueWithUIColor:color] * 255)]];
    
    return [NSString stringWithFormat:@"#%@%@%@%@",r,g,b,a];
}

#pragma mark Hex String From UIColor

+(NSString *)es_hexStringWithUIColor:(UIColor *)color{
    NSString *r = [NSString stringWithFormat:@"%@", [self decimalConvertToHexString:ceil([UIColor es_redValueWithUIColor:color] * 255)]];
    NSString *g = [NSString stringWithFormat:@"%@", [self decimalConvertToHexString:ceil([UIColor es_greenValueWithUIColor:color] * 255)]];
    NSString *b = [NSString stringWithFormat:@"%@", [self decimalConvertToHexString:ceil([UIColor es_blueValueWithUIColor:color] * 255)]];
    NSString *a = [NSString stringWithFormat:@"%@", [self decimalConvertToHexString:ceil([UIColor es_alphaValueWithUIColor:color] * 255)]];
    
    return [NSString stringWithFormat:@"#%@%@%@%@",r,g,b,a];
}

#pragma mark r g b a value
//red value
+ (CGFloat)es_redValueWithUIColor:(UIColor *)color {
    return CGColorGetComponents(color.CGColor)[0];
}

//green value
+ (CGFloat)es_greenValueWithUIColor:(UIColor *)color {
    NSUInteger count = CGColorGetNumberOfComponents(color.CGColor);
    if (count == 2) {
        return CGColorGetComponents(color.CGColor)[0];
    } else {
        return CGColorGetComponents(color.CGColor)[1];
    }
}

//blue value
+ (CGFloat)es_blueValueWithUIColor:(UIColor *)color{
    NSUInteger count = CGColorGetNumberOfComponents(color.CGColor);
    if (count == 2) {
        return CGColorGetComponents(color.CGColor)[0];
    } else {
        return CGColorGetComponents(color.CGColor)[2];
    }
}

//alpha value
+ (CGFloat)es_alphaValueWithUIColor:(UIColor *)color{
    NSUInteger count = CGColorGetNumberOfComponents(color.CGColor);
    return CGColorGetComponents(color.CGColor)[count - 1];
}

#pragma mark r g b a string
+ (NSString *)es_redStringWithUIColor:(UIColor *)color {
    return [NSString stringWithFormat:@"%lf", [[self class] es_redValueWithUIColor:color]];
}

/** green From UIColor */
+ (NSString *)es_greenStringWithUIColor:(UIColor *)color {
    return [NSString stringWithFormat:@"%lf", [[self class] es_greenValueWithUIColor:color]];
}

/** blue From UIColor */
+ (NSString *)es_blueStringWithUIColor:(UIColor *)color {
    return [NSString stringWithFormat:@"%lf", [[self class] es_blueValueWithUIColor:color]];
}

+ (NSString *)es_alphaStringWithUIColor:(UIColor *)color {
    return [NSString stringWithFormat:@"%lf", [[self class] es_alphaValueWithUIColor:color]];
}


#pragma mark decimal convert to hexadecimal
//十进制转十六进制 decimal convert to hexadecimal
+(NSString *)decimalConvertToHexString:(int)tmpid {
    NSString *endtmp=@"";
    NSString *nLetterValue;
    NSString *nStrat;
    int ttmpig=tmpid%16;
    int tmp=tmpid/16;
    switch (ttmpig)
    {
        case 10:
            nLetterValue =@"A";break;
        case 11:
            nLetterValue =@"B";break;
        case 12:
            nLetterValue =@"C";break;
        case 13:
            nLetterValue =@"D";break;
        case 14:
            nLetterValue =@"E";break;
        case 15:
            nLetterValue =@"F";break;
        default:nLetterValue=[[NSString alloc]initWithFormat:@"%i",ttmpig];
    }
    switch (tmp)
    {
        case 10:
            nStrat =@"A";break;
        case 11:
            nStrat =@"B";break;
        case 12:
            nStrat =@"C";break;
        case 13:
            nStrat =@"D";break;
        case 14:
            nStrat =@"E";break;
        case 15:
            nStrat =@"F";break;
        default:nStrat=[[NSString alloc]initWithFormat:@"%i",tmp];
    }
    endtmp=[[NSString alloc]initWithFormat:@"%@%@",nStrat,nLetterValue];
    return endtmp;
}

#pragma mark - color Percent

+ (UIColor *)es_transitionStartColor:(UIColor *)startColor
                            endColor:(UIColor *)endColor
                         coefficient:(double)coefficient {
    coefficient = MIN(1, coefficient);
    coefficient = MAX(0, coefficient);
    
    CGFloat startRed    = [UIColor es_redValueWithUIColor:startColor];
    CGFloat startGreen  = [UIColor es_greenValueWithUIColor:startColor];
    CGFloat startBlue   = [UIColor es_blueValueWithUIColor:startColor];
    CGFloat startAlpha  = [UIColor es_alphaValueWithUIColor:startColor];
    
    CGFloat endRed      = [UIColor es_redValueWithUIColor:endColor];
    CGFloat endGreen    = [UIColor es_greenValueWithUIColor:endColor];
    CGFloat endBlue     = [UIColor es_blueValueWithUIColor:endColor];
    CGFloat endAlpha    = [UIColor es_alphaValueWithUIColor:endColor];
    
    CGFloat red     = startRed - (startRed - endRed) * coefficient;
    CGFloat green   = startGreen - (startGreen - endGreen) * coefficient;
    CGFloat blue    = startBlue - (startBlue - endBlue) * coefficient;
    CGFloat alpha   = startAlpha - (startAlpha - endAlpha) * coefficient;
    
    UIColor *transitionColor = [UIColor colorWithRed:red green:green blue:blue alpha:alpha];
    return transitionColor;
}

- (UIColor *)tt_lightTypeHighlightForPercent:(CGFloat)percent {
    percent = MIN(1, percent);
    percent = MAX(0, percent);
    CGFloat h,s,b,a;
    [self getHue:&h saturation:&s brightness:&b alpha:&a];
    return [UIColor colorWithHue:h saturation:s - percent brightness:b alpha:a];
}

- (UIColor *)tt_lightTypeHighlight {
    return [self tt_lightTypeHighlightForPercent:0.4];
}

- (UIColor *)tt_darkTypeHighlightForPercent:(CGFloat)percent {
    percent = MIN(1, percent);
    percent = MAX(0, percent);
    CGFloat h,s,b,a;
    [self getHue:&h saturation:&s brightness:&b alpha:&a];
    return [UIColor colorWithHue:h saturation:s brightness:b - percent alpha:a];
}

- (UIColor *)tt_darkTypeHighlight {
    return [self tt_darkTypeHighlightForPercent:0.2];
}

@end
