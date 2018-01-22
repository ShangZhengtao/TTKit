//
//  UITableView+RegisterCell.h
//  TTKitDemo
//
//  Created by apple on 2017/11/22.
//  Copyright © 2017年 shang. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface UITableView (RegisterCell)

- (void)registerClassCellWithName:(Class)name;
- (void)registerNibCellWithName:(Class)name;
- (void)registerClassCellsWithArray:(NSArray<Class>*)cells;
- (void)registerNibCellsWithArray:(NSArray<Class>*)cells;

- (__kindof UITableViewCell *)dequeueReusableCellWithClass:(Class)aClass AtIndexPath:(NSIndexPath *)indexPath;

@end
