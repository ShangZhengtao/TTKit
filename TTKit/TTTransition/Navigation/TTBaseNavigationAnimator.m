//
//  TTBaseNavigationAnimator.m
//  TransitionDemo
//
//  Created by apple on 2018/1/30.
//  Copyright © 2018年 shang. All rights reserved.
//

#import "TTBaseNavigationAnimator.h"

@interface TTBaseNavigationAnimator ()<UIGestureRecognizerDelegate>

@property (weak, nonatomic) id<UIViewControllerContextTransitioning> transitionContext;
@property (weak, nonatomic, readonly) UIViewController *toViewController;

@end 

@implementation TTBaseNavigationAnimator

- (instancetype)init {
    self = [super init];
    if (self) {
        self.enableGesture = YES;
        self.transitionDuration = 0.5;
    }
    return self;
}

- (NSTimeInterval)transitionDuration:(id<UIViewControllerContextTransitioning>)transitionContext {
    //子类去实现
    return 0;
}

- (void)animateTransition:(id<UIViewControllerContextTransitioning>)transitionContext {
    //子类去实现
}

#pragma mark - 添加手势

-(void)interactionForViewController:(UIViewController *)viewController {
    _toViewController = viewController;
    _panGesture = [[UIScreenEdgePanGestureRecognizer alloc]initWithTarget:self action:@selector(gestureRecognizeDidUpdate:)];
    _panGesture.delegate = self;
    _panGesture.edges = UIRectEdgeLeft;
    [viewController.view addGestureRecognizer:_panGesture];
}


///是否让这个手势起作用，生效，返回NO，无效，返回YES手势生效
- (BOOL)gestureRecognizerShouldBegin:(UIPanGestureRecognizer *)gestureRecognizer {
    return self.enableGesture;
}

///同一个view上如果作用了两个相同类型的手势，那么系统默认只会响应一个,该方法返回YES时，意味着所有相同类型的手势辨认都会得到处理。
//- (BOOL)gestureRecognizer:(UIGestureRecognizer *)gestureRecognizer shouldRecognizeSimultaneouslyWithGestureRecognizer:(UIGestureRecognizer *)otherGestureRecognizer {
//    if ([otherGestureRecognizer isKindOfClass:NSClassFromString(@"UIScrollViewPanGestureRecognizer")] ||
//        [otherGestureRecognizer isKindOfClass:NSClassFromString(@"UIPanGestureRecognizer")] ||
//        [otherGestureRecognizer isKindOfClass:NSClassFromString(@"UIScrollViewPagingSwipeGestureRecognizer")]) {
//        UIView *aView = otherGestureRecognizer.view;
//        if ([aView isKindOfClass:[UIScrollView class]]) {
//            UIScrollView *sv = (UIScrollView *)aView;
//            if (sv.contentOffset.x == 0) {//左边界判断
//                return YES;
//            }
//        }
//        return NO;
//    }
//    return YES;
//}

#pragma mark - 手势动画处理

- (void)startInteractiveTransition:(id<UIViewControllerContextTransitioning>)transitionContext {
    // Save the transitionContext for later.
    self.transitionContext = transitionContext;
    [super startInteractiveTransition:transitionContext];
}

- (void)gestureRecognizeDidUpdate:(UIScreenEdgePanGestureRecognizer *)gestureRecognizer {
    switch (gestureRecognizer.state)
    {
        case UIGestureRecognizerStateBegan:
            // The Began state is handled by the view controllers.  In response
            // to the gesture recognizer transitioning to this state, they
            // will trigger the presentation or dismissal.
        {
            self.interactionInProgress = YES;
            [_toViewController.navigationController popViewControllerAnimated:YES];
            
        }
            break;
        case UIGestureRecognizerStateChanged:
        {
            // We have been dragging! Update the transition context accordingly.
            CGFloat percent = [self percentForGesture:gestureRecognizer];
            //            NSLog(@"---%f",percent);
            [self updateInteractiveTransition:percent];
        }
            break;
        case UIGestureRecognizerStateEnded:
            // Dragging has finished.
            // Complete or cancel, depending on how far we've dragged.
            if ([self percentForGesture:gestureRecognizer] >= 0.5f)
                [self finishInteractiveTransition];
            else
                [self cancelInteractiveTransition];
            break;
        default:
            // Something happened. cancel the transition.
            [self cancelInteractiveTransition];
            break;
    }
    self.interactionInProgress = NO;
}

- (CGFloat)percentForGesture:(UIScreenEdgePanGestureRecognizer *)gesture {
    // Because view controllers will be sliding on and off screen as part
    // of the animation, we want to base our calculations in the coordinate
    // space of the view that will not be moving: the containerView of the
    // transition context.
    UIView *transitionContainerView = self.transitionContext.containerView;
    
    CGPoint locationInSourceView = [gesture locationInView:transitionContainerView];
    
    // Figure out what percentage we've gone.
    
    CGFloat width = CGRectGetWidth(transitionContainerView.bounds);
    CGFloat height = CGRectGetHeight(transitionContainerView.bounds);
    UIRectEdge edge = self.panGesture.edges;
    // Return an appropriate percentage based on which edge we're dragging
    // from.
    if (edge == UIRectEdgeRight)
        return (width - locationInSourceView.x) / width;
    else if (edge == UIRectEdgeLeft)
        return locationInSourceView.x / width;
    else if (edge == UIRectEdgeBottom)
        return (height - locationInSourceView.y) / height;
    else if (edge == UIRectEdgeTop)
        return locationInSourceView.y / height;
    else
        return 0.f;
}

-(void)dealloc {
    [_panGesture.view removeGestureRecognizer:_panGesture];
}

@end

#pragma mark - 投影转换

inline CGFloat TT_DegreesToRadians (CGFloat degrees) {
     return degrees / 180.0 * M_PI;
}

inline CATransform3D TT_CATransform3DMakePerspective(CGPoint center, float disZ) {
    CATransform3D transToCenter = CATransform3DMakeTranslation(-center.x, -center.y, 0);
    CATransform3D transBack = CATransform3DMakeTranslation(center.x, center.y, 0);
    CATransform3D scale = CATransform3DIdentity;
    scale.m34 = -1.0f/disZ;
    return CATransform3DConcat(CATransform3DConcat(transToCenter, scale), transBack);
}

inline CATransform3D TT_CATransform3DPerspect(CATransform3D t, CGPoint center, float disZ) {
    return CATransform3DConcat(t, TT_CATransform3DMakePerspective(center, disZ));
}

