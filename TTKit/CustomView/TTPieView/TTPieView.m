//
//  TTPieView.m
//  PieDemo
//
//  Created by apple on 2018/3/30.
//  Copyright © 2018年 Shang. All rights reserved.

#import "TTPieView.h"
#import "TTArcView.h"

@interface TTPieView()

@property (nonatomic, strong) NSArray<NSNumber *> *dataArray;

@end

@implementation TTPieView

- (instancetype)initWithDataArray:(NSArray<NSNumber *> *)dataArray colors:(NSArray<UIColor *> *)colors {
    if (self = [self initWithFrame:CGRectZero]) {
        self.dataArray = dataArray;
        self.colors = colors;
    }
    return self;
}

- (void)layoutSubviews {
    [super layoutSubviews];
    if (self.subviews.count == 0) {
        [self updateSubViews];
    }
}

- (void)updateSubViews {
    [self.subviews enumerateObjectsUsingBlock:^(__kindof UIView * _Nonnull obj, NSUInteger idx, BOOL * _Nonnull stop) {
        [obj removeFromSuperview];
    }];
    __block CGFloat total = 0;
    [self.dataArray enumerateObjectsUsingBlock:^(NSNumber * _Nonnull obj, NSUInteger idx, BOOL * _Nonnull stop) {
        total += obj.doubleValue;
    }];
    __block CGFloat currentScale = 0;
    [self.dataArray enumerateObjectsUsingBlock:^(NSNumber * _Nonnull obj, NSUInteger idx, BOOL * _Nonnull stop) {
        TTArcView *arcView = [[TTArcView alloc]initWithFrame:self.bounds];
        arcView.scale = obj.doubleValue / total;
        arcView.startScale  = currentScale;
        UIColor *backgroundcolor = [UIColor colorWithWhite:currentScale alpha:1];
        @try {
            backgroundcolor = [self.colors objectAtIndex:idx];
        } @catch (NSException *exception) {

        } @finally {
            arcView.backgroundColor = backgroundcolor;
        }
        arcView.tag = idx;
        [self addSubview:arcView];
        currentScale += (obj.doubleValue / total);
    }];
}


@end
