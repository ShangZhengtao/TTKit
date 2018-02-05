//
//  TTBaseNavigationAnimator.h
//  TransitionDemo
//
//  Created by apple on 2018/1/30.
//  Copyright © 2018年 shang. All rights reserved.
//

#import <UIKit/UIKit.h>

CA_EXTERN CGFloat TT_DegreesToRadians(CGFloat degrees);

CA_EXTERN CATransform3D TT_CATransform3DMakePerspective(CGPoint center, float disZ);

CA_EXTERN CATransform3D TT_CATransform3DPerspect(CATransform3D t, CGPoint center, float disZ);

@interface TTBaseNavigationAnimator : UIPercentDrivenInteractiveTransition
<UIViewControllerAnimatedTransitioning>

/**
 添加手势交互动画 默认给vc添加左滑动手势
 
 @param viewController 传入 toVC
 */
- (void)interactionForViewController:(UIViewController *)viewController;
/**push or pop*/
@property (nonatomic, assign) UINavigationControllerOperation operation;
/**用于判断交互手势是否进行中*/
@property (nonatomic, assign) BOOL interactionInProgress;
/**是否启用手势*/
@property (nonatomic, assign) BOOL enableGesture;
/**内部创建手势 (边界滑动手势)*/
@property (nonatomic, strong, readonly) UIScreenEdgePanGestureRecognizer *panGesture;

@property (nonatomic, assign) NSTimeInterval transitionDuration;

@end
