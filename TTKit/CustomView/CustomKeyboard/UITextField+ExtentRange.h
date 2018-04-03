//
//  UITextField+ExtentRange.h
//  CustomKeyBoardDemo
//
//  Created by apple on 2018/4/3.
//  Copyright © 2018年 Shang. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface UITextField (ExtentRange)

- (NSRange)selectedRange;
//UITextField必须为第一响应者才有效
- (void)setSelectedRange:(NSRange) range;
@end
