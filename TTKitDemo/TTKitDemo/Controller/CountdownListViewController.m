//
//  CountdownListViewController.m
//  TTKitDemo
//
//  Created by apple on 2018/1/5.
//  Copyright © 2018年 shang. All rights reserved.
//

#import "CountdownListViewController.h"
#import "BaseListModel.h"
#import "CellModel.h"
#import "NSTimer+YYAdd.h"
#import "TTKitDemo-Swift.h"
#import "TTMacros.h"
#import "TableViewAnimationKit.h"
@interface CountdownListViewController ()

@end

@implementation CountdownListViewController


- (void)viewDidAppear:(BOOL)animated {
    [super viewDidAppear:animated];
    [TableViewAnimationKit shakeAnimationWithTableView:self.tableView];
}

- (void)viewDidLoad {
    [super viewDidLoad];
    self.model = [[BaseListModel alloc]init];
    self.model.allListModels = @[].mutableCopy;
    for (NSInteger i = 0; i < 50; i++) {
        CellModel *model = [[CellModel alloc]init];
        model.date = [NSDate dateWithTimeIntervalSinceNow: 3600*24*i+(arc4random()%100)].timeIntervalSince1970;
        [self.model.allListModels addObject:model];
    }
    [self.tableView registerClass:[TTCountdownCell class] forCellReuseIdentifier:@"TTCountdownCell"];
     
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    TTCountdownCell *cell = [tableView dequeueReusableCellWithIdentifier:@"TTCountdownCell" forIndexPath:indexPath];
    cell.model  =  self.model.allListModels[indexPath.row];
    cell.backgroundColor = [kRandomColor colorWithAlphaComponent:0.5];
    return cell;
}



@end
