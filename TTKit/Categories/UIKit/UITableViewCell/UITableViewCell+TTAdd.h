//
//  UITableViewCell+TTAdd.h
//  TTKitDemo
//
//  Created by apple on 2018/2/11.
//  Copyright © 2018年 shang. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface UITableViewCell (TTAdd)

+ (instancetype)tt_reusableCellWithTableView:(UITableView *)tableView isFromXIB:(BOOL)isFromXIB;

@end
