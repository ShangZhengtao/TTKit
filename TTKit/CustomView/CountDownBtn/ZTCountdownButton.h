//
//  ZTCuntdownButton.h
//  CountdownDemo
//
//  Created by YunYS on 16/8/16.
//  Copyright © 2016年 YunYS. All rights reserved.
//

#import <UIKit/UIKit.h>

typedef enum : NSUInteger {
    ZTCountdownButtonStyleDefault = 0, //重发(?)
    ZTCountdownButtonStyle1, //?秒后重新获取
    ZTCountdownButtonStyle2, //?秒
} ZTCountdownButtonStyle;


@interface ZTCountdownButton : UIButton

/**普通标题*/
@property (nonatomic, copy) NSString *normalTitle;
/**倒计时状态标题必须包含数字占位符 "?" eg. 再次获取（?）*/
@property (nonatomic, copy) NSString *countdownTitle;
/**普通状态背景色*/
@property (nonatomic, strong) UIColor *normalBackgroundColor;
/**倒计时状态背景颜色*/
@property (nonatomic, strong) UIColor *countdownBackgroundColor;
/**时间间隔单位秒  默认60秒*/
@property (nonatomic, assign) NSTimeInterval timeInterval;
/**按钮样式*/
@property (nonatomic, assign) ZTCountdownButtonStyle style;


/**
 *  推荐的初始化方法 (支持xib创建)
 *
 *  @param frame        frame
 *  @param timeInterval 倒计时总时间间隔 单位秒
 *
 *  @return 具有倒计时功能的按钮 默认样式
 */
- (instancetype)initWithFrame:(CGRect) frame  timeInterval:(NSTimeInterval)timeInterval;

@end
