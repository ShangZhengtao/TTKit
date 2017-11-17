//
//  PresentAnimator.h
//  TransitionDemo
//
//  Created by apple on 2017/9/18.
//  Copyright © 2017年 shang. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface PresentAnimator : NSObject <UIViewControllerAnimatedTransitioning>
/** 推出后的背景颜色*/
@property (nonatomic, strong) UIColor *presentedBackgroundColor;
@end
