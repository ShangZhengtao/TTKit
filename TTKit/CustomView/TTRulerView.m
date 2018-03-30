//
//  TTRulerView.m
//  RulerDemo
//
//  Created by apple on 2018/3/28.
//  Copyright © 2018年 Shang. All rights reserved.
//

#import "TTRulerView.h"
@interface TTRulerView ()<UIScrollViewDelegate>

@property (nonatomic, strong) UIScrollView *scrollView;
@property (nonatomic, strong) UIView *middleLineView;
@property (nonatomic, strong) CAShapeLayer *rulerLayer;

@end

@implementation TTRulerView

#pragma mark - lazyload

- (UIScrollView *)scrollView {
    if (!_scrollView) {
        _scrollView = [[UIScrollView alloc]init];
        _scrollView.delegate = self;
        _scrollView.showsHorizontalScrollIndicator = NO;
        _scrollView.showsVerticalScrollIndicator = NO;
    }
    return _scrollView;
}

- (UIView *)middleLineView {
    if (!_middleLineView) {
        _middleLineView = [[UIView alloc]init];
        _middleLineView.backgroundColor = [UIColor redColor];
        _middleLineView.layer.cornerRadius = 0.5;
    }
    return _middleLineView;
}

#pragma mark - InitMethod

- (instancetype)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        [self commonInit];
    }
    return self;
}

- (instancetype)initWithCoder:(NSCoder *)coder
{
    self = [super initWithCoder:coder];
    if (self) {
        [self commonInit];
    }
    return self;
}

- (void)commonInit {
    self.textFont = [UIFont systemFontOfSize:10];
    self.space = 5;
    self.lineWidth = 1;
    self.smallLineHeight = 8;
    self.bigLineHeight = 14;
    self.times = 1;
    self.minValue = 0;
    self.maxValue = 100;
    _currentValue = self.minValue;
    [self addSubview:self.scrollView];
    [self addSubview:self.middleLineView];
}

- (void)layoutSubviews {
    [super layoutSubviews];
    self.scrollView.frame = self.bounds;
    self.middleLineView.bounds = CGRectMake(0, 0, 1, self.bounds.size.height);
    self.middleLineView.center = self.scrollView.center;
    [self updateRuler:self.maxValue];
    [self setCurrentValue:self.minValue animated:NO];
}

- (void)updateRuler:(NSInteger)amount {
    
    self.scrollView.contentSize = CGSizeMake((amount-self.minValue) *_space +self.scrollView.bounds.size.width, self.scrollView.bounds.size.height);
    
    [self.rulerLayer removeFromSuperlayer];
    CAShapeLayer *layer = [CAShapeLayer layer]; //刻度线
    layer.strokeColor = [UIColor blackColor].CGColor; //刻度线颜色
    layer.lineWidth = self.lineWidth;
    layer.lineCap = kCALineCapRound;
    layer.frame = CGRectMake(self.scrollView.bounds.size.width * 0.5, 0, (amount- self.minValue) *_space, self.scrollView.contentSize.height);
    self.rulerLayer = layer;
    [self.scrollView.layer addSublayer:layer];
    
    UIBezierPath *path = [UIBezierPath bezierPath];
    for (NSInteger i = 0; i <= amount-self.minValue; i++) {
        
        [path moveToPoint:CGPointMake(i*_space, layer.bounds.size.height)];
        if (i%10) {
            //小刻度
            [path addLineToPoint:CGPointMake(i*_space, layer.bounds.size.height -_smallLineHeight)];
        }else{
            //大刻度
            [path addLineToPoint:CGPointMake(i*_space, layer.bounds.size.height -_bigLineHeight)];
            //文本
            CATextLayer *textLayer = [CATextLayer layer];
            //            textLayer.backgroundColor = [UIColor whiteColor].CGColor;
            textLayer.alignmentMode = kCAAlignmentCenter;
            textLayer.contentsScale = [UIScreen mainScreen].scale;
            textLayer.string = [NSString stringWithFormat:@"%ld",(i+self.minValue)*_times];
            textLayer.fontSize = self.textFont.pointSize;
            textLayer.font = (__bridge CFTypeRef _Nullable)(self.textFont.fontName);
            textLayer.foregroundColor = [UIColor blackColor].CGColor;//文字颜色
            CGSize textSize =  [textLayer.string sizeWithAttributes:@{NSFontAttributeName : self.textFont}];
            CGFloat textW = textSize.width;
            CGFloat textH = textSize.height;
            textLayer.bounds = CGRectMake(0, 0, textW, textH);
            textLayer.position = CGPointMake(i*_space, layer.bounds.size.height - _bigLineHeight - textH *0.5 - 5);
            [layer addSublayer:textLayer];
        }
    }
    layer.path = path.CGPath;
}
#pragma mark - 矫正刻度
- (void)scrollViewDidEndDecelerating:(UIScrollView *)scrollView {
    [self adjustOffsetX];
}

- (void)scrollViewDidEndDragging:(UIScrollView *)scrollView willDecelerate:(BOOL)decelerate {
    if (!decelerate) {
        [self adjustOffsetX];
    }
}
#pragma mark - 跟踪滑动回调
- (void)scrollViewDidScroll:(UIScrollView *)scrollView {
    CGFloat offsetX = self.scrollView.contentOffset.x;
    NSInteger amount =  roundf(offsetX / _space);
    amount = MAX(0, amount);
    amount = MIN(self.maxValue - self.minValue, amount);
    !self.scrollRulerBlock ?: self.scrollRulerBlock(amount+self.minValue);
    _currentValue = amount+self.minValue;
}

- (void)scrollViewDidEndScrollingAnimation:(UIScrollView *)scrollView {
    CGFloat offsetX = self.scrollView.contentOffset.x;
    NSInteger amount =  roundf(offsetX / _space) ;
    !self.scrollRulerBlock ?: self.scrollRulerBlock(amount+self.minValue);
    _currentValue = amount+self.minValue;
}
/**
 四舍五入调整刻度
 */
- (void)adjustOffsetX {
    NSInteger offsetX = self.scrollView.contentOffset.x;
    NSInteger newOffsetX =  roundf(offsetX / _space) * _space ;
    [self.scrollView setContentOffset:CGPointMake(newOffsetX, 0) animated:YES];
}

-(void)setMinValue:(NSInteger)minValue {
    NSAssert(minValue >= 0, @"minValue不能小于0");
    NSAssert(minValue <= self.maxValue, @"minValue不能大于maxValue");
    _minValue = minValue;
}

#pragma mark - Public

- (void)setCurrentValue:(NSInteger)currentValue animated:(BOOL)animated {
    NSAssert(currentValue >= self.minValue, @"currentValue不能小于minValue");
    NSAssert(currentValue <= self.maxValue, @"currentValue不能大于maxValue");
    _currentValue = currentValue;
    [self.scrollView setContentOffset:CGPointMake((currentValue-self.minValue)*self.space, 0) animated:animated];
}

@end
