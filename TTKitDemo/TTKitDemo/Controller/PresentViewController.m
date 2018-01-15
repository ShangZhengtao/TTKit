//
//  PresentViewController.m
//  TTKitDemo
//
//  Created by apple on 2018/1/12.
//  Copyright © 2018年 shang. All rights reserved.
//

#import "PresentViewController.h"
#import "OpenDoorAnimator.h"

@interface PresentViewController ()<UIViewControllerTransitioningDelegate>

@property (nonatomic, strong)UIButton *backButton;

@end

@implementation PresentViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.backButton = [[UIButton alloc]initWithFrame:CGRectMake(100, 100, 80, 50)];
    [self.backButton setTitle:@"dismiss" forState:UIControlStateNormal];
    [self.backButton setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
    [self.backButton addTarget:self action:@selector(backButtonTapped:) forControlEvents:UIControlEventTouchUpInside];
    self.view.backgroundColor = [UIColor darkGrayColor];
    [self.view addSubview:self.backButton];
    
    self.transitioningDelegate =  self;
}

- (void)backButtonTapped:(UIButton *)sender {
    [self dismissViewControllerAnimated:YES completion:nil];
}

- (nullable id <UIViewControllerAnimatedTransitioning>)animationControllerForPresentedController:(UIViewController *)presented presentingController:(UIViewController *)presenting sourceController:(UIViewController *)source {
    return [OpenDoorAnimator new];
}

- (nullable id <UIViewControllerAnimatedTransitioning>)animationControllerForDismissedController:(UIViewController *)dismissed {
    return [OpenDoorAnimator new];
}

@end
