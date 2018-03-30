//
//  TTRulerView.h
//  RulerDemo
//
//  Created by apple on 2018/3/28.
//  Copyright © 2018年 Shang. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface TTRulerView : UIView

@property(nonatomic, strong)UIFont *textFont;
/**刻度间距 默认5*/
@property (nonatomic, assign) CGFloat space;
/**刻度线粗细 默认1*/
@property (nonatomic, assign) CGFloat lineWidth;
/**小刻度高度 默认8*/
@property (nonatomic, assign) CGFloat smallLineHeight;
/**大刻度高度 默认14*/
@property (nonatomic, assign) CGFloat bigLineHeight;
/**刻度倍数 默认x1*/
@property (nonatomic, assign) NSInteger times;

/**当前刻度值*/
@property (nonatomic, assign, readonly) NSInteger currentValue;
/**最小值 默认0*/
@property (nonatomic, assign) NSInteger minValue;
/**最大值 默认100*/
@property (nonatomic, assign) NSInteger maxValue;

/** 滑动刻度尺回调*/
@property (nonatomic, copy) void(^scrollRulerBlock)(NSInteger amount);

/**
 设置 当前刻度值

 @param currentValue 指定刻度值
 @param animated 是否动画
 */
-(void)setCurrentValue:(NSInteger)currentValue animated:(BOOL)animated;

@end
