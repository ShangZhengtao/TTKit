//
//  BaseTouchTableViewCell.m
//  TTKitDemo
//
//  Created by apple on 2018/2/11.
//  Copyright © 2018年 shang. All rights reserved.
//

#import "BaseTouchTableViewCell.h"
#import "YYKit.h"
@interface BaseTouchTableViewCell()

@property (nonatomic,strong) NSTimer *touchTimer;
@property (nonatomic,assign) BOOL isLongPress;

@end

@implementation BaseTouchTableViewCell

- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier {
    if (self = [super initWithStyle:style reuseIdentifier:reuseIdentifier]) {
        self.selectionStyle = UITableViewCellSelectionStyleNone;
    }
    return self;
}

- (void)awakeFromNib {
    [super awakeFromNib];
     self.selectionStyle = UITableViewCellSelectionStyleNone;
}

#pragma mark - touch event
- (void)touchesBegan:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event {
    self.isLongPress = NO;
//    [self.touchTimer invalidate];
//    @weakify(self);
//    self.touchTimer = [NSTimer timerWithTimeInterval:1 repeats:NO block:^(NSTimer * _Nonnull timer) {
//        @strongify(self);
//        self.isLongPress = YES;
//    }];
//    [self.touchTimer fire];

    dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(0.5 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
        self.isLongPress = YES;
    });

    [super touchesBegan:touches withEvent:event];
    UITouch *touch = [touches anyObject];
    CGPoint touchPoint = [touch locationInView:self];
    UIView *touchView = [self p_touchingViewForTouches:touches event:event];
    [self touchingAnimateForView:touchView touchPoint:touchPoint];
   
}

//- (void)touchesEnded:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event {
//    [super touchesBegan:touches withEvent:event];
////    [self.touchTimer invalidate];
//    UITouch *touch = [touches anyObject];
//    CGPoint touchPoint = [touch locationInView:self];
//    UIView *touchView = [self p_touchingViewForTouches:touches event:event];
//    if (!self.isLongPress) {
//        [self tapCellInView:touchView point:touchPoint];
//    }else {
//        [self longPressCellInView:touchView point:touchPoint];
//    }
//}


- (UIView *)p_touchingViewForTouches:(NSSet<UITouch *> *)touches event:(UIEvent *)event {
    UITouch *touch = [touches anyObject];
    CGPoint touchPoint = [touch locationInView:self];
    UIView *view = [self hitTest:touchPoint withEvent:event];
    if ([view isKindOfClass:NSClassFromString(@"UITableViewCellContentView")]) {
        view = self;
    }
    return view;
}

- (void)touchingAnimateForView:(UIView *)view touchPoint:(CGPoint)touchPoint {
    
    UIView *needScaleView = view;
    UIView *needColorView = view;
    UIColor *startColor = view.backgroundColor;
//    if ([self.headView.subviews containsObject:view] || [view isKindOfClass:[ZHNProfileView class]]) {
//        needScaleView = self;
//    }
//    if ([view isKindOfClass:[YYLabel class]]) {
//        needScaleView = self;
//    }
//    if (CGRectContainsPoint(self.reweetBackView.frame, touchPoint) && [view isEqual:self.reweetStatuTextLabel]) {
//        needColorView = self.reweetBackView;
//        startColor = self.reweetBackView.backgroundColor;
//    }
    [UIView animateWithDuration:0.15 animations:^{
        needScaleView.transform = CGAffineTransformMakeScale(0.97, 0.97);
        CGFloat h,s,b,a;
        [startColor getHue:&h saturation:&s brightness:&b alpha:&a];
        UIColor *darkcolor = [UIColor colorWithHue:h saturation:s - 0.1 brightness:b alpha:a];
        needColorView.backgroundColor = darkcolor;
    } completion:^(BOOL finished) {
        dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(0.15 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
            [UIView animateWithDuration:0.15 animations:^{
                needScaleView.transform = CGAffineTransformIdentity;
                needColorView.backgroundColor = startColor;
            }];
        });
    }];
}
- (void)tapCellInView:(UIView *)view point:(CGPoint)tapPoint{
    NSLog(@"%s",__func__);
}
- (void)longPressCellInView:(UIView *)view point:(CGPoint)point{
    NSLog(@"%s",__func__);
}

@end
