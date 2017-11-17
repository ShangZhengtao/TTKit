//
//  PresentAnimator.m
//  TransitionDemo
//
//  Created by apple on 2017/9/18.
//  Copyright © 2017年 shang. All rights reserved.
//

#import "PresentAnimator.h"
#import "ZTPopUpViewController.h"
@implementation PresentAnimator

- (NSTimeInterval)transitionDuration:(id<UIViewControllerContextTransitioning>)transitionContext {
    return 0.3;
}

- (void)animateTransition:(id<UIViewControllerContextTransitioning>)transitionContext {
    
    UIViewController *fromViewController = [transitionContext viewControllerForKey:UITransitionContextFromViewControllerKey];
    UIViewController *toViewController = [transitionContext viewControllerForKey:UITransitionContextToViewControllerKey];
    
    UIView *containerView = transitionContext.containerView;
    // For a Presentation:
    //      fromView = The presenting view.
    //      toView   = The presented view.
    // For a Dismissal:
    //      fromView = The presented view.
    //      toView   = The presenting view.
    
    UIView *fromView = fromViewController.view;
    UIView *toView = toViewController.view;
    fromView.frame = [transitionContext initialFrameForViewController:fromViewController];
    toView.frame = [transitionContext finalFrameForViewController:toViewController];
    
    if (toViewController.isBeingPresented) { // present
        ZTPopUpViewController *toVC = (ZTPopUpViewController *)toViewController;
        
        [containerView addSubview:toView]; //require
        
        UIView *popView = toView.subviews.firstObject;
        CGFloat bottom = toView.bounds.size.height - popView.frame.origin.y;
        popView.transform = CGAffineTransformTranslate(popView.transform, 0, bottom);
        NSTimeInterval transitionDuration = [self transitionDuration:transitionContext];
        
        [UIView animateWithDuration:transitionDuration delay:0 options:UIViewAnimationOptionCurveEaseOut animations:^{
            toView.backgroundColor = self.presentedBackgroundColor;
            popView.transform = CGAffineTransformIdentity;
            
        } completion:^(BOOL finished) {
            BOOL wasCancelled = [transitionContext transitionWasCancelled];
            [transitionContext completeTransition:!wasCancelled];// require
            !toVC.popUpBlock ?: toVC.popUpBlock();
        }];
        
    }
    
    if (fromViewController.isBeingDismissed) { //dismiss
        ZTPopUpViewController *fromeVC = (ZTPopUpViewController *)fromViewController;
        UIView *popView = fromView.subviews.firstObject;
        NSTimeInterval transitionDuration = [self transitionDuration:transitionContext];
        
        [UIView animateWithDuration:transitionDuration  delay:0 options:UIViewAnimationOptionCurveEaseOut animations:^{
            fromView.backgroundColor = [UIColor clearColor];
            CGFloat bottom = toView.bounds.size.height - popView.frame.origin.y;
            popView.transform = CGAffineTransformTranslate(popView.transform, 0, bottom);
        } completion:^(BOOL finished) {
            
            BOOL wasCancelled = [transitionContext transitionWasCancelled];
            [transitionContext completeTransition:!wasCancelled];
            !fromeVC.dismissBlock ?: fromeVC.dismissBlock();
        }];
    }

}


@end
