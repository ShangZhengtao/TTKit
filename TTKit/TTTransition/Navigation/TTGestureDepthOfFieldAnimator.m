//
//  TTGestureDepthOfFieldAnimator.m
//  TransitionDemo
//
//  Created by apple on 2018/1/30.
//  Copyright © 2018年 shang. All rights reserved.
//

#import "TTGestureDepthOfFieldAnimator.h"

@interface TTGestureDepthOfFieldAnimator()

@property (nonatomic, strong) NSMutableArray <UIView *> *screenSnapshots;
@property (nonatomic, weak) UIViewController *fromVC;
@property (nonatomic, weak) UIViewController *toVC;

@end

@implementation TTGestureDepthOfFieldAnimator

- (NSMutableArray<UIView *> *)screenSnapshots {
    if (!_screenSnapshots) {
        _screenSnapshots = @[].mutableCopy;
    }
    return _screenSnapshots;
}

- (NSTimeInterval)transitionDuration:(id<UIViewControllerContextTransitioning>)transitionContext {
    return self.transitionDuration - 0.1;
}

- (void)animateTransition:(id<UIViewControllerContextTransitioning>)transitionContext {
    UIViewController *fromVC = [transitionContext viewControllerForKey:UITransitionContextFromViewControllerKey];
    UIViewController *toVC = [transitionContext viewControllerForKey:UITransitionContextToViewControllerKey];
    self.fromVC = fromVC;
    self.toVC = toVC;
    UIView *toView = toVC.view;
    UIView *fromView = fromVC.view;
    [toVC beginAppearanceTransition:YES animated:NO];
    if(self.operation == UINavigationControllerOperationPush){
        UIView *screenSnapshot = [[UIApplication sharedApplication].keyWindow snapshotViewAfterScreenUpdates:NO];
        [self.screenSnapshots addObject:screenSnapshot];
        [self pushViewControllerAnimation:transitionContext fromVC:fromVC toVC:toVC fromView:fromView toView:toView];
    } else {
        [self popViewControllerAnimation:transitionContext fromVC:fromVC toVC:toVC fromView:fromView toView:toView];
    }
}

#pragma mark push

-(void)pushViewControllerAnimation:(id<UIViewControllerContextTransitioning>)transitionContext fromVC:(UIViewController *)fromVC toVC:(UIViewController *)toVC fromView:(UIView *)fromView toView:(UIView *)toView {
    CGRect toFrame = [transitionContext finalFrameForViewController:toVC];
    NSTimeInterval duration = [self transitionDuration:transitionContext];
    
    UIView *tempFromView = [fromVC.tabBarController.view snapshotViewAfterScreenUpdates:NO]; //截取全屏图
    tempFromView.frame = [UIScreen mainScreen].bounds;
    UIView *tempView = [[UIView alloc]initWithFrame:[UIScreen mainScreen].bounds];//灰色蒙版
    tempView.backgroundColor = [UIColor clearColor];
    [tempFromView addSubview:tempView];
    fromView.hidden = YES; //截图代替fromview
    
    // 变暗  变小
    UIView* containerView = [transitionContext containerView];
    [containerView addSubview:tempFromView];
    [containerView addSubview:toView];
    
    BOOL hideTabbar = toVC.hidesBottomBarWhenPushed;
    fromVC.tabBarController.tabBar.alpha = !hideTabbar;
    
    __block CGAffineTransform fromTransform = CGAffineTransformMakeTranslation(toFrame.size.width, 0);
    fromVC.navigationController.navigationBar.transform = fromTransform;
    fromVC.tabBarController.tabBar.transform = fromTransform;
    toView.transform = fromTransform;
    
    [UIView animateWithDuration:duration  delay:0 options:UIViewAnimationOptionCurveEaseOut animations:^{
        tempFromView.transform = CGAffineTransformMakeScale(0.9, 0.9);
        tempView.backgroundColor = [UIColor colorWithWhite:0 alpha:0.5];
        
        fromVC.tabBarController.tabBar.transform = CGAffineTransformIdentity;
        fromVC.navigationController.navigationBar.transform = CGAffineTransformIdentity;
        toView.transform = CGAffineTransformIdentity;
    } completion:^(BOOL finished) {
        fromView.transform = CGAffineTransformIdentity;
        toView.transform = CGAffineTransformIdentity;
        fromVC.tabBarController.tabBar.transform = CGAffineTransformIdentity;
        fromVC.navigationController.navigationBar.transform = CGAffineTransformIdentity;
        fromVC.tabBarController.tabBar.alpha = !toVC.tabBarController.tabBar.hidden;
        fromVC.navigationController.navigationBar.alpha = !toVC.navigationController.navigationBar.hidden;
        
        toView.hidden = NO;
        fromView.hidden = NO;
        
        [tempView removeFromSuperview];
        [tempFromView removeFromSuperview];
        [transitionContext completeTransition:![transitionContext transitionWasCancelled]];
    }];
}

#pragma mark - pop

-(void)popViewControllerAnimation:(id<UIViewControllerContextTransitioning>)transitionContext fromVC:(UIViewController *)fromVC toVC:(UIViewController *)toVC fromView:(UIView *)fromView toView:(UIView *)toView {
    NSTimeInterval duration = [self transitionDuration:transitionContext];
    //fromView
    UIView *tempFromView = [fromVC.tabBarController.view snapshotViewAfterScreenUpdates:NO];
    tempFromView.frame = [UIScreen mainScreen].bounds;
    
    //toView
    UIView *tempView = [[UIView alloc]initWithFrame:[UIScreen mainScreen].bounds]; //遮罩
    tempView.backgroundColor = [UIColor colorWithWhite:0 alpha:0.5];
    UIView *tempToView = self.screenSnapshots.lastObject;
    [tempToView addSubview:tempView];
    CGAffineTransform transform = CGAffineTransformMakeScale(0.9, 0.9);
    tempToView.transform = transform;
    
    UIView* containerView = [transitionContext containerView];
    [containerView addSubview:toView];
    [containerView insertSubview:tempToView atIndex:0];
    [containerView addSubview:tempFromView];
    
    fromView.hidden = YES;
    toView.hidden = YES;
    fromVC.tabBarController.tabBar.alpha = 0;
    fromVC.navigationController.navigationBar.alpha = 0;
    
    [UIView animateWithDuration:duration delay:0 options:UIViewAnimationOptionCurveLinear animations:^{
        tempView.backgroundColor = [UIColor clearColor];
        tempToView.transform = CGAffineTransformIdentity;
        tempFromView.transform = CGAffineTransformMakeTranslation([UIScreen mainScreen].bounds.size.width, 0);
        
    }  completion:^(BOOL finished) {
        [tempView removeFromSuperview];
        [tempFromView removeFromSuperview];
        [tempToView removeFromSuperview];
        fromView.transform = CGAffineTransformIdentity;
        toView.transform = CGAffineTransformIdentity;
        fromView.hidden = NO;
        toView.hidden = NO;
        toVC.tabBarController.tabBar.alpha = !toVC.tabBarController.tabBar.hidden;
        toVC.navigationController.navigationBar.alpha = !toVC.navigationController.navigationBar.hidden;
        
        [transitionContext completeTransition:![transitionContext transitionWasCancelled]];
    }];
}

- (void)animationEnded:(BOOL)transitionCompleted {
    if (transitionCompleted) {
        if (self.operation == UINavigationControllerOperationPop) {
            [self.screenSnapshots removeLastObject];
        }
    }else {
        self.fromVC.tabBarController.tabBar.alpha = !self.fromVC.tabBarController.tabBar.hidden;
        self.fromVC.navigationController.navigationBar.alpha = !self.fromVC.navigationController.navigationBar.hidden;
    }
}

@end
