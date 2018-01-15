//
//  TTModalDelegate.h
//  TTKitDemo
//
//  Created by apple on 2018/1/15.
//  Copyright © 2018年 shang. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "UIViewController+TTModalTransition.h"
@interface TTModalDelegate : NSObject<UIViewControllerTransitioningDelegate>

@property (nonatomic, assign) TTModalTransitionStyle  transitionStyle;

@end
