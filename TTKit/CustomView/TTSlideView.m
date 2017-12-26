//
//  TTSlideView.m
//  TTKitDemo
//
//  Created by apple on 2017/11/20.
//  Copyright © 2017年 shang. All rights reserved.
//

#import "TTSlideView.h"
#import "DLScrollTabbarView.h"
#import "DLCustomSlideView.h"
#import "DLLRUCache.h"

@interface TTSlideView()<DLCustomSlideViewDelegate>

@property (nonatomic, weak) UIViewController* target;
@property (nonatomic, strong) DLCustomSlideView *slideView;
@property (nonatomic, strong) DLScrollTabbarView *tabbar;

@end

@implementation TTSlideView

- (DLCustomSlideView *)slideView {
    if (!_slideView) {
        _slideView = [[DLCustomSlideView alloc]init];
        _slideView.backgroundColor = [UIColor clearColor];
        _slideView.delegate = self;
    }
    return _slideView;
}

- (void)initializationUI:(DLCustomSlideView *)view{
    
    NSMutableArray* itemArray = [NSMutableArray array];
    NSArray *titleArray = @[];
    if ([self.dataSource respondsToSelector:@selector(pageTitlesForSlideView:)]) {
        titleArray = [self.dataSource pageTitlesForSlideView:self];
    }
    if (titleArray.count == 0) return;
    [titleArray enumerateObjectsUsingBlock:^(id obj, NSUInteger idx, BOOL *stop) {
        if (self.tabItemWidth == 0) {
            self.tabItemWidth = self.bounds.size.width/titleArray.count;
        }
        DLScrollTabbarItem *item = [DLScrollTabbarItem itemWithTitle:obj width:self.tabItemWidth];
        if (item) {
            [itemArray addObject:item];
        }
    }];
    
    //初始化分页
    [self.tabbar removeFromSuperview];
    self.tabbar = [[DLScrollTabbarView alloc] initWithFrame:CGRectMake(0, 0, self.bounds.size.width, self.slideBarHeight)];
    self.tabbar.tabItemNormalColor = self.tabItemNormalColor;
    self.tabbar.tabItemSelectedColor = self.tabItemSelectedColor;
    self.tabbar.tabItemNormalFontSize = self.tabItemNormalFontSize;
    self.tabbar.trackColor = self.trackColor;
    self.tabbar.backgroundColor = self.tabBackgroundColor;
    self.tabbar.tabbarItems = itemArray;
    view.tabbar = self.tabbar;
    DLLRUCache *cache = [[DLLRUCache alloc] initWithCount:itemArray.count];
    view.cache = cache;
    view.tabbarBottomSpacing = self.tabbarBottomSpacing;
    view.baseViewController = self.target;
    [view setup];
    view.selectedIndex = self.selectedIndex;
}


- (instancetype)initWithTarget:(UIViewController *)target {
    self = [super initWithFrame:CGRectZero];
    _slideBarHeight =  44;
    _tabItemNormalColor = [UIColor grayColor];
    _tabItemSelectedColor = [UIColor blackColor];
    _trackColor = [UIColor blackColor];
    _tabBackgroundColor = [UIColor whiteColor];
    _tabItemNormalFontSize = 14;
    _tabbarBottomSpacing = 0;
    _selectedIndex = 0;
    _target = target;
    _tabItemWidth = 0;
    [self addSubview:self.slideView];
    return self;
}

- (void)layoutSubviews {
    [super layoutSubviews];
    self.slideView.frame = self.bounds;
    self.tabbar.frame = CGRectMake(0, 0, self.bounds.size.width, self.slideBarHeight);
}

#pragma mark - setter

- (void)setSlideBarHeight:(CGFloat)slideBarHeight {
    _slideBarHeight = slideBarHeight;
    self.slideView.tabbar.bounds = CGRectMake(0, 0, self.slideView.bounds.size.width, slideBarHeight);
}

- (void)setTabItemWidth:(CGFloat)tabItemWidth {
    _tabItemWidth = tabItemWidth;
    [self reloadData];
}

- (void)setTabItemNormalColor:(UIColor *)tabItemNormalColor {
    _tabItemNormalColor = tabItemNormalColor;
    self.tabbar.tabItemNormalColor = tabItemNormalColor;
}

-(void)setTabItemSelectedColor:(UIColor *)tabItemSelectedColor {
    _tabItemSelectedColor = tabItemSelectedColor;
    self.tabbar.tabItemSelectedColor = tabItemSelectedColor;
}

- (void)setTabBackgroundColor:(UIColor *)tabBackgroundColor {
    _tabBackgroundColor = tabBackgroundColor;
    self.tabbar.backgroundColor = tabBackgroundColor;
}

- (void)setTrackColor:(UIColor *)trackColor {
    _trackColor = trackColor;
    self.tabbar.trackColor = trackColor;
}

-(void)setTabItemNormalFontSize:(CGFloat)tabItemNormalFontSize {
    _tabItemNormalFontSize = tabItemNormalFontSize;
    self.tabbar.tabItemNormalFontSize = tabItemNormalFontSize;
}

- (void)setTabbarBottomSpacing:(CGFloat)tabbarBottomSpacing {
    _tabbarBottomSpacing = tabbarBottomSpacing;
    self.slideView.tabbarBottomSpacing = tabbarBottomSpacing;
}

- (void)setSelectedIndex:(NSInteger)selectedIndex {
    _selectedIndex = selectedIndex;
    self.slideView.selectedIndex = selectedIndex;
}

- (void)setDataSource:(id<TTSlideViewDataSource>)dataSource {
    _dataSource = dataSource;
    [self initializationUI:self.slideView];
}

#pragma mark - delegate

-(NSInteger)numberOfTabsInDLCustomSlideView:(DLCustomSlideView *)sender {
    if ([self.dataSource respondsToSelector:@selector(pageTitlesForSlideView:)]) {
        return  [self.dataSource pageTitlesForSlideView:self].count;
    }else{
        return 0;
    }
}

- (UIViewController *)DLCustomSlideView:(DLCustomSlideView *)sender controllerAt:(NSInteger)index {
    UIViewController *vc = nil;
    if ([self.dataSource respondsToSelector:@selector(slideView:controllerAtPageIndex:)]) {
        vc = [self.dataSource slideView:self controllerAtPageIndex:index];
    }
    return vc;
}

- (void)DLCustomSlideView:(DLCustomSlideView *)sender didSelectedAt:(NSInteger)index {
    if ([self.delegete respondsToSelector:@selector(slideView:didSelectedAtIndex:)]) {
        [self.delegete slideView:self didSelectedAtIndex:index];
    }
}

#pragma mark - Public

- (void)reloadData {
    [self initializationUI:self.slideView];
}


@end
