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

- (void)addGravityBehaviorItems:(NSArray<__kindof UIView *>*)items intoContainerView:(UIView *)view;

@end
