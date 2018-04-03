//
//  TTPieView.h
//  PieDemo
//
//  Created by apple on 2018/3/30.
//  Copyright © 2018年 Shang. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface TTPieView : UIView
/**
 图例颜色长度于数据数组长度保持一致
 */
@property(nonatomic, strong)NSArray<UIColor *> *colors;

- (instancetype)initWithDataArray:(NSArray <NSNumber *> *)dataArray colors:(NSArray<UIColor *> *)colors;

@end
