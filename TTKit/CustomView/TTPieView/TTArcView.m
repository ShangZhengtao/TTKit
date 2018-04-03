//
//  TTArcView.m
//  PieDemo
//
//  Created by apple on 2018/3/29.
//  Copyright © 2018年 Shang. All rights reserved.
//

#import "TTArcView.h"

@interface TTArcView()<CAAnimationDelegate>

//@property (nonatomic, strong) UIBezierPath *path;
//@property (nonatomic, strong) UIBezierPath *startPath;
//@property (nonatomic, strong) UIBezierPath *endPath;
@property (nonatomic, strong) CAShapeLayer *maskLayer;

@end

@implementation TTArcView

//- (UIBezierPath *)startPath {
//    if (!_startPath) {
//        _startPath = [self configPathWithScale:0.001];
//    }
//    return _startPath;
//}
//
//
//- (UIBezierPath *)endPath {
//    if (!_endPath) {
//        _endPath = [self configPathWithScale:self.scale];
//    }
//    return _endPath;
//}


//- (UIBezierPath *)configPathWithScale:(CGFloat)scale {
//    CGFloat radius = MIN(self.bounds.size.width, self.bounds.size.height) * 0.5;
//    CGPoint center = CGPointMake(self.bounds.size.width * 0.5, self.bounds.size.height * 0.5);
//    CGFloat startRadian = self.startScale * M_PI * 2; //开始弧度
//    CGFloat endRadian = (self.startScale + scale) * M_PI *2; //结束弧度
//    //绘制圆环
//    UIBezierPath *path = [UIBezierPath bezierPath];
//    [path addArcWithCenter:center radius:radius startAngle: startRadian endAngle:endRadian clockwise:YES];
//    CGPoint point1 = [self getCirclePointWithCenter:center radius:radius * self.holeScale radian:endRadian];
//    [path addLineToPoint:point1];
//    [path addArcWithCenter:center radius:radius * self.holeScale startAngle:endRadian endAngle:startRadian  clockwise:NO];
//    [path closePath];
//
//    return path;
//}

- (instancetype)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        self.startScale = 0;
        self.scale = 0.3;
        self.holeScale = 0.5;
        UITapGestureRecognizer *tap = [[UITapGestureRecognizer alloc]initWithTarget:self action:@selector(tapAction:)];
        [self addGestureRecognizer:tap];
    }
    return self;
}

- (void)layoutSubviews {
    [super layoutSubviews];
    double radius = MIN(self.bounds.size.width, self.bounds.size.height) * 0.5;
    CGPoint center = CGPointMake(self.bounds.size.width * 0.5, self.bounds.size.height * 0.5);
    CGFloat startRadian = self.startScale * M_PI * 2; //开始弧度
    CGFloat endRadian = (self.startScale + self.scale) * M_PI *2; //结束弧度
    //绘制圆环
    CAShapeLayer *masklayer = [CAShapeLayer layer];
    masklayer.frame         = self.bounds;
    masklayer.fillColor     = [UIColor clearColor].CGColor;
    masklayer.strokeColor   = [UIColor redColor].CGColor;
    masklayer.lineWidth     = (1 - _holeScale) * radius;
    masklayer.strokeEnd     = 0; //默认不显示
    //粗圆弧线方案
    UIBezierPath *linePath = [UIBezierPath bezierPathWithArcCenter:center radius:radius * (1 + _holeScale) * 0.5 startAngle:startRadian endAngle:endRadian clockwise:YES];
    masklayer.path = linePath.CGPath;
    
    self.layer.mask = masklayer;
    self.maskLayer = masklayer;
    [self animatedArc:masklayer];

}

- (void)animatedArc:(CAShapeLayer *)maskLayer {
    
    CABasicAnimation *animation = [CABasicAnimation animationWithKeyPath:@"strokeEnd"];
    CGFloat totalDuration = 3;//完成圆周动画总时间
    animation.beginTime = CACurrentMediaTime() + totalDuration*self.startScale;
    animation.duration = totalDuration*self.scale;
    animation.repeatCount = 1;
    animation.fromValue = @(0);
    animation.toValue   = @(1);
    animation.removedOnCompletion = NO;
    animation.fillMode = kCAFillModeForwards;
    animation.delegate = self;
    [maskLayer addAnimation:animation forKey:@""];
    
}


- (void)tapAction:(UITapGestureRecognizer *)sender {
//    NSLog(@"%ld",self.tag);
    CGFloat distance = 10;//偏移距离
    CGFloat x, y;
    CGFloat θ = (self.startScale + self.scale * 0.5) * 2 * M_PI; //向量角度
    x = distance * cos(θ);
    y = distance * sin(θ);
    
    CGAffineTransform t = CGAffineTransformMakeScale(1.05, 1.05);
    t = CGAffineTransformTranslate(t, x, y);
    [UIView animateWithDuration:0.3 animations:^{
        if (CGAffineTransformEqualToTransform(CGAffineTransformIdentity, self.transform)) {
            self.transform = t;
        }else {
            self.transform = CGAffineTransformIdentity;
        }
    }];
}

- (BOOL)pointInside:(CGPoint)point withEvent:(UIEvent *)event {
    UIColor *color = [self colorOfPoint:point];
    CGFloat w,alpha;
    [color getWhite:&w alpha:&alpha];
    return alpha;
}

#pragma mark - Private

/**
 获取圆周上的点坐标
 以正东面为0度起点计算指定角度所对应的圆周上的点的坐标：
 http://www.cnblogs.com/weilaikeji/p/3253893.html
 
 @param center 圆心坐标
 @param radius 半径
 @param radian 弧度
 @return 点坐标
 */
- (CGPoint)getCirclePointWithCenter:(CGPoint)center radius:(CGFloat)radius radian:(CGFloat)radian {
    
    float x = center.x + cos(radian)*radius;
    
    float y = center.y + sin(radian)*radius;
    
    return CGPointMake(x, y);;
}

/**
 获取view 指定点的颜色
 */
- (UIColor *)colorOfPoint:(CGPoint)point {
    unsigned char pixel[4] = {0};
    CGColorSpaceRef colorSpace = CGColorSpaceCreateDeviceRGB();
    CGContextRef context = CGBitmapContextCreate(pixel, 1, 1, 8, 4, colorSpace, (CGBitmapInfo)kCGImageAlphaPremultipliedLast);
    CGContextTranslateCTM(context, -point.x, -point.y);
    [self.layer renderInContext:context];
    CGContextRelease(context);
    CGColorSpaceRelease(colorSpace);
    
    UIColor *color = [UIColor colorWithRed:pixel[0]/255.0 green:pixel[1]/255.0 blue:pixel[2]/255.0 alpha:pixel[3]/255.0];
    return color;
}
//动画回调
- (void)animationDidStop:(CAAnimation *)anim finished:(BOOL)flag {
    //    self.maskLayer.path = self.endPath.CGPath;
    self.maskLayer.strokeEnd = 1;
}

@end
