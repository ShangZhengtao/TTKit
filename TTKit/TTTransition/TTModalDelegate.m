//
//  TTModalDelegate.m
//  TTKitDemo
//
//  Created by apple on 2018/1/15.
//  Copyright © 2018年 shang. All rights reserved.
//

#import "TTModalDelegate.h"
#import "TTModalAnimator.h"
@implementation TTModalDelegate

- (nullable id <UIViewControllerAnimatedTransitioning>)animationControllerForPresentedController:(UIViewController *)presented presentingController:(UIViewController *)presenting sourceController:(UIViewController *)source {
    if (self.transitionStyle == TTModalTransitionStyleDefault)  return nil;
    TTModalAnimator *animatior = [[TTModalAnimator alloc]init];
    animatior.style = self.transitionStyle;
    return animatior;
}

- (nullable id <UIViewControllerAnimatedTransitioning>)animationControllerForDismissedController:(UIViewController *)dismissed {
    if (self.transitionStyle == TTModalTransitionStyleDefault)  return nil;
    TTModalAnimator *animatior = [[TTModalAnimator alloc]init];
    animatior.style = self.transitionStyle;
    return animatior;
}


@end
