//
//  LrdOutputView.h
//  LrdOutputView
//
//  Created by 键盘上的舞者 on 4/14/16.
//  Copyright © 2016 键盘上的舞者. All rights reserved.
//

#import <UIKit/UIKit.h>
@class LrdOutputView;
@protocol LrdOutputViewDelegate <NSObject>
@required
- (void) outputView:(LrdOutputView *) outputView didSelectedAtIndexPath:(NSIndexPath *)indexPath;
@end

typedef NS_ENUM(NSUInteger, LrdOutputViewDirection) {
    kLrdOutputViewDirectionLeft = 1,
    kLrdOutputViewDirectionRight
};

@interface LrdOutputView : UIView
@property (nonatomic, weak) id<LrdOutputViewDelegate> delegate;
@property (nonatomic, strong) void(^dismissBlock)(void);
@property (nonatomic, strong) NSIndexPath *selectedIndexPath;
//初始化方法
//传入参数：模型数组，弹出原点，宽度，高度（每个cell的高度）
- (instancetype)initWithDataArray:(NSArray *)dataArray
                           origin:(CGPoint)origin
                            width:(CGFloat)width
                        rowHeight:(CGFloat)rowHeight
                        direction:(LrdOutputViewDirection)direction;

//弹出
- (void)pop;
//消失
- (void)dismiss;

@end


/**
 cell模型
 */
@interface LrdCellModel : NSObject

@property (nonatomic, copy) NSString *title;
@property (nonatomic, copy) NSString *imageName;

- (instancetype)initWithTitle:(NSString *)title imageName:(NSString *)imageName;

@end
