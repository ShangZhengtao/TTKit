//
//  SlideViewController.m
//  TTKitDemo
//
//  Created by apple on 2017/11/20.
//  Copyright © 2017年 shang. All rights reserved.
//

#import "SlideViewController.h"

#import "DLScrollTabbarView.h"
#import "DLCustomSlideView.h"
#import "DLLRUCache.h"

#import "TTSlideView.h"

@interface SlideViewController ()<TTSlideViewDataSource>

@property (nonatomic, strong) TTSlideView *slideView;
@property (nonatomic, strong)NSArray *dataArray;

@end

@implementation SlideViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.view.backgroundColor = [UIColor whiteColor];
    self.dataArray = @[@"全部",@"待付款",@"待发货",@"待收货",@"已完成",@"待发货",@"待收货",@"已完成",@"已完成",@"待发货",@"待收货",@"已完成"];
    self.slideView = [[TTSlideView alloc]initWithTarget:self];
    self.slideView.frame = CGRectMake(0, 64,375, 667-64);
//    self.slideView.tabItemNormalColor = [UIColor blackColor];
//    self.slideView.tabItemSelectedColor = [UIColor orangeColor];
//    self.slideView.tabItemNormalFontSize = 17;
//    self.slideView.tabbarBottomSpacing = 10;
//    self.slideView.trackColor = [UIColor redColor];
    self.slideView.tabItemWidth = 60;
    [self.view addSubview:self.slideView];
    self.slideView.dataSource = self;
    
//    dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(1 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
//        self.dataArray = @[@"1",@"2"];
//        [self.slideView reloadData];
//    });
}

- (NSArray<NSString *> *)pageTitlesForSlideView:(TTSlideView *)slideView {
    return self.dataArray;
}

- (UIViewController *)slideView:(TTSlideView *)slideView controllerAtPageIndex:(NSInteger)pageIndex {
    UITableViewController *orderVC = [[UITableViewController alloc]init];
        orderVC.view.backgroundColor = [UIColor colorWithWhite:0 alpha:arc4random() % 100 *0.01];
        return orderVC;
}

@end
