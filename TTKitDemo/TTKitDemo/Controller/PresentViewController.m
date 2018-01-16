//
//  PresentViewController.m
//  TTKitDemo
//
//  Created by apple on 2018/1/12.
//  Copyright © 2018年 shang. All rights reserved.
//

#import "PresentViewController.h"
#import "OpenDoorAnimator.h"
#import "UIViewController+TTModalTransition.h"
@interface PresentViewController ()

@property (nonatomic, strong)UIButton *backButton;

@property (nonatomic, strong) UIImageView *imageView;

@end

@implementation PresentViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.imageView = [[UIImageView alloc]initWithFrame:[UIScreen mainScreen].bounds];
    self.imageView.image = [UIImage imageNamed:@"img01"];
    [self.view addSubview:self.imageView];
    
    self.backButton = [[UIButton alloc]initWithFrame:CGRectMake(100, 300, 80, 50)];
    [self.backButton setTitle:@"dismiss" forState:UIControlStateNormal];
    [self.backButton setTitleColor:[UIColor blueColor] forState:UIControlStateNormal];
    [self.backButton addTarget:self action:@selector(backButtonTapped:) forControlEvents:UIControlEventTouchUpInside];
    self.view.backgroundColor = [UIColor darkGrayColor];
    [self.view addSubview:self.backButton];
    
//    self.tt_modalTransitionStyle = TTModalTransitionStyleOpenDoor;
}

- (void)backButtonTapped:(UIButton *)sender {
    [self dismissViewControllerAnimated:YES completion:nil];
}


@end
