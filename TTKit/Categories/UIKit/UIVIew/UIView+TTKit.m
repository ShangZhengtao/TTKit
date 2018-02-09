//
//  UIView+TTKit.m
//  TTKitDemo
//
//  Created by apple on 2017/11/28.
//  Copyright © 2017年 shang. All rights reserved.
//

#import "UIView+TTKit.h"

@implementation UIView (TTKit)

#pragma mark - Corner

- (void)setCircleCorner {
    CGFloat radius = MIN(self.bounds.size.width, self.bounds.size.height) * 0.5;
    [self setCornerWithRadius:radius];
}

- (void)setCornerWithRadius:(CGFloat)radius {
    self.layer.masksToBounds = YES;
    self.layer.cornerRadius = radius;
}

- (void)setCornerAtCorner:(UIRectCorner)corner withRadius:(CGFloat)radius {
    UIBezierPath *maskPath = [UIBezierPath bezierPathWithRoundedRect:self.bounds byRoundingCorners:corner cornerRadii:CGSizeMake(radius, radius)];
    CAShapeLayer *maskLayer = [[CAShapeLayer alloc] init];
    maskLayer.frame = self.bounds;
    maskLayer.path = maskPath.CGPath;
    self.layer.mask = maskLayer;
}


- (void)addMotionEffectWithRelativeValue:(CGFloat)value effectOptions:(TTMotionEffectOptions)options {
    UIInterpolatingMotionEffect *motionX = [[UIInterpolatingMotionEffect alloc]initWithKeyPath:@"center.x" type:UIInterpolatingMotionEffectTypeTiltAlongHorizontalAxis];
    motionX.maximumRelativeValue = @(value);
    motionX.minimumRelativeValue = @(-value);
    
    UIInterpolatingMotionEffect *motionY = [[UIInterpolatingMotionEffect alloc]initWithKeyPath:@"center.y" type:UIInterpolatingMotionEffectTypeTiltAlongVerticalAxis];
    motionY.maximumRelativeValue = @(value);
    motionY.minimumRelativeValue = @(-value);
    
    if ((options & TTMotionEffectOptionVertical) &&
        (options & TTMotionEffectOptionHorizontal)) {
        [self addMotionEffect:motionY];
        [self addMotionEffect:motionX];
    }else if (options & TTMotionEffectOptionHorizontal) {
        [self addMotionEffect:motionX];
    }else if (options & TTMotionEffectOptionVertical) {
        [self addMotionEffect:motionY];
    }
}


- (void)setAnchorPointWithoutMove:(CGPoint)anchorpoint{
    CGRect oldFrame = self.frame;
    self.layer.anchorPoint = anchorpoint;
    self.frame = oldFrame;
}

@end
