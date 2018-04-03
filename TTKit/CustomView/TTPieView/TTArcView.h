//
//  TTArcView.h
//  PieDemo
//
//  Created by apple on 2018/3/29.
//  Copyright © 2018年 Shang. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface TTArcView : UIView
/**所占比例0-1*/
@property (nonatomic, assign) double scale;
/**开始位置0-1*/
@property (nonatomic, assign) double startScale;
/**空心比例0-1*/
@property (nonatomic, assign) double holeScale;

@end
