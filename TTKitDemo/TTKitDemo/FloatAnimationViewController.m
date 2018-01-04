//
//  FloatAnimationViewController.m
//  TTKitDemo
//
//  Created by apple on 2018/1/3.
//  Copyright © 2018年 shang. All rights reserved.
//

#import "FloatAnimationViewController.h"
#import "TTMacros.h"
#import "TTAnimationKit.h"

@interface FloatAnimationViewController ()

@property (nonatomic, strong) NSMutableArray *views;

@end



@implementation FloatAnimationViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.title = @"浮动效果";
    self.views = @[].mutableCopy;
    [self setupUI];
    [TTAnimationKit floatViews:self.views];
}
- (void)setupUI {
    self.view.backgroundColor = [UIColor groupTableViewBackgroundColor];
    for (NSInteger i = 0; i < 9; i++) {
        CGFloat margin =  30;
        CGFloat side = 55;
        CGFloat x = margin * (i%4+1) + side * (i%4);
        CGFloat y = margin * (i/4+1) + side * (i/4) + kStatusBarHeight + kNavBarHeight;
        CGRect frame = CGRectMake(x, y, side, side);
        UIView *view  = [[UIView alloc]initWithFrame:frame];
        view.layer.cornerRadius = side *0.5;
        view.layer.shadowOpacity = 0.7;
        view.layer.shadowOffset = CGSizeMake(3, 3);
        view.backgroundColor = kRandomColor;
        [self.view addSubview:view];
        [self.views addObject:view];
    }
}

@end
