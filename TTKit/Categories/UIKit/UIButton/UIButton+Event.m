//
//  UIButton+Event.m
//  TTKitDemo
//
//  Created by apple on 2018/1/4.
//  Copyright © 2018年 shang. All rights reserved.
//

#import "UIButton+Event.h"
#import <objc/runtime.h>

@interface UIButton ()

@property (nonatomic, assign) BOOL isIgnoreEvent;

@end

@implementation UIButton (Event)

- (BOOL)isIgnoreEvent {
    return [objc_getAssociatedObject(self, _cmd) boolValue];
}

- (void)setIsIgnoreEvent:(BOOL)isIgnoreEvent {
    objc_setAssociatedObject(self, @selector(isIgnoreEvent), @(isIgnoreEvent), OBJC_ASSOCIATION_RETAIN_NONATOMIC);
}

- (NSTimeInterval)eventTimeInterval {
    return [objc_getAssociatedObject(self, _cmd) doubleValue];
}

- (void)setEventTimeInterval:(NSTimeInterval)eventTimeInterval {
    objc_setAssociatedObject(self, @selector(eventTimeInterval), @(eventTimeInterval), OBJC_ASSOCIATION_RETAIN_NONATOMIC);
}

+ (void)load {
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        SEL systemSEL = @selector(sendAction:to:forEvent:);
        SEL replaceSEL = @selector(mySendAction:to:forEvent:);
        Method systemMethod = class_getInstanceMethod(self, systemSEL);
        Method replaceMethod = class_getInstanceMethod(self, replaceSEL);
        
        BOOL isAdd = class_addMethod(self, systemSEL, method_getImplementation(replaceMethod), method_getTypeEncoding(replaceMethod));
        
        if (isAdd) {
            class_replaceMethod(self, replaceSEL, method_getImplementation(systemMethod), method_getTypeEncoding(systemMethod));
        } else {
            // 添加失败，说明本类中有 replaceMethod 的实现，此时只需要将 systemMethod 和 replaceMethod 的IMP互换一下即可
            method_exchangeImplementations(systemMethod, replaceMethod);
        }
    });
}

- (void)mySendAction:(SEL)action to:(id)target forEvent:(UIEvent *)event {
    if (self.isIgnoreEvent){
        return;
    } else if (self.eventTimeInterval > 0) {
        dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(self.eventTimeInterval * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
            [self setIsIgnoreEvent:NO];
        });
        self.isIgnoreEvent = YES;
    }
    [self mySendAction:action to:target forEvent:event];
}

@end

