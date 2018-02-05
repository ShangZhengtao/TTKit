//
//  TTModalAnimator.m
//  TTKitDemo
//
//  Created by apple on 2018/1/15.
//  Copyright © 2018年 shang. All rights reserved.
//

#import "TTModalAnimator.h"


@implementation TTModalAnimator

- (NSTimeInterval)transitionDuration:(id<UIViewControllerContextTransitioning>)transitionContext {
    switch (self.style) {
        case TTModalTransitionStyleDefault:
            return 0.7;
        case TTModalTransitionStyleOpenDoor:
            return 0.9;
        case TTModalTransitionStyleGradient:
            return 0.7;
        case TTModalTransitionStyleCircleZoom:
            return 0.7;
    }
}

- (void)animateTransition:(id<UIViewControllerContextTransitioning>)transitionContext {
    switch (self.style) {
        case TTModalTransitionStyleOpenDoor:
            [self animateTransitionOpenDoorEffect:transitionContext]; break;
        case TTModalTransitionStyleGradient:
            [self animateTransitionGradientEffect:transitionContext]; break;
        case TTModalTransitionStyleCircleZoom:
        {
            CGFloat x = [[[NSUserDefaults standardUserDefaults] valueForKey:kTTTouchEventPointXKey] doubleValue];
            CGFloat y = [[[NSUserDefaults standardUserDefaults] valueForKey:kTTTouchEventPointYKey] doubleValue];
            [self animateTransitionCircleZoomEffect:transitionContext circleCenter:CGPointMake(x, y)];
            break;
        }
        default:
            [self animateTransitionOpenDoorEffect:transitionContext];
    }
}

- (void)animateTransitionCircleZoomEffect:(id<UIViewControllerContextTransitioning>)transitionContext circleCenter:(CGPoint)center {
    
    UIViewController *fromVC = [transitionContext viewControllerForKey:UITransitionContextFromViewControllerKey];
    UIViewController *toVC = [transitionContext viewControllerForKey:UITransitionContextToViewControllerKey];
    
    UIView *containerView = transitionContext.containerView;
    NSTimeInterval transitionDuration = [self transitionDuration:transitionContext];
    UIView *fromView = fromVC.view;
    UIView *toView = toVC.view;
    fromView.frame = [transitionContext initialFrameForViewController:fromVC];
    toView.frame = [transitionContext finalFrameForViewController:toVC];
    CGFloat screenW = [UIScreen mainScreen].bounds.size.width;
    CGFloat screenH = [UIScreen mainScreen].bounds.size.height;
    //计算半径
    CGFloat a, b;
    a = center.x < screenW * 0.5 ? screenW  - center.x : center.x;
    b = center.y < screenH * 0.5 ? screenH  - center.y : center.y;
    CGFloat radius = hypotf(a,b);
    if (toVC.isBeingPresented) {
        
        [containerView addSubview:toView]; //require
        
        CAShapeLayer *maskLayer = [CAShapeLayer layer];
        maskLayer.shadowOpacity = 1;
        maskLayer.shadowColor = [UIColor blackColor].CGColor;
        maskLayer.shadowRadius = 5;
        maskLayer.frame = [UIScreen mainScreen].bounds;
        
        UIBezierPath *path = [UIBezierPath bezierPathWithArcCenter:center radius:0.1 startAngle:0 endAngle:M_PI *2 clockwise:YES];
        maskLayer.path = path.CGPath;
        maskLayer.fillColor = [UIColor whiteColor].CGColor;
        toView.layer.mask = maskLayer;
        
        CABasicAnimation *animation = [CABasicAnimation animationWithKeyPath:@"path"];
        animation.duration = transitionDuration;
        animation.repeatCount = 1;
        animation.removedOnCompletion = NO;
        animation.fillMode = kCAFillModeForwards;
        animation.autoreverses = NO;
        animation.timingFunction = [CAMediaTimingFunction functionWithControlPoints:0.70 :0.20 :1.00 :0.00];
        //https://yq.aliyun.com/articles/29568
        UIBezierPath *beginPath = [UIBezierPath bezierPathWithArcCenter:center radius:0.1 startAngle:0 endAngle:M_PI *2 clockwise:YES];
        UIBezierPath *finalPath = [UIBezierPath bezierPathWithArcCenter:center radius:radius startAngle:0 endAngle:M_PI *2 clockwise:YES];
        animation.fromValue = (__bridge id)beginPath.CGPath;
        animation.toValue   = (__bridge id)finalPath.CGPath;
        [maskLayer addAnimation:animation forKey:@""];
        
        dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(transitionDuration * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
            [transitionContext completeTransition:YES];
            fromView.hidden = NO;
            toView.layer.mask = nil;
            [maskLayer removeFromSuperlayer];
        });
    }
    
    if (fromVC.isBeingDismissed) {
        
        [containerView addSubview:toView]; //require
        [containerView addSubview:fromView];
        
        CAShapeLayer *maskLayer = [CAShapeLayer layer];
        maskLayer.shadowOpacity = 1;
        maskLayer.shadowColor = [UIColor blackColor].CGColor;
        maskLayer.shadowRadius = 5;
        maskLayer.frame = [UIScreen mainScreen].bounds;
        UIBezierPath *path = [UIBezierPath bezierPathWithArcCenter:center radius:radius startAngle:0 endAngle:M_PI *2 clockwise:YES];
        maskLayer.path = path.CGPath;
        maskLayer.fillColor = [UIColor whiteColor].CGColor;
        fromView.layer.mask = maskLayer;
        
        CABasicAnimation *animation = [CABasicAnimation animationWithKeyPath:@"path"];
        animation.duration = transitionDuration;
        animation.repeatCount = 1;
        animation.removedOnCompletion = NO;
        animation.fillMode = kCAFillModeForwards;
        animation.autoreverses = NO;
        animation.timingFunction = [CAMediaTimingFunction functionWithControlPoints:0.20 :1.00 :1.00 :0.60];
        
        UIBezierPath *beginPath = [UIBezierPath bezierPathWithArcCenter:center radius:radius startAngle:0 endAngle:M_PI *2 clockwise:YES];
        UIBezierPath *finalPath = [UIBezierPath bezierPathWithArcCenter:center radius:0.1 startAngle:0 endAngle:M_PI *2 clockwise:YES];
        
        animation.fromValue = (__bridge id)beginPath.CGPath;
        animation.toValue   = (__bridge id)finalPath.CGPath;
        [maskLayer addAnimation:animation forKey:@""];
        
        dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(transitionDuration * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
            [transitionContext completeTransition:YES];
            fromView.hidden = NO;
            fromView.layer.mask = nil;
        });
    }
}


- (void)animateTransitionGradientEffect:(id<UIViewControllerContextTransitioning>)transitionContext {
    
    UIViewController *fromVC = [transitionContext viewControllerForKey:UITransitionContextFromViewControllerKey];
    UIViewController *toVC = [transitionContext viewControllerForKey:UITransitionContextToViewControllerKey];
    
    UIView *containerView = transitionContext.containerView;
    NSTimeInterval transitionDuration = [self transitionDuration:transitionContext];
    // For a Presentation:
    //      fromView = The presenting view.
    //      toView   = The presented view.
    // For a Dismissal:
    //      fromView = The presented view.
    //      toView   = The presenting view.
    
    UIView *fromView = fromVC.view;
    UIView *toView = toVC.view;
    fromView.frame = [transitionContext initialFrameForViewController:fromVC];
    toView.frame = [transitionContext finalFrameForViewController:toVC];
    CGFloat screenW = [UIScreen mainScreen].bounds.size.width;
    CGFloat screenH = [UIScreen mainScreen].bounds.size.height;
    
    if (toVC.isBeingPresented) {
        UIView *tempView = [fromView snapshotViewAfterScreenUpdates:NO];
        tempView.frame = [UIScreen mainScreen].bounds;
        [containerView addSubview:toView]; //require
        [containerView addSubview:tempView];
        CAGradientLayer *maskLayer = [[CAGradientLayer alloc]init];
        tempView.layer.mask = maskLayer;
        maskLayer.frame = CGRectMake(0,0, screenW, screenH);
        maskLayer.colors = @[(__bridge id)[UIColor clearColor].CGColor,
                             (__bridge id)[UIColor whiteColor].CGColor];
        maskLayer.startPoint = CGPointMake(0.5, 1);
        maskLayer.endPoint = CGPointMake(0.5, 0);
        maskLayer.locations = @[@(-1),@(0)];
        
        CABasicAnimation *animation = [CABasicAnimation animationWithKeyPath:@"locations"];
        animation.removedOnCompletion = NO;
        animation.autoreverses = NO;
        animation.fillMode = kCAFillModeForwards;
        animation.duration = transitionDuration;
        animation.byValue = @[@(2),@(2)];
        animation.repeatCount = 1;
        animation.timingFunction = [CAMediaTimingFunction functionWithName:kCAMediaTimingFunctionEaseIn];
        [maskLayer addAnimation:animation forKey:@""];
        dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(transitionDuration * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
            [transitionContext completeTransition:YES];
            [tempView removeFromSuperview];
        });
    }
    
    if (fromVC.isBeingDismissed) {
        
        UIView *tempView = [fromView snapshotViewAfterScreenUpdates:YES];
        tempView.frame = [UIScreen mainScreen].bounds;
        fromView.hidden = YES;
        [containerView addSubview:toView]; //require
        [containerView addSubview:tempView];
        CAGradientLayer *maskLayer = [[CAGradientLayer alloc]init];
        tempView.layer.mask = maskLayer;
        maskLayer.frame = CGRectMake(0,0, screenW, screenH);
        maskLayer.colors = @[(__bridge id)[UIColor clearColor].CGColor,
                             (__bridge id)[UIColor whiteColor].CGColor];
        maskLayer.startPoint = CGPointMake(0.5, 0);
        maskLayer.endPoint = CGPointMake(0.5, 1);
        maskLayer.locations = @[@(-1),@(0)];
        
        CABasicAnimation *animation = [CABasicAnimation animationWithKeyPath:@"locations"];
        animation.removedOnCompletion = NO;
        animation.autoreverses = NO;
        animation.fillMode = kCAFillModeForwards;
        animation.duration = transitionDuration;
        animation.byValue = @[@(2),@(2)];
        animation.repeatCount = 1;
        animation.timingFunction = [CAMediaTimingFunction functionWithName:kCAMediaTimingFunctionEaseIn];
        [maskLayer addAnimation:animation forKey:@""];
        dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(transitionDuration * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
            [transitionContext completeTransition:YES];
            [tempView removeFromSuperview];
            fromView.hidden = NO;
        });
    }
}


- (void)animateTransitionOpenDoorEffect:(id<UIViewControllerContextTransitioning>)transitionContext {
    
    UIViewController *fromVC = [transitionContext viewControllerForKey:UITransitionContextFromViewControllerKey];
    UIViewController *toVC = [transitionContext viewControllerForKey:UITransitionContextToViewControllerKey];
    
    UIView *containerView = transitionContext.containerView;
    NSTimeInterval transitionDuration = [self transitionDuration:transitionContext];
    // For a Presentation:
    //      fromView = The presenting view.
    //      toView   = The presented view.
    // For a Dismissal:
    //      fromView = The presented view.
    //      toView   = The presenting view.
    
    UIView *fromView = fromVC.view;
    UIView *toView = toVC.view;
    fromView.frame = [transitionContext initialFrameForViewController:fromVC];
    toView.frame = [transitionContext finalFrameForViewController:toVC];
    CGFloat screenW = [UIScreen mainScreen].bounds.size.width;
    CGFloat screenH = [UIScreen mainScreen].bounds.size.height;
    if (toVC.isBeingPresented) { // present 开门
        UIView *leftView = [fromVC.view snapshotViewAfterScreenUpdates:NO];
        UIView *rightView = [fromVC.view snapshotViewAfterScreenUpdates:NO];
        
        [containerView addSubview:toView]; //require
        [containerView addSubview:leftView];
        [containerView addSubview:rightView];
        fromView.hidden = YES;
        
        CATransform3D tf = CATransform3DIdentity;
        tf.m34 = - 1/1000;
        containerView.layer.sublayerTransform = tf;
        CAShapeLayer *leftLayer = [CAShapeLayer layer];
        leftLayer.backgroundColor = [UIColor whiteColor].CGColor;
        leftLayer.frame = CGRectMake(0, 0,screenW * 0.5, screenH);
        leftView.layer.mask = leftLayer;
        leftView.layer.anchorPoint = CGPointMake(0, 0.5);
        leftView.layer.frame = CGRectMake(0, 0, screenW, screenH);
        leftView.layer.transform = tf;
        CAShapeLayer *rightLayer = [CAShapeLayer layer];
        rightLayer.backgroundColor = [UIColor whiteColor].CGColor;
        rightLayer.frame = CGRectMake(screenW * 0.5, 0, screenW*0.5, screenH);
        rightView.layer.mask = rightLayer;
        rightView.layer.anchorPoint = CGPointMake(1, 0.5);
        rightView.layer.frame = CGRectMake(0, 0, screenW, screenH);
        rightView.layer.transform = tf;
        
        CATransform3D toTransform = CATransform3DMakeTranslation(0, 0, -screenW *0.5);
        toTransform = CATransform3DScale(toTransform, 0, 0, 1);
        toView.layer.transform = toTransform;
        
        [UIView animateWithDuration:transitionDuration delay:0 options:UIViewAnimationOptionCurveEaseIn animations:^{
            CATransform3D transform = CATransform3DMakeRotation(M_PI*0.5, 0, 1, 0);
            transform = CATransform3DScale(transform, 1, 0.9, 1);
            leftView.layer.transform = _CATransform3DPerspect(transform, CGPointZero, 1000);
            
            transform = CATransform3DMakeRotation(-M_PI*0.5, 0, 1, 0);
            transform = CATransform3DScale(transform, 1, 0.9, 1);
            rightView.layer.transform = _CATransform3DPerspect(transform, CGPointZero, 1000);
            
        } completion:^(BOOL finished) {
            
        }];
        
        [UIView animateWithDuration:transitionDuration *(1-0.35) delay:transitionDuration *0.35 options:UIViewAnimationOptionCurveEaseIn  animations:^{
            
            toView.layer.transform = CATransform3DIdentity;
            
        } completion:^(BOOL finished) {
            BOOL wasCancelled = [transitionContext transitionWasCancelled];
            [transitionContext completeTransition:!wasCancelled];// require
            [leftView removeFromSuperview];
            [rightView removeFromSuperview];
            fromView.hidden = NO;
            toView.hidden = NO;
        }];
    }
    
    if (fromVC.isBeingDismissed) { //dismiss 关门
        UIView *leftView = [toView snapshotViewAfterScreenUpdates:YES];
        UIView *rightView = [toView snapshotViewAfterScreenUpdates:YES];
        [containerView addSubview:leftView];
        [containerView addSubview:rightView];
        toView.hidden = YES;
        
        CATransform3D tf = CATransform3DIdentity;
        tf.m34 = - 1/1000;
        containerView.layer.sublayerTransform = tf;
        fromView.layer.transform = tf;
        CAShapeLayer *leftLayer = [CAShapeLayer layer];
        leftLayer.backgroundColor = [UIColor whiteColor].CGColor;
        leftLayer.frame = CGRectMake(0, 0,screenW * 0.5, screenH);
        leftView.layer.mask = leftLayer;
        leftView.layer.anchorPoint = CGPointMake(0, 0.5);
        leftView.layer.frame = CGRectMake(0, 0, screenW, screenH);
        leftView.layer.transform = tf;
        CAShapeLayer *rightLayer = [CAShapeLayer layer];
        rightLayer.backgroundColor = [UIColor whiteColor].CGColor;
        rightLayer.frame = CGRectMake(screenW * 0.5, 0, screenW*0.5, screenH);
        rightView.layer.mask = rightLayer;
        rightView.layer.anchorPoint = CGPointMake(1, 0.5);
        rightView.layer.frame = CGRectMake(0, 0, screenW, screenH);
        rightView.layer.transform = tf;
        
        CATransform3D transform = CATransform3DMakeRotation(M_PI*0.5, 0, 1, 0);
        transform = CATransform3DScale(transform, 1, 0.9, 1);
        leftView.layer.transform = _CATransform3DPerspect(transform, CGPointZero, 1000);
        
        transform = CATransform3DMakeRotation(-M_PI*0.5, 0, 1, 0);
        transform = CATransform3DScale(transform, 1, 0.9, 1);
        rightView.layer.transform = _CATransform3DPerspect(transform, CGPointZero, 1000);
        
        //toView
        [UIView animateWithDuration:transitionDuration *(1-0.3)  delay:transitionDuration *0.3 options:UIViewAnimationOptionCurveEaseOut animations:^{
            
            CATransform3D tf = CATransform3DIdentity;
            tf.m34 = - 1/1000;
            leftView.layer.transform = tf;
            rightView.layer.transform = tf;
            
        } completion:^(BOOL finished) {
            
            BOOL wasCancelled = [transitionContext transitionWasCancelled];
            [transitionContext completeTransition:!wasCancelled];
            
            [leftView removeFromSuperview];
            [rightView removeFromSuperview];
            fromView.hidden = NO;
            toView.hidden = NO;
            fromView.layer.transform = CATransform3DIdentity;
            
        }];
        
        // fromView
        [UIView animateWithDuration:transitionDuration *0.5  delay:0 options:UIViewAnimationOptionCurveEaseOut animations:^{
            CATransform3D fromTransform = CATransform3DMakeTranslation(0, 0, -screenW *0.5);
            fromTransform = CATransform3DScale(fromTransform, 0.00000001, 0.00000001, 1);
            fromView.layer.transform = fromTransform;
            
        } completion:^(BOOL finished) {
            
        }];
    }
}

#pragma mark -投影转换

CATransform3D _CATransform3DMakePerspective(CGPoint center, float disZ) {
    CATransform3D transToCenter = CATransform3DMakeTranslation(-center.x, -center.y, 0);
    CATransform3D transBack = CATransform3DMakeTranslation(center.x, center.y, 0);
    CATransform3D scale = CATransform3DIdentity;
    scale.m34 = -1.0f/disZ;
    return CATransform3DConcat(CATransform3DConcat(transToCenter, scale), transBack);
}

CATransform3D _CATransform3DPerspect(CATransform3D t, CGPoint center, float disZ) {
    return CATransform3DConcat(t, _CATransform3DMakePerspective(center, disZ));
}

@end
