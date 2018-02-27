//
//  UITableViewCell+TTAdd.m
//  TTKitDemo
//
//  Created by apple on 2018/2/11.
//  Copyright © 2018年 shang. All rights reserved.
//

#import "UITableViewCell+TTAdd.h"

@implementation UITableViewCell (TTAdd)

+ (instancetype)tt_reusableCellWithTableView:(UITableView *)tableView isFromXIB:(BOOL)isFromXIB {
    NSString *identifier = NSStringFromClass(self);
    id cell = [tableView dequeueReusableCellWithIdentifier:identifier];
    if (!cell) {
        if (isFromXIB) {
            cell = [[NSBundle mainBundle] loadNibNamed:identifier owner:self options:nil].firstObject;
        }else {
            cell = [[self alloc]initWithStyle:UITableViewCellStyleValue1 reuseIdentifier:identifier];
        }
    }
    return cell;
}

@end
