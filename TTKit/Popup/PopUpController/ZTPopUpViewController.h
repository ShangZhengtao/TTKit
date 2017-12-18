//
//  PopUpViewController.h
//  TransitionDemo
//
//  Created by apple on 2017/9/18.
//  Copyright © 2017年 shang. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface ZTPopUpViewController : UIViewController

/** 推出后的背景颜色*/
@property (nonatomic, strong) UIColor *presentedBackgroundColor;
/**点击背景dismiss*/
@property (nonatomic, assign) BOOL tapBackgroundDismiss;
/** 弹出回调*/
@property (nonatomic, copy) void(^popUpBlock)(void);
/** 消失回调*/
@property (nonatomic, copy) void(^dismissBlock)(void);

@end
