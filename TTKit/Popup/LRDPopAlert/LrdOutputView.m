//
//  LrdOutputView.m
//  LrdOutputView
//
//  Created by 键盘上的舞者 on 4/14/16.
//  Copyright © 2016 键盘上的舞者. All rights reserved.
//

#import "LrdOutputView.h"

#define CellLineEdgeInsets UIEdgeInsetsMake(0, 10, 0, 10)
static const NSInteger kArrowPadding = 20;
static const NSInteger kArrowSide = 5;
static const NSInteger kMaxViewHeight  = 200;

@interface LrdOutputView () <UITableViewDataSource, UITableViewDelegate>
@property (nonatomic, strong) UITableView *tableView;
@property (nonatomic, assign) CGPoint origin;
@property (nonatomic, assign) CGFloat rowHeight;
@property (nonatomic, assign) CGFloat width;
@property (nonatomic, strong) NSArray *dataArray;
@property (nonatomic, assign) LrdOutputViewDirection direction;
@end

@implementation LrdOutputView

- (instancetype)initWithDataArray:(NSArray *)dataArray
                           origin:(CGPoint)origin
                            width:(CGFloat)width
                        rowHeight:(CGFloat)rowHeight
                        direction:(LrdOutputViewDirection)direction {
    if (self = [super initWithFrame:CGRectMake(0, 0, [UIScreen mainScreen].bounds.size.width, [UIScreen mainScreen].bounds.size.height)]) {
        //背景色为clearColor
        self.backgroundColor = [UIColor clearColor];
        
        self.origin = origin;
        self.rowHeight = rowHeight;
        self.width = width;
        self.direction = direction;
        self.dataArray = dataArray;
        if (rowHeight <= 0) {
            rowHeight = 44;
        }
        
        CGFloat tableViewH = MIN(kMaxViewHeight, rowHeight *_dataArray.count);
        if (direction == kLrdOutputViewDirectionLeft) {
            self.tableView = [[UITableView alloc] initWithFrame:CGRectMake(origin.x-kArrowPadding, origin.y, width, tableViewH) style:UITableViewStylePlain];
        } else {
            self.tableView = [[UITableView alloc] initWithFrame:CGRectMake(origin.x-width+kArrowPadding, origin.y, width, tableViewH) style:UITableViewStylePlain];
        }
        
        _tableView.separatorColor = [UIColor  clearColor];
        _tableView.backgroundColor = [UIColor blackColor];
        _tableView.bounces = NO;
        _tableView.layer.cornerRadius = 2;
        _tableView.delegate = self;
        _tableView.dataSource = self;
        [_tableView registerClass:[UITableViewCell class] forCellReuseIdentifier:@"cell"];
        
        [self addSubview:self.tableView];
        
        //cell线条
        if ([self.tableView respondsToSelector:@selector(setSeparatorInset:)]) {
            [self.tableView setSeparatorInset:CellLineEdgeInsets];
        }
        
        if ([self.tableView respondsToSelector:@selector(setLayoutMargins:)]) {
            [self.tableView setLayoutMargins:CellLineEdgeInsets];
        }
    }
    return self;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return self.dataArray.count;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    return self.rowHeight;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"cell"];
    cell.textLabel.textColor = [UIColor whiteColor];
    cell.textLabel.font = [UIFont systemFontOfSize:14];
    cell.backgroundColor = [UIColor clearColor];
    cell.textLabel.textAlignment = NSTextAlignmentCenter;
    //取出模型
    LrdCellModel *model = [self.dataArray objectAtIndex:indexPath.row];
    cell.textLabel.text = model.title;
    cell.imageView.image = [UIImage imageNamed:model.imageName];
    cell.selectedBackgroundView = [[UIView alloc] initWithFrame:cell.frame];
    cell.selectedBackgroundView.backgroundColor = [UIColor colorWithRed:0.0 green:0.0 blue:0.0 alpha:0.5];
    cell.textLabel.highlightedTextColor = [UIColor colorWithRed:0 green:1 blue:240 /255.0 alpha:1];
    return cell;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    //通知代理处理点击事件
    if ([self.delegate respondsToSelector:@selector(outputView: didSelectedAtIndexPath:)]) {
        [self.delegate outputView:self didSelectedAtIndexPath:indexPath];
    }
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
    [self dismiss];
}

- (void)tableView:(UITableView *)tableView willDisplayCell:(UITableViewCell *)cell forRowAtIndexPath:(NSIndexPath *)indexPath {
    if ([cell respondsToSelector:@selector(setSeparatorInset:)]) {
        [cell setSeparatorInset:CellLineEdgeInsets];
    }
    if ([cell respondsToSelector:@selector(setLayoutMargins:)]) {
        [cell setLayoutMargins:CellLineEdgeInsets];
    }
}

//画出尖尖
- (void)drawRect:(CGRect)rect {
    //拿到当前视图准备好的画板
    CGContextRef context = UIGraphicsGetCurrentContext();
    //利用path进行绘制三角形
    CGContextBeginPath(context);//标记
    CGFloat startX = self.origin.x-kArrowSide;
    CGFloat startY = self.origin.y;
    CGContextMoveToPoint(context, startX, startY);//设置起点
    CGContextAddLineToPoint(context, self.origin.x, self.origin.y - kArrowSide);
    CGContextAddLineToPoint(context, self.origin.x + kArrowSide, self.origin.y);
    CGContextClosePath(context);//路径结束标志，不写默认封闭
    [self.tableView.backgroundColor setFill]; //设置填充色
    [[UIColor clearColor] setStroke];
    CGContextDrawPath(context, kCGPathFillStroke);//绘制路径path
}

- (void)pop {
    UIWindow *keyWindow = [[UIApplication sharedApplication] keyWindow];
    [keyWindow addSubview:self];
    //动画效果弹出
    self.alpha = 0;
    [self.tableView selectRowAtIndexPath:self.selectedIndexPath animated:NO scrollPosition:UITableViewScrollPositionMiddle];
    CGRect frame = self.tableView.frame;
    self.tableView.frame = CGRectMake(self.origin.x, self.origin.y, 0, 0);
    [UIView animateWithDuration:0.2 animations:^{
        self.alpha = 1;
        self.tableView.frame = frame;
    }];
}

- (void)dismiss {
    //动画效果淡出
    [UIView animateWithDuration:0.2 animations:^{
        self.alpha = 0;
        self.tableView.frame = CGRectMake(self.origin.x, self.origin.y, 0, 0);
    } completion:^(BOOL finished) {
        if (finished) {
            [self removeFromSuperview];
            if (self.dismissBlock) {
                self.dismissBlock();
            }
        }
    }];
}

- (void)touchesBegan:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event {
    UITouch *touch = [touches anyObject];
    if (![touch.view isEqual:self.tableView]) {
        [self dismiss];
    }
}

@end

#pragma mark - LrdCellModel

@implementation LrdCellModel

- (instancetype)initWithTitle:(NSString *)title imageName:(NSString *)imageName {
    LrdCellModel *model = [[LrdCellModel alloc] init];
    model.title = title;
    model.imageName = imageName;
    return model;
}

@end
