//
//  TTCollisionView.h
//  Dynamic
//
//  Created by apple on 2018/1/17.
//  Copyright © 2018年 Shang. All rights reserved.
//

#import <UIKit/UIKit.h>
//http://blog.csdn.net/dazeng1990/article/details/50454716

/**
 继承此类可以设置碰撞类型
 */
NS_CLASS_AVAILABLE_IOS(9_0) @interface TTCollisionView : UIView

@property (nonatomic, assign) UIDynamicItemCollisionBoundsType collisionBoundsType;

@property (nonatomic, strong) UIBezierPath *collisionBoundingPath;

@end
