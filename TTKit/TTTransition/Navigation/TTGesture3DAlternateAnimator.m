//
//  TTGesture3DAlternateAnimator.m
//  TransitionDemo
//
//  Created by apple on 2018/1/30.
//  Copyright © 2018年 shang. All rights reserved.
//

#import "TTGesture3DAlternateAnimator.h"

@implementation TTGesture3DAlternateAnimator

- (void)animateTransition:(id<UIViewControllerContextTransitioning>)transitionContext {
    UIViewController *fromVC = [transitionContext viewControllerForKey:UITransitionContextFromViewControllerKey];
    UIViewController *toVC = [transitionContext viewControllerForKey:UITransitionContextToViewControllerKey];
    UIView *toView = toVC.view;
    UIView *fromView = fromVC.view;
    //    [toVC beginAppearanceTransition:YES animated:YES];
    if(self.operation == UINavigationControllerOperationPush){
        [self pushViewControllerAnimation:transitionContext fromVC:fromVC toVC:toVC fromView:fromView toView:toView];
    } else {
        [self popViewControllerAnimation:transitionContext fromVC:fromVC toVC:toVC fromView:fromView toView:toView];
    }
}

#pragma mark push

- (void)pushViewControllerAnimation:(id<UIViewControllerContextTransitioning>)transitionContext fromVC:(UIViewController *)fromVC toVC:(UIViewController *)toVC fromView:(UIView *)fromView toView:(UIView *)toView {
    CGRect fromFrame = [transitionContext initialFrameForViewController:fromVC];
    CGRect toFrame = [transitionContext finalFrameForViewController:toVC];
    NSTimeInterval duration = [self transitionDuration:transitionContext];
    fromView.layer.anchorPoint = CGPointMake(0, 0.5);
    fromView.layer.frame = fromFrame; //修正frame
    toView.layer.anchorPoint = CGPointMake(1, 0.5);
    toView.layer.frame = toFrame;
    UIView *tempView = [[UIView alloc]initWithFrame:fromView.bounds];
    tempView.backgroundColor = [UIColor clearColor];
    [fromView addSubview:tempView];
    
    UIView* containerView = [transitionContext containerView];
    [containerView addSubview:toView];
    
    
    CATransform3D t2 = CATransform3DMakeRotation(-TT_DegreesToRadians(80), 0, 1, 0);
    t2 = CATransform3DTranslate(t2, fromFrame.size.width, 0, -fromFrame.size.width *0.7);
    t2 = CATransform3DScale(t2, 1, 1.5, 1);
    t2 = CATransform3DRotate(t2, TT_DegreesToRadians(5), 1, 0, 0);
    t2 = TT_CATransform3DPerspect(t2, CGPointZero, 1000);
    
    CABasicAnimation *toAnimation = [CABasicAnimation animationWithKeyPath:@"transform"];
    toAnimation.fromValue = [NSValue valueWithCATransform3D:t2];
    toAnimation.toValue = [NSValue valueWithCATransform3D:CATransform3DIdentity];
    toAnimation.repeatCount = 1;
    toAnimation.duration = duration;
    toAnimation.timingFunction = [CAMediaTimingFunction functionWithName:kCAMediaTimingFunctionEaseOut];
    [toView.layer addAnimation:toAnimation forKey:@"toAnimation"];
    [UIView animateWithDuration:duration *0.5 animations:^{
        tempView.backgroundColor = [UIColor colorWithWhite:0 alpha:0.3];
    }];
    
    CATransform3D t1 = CATransform3DMakeRotation(TT_DegreesToRadians(80), 0, 1, 0);
    t1 = CATransform3DScale(t1, 1, 0.8, 1);//在y方向缩放
    t1 = CATransform3DRotate(t1, TT_DegreesToRadians(-2), 1, 0, 0);
    t1 = CATransform3DTranslate(t1, 0, 0, -50);
    t1 = TT_CATransform3DPerspect(t1, CGPointZero, 1000);
    CABasicAnimation *fromAnimation = [CABasicAnimation animationWithKeyPath:@"transform"];
    fromAnimation.byValue = [NSValue valueWithCATransform3D:t1];
    fromAnimation.duration = duration;
    fromAnimation.repeatCount = 1;
    fromAnimation.timingFunction = [CAMediaTimingFunction functionWithName:kCAMediaTimingFunctionEaseIn];
    [fromView.layer addAnimation:fromAnimation forKey:@"fromAnimation"];
    
    dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)((duration) * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
        fromView.layer.anchorPoint = CGPointMake(0.5, 0.5);
        fromView.layer.frame = fromFrame;
        fromView.layer.transform = CATransform3DIdentity;
        [tempView removeFromSuperview];
        toView.layer.anchorPoint = CGPointMake(0.5, 0.5);
        toView.layer.frame = toFrame;
        toView.layer.transform = CATransform3DIdentity;
        
        [transitionContext completeTransition:![transitionContext transitionWasCancelled]];
    });
}

#pragma mark pop

- (void)popViewControllerAnimation:(id<UIViewControllerContextTransitioning>)transitionContext fromVC:(UIViewController *)fromVC toVC:(UIViewController *)toVC fromView:(UIView *)fromView toView:(UIView *)toView {
    CGRect fromFrame = [transitionContext initialFrameForViewController:fromVC];
    CGRect toFrame = [transitionContext finalFrameForViewController:toVC];
    NSTimeInterval duration = [self transitionDuration:transitionContext];
    
    fromView.layer.anchorPoint = CGPointMake(1, 0.5);
    fromView.layer.frame = fromFrame;
    toView.layer.anchorPoint = CGPointMake(0, 0.5);
    toView.layer.frame = toFrame;
    
    UIView *tempView = [[UIView alloc]initWithFrame:CGRectMake(0, 0, fromFrame.size.width, fromFrame.size.height)];
    tempView.backgroundColor = [UIColor colorWithWhite:0 alpha:0.7];
    [toView addSubview:tempView];
    
    UIView* containerView = [transitionContext containerView];
    [containerView addSubview:toView];
    
    
    CATransform3D t1= CATransform3DMakeRotation(M_PI_2, 0, 1, 0); //y轴旋转90°
    t1 = CATransform3DScale(t1, 1, 0.8, 1);//在y方向缩小
    t1 = CATransform3DRotate(t1, TT_DegreesToRadians(-2), 1, 0, 0);//x轴旋转-2°
    t1 = TT_CATransform3DPerspect(t1, CGPointZero, 1000); //透视
    toView.layer.transform = t1;
    
    CATransform3D t2 = CATransform3DMakeRotation(-TT_DegreesToRadians(80), 0, 1, 0);//沿Y轴旋转-80°
    t2 = CATransform3DRotate(t2, TT_DegreesToRadians(5), 1, 0, 0);//沿x轴旋转5°
    t2 = CATransform3DTranslate(t2, fromFrame.size.width, 0, 0); //沿x轴平移屏幕宽
    t2 = CATransform3DScale(t2, 1, 1.5, 1);//Y轴放大
    t2 = TT_CATransform3DPerspect(t2, CGPointZero, 1000);//透视效果
    
    [UIView animateKeyframesWithDuration:duration delay:0.0 options:UIViewKeyframeAnimationOptionCalculationModeCubic animations:^{
        
        //执行动画t2
        [UIView addKeyframeWithRelativeStartTime:0.0f relativeDuration:1 animations:^{
            fromView.layer.transform = t2;
            toView.layer.transform = CATransform3DIdentity;
            tempView.backgroundColor = [UIColor clearColor];
        }];
        
        //执行动画t3
        [UIView addKeyframeWithRelativeStartTime: 0.7 relativeDuration: 0.3 animations:^{
            CATransform3D t3 = CATransform3DTranslate(t2, 0, 0, -fromFrame.size.width *0.7);
            fromView.layer.transform = t3;
        }];
        
    } completion:^(BOOL finished) {
        fromView.layer.anchorPoint = CGPointMake(0.5, 0.5);
        fromView.layer.frame = fromFrame;
        fromView.layer.transform = CATransform3DIdentity;
        [tempView removeFromSuperview];
        toView.layer.anchorPoint = CGPointMake(0.5, 0.5);
        toView.layer.frame = toFrame;
        toView.layer.transform = CATransform3DIdentity;
        [transitionContext completeTransition:![transitionContext transitionWasCancelled]];
    }];
}

@end
