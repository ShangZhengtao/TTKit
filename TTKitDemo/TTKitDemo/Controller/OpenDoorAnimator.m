//
//  OpenDoorAnimator.m
//  TTKitDemo
//
//  Created by apple on 2018/1/12.
//  Copyright © 2018年 shang. All rights reserved.
//

#import "OpenDoorAnimator.h"

@implementation OpenDoorAnimator


- (NSTimeInterval)transitionDuration:(id<UIViewControllerContextTransitioning>)transitionContext {
    return 0.9;
}

- (void)animateTransition:(id<UIViewControllerContextTransitioning>)transitionContext {
    
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
        
        [UIView animateWithDuration:transitionDuration delay:0 options:UIViewAnimationOptionCurveEaseOut animations:^{
            CATransform3D transform = CATransform3DMakeRotation(M_PI*0.5, 0, 1, 0);
            transform = CATransform3DScale(transform, 1, 0.9, 1);
            leftView.layer.transform = CATransform3DPerspect(transform, CGPointZero, 1000);
            
            transform = CATransform3DMakeRotation(-M_PI*0.5, 0, 1, 0);
            transform = CATransform3DScale(transform, 1, 0.9, 1);
            rightView.layer.transform = CATransform3DPerspect(transform, CGPointZero, 1000);
            
        } completion:^(BOOL finished) {
            
        }];
        
        [UIView animateWithDuration:transitionDuration *(1-0.3) delay:transitionDuration *0.3 options:UIViewAnimationOptionCurveEaseOut  animations:^{
            
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
        leftView.layer.transform = CATransform3DPerspect(transform, CGPointZero, 1000);
        
        transform = CATransform3DMakeRotation(-M_PI*0.5, 0, 1, 0);
        transform = CATransform3DScale(transform, 1, 0.9, 1);
        rightView.layer.transform = CATransform3DPerspect(transform, CGPointZero, 1000);
        
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

CATransform3D CATransform3DMakePerspective(CGPoint center, float disZ) {
    CATransform3D transToCenter = CATransform3DMakeTranslation(-center.x, -center.y, 0);
    CATransform3D transBack = CATransform3DMakeTranslation(center.x, center.y, 0);
    CATransform3D scale = CATransform3DIdentity;
    scale.m34 = -1.0f/disZ;
    return CATransform3DConcat(CATransform3DConcat(transToCenter, scale), transBack);
}

CATransform3D CATransform3DPerspect(CATransform3D t, CGPoint center, float disZ) {
    return CATransform3DConcat(t, CATransform3DMakePerspective(center, disZ));
}

@end