//
//  TTNavigationBar.m
//  TTKitDemo
//
//  Created by apple on 2018/3/5.
//  Copyright © 2018年 shang. All rights reserved.
//

#import "TTNavigationBar.h"

#ifndef TTStatusBarHeight
#define TTStatusBarHeight [[UIApplication sharedApplication] statusBarFrame].size.height
#endif

@interface TTNavigationBar()

@property (nonatomic, strong) UIImageView *backgroundImage;
@property (nonatomic, strong) UILabel *titleLabel;
@property (nonatomic, strong) UIButton *backButton;
@property (nonatomic, weak) UIViewController *vc;

@end

@implementation TTNavigationBar

- (instancetype)initWithFrame:(CGRect)frame {
    self = [super initWithFrame:frame];
    if (self) {
        CGFloat height = TTStatusBarHeight + 44;
        self.frame = CGRectMake(0, 0, [UIScreen mainScreen].bounds.size.width, height);
        self.backgroundColor = [UIColor whiteColor];
        [self addSubview:self.backgroundImage];
        [self addSubview:self.backButton];
        [self addSubview:self.titleLabel];
    }
    return self;
}

- (void)layoutSubviews {
    [super layoutSubviews];
    
    CGFloat titleW = _titleLabel.bounds.size.width;
    CGFloat titleH = _titleLabel.bounds.size.height;
    _titleLabel.frame = CGRectMake(self.center.x - titleW * 0.5, TTStatusBarHeight + (44 - titleH)*0.5, titleW, titleH);
     _backButton.frame = CGRectMake(10, TTStatusBarHeight + (44 - 40)*0.5,40, 40);
    _backgroundImage.frame = self.bounds;
}

#pragma mark - lazyload

- (UILabel *)titleLabel {
    if (!_titleLabel) {
        _titleLabel = [[UILabel alloc]init];
        _titleLabel.text = self.vc.title;
        _titleLabel.font = [UIFont systemFontOfSize:10];
        [_titleLabel sizeToFit];
    }
    return _titleLabel;
}

- (UIButton *)backButton {
    if(!_backButton) {
        _backButton = [[UIButton alloc]init];
        [_backButton setTitle:@"返回" forState:UIControlStateNormal];
        [_backButton addTarget:self action:@selector(backButtonTapped:) forControlEvents:UIControlEventTouchUpInside];
    }
    return _backButton;
}

- (UIImageView *)backgroundImage {
    if (!_backgroundImage) {
        _backgroundImage = [[UIImageView alloc]init];
    }
    return _backgroundImage;
}

- (void)backButtonTapped:(UIButton *)sender {
    if (self.vc.navigationController.childViewControllers.count > 1) {
       [self.vc.navigationController popViewControllerAnimated:YES];
    }else {
        [self.vc dismissViewControllerAnimated:YES completion:nil];
    }
    
}


@end
