//
//  PresentOpenDoorViewController.m
//  TTKitDemo
//
//  Created by apple on 2018/1/16.
//  Copyright © 2018年 shang. All rights reserved.
//

#import "PresentOpenDoorViewController.h"

@interface PresentOpenDoorViewController ()
@property (nonatomic, strong) UIImageView *imageView;
@property (nonatomic, strong)UIButton *backButton;
@end

@implementation PresentOpenDoorViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.imageView = [[UIImageView alloc]initWithFrame:[UIScreen mainScreen].bounds];
    self.imageView.image = [UIImage imageNamed:@"img01"];
    [self.view addSubview:self.imageView];
    
    self.view.backgroundColor = [UIColor whiteColor];
    self.backButton = [[UIButton alloc]initWithFrame:CGRectMake(150, 350, 80, 50)];
    self.backButton.backgroundColor = [UIColor redColor];
    [self.backButton setTitle:@"返回" forState:UIControlStateNormal];
    [self.backButton setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
    [self.backButton addTarget:self action:@selector(backButtonTapped:) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:self.backButton];
    
}



- (void)backButtonTapped:(UIButton *)sender {
    [self dismissViewControllerAnimated:YES completion:nil];
}

@end
