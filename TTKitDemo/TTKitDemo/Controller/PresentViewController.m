//
//  PresentViewController.m
//  TTKitDemo
//
//  Created by apple on 2018/1/12.
//  Copyright © 2018年 shang. All rights reserved.
//

#import "PresentViewController.h"
#import "UIViewController+TTModalTransition.h"
#import "PresentOpenDoorViewController.h"
#import "PresentGradientViewController.h"
#import "PresentCircleViewController.h"
@interface PresentViewController ()

@property (nonatomic, strong) UIButton *backButton;
@property (nonatomic, strong) UIImageView *imageView;

@end

@implementation PresentViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.imageView = [[UIImageView alloc]initWithFrame:[UIScreen mainScreen].bounds];
    self.imageView.image = [UIImage imageNamed:@"img02"];
    [self.view addSubview:self.imageView];
    
    self.view.backgroundColor = [UIColor whiteColor];
    self.backButton = [[UIButton alloc]initWithFrame:CGRectMake(150, 300, 80, 50)];
    self.backButton.backgroundColor = [UIColor redColor];
    [self.backButton setTitle:@"返回" forState:UIControlStateNormal];
    [self.backButton setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
    [self.backButton addTarget:self action:@selector(backButtonTapped:) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:self.backButton];
    
    UIButton *presentButton1 = [[UIButton alloc]initWithFrame:CGRectMake(50, 200, 80, 50)];
    [presentButton1 setTitle:@"样式一" forState:UIControlStateNormal];
    presentButton1.tag = 1;
    presentButton1.backgroundColor = [UIColor groupTableViewBackgroundColor];
    [presentButton1 setTitleColor:[UIColor blueColor] forState:UIControlStateNormal];
    [presentButton1 addTarget:self action:@selector(presentButton:) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:presentButton1];
    
    UIButton *presentButton2 = [[UIButton alloc]initWithFrame:CGRectMake(160, 200, 80, 50)];
    [presentButton2 setTitle:@"样式二" forState:UIControlStateNormal];
    presentButton2.tag = 2;
    presentButton2.backgroundColor = [UIColor groupTableViewBackgroundColor];
    [presentButton2 setTitleColor:[UIColor blueColor] forState:UIControlStateNormal];
    [presentButton2 addTarget:self action:@selector(presentButton:) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:presentButton2];
    
    UIButton *presentButton3 = [[UIButton alloc]initWithFrame:CGRectMake(270, 200, 80, 50)];
    [presentButton3 setTitle:@"样式三" forState:UIControlStateNormal];
    presentButton3.tag = 3;
    presentButton3.backgroundColor = [UIColor groupTableViewBackgroundColor];
    [presentButton3 setTitleColor:[UIColor blueColor] forState:UIControlStateNormal];
    [presentButton3 addTarget:self action:@selector(presentButton:) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:presentButton3];
}

- (void)backButtonTapped:(UIButton *)sender {
    [self dismissViewControllerAnimated:YES completion:nil];
}

- (void)presentButton:(UIButton *)sender {
    
    if (sender.tag == 1) {
        PresentOpenDoorViewController *vc = [[PresentOpenDoorViewController alloc]init];
        vc.tt_modalTransitionStyle = TTModalTransitionStyleOpenDoor;
        [self presentViewController:vc animated:YES completion:nil];
    }else if (sender.tag == 2) {
        PresentGradientViewController *vc = [[PresentGradientViewController alloc]init];
        vc.tt_modalTransitionStyle = TTModalTransitionStyleGradient;
        [self presentViewController:vc animated:YES completion:nil];
    }else {
        PresentCircleViewController *vc = [[PresentCircleViewController alloc]init];
        vc.tt_modalTransitionStyle = TTModalTransitionStyleCircleZoom;
        [self presentViewController:vc animated:YES completion:nil];
    }
}

@end
