//
//  BaseTabBarViewController.m
//  TTKitDemo
//
//  Created by apple on 2017/11/21.
//  Copyright © 2017年 shang. All rights reserved.
//

#import "BaseTabBarViewController.h"
#import "BaseTableViewController.h"
#import "NSDictionary+SafeAccess.h"
#import "TTMacros.h"
#import "CoreJPush.h"
@interface BaseTabBarViewController ()
<UITabBarControllerDelegate,
CoreJPushProtocal
>

/**index*/
@property (nonatomic, assign) NSInteger indexFlag;

@end

@implementation BaseTabBarViewController

+ (void)initialize {
    UITabBar *tabBar =  [UITabBar appearance];
    tabBar.tintColor = kThemeColor;
    [tabBar setBackgroundColor:[UIColor whiteColor]];
    tabBar.shadowImage = [UIImage new];
    tabBar.backgroundImage = [UIImage new];
}

- (void)viewDidLoad {
    [super viewDidLoad];
    [self setupAllChildViewController];
    self.delegate = self;
    [CoreJPush addJPushObserver:self];
}

#pragma mark -

-(void)setupAllChildViewController{
    UINavigationController *demoVC = [UIStoryboard storyboardWithName:@"Main" bundle:nil].instantiateInitialViewController;
    [self setupChildViewController:demoVC title:@"Demo" imageName:@"tabbar_icon_video_nor" seleceImageName:@"tabbar_icon_video_sel"];
    
    BaseTableViewController *msgVC = [BaseTableViewController new];
    [self setupChildViewController:msgVC title:@"首页" imageName:@"tabbar_icon_home_nor" seleceImageName:@"tabbar_icon_home_sel"];
    
    UIViewController *mineVC = [[UIViewController alloc]init];
    [self setupChildViewController:mineVC title:@"我的" imageName:@"tabbar_icon_mine_nor" seleceImageName:@"tabbar_icon_mine_sel"];
}

-(void)setupChildViewController:(UIViewController*)controller title:(NSString *)title imageName:(NSString *)imageName seleceImageName:(NSString *)selectImageName{
    [self addChildViewController:controller];
    //    controller.title = title;
    controller.tabBarItem.title = title;
    controller.tabBarItem.image = [[UIImage imageNamed:imageName] imageWithRenderingMode:UIImageRenderingModeAlwaysOriginal];
    controller.tabBarItem.selectedImage = [[UIImage imageNamed:selectImageName] imageWithRenderingMode:UIImageRenderingModeAlwaysOriginal];
    //    //未选中字体颜色
    //    [controller.tabBarItem setTitleTextAttributes:@{NSForegroundColorAttributeName:kTextColorDark,NSFontAttributeName:SYSTEMFONT(10.0f)} forState:UIControlStateNormal];
    //    //选中字体颜色
    //    [controller.tabBarItem setTitleTextAttributes:@{NSForegroundColorAttributeName:kTextColorDark,NSFontAttributeName:SYSTEMFONT(10.0f)} forState:UIControlStateSelected];
}

#pragma mark - UITabBarControllerDelegate

-(void)tabBarController:(UITabBarController *)tabBarController didSelectViewController:(UIViewController *)viewController{
    //        NSLog(@"选中 %ld",tabBarController.selectedIndex);
}

#pragma mark - tabBarItemAnimation

- (void)tabBar:(UITabBar *)tabBar didSelectItem:(UITabBarItem *)item {
    NSInteger index = [self.tabBar.items indexOfObject:item];
    if (self.indexFlag != index) {
        [self animationWithIndex:index];
    }
    self.indexFlag = index;
}

// 动画
- (void)animationWithIndex:(NSInteger) index {
    NSMutableArray * tabbarbuttonArray = [NSMutableArray array];
    for (UIView *tabBarButton in self.tabBar.subviews) {
        if ([tabBarButton isKindOfClass:NSClassFromString(@"UITabBarButton")]) {
            [tabbarbuttonArray addObject:tabBarButton];
        }
    }
    CASpringAnimation *spring = [CASpringAnimation animationWithKeyPath:@"transform.scale"];
    spring.duration = 0.7;
    spring.repeatCount = 1;
    spring.fromValue = @(1.1);
    spring.toValue = @(1);
    spring.damping = 10;//阻尼系数，阻止弹簧伸缩的系数，阻尼系数越大，停止越快 Defaults to 10
    spring.stiffness = 500; //刚度系数(劲度系数/弹性系数)，刚度系数越大，形变产生的力就越大，运动越快 Defaults to 100
    spring.mass = 5; //质量，影响图层运动时的弹簧惯性，质量越大，弹簧拉伸和压缩的幅度越大 Defaults to one
    spring.initialVelocity = 20; ///初始速率，动画视图的初始速度大小 Defaults to zero 速率为正数时，速度方向与运动方向一致，速率为负数时，速度方向与运动方向相反
    [[tabbarbuttonArray[index] layer] addAnimation:spring forKey:nil];
}

#pragma mark - Push

- (void)didReceiveRemoteNotification:(NSDictionary *)userInfo {
    NSLog(@"推送消息：\n%@",userInfo);
    //    NSDictionary *apns = [userInfo objectForKey:@"aps"];
    NSString *msg = [NSString stringWithFormat:@"%@",userInfo];
    UIAlertController *alertVC = [UIAlertController alertControllerWithTitle:@"推送测试" message:msg preferredStyle:UIAlertControllerStyleAlert];
    UIAlertAction *cancel = [UIAlertAction actionWithTitle:@"确定" style:UIAlertActionStyleCancel handler:nil];
    [alertVC addAction:cancel];
    [self presentViewController:alertVC animated:YES completion:nil];
}

- (void)handleAction:(NSDictionary *)userInfo actionIdentifier:(NSString *)identifier {
    
    NSDictionary *apns = [userInfo objectForKey:@"aps"];
    NSString *categoryID = [apns stringForKey:@"category"];
    if ([categoryID isEqualToString:@"comment-reply"]) { //注册通知时配置ID
        if ([identifier isEqualToString:@"close"]) {
            [kUserDefaults setObject:@"close" forKey: @"handleAction"];
            NSLog(@"关闭");
        }else if ([identifier isEqualToString:@"enter"]) {
            NSLog(@"进入");
        }else if ([identifier isEqualToString:@"unLock"]) {
            NSLog(@"解锁");
        }else if ([identifier isEqualToString:@"input"]) {
            NSString * userText = [userInfo stringForKey:kHandleActionUserTextKey];
            NSLog(@"输入的内容为：%@",userText);
        }else if ([identifier isEqualToString:@""]) {
            
        }
    }
    
}
@end
