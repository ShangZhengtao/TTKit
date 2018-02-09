//
//  AnimationKitViewController.m
//  TTKitDemo
//
//  Created by apple on 2018/1/3.
//  Copyright © 2018年 shang. All rights reserved.
//

#import "AnimationKitViewController.h"
#import "FloatAnimationViewController.h"

#import "ZHNShineButton.h"

@interface AnimationKitViewController ()

@end

@implementation AnimationKitViewController

- (void)viewDidLoad {
    [super viewDidLoad];
  
    ZHNShineButton *shineButton = [ZHNShineButton zhn_shineButtonWithTintColor:[UIColor colorWithRed:34/255.0 green:202/255.0 blue:253/255.0 alpha:1] normalImage:[UIImage imageNamed:@"tabbar_icon_home_sel"] hightLightImage:[UIImage imageNamed:@"tabbar_icon_home_sel"] normalTypeTapAction:^{
        NSLog(@"normal状态下响应   ");
        
    } hightLightTypeTapAction:^{
        NSLog(@"hightLight状态下响应  ");
    }];
    shineButton.frame = CGRectMake(230, 110, 50, 50);
    shineButton.isNeedAnimateEverytime = YES;
    [shineButton noAnimationHgihtLight];
//    shineButton.isCycleResponse = YES;
    shineButton.unconventionalImage = [UIImage imageNamed:@"tabbar_icon_video_sel"];
    [self.view addSubview:shineButton];
}

- (IBAction)floatAnimationButtonTapped:(UIButton *)sender {
    
    [self.navigationController pushViewController:[FloatAnimationViewController new] animated:YES];
}



@end
