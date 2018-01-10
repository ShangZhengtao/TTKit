//
//  ZTCuntdownButton.m
//  CountdownDemo
//
//  Created by YunYS on 16/8/16.
//  Copyright © 2016年 YunYS. All rights reserved.
//

#import "ZTCountdownButton.h"

@interface ZTCountdownButton ()

@property (nonatomic, strong) NSTimer *timer;
@property (nonatomic, assign) SEL action;
@property (nonatomic, weak) id target;
@property (nonatomic, assign) NSTimeInterval temp;
@end


@implementation ZTCountdownButton

-(instancetype)initWithFrame:(CGRect)frame {
    
    self =  [super initWithFrame:frame];
    if (self) {
        self.timeInterval = 60;
        self.style = ZTCountdownButtonStyleDefault;
        [self setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
    }
    
    return self;
}

-(instancetype)initWithCoder:(NSCoder *)aDecoder {
    self = [super initWithCoder:aDecoder];
    if (self) {
        self.style = ZTCountdownButtonStyleDefault;
        self.timeInterval = 60;
        self.normalBackgroundColor = self.backgroundColor;
        if (self.buttonType == UIButtonTypeSystem) {
            [self setValue:@(0) forKey:@"buttonType"];
            [self setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
        }
        
    }
    return self;
    
}

- (instancetype)initWithFrame:(CGRect)frame timeInterval:(NSTimeInterval)timeInterval {
    
    self = [ZTCountdownButton buttonWithType:UIButtonTypeCustom];
    if (self) {
        self.frame = frame;
        self.timeInterval = timeInterval;
        self.style = ZTCountdownButtonStyleDefault;
        [self setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
        
    }
    return self;
}

- (NSTimer *)timer {
    if (!_timer) {
        _timer =[NSTimer scheduledTimerWithTimeInterval:1 target:self selector:@selector(changeTitle) userInfo:nil repeats:YES];
    }
    return _timer;
}

- (void)setNormalTitle:(NSString *)normalTitle {
    
    _normalTitle = normalTitle;
    
    [self setTitle:normalTitle forState:UIControlStateNormal];
}

- (void)setStyle:(ZTCountdownButtonStyle)style {
    
            switch (self.style) {
                case ZTCountdownButtonStyleDefault:
                    self.normalTitle = @"获取验证码";
                    self.countdownTitle = @"重发(?)";
                    break;
                case ZTCountdownButtonStyle1:
                    self.normalTitle = @"获取验证码";
                    self.countdownTitle = @"?秒后重新获取";
                    break;
                case ZTCountdownButtonStyle2:
                    self.normalTitle = @"点击获取验证码";
                    self.countdownTitle = @"?秒";
                    break;
                default:
                    self.normalTitle = @"";
                    self.countdownTitle = @"?";
                    break;
            }
    self.normalBackgroundColor = [UIColor whiteColor];
    self.countdownBackgroundColor = [UIColor groupTableViewBackgroundColor];
    
}


- (void)startCountDown {
     self.temp = self.timeInterval;
    if (![self.timer isValid]) {
         self.timer =[NSTimer scheduledTimerWithTimeInterval:1 target:self selector:@selector(changeTitle) userInfo:nil repeats:YES];
    }
    self.backgroundColor = self.countdownBackgroundColor;
    self.userInteractionEnabled = NO;
    
}

- (void)stopCountDown {
    [self.timer invalidate];
    self.timer = nil;
    [self setTitle:self.normalTitle forState:UIControlStateNormal];
    self.backgroundColor = self.normalBackgroundColor;
    self.userInteractionEnabled = YES;
    
}

- (void)changeTitle{
    if (![self.countdownTitle containsString:@"?"]) {
        NSLog(@"倒计时标题格式不正确！必须包含占位符“?”");
    }
    NSString *title = [self.countdownTitle stringByReplacingOccurrencesOfString:@"?" withString:@(self.timeInterval).stringValue]
    ;
    [self setTitle:title forState:UIControlStateNormal];
    
    self.timeInterval --;
    if (self.timeInterval < 0) {
        [self stopCountDown];
        self.timeInterval = self.temp;
    }
}


- (void)addTarget:(id)target action:(SEL)action forControlEvents:(UIControlEvents)controlEvents {
    
    if (controlEvents == UIControlEventTouchUpInside) {
        self.action = action;
        self.target = target;
        [super addTarget:self action:@selector(newAction)  forControlEvents:controlEvents];
    }else{
        [super addTarget:target action:action forControlEvents:controlEvents];
    }
}


- (void)newAction{
    
    if ([self.target respondsToSelector:self.action]) {
//http://fuckingclangwarnings.com/
#pragma clang diagnostic push
#pragma clang diagnostic ignored "-Warc-performSelector-leaks"
        [self.target performSelector:self.action withObject:self];
#pragma clang diagnostic pop
    }
    [self startCountDown];
}

- (void)dealloc {
    [self.timer invalidate];
    self.timer = nil;
}

@end
