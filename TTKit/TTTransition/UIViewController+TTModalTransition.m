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

NSString *const kTTTouchEventPointXKey = @"kTTTouchEventPointXKey";
NSString *const kTTTouchEventPointYKey = @"kTTTouchEventPointYKey";

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

@implementation UIApplication (TTEvent)

+ (void)load{
    Class application = NSClassFromString(@"UIApplication");
    [self swizzleMethod:application originmethod:@selector(sendEvent:) newMethod:@selector(mySendEvent:)];
}

+ (void)swizzleMethod:(Class)targetClass originmethod:(SEL) origin newMethod:(SEL) new{
    Method originMethod =  class_getInstanceMethod(targetClass, origin);
    Method newMethod = class_getInstanceMethod(targetClass, new);
    //已经存在返回NO 添加成功返回 YES
    BOOL hasAdd = class_addMethod(targetClass, origin, method_getImplementation(newMethod), method_getTypeEncoding(newMethod));
    if (hasAdd) {
        //原始方法的实现不存在 被添加上新的方法实现 新方法替换为空实现
        id block = ^(id self){
            
        };
        IMP imp =  imp_implementationWithBlock(block);
        class_replaceMethod(targetClass, new, imp, method_getTypeEncoding(originMethod));
    }else {
        method_exchangeImplementations(originMethod, newMethod);
    }
}

- (void)mySendEvent:(UIEvent *)event {
    UITouch *touch = event.allTouches.anyObject;
    CGPoint point = [touch locationInView:nil];
    [[NSUserDefaults standardUserDefaults] setValue:@(point.x) forKey:kTTTouchEventPointXKey];
    [[NSUserDefaults standardUserDefaults] setValue:@(point.y) forKey:kTTTouchEventPointYKey];
    [[NSUserDefaults standardUserDefaults] synchronize];
    [self mySendEvent:event];
}

@end;
