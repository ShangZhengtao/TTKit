//
//  TTSlideView.h
//  TTKitDemo
//
//  Created by apple on 2017/11/20.
//  Copyright © 2017年 shang. All rights reserved.
//

#import <UIKit/UIKit.h>
NS_ASSUME_NONNULL_BEGIN
@class TTSlideView;

@protocol TTSlideViewDelegate<NSObject>
@optional
- (void)slideView:(TTSlideView *)sender didSelectedAtIndex:(NSInteger)index;
@end

@protocol TTSlideViewDataSource<NSObject>

@required
- (NSArray<NSString*> *)pageTitlesForSlideView:(TTSlideView *)slideView;

- (UIViewController *)slideView:(TTSlideView *)slideView controllerAtPageIndex:(NSInteger)pageIndex;

@end

@interface TTSlideView : UIView

/*默认 44*/
@property (nonatomic, assign) CGFloat slideBarHeight;
@property (nonatomic, assign) CGFloat tabItemNormalFontSize;
@property (nonatomic, assign) CGFloat tabItemWidth;
@property (nonatomic, strong) UIColor *tabItemNormalColor;
@property (nonatomic, strong) UIColor *tabItemSelectedColor;
@property (nonatomic, strong) UIColor *tabBackgroundColor;
@property (nonatomic, strong) UIColor *trackColor;
/**默认 0*/
@property (nonatomic, assign) CGFloat tabbarBottomSpacing;
@property (nonatomic, assign) NSInteger selectedIndex;

@property (nonatomic, weak, nullable) id <TTSlideViewDataSource>  dataSource;
@property (nonatomic, weak, nullable) id <TTSlideViewDelegate> delegete;

- (instancetype)initWithCoder:(NSCoder *)aDecoder NS_UNAVAILABLE;
- (instancetype)initWithFrame:(CGRect)frame NS_UNAVAILABLE;
- (instancetype)initWithTarget:(nonnull UIViewController *)target NS_DESIGNATED_INITIALIZER;

- (void)reloadData;

@end
NS_ASSUME_NONNULL_END
