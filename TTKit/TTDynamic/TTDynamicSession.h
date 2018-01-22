//
//  TTDynamicKit.h
//  Dynamic
//
//  Created by apple on 2018/1/18.
//  Copyright © 2018年 Shang. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "TTCollisionView.h"

@class TTCollisionView;@interface TTDynamicSession : NSObject

/**
  使多个view在指定容器view范围内 具备重力感应效果

 @param items 具备重力感应效果的view集合
 @param view  重力场容器view
 */
- (void)addGravityBehaviorItems:(NSArray<__kindof UIView *>*)items intoContainerView:(UIView *)view;

@end
