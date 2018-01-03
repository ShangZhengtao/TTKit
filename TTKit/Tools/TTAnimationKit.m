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

@end
