//
//  TTAnimationKit.m
//  TTKitDemo
//
//  Created by apple on 2018/1/2.
//  Copyright © 2018年 shang. All rights reserved.
//

#import "TTAnimationKit.h"

@implementation TTAnimationKit


+ (void)floatViews:(NSArray<__kindof UIView *> *)views {
    [views enumerateObjectsUsingBlock:^(UIView *view, NSUInteger idx, BOOL *  stop) {
        
        //沿着中心左移5上移5
        CAKeyframeAnimation *positionAnimation = [CAKeyframeAnimation animationWithKeyPath:@"position"];
        positionAnimation.calculationMode = kCAAnimationPaced;
        positionAnimation.fillMode = kCAFillModeForwards;
        positionAnimation.repeatCount = MAXFLOAT;
        positionAnimation.autoreverses = YES;
        positionAnimation.timingFunction = [CAMediaTimingFunction functionWithName:kCAMediaTimingFunctionEaseInEaseOut];
        positionAnimation.duration = (idx == views.count - 1) ? 4 : 5+idx;
        UIBezierPath *positionPath = [UIBezierPath bezierPathWithOvalInRect:CGRectInset(view.frame, view.frame.size.width/2-5, view.frame.size.height/2-5)];
        positionAnimation.path = positionPath.CGPath;
        [view.layer addAnimation:positionAnimation forKey:nil];
        
        // scaleXAniamtion
        CAKeyframeAnimation *scaleXAniamtion = [CAKeyframeAnimation animationWithKeyPath:@"transform.scale.x"];
        scaleXAniamtion.values = @[@1.0,@1.1,@1.0];
        scaleXAniamtion.keyTimes = @[@0.0,@0.5,@1.0];
        scaleXAniamtion.repeatCount = MAXFLOAT;
        scaleXAniamtion.autoreverses = YES;
        scaleXAniamtion.duration = 4+idx;
        [view.layer addAnimation:scaleXAniamtion forKey:nil];
        
        // scaleYAniamtion
        CAKeyframeAnimation *scaleYAnimation = [CAKeyframeAnimation animationWithKeyPath:@"transform.scale.y"];
        scaleYAnimation.values = @[@1,@1.1,@1.0];
        scaleYAnimation.keyTimes = @[@0.0,@0.5,@1.0];
        scaleYAnimation.autoreverses = YES;
        scaleYAnimation.repeatCount = YES;
        scaleYAnimation.duration = 4+idx;
        [view.layer addAnimation:scaleYAnimation forKey:nil];
    }];
    
}

+ (void)pathAnimationForView:(UIView *)view color:(UIColor *)color duration:(NSTimeInterval)duration {
    
    CAShapeLayer *shapeLayer = [CAShapeLayer layer];
    shapeLayer.frame = view.bounds;
    shapeLayer.path = [UIBezierPath bezierPathWithRoundedRect:view.bounds cornerRadius:view.layer.cornerRadius].CGPath;
    shapeLayer.lineWidth = 5;
    shapeLayer.fillColor = [UIColor clearColor].CGColor;
    shapeLayer.strokeColor = color.CGColor;
    shapeLayer.shadowColor = color.CGColor;
    shapeLayer.shadowRadius = 5;
    shapeLayer.shadowOffset = CGSizeZero;
    shapeLayer.shadowOpacity = 1;
    shapeLayer.lineCap = kCALineCapRound;
    [view.layer addSublayer:shapeLayer];
    //开始位置
    CABasicAnimation *aniStart = [CABasicAnimation animationWithKeyPath:@"strokeStart"];
    aniStart.beginTime = 0.03;
    aniStart.fromValue = @(0);
    aniStart.toValue = @(1);
    //结束位置
    CABasicAnimation *aniEnd = [CABasicAnimation animationWithKeyPath:@"strokeEnd"];
    aniEnd.fromValue = @(0);
    aniEnd.toValue = @(1);
    
    CAAnimationGroup *group = [CAAnimationGroup animation];
    group.duration = duration;
    group.repeatCount = CGFLOAT_MAX;
    group.animations = @[aniStart,aniEnd];
    [shapeLayer addAnimation:group forKey:nil];
    
}

+ (void)borderGradientAnimationForView:(UIView *)view color:(UIColor *)color duration:(NSTimeInterval)duration {
    //渐变色
    CAGradientLayer *colorlayer = [CAGradientLayer layer];
    colorlayer.colors = @[ (__bridge id)view.backgroundColor.CGColor,
                           (__bridge id)color.CGColor,
                           (__bridge id)view.backgroundColor.CGColor
                           ];
    
    colorlayer.locations = @[@(0),@(0.5),@(1)];
    colorlayer.startPoint = CGPointMake(0, 0);
    colorlayer.endPoint = CGPointMake(1, 0);
    colorlayer.frame = view.bounds;
    [view.layer addSublayer:colorlayer];
    //mask
    CAShapeLayer *shapeLayer = [CAShapeLayer layer];
    shapeLayer.frame = view.bounds;
    shapeLayer.lineWidth = 5;
    CGFloat dx = shapeLayer.lineWidth*0.5;
    shapeLayer.path = [UIBezierPath bezierPathWithRoundedRect:CGRectInset(view.bounds,dx ,dx) cornerRadius:view.layer.cornerRadius].CGPath;
    shapeLayer.fillColor = [UIColor clearColor].CGColor;
    shapeLayer.strokeColor = [UIColor redColor].CGColor;
    colorlayer.mask = shapeLayer;
    //动画
    CABasicAnimation *animation = [CABasicAnimation animationWithKeyPath:@"locations"];
    animation.fromValue = @[@(-1),@(-0.5),@(0)];
    animation.toValue = @[@(1),@(1.5),@(2)];
    animation.duration = 1.5;
    animation.repeatCount = CGFLOAT_MAX;
    [colorlayer addAnimation:animation forKey:nil];
}

@end
