//
//  UIViewController+TTModalTransition.m
//  TTKitDemo
//
//  Created by apple on 2018/1/15.
//  Copyright © 2018年 shang. All rights reserved.
//

#import "UIViewController+TTModalTransition.h"
#import <objc/runtime.h>
#import "TTModalDelegate.h"

@interface UIViewController()
@property (nonatomic, strong)id<UIViewControllerTransitioningDelegate> tt_delegate;
@end

@implementation UIViewController (TTModalTransition)

- (void)setTt_modalTransitionStyle:(TTModalTransitionStyle)tt_modalTransitionStyle {
    objc_setAssociatedObject(self, @selector(tt_modalTransitionStyle), @(tt_modalTransitionStyle), OBJC_ASSOCIATION_ASSIGN);
    TTModalDelegate *delegate = [[TTModalDelegate alloc]init];
    delegate.transitionStyle = tt_modalTransitionStyle;
    self.tt_delegate = delegate;
    self.transitioningDelegate = delegate;
}

- (TTModalTransitionStyle)tt_modalTransitionStyle {
    return [objc_getAssociatedObject(self, _cmd) integerValue];
}

- (void)setTt_delegate:(id<UIViewControllerTransitioningDelegate>)delegate {
    objc_setAssociatedObject(self, @selector(tt_delegate), delegate, OBJC_ASSOCIATION_RETAIN_NONATOMIC);
}

- (id<UIViewControllerTransitioningDelegate>) tt_delegate {
    return objc_getAssociatedObject(self, _cmd);
}




@end
