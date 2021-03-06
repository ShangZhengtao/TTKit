//
//  BaseNavigationController.m
//  TTKitDemo
//
//  Created by apple on 2017/11/21.
//  Copyright © 2017年 shang. All rights reserved.
//

#import "BaseNavigationController.h"
#import "TTMacros.h"
#import "WRNavigationBar.h"
#import "TTBaseNavigationAnimator.h"
#import "TTGestureDepthOfFieldAnimator.h"

@interface BaseNavigationController ()<UINavigationControllerDelegate>

@property (nonatomic ,strong) TTBaseNavigationAnimator *animator;

@end

@implementation BaseNavigationController

+ (void)initialize {
    UINavigationBar *navBar = [UINavigationBar appearance];
    //导航栏背景图
    //[navBar setBackgroundImage:[UIImage imageNamed:@"tabBarBj"] forBarMetrics:UIBarMetricsDefault];
    [navBar setBackgroundImage:[UIImage imageNamed:@""] forBarPosition:UIBarPositionAny barMetrics:UIBarMetricsDefault];
    //导航栏主题 title文字属性
    navBar.barTintColor = kThemeColor;
    navBar.barStyle = UIBarStyleDefault;
    navBar.tintColor = [UIColor whiteColor];
    [navBar setTitleTextAttributes:@{
                                     NSForegroundColorAttributeName :[UIColor whiteColor],
                                     NSFontAttributeName : [UIFont systemFontOfSize:16]
                                     }];
    //去掉阴影线
    [navBar setShadowImage:[UIImage new]];
    
    [WRNavigationBar wr_setDefaultNavBarBarTintColor:kThemeColor];
    [WRNavigationBar wr_setDefaultNavBarTintColor:[UIColor whiteColor]];
    [WRNavigationBar wr_setDefaultNavBarTitleColor:[UIColor whiteColor]];
    [WRNavigationBar wr_setDefaultStatusBarStyle:UIStatusBarStyleDefault];
}

- (void)viewDidLoad {
    [super viewDidLoad];
    self.delegate = self;
    self.animator = [[TTGestureDepthOfFieldAnimator alloc]init];
}

//push时隐藏tabbar
- (void)pushViewController:(UIViewController *)viewController animated:(BOOL)animated {
    if (self.viewControllers.count > 0) {
        viewController.hidesBottomBarWhenPushed = YES;
        //自定义返回箭头图标
//        viewController.navigationItem.leftBarButtonItem = [[UIBarButtonItem alloc]initWithImage:[UIImage imageNamed:@"nav_icon_back"] style:UIBarButtonItemStylePlain target:self action:@selector(back)];
    }
    [super pushViewController:viewController animated:animated];
    // 修改tabBra的frame
    //    CGRect frame = self.tabBarController.tabBar.frame;
    //    frame.origin.y = [UIScreen mainScreen].bounds.size.height - frame.size.height;
    //    self.tabBarController.tabBar.frame = frame;
}

- (void)back {
    [self popViewControllerAnimated:YES];
}

#pragma mark - navigationDelegate

- (id<UIViewControllerAnimatedTransitioning>)navigationController:(UINavigationController *)navigationController animationControllerForOperation:(UINavigationControllerOperation)operation fromViewController:(UIViewController *)fromVC toViewController:(UIViewController *)toVC {
    //给toVC 添加手势
    if (toVC != navigationController.childViewControllers.firstObject) {
        [self.animator interactionForViewController:toVC];
    }
    self.animator.operation = operation;
    return self.animator;
}

- (id<UIViewControllerInteractiveTransitioning>)navigationController:(UINavigationController *)navigationController interactionControllerForAnimationController:(id<UIViewControllerAnimatedTransitioning>)animationController {
    return self.animator.interactionInProgress ? self.animator : nil;
}

@end
