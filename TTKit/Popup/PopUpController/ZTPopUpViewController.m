//
//  PopUpViewController.m
//  TransitionDemo
//
//  Created by apple on 2017/9/18.
//  Copyright © 2017年 shang. All rights reserved.
//

#import "ZTPopUpViewController.h"
#import "PresentAnimator.h"
@interface ZTPopUpViewController ()<UIViewControllerTransitioningDelegate>
/** dismiss手势*/
@property (nonatomic, strong) UITapGestureRecognizer *tap;
@end

@implementation ZTPopUpViewController

#pragma mark - initMethod

- (void)commonInit{
    self.modalPresentationStyle = UIModalPresentationCustom;
    self.transitioningDelegate = self;
    self.presentedBackgroundColor = [UIColor colorWithWhite:0 alpha:0.3];
    self.tapBackgroundDismiss = YES;
}

- (instancetype)initWithCoder:(NSCoder *)aDecoder{
    if (self = [super initWithCoder:aDecoder]) {
        [self commonInit];
    }
    return self;
}

- (instancetype)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil {
    if (self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil]) {
        [self commonInit];
    }
    return self;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    self.view.backgroundColor = [UIColor clearColor];
    if(self.tapBackgroundDismiss){
        self.tap = [[UITapGestureRecognizer alloc]initWithTarget:self action:@selector(disMissTapped:)];
//        self.tap.delegate = self;
        self.tap.cancelsTouchesInView = NO;
        [self.view addGestureRecognizer:self.tap];
        
    }
}

/**
 点击背景 dismiss

 @param tap 手势
 */
- (void)disMissTapped:(UITapGestureRecognizer *)tap {
    if (!self.tapBackgroundDismiss){return;}
    [self.view endEditing:YES];
    CGPoint point = [tap locationInView:self.view];
    if (!CGRectContainsPoint(self.view.subviews.firstObject.frame, point)) { //targetView outside;
        [self dismissViewControllerAnimated:YES completion:nil];
    }

}

//- (BOOL)gestureRecognizerShouldBegin:(UIGestureRecognizer *)gestureRecognizer {
//    if (gestureRecognizer != self.tap) {
//        return YES;
//    }
//    CGPoint point = [gestureRecognizer locationInView:self.view];
//    if (CGRectContainsPoint(self.view.subviews.firstObject.frame, point)) { //targetView outside;
//        return NO;
//
//    }else{
//        return YES;
//    }
//}

#pragma mark - UIViewControllerTransitioningDelegate

- (nullable id <UIViewControllerAnimatedTransitioning>)animationControllerForPresentedController:(UIViewController *)presented presentingController:(UIViewController *)presenting sourceController:(UIViewController *)source{
    if (![presented isKindOfClass:[ZTPopUpViewController class]]) {
        return nil;
    }
    PresentAnimator *animator = [[PresentAnimator alloc]init];
    animator.presentedBackgroundColor = self.presentedBackgroundColor;
    return animator;
}

- (nullable id <UIViewControllerAnimatedTransitioning>)animationControllerForDismissedController:(UIViewController *)dismissed{
    PresentAnimator *animator = [[PresentAnimator alloc]init];
    animator.presentedBackgroundColor = self.presentedBackgroundColor;
    return animator;
}

@end
