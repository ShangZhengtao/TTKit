//
//  UIView+Corner.m
//  GoldLiving
//
//  Created by 海中金信息中心mac2 on 2017/8/19.
//  Copyright © 2017年 lhb. All rights reserved.
//

#import "UIView+Corner.h"

@implementation UIView (Corner)

- (void)setCircleCorner {
    
    CGFloat radius = MIN(self.bounds.size.width, self.bounds.size.height) * 0.5;
    [self setCornerWithRadius:radius];

}

- (void)setCornerWithRadius:(CGFloat)radius {
    
    self.layer.masksToBounds = YES;
    self.layer.cornerRadius = radius;
    
}

- (void)setCornerAtCorner:(UIRectCorner)corner withRadius:(CGFloat)radius {
    
    UIBezierPath *maskPath = [UIBezierPath bezierPathWithRoundedRect:self.bounds byRoundingCorners:corner cornerRadii:CGSizeMake(radius, radius)];
    CAShapeLayer *maskLayer = [[CAShapeLayer alloc] init];
    maskLayer.frame = self.bounds;
    maskLayer.path = maskPath.CGPath;
    self.layer.mask = maskLayer;
    
}

@end
