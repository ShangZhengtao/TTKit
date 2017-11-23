
//
//  UITableView+RegisterCell.m
//  TTKitDemo
//
//  Created by apple on 2017/11/22.
//  Copyright © 2017年 shang. All rights reserved.
//

#import "UITableView+RegisterCell.h"

@implementation UITableView (RegisterCell)

#pragma mark - PublicMethod
//register cell
- (void)registerNibCellWithName:(Class)name {
    NSString *ID = NSStringFromClass([name class]);
    [self registerNib:[UINib nibWithNibName:ID bundle:nil] forCellReuseIdentifier:ID];
}
-(void)registerClassCellWithName:(Class)name {
    NSString *ID = NSStringFromClass([name class]);
    [self registerClass:name forCellReuseIdentifier:ID];
}

- (void)registerClassCellsWithArray:(NSArray<Class>*)cells {
    for (Class name in cells) {
        [self registerClassCellWithName:name];
    }
}
- (void)registerNibCellsWithArray:(NSArray<Class>*)cells {
    for (Class name in cells) {
        [self registerNibCellWithName:name];
    }
}
- (__kindof UITableViewCell *)dequeueReusableCellWithClass:(Class)aClass AtIndexPath:(NSIndexPath *)indexPath {
    NSString *ID = NSStringFromClass([aClass class]);
    return [self dequeueReusableCellWithIdentifier:ID forIndexPath:indexPath];
}



@end
