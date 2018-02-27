//
//  BaseTouchTableViewCell.h
//  TTKitDemo
//
//  Created by apple on 2018/2/11.
//  Copyright © 2018年 shang. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface BaseTouchTableViewCell : UITableViewCell

- (void)touchingAnimateForView:(UIView *)view touchPoint:(CGPoint)touchPoint;

- (void)tapCellInView:(UIView *)view point:(CGPoint)tapPoint;
- (void)longPressCellInView:(UIView *)view point:(CGPoint)point;


@end
