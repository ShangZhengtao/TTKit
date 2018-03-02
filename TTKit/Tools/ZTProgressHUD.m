//
//  ZTProgressHUD.m
//  GoldLiving
//
//  Created by apple on 2017/9/26.
//  Copyright © 2017年 lhb. All rights reserved.
//

#import "ZTProgressHUD.h"
//#import "SVProgressHUD.h"
#import "DGActivityIndicatorView.h"
@implementation ZTProgressHUD

static  CGFloat indicatorSize = 60;

+ (void)show {
    //    [SVProgressHUD show];
    [self dismiss];
    dispatch_async(dispatch_get_main_queue(), ^{
        UIWindow *win = [UIApplication sharedApplication].delegate.window;
        DGActivityIndicatorView *indicatorView = [[DGActivityIndicatorView alloc]initWithType:DGActivityIndicatorAnimationTypeBallClipRotateMultiple tintColor:[UIColor blueColor] size:indicatorSize];
      
        indicatorView.frame = CGRectMake(win.center.x - indicatorSize*0.5, win.center.y - indicatorSize*0.5, indicatorSize, indicatorSize);
        indicatorView.tag = 10089;
        [indicatorView startAnimating];
        
        [win addSubview:indicatorView];
    });
    
}

+ (void)dismiss {
    //    [SVProgressHUD dismiss];
    [self hide];
    dispatch_async(dispatch_get_main_queue(), ^{
        UIWindow *win = [UIApplication sharedApplication].delegate.window;
        UIView *indicatorView = [win viewWithTag:10089];
        if (indicatorView) {
            [indicatorView removeFromSuperview];
        }
    });
}

+ (void)showInfo:(NSString *)text {
    [self dismiss];
    dispatch_async(dispatch_get_main_queue(), ^{
        UIWindow *win = [UIApplication sharedApplication].delegate.window;
        UIView *hub = [win viewWithTag:10088];
        if (hub) {
            [hub removeFromSuperview];
        }
        UIView *maskView = [[UIView alloc]initWithFrame:[UIScreen mainScreen].bounds];
        maskView.tag = 10088;
        maskView.backgroundColor = [UIColor clearColor];
        maskView.userInteractionEnabled = NO;
        //label
        UILabel *lab = [[UILabel alloc] initWithFrame:CGRectMake(0, 0, 0, 0)];
        lab.textAlignment = NSTextAlignmentCenter;
        lab.numberOfLines = 0;
        lab.textColor = [UIColor whiteColor];
        lab.font = [UIFont systemFontOfSize:14];
        lab.text = text;
        CGFloat height = [@"abc" boundingRectWithSize:CGSizeMake(CGFLOAT_MAX, 20) options:NSStringDrawingUsesFontLeading attributes:@{NSFontAttributeName : lab.font} context:nil].size.height;
        
        [lab sizeToFit];
        CGRect frame = lab.frame;
        frame.size.width = MIN([UIScreen mainScreen].bounds.size.width *0.8, frame.size.width);
        frame.size.height = MIN([UIScreen mainScreen].bounds.size.height *0.5, frame.size.height);
        lab.frame = frame;
        [lab sizeToFit];
        frame = lab.frame;
        
        UIView *bgView = [[UIView alloc]initWithFrame:CGRectMake(0, 0, frame.size.width + height , frame.size.height + height)];
        bgView.backgroundColor = [UIColor blackColor];
        bgView.layer.cornerRadius = MIN(bgView.bounds.size.height *0.25, 20);
        bgView.layer.shadowRadius = 5;
        bgView.layer.shadowOffset = CGSizeMake(5, 5);
        bgView.layer.shadowOpacity = 0.5;
        bgView.layer.shadowColor = [UIColor blackColor].CGColor;
        bgView.center = win.center;
        lab.center = CGPointMake(bgView.bounds.size.width *0.5, bgView.bounds.size.height *0.5);
        
        [bgView addSubview:lab];
        [maskView addSubview:bgView];
        [win addSubview:maskView];
        
        //hidden
        [UIView animateWithDuration:0.5 delay:1.5 options:UIViewAnimationOptionCurveEaseOut animations:^{
            maskView.alpha = 0;
        } completion:^(BOOL finished) {
            [maskView removeFromSuperview];
        }];
    });
    
}

+ (void)hide {
    dispatch_async(dispatch_get_main_queue(), ^{
       UIWindow *win = [UIApplication sharedApplication].delegate.window;
       UIView *hub = [win viewWithTag:10088];
        if (hub) {
            [hub removeFromSuperview];
        }
    });
}

@end
