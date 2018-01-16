//
//  TTModalAnimator.h
//  TTKitDemo
//
//  Created by apple on 2018/1/15.
//  Copyright © 2018年 shang. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "UIViewController+TTModalTransition.h"

@interface TTModalAnimator : NSObject<UIViewControllerAnimatedTransitioning>

@property (nonatomic, assign) TTModalTransitionStyle  style;



@end
