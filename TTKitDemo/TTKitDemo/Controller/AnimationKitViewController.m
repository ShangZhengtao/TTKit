//
//  AnimationKitViewController.m
//  TTKitDemo
//
//  Created by apple on 2018/1/3.
//  Copyright © 2018年 shang. All rights reserved.
//

#import "AnimationKitViewController.h"
#import "FloatAnimationViewController.h"

@interface AnimationKitViewController ()

@end

@implementation AnimationKitViewController

- (void)viewDidLoad {
    [super viewDidLoad];
  
}

- (IBAction)floatAnimationButtonTapped:(UIButton *)sender {
    
    [self.navigationController pushViewController:[FloatAnimationViewController new] animated:YES];
}



@end
