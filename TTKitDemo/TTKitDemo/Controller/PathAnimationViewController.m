//
//  PathAnimationViewController.m
//  TTKitDemo
//
//  Created by apple on 2018/1/3.
//  Copyright © 2018年 shang. All rights reserved.
//

#import "PathAnimationViewController.h"
#import "TTAnimationKit.h"
@interface PathAnimationViewController ()
@property (weak, nonatomic) IBOutlet UIView *animationView;
@property (nonatomic, strong) UIView *borderView;

@property (nonatomic, strong) UIBezierPath *path;
@property (nonatomic, weak) CAShapeLayer *shapLayer;
@end

@implementation PathAnimationViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.animationView.frame = CGRectMake(50, 100, 100, 100);
    self.animationView.layer.cornerRadius = 15;
    self.animationView.backgroundColor = [UIColor brownColor];
    
    self.borderView = [[UIView alloc]initWithFrame:CGRectMake(50, 250, 150, 50)];
    self.borderView.backgroundColor = [UIColor brownColor];
    self.borderView.layer.cornerRadius = 25;
    [self.view addSubview:self.borderView];
    self.view.backgroundColor = [UIColor blackColor];
    self.title = @"轨迹动画";
}
- (void)viewDidLayoutSubviews {
    [super viewDidLayoutSubviews];

    [TTAnimationKit pathAnimationForView:self.animationView color:[UIColor greenColor] duration:3];
    [TTAnimationKit borderGradientAnimationForView:self.borderView color:[UIColor whiteColor] duration:1.5];
}

@end
