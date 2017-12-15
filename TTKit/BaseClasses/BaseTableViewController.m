//
//  BaseTableViewController.m
//  TTKitDemo
//
//  Created by apple on 2017/11/22.
//  Copyright © 2017年 shang. All rights reserved.
//

#import "BaseTableViewController.h"
#import "BaseListModel.h"
#import "TTMacros.h"

NSString *const kTableViewDefaultCellID = @"kTableViewDefaultCellID"; //缺省cell

@interface BaseTableViewController ()

@end

@implementation BaseTableViewController

- (UITableView *)tableView {
    if (!_tableView) {
        _tableView = [[UITableView alloc]initWithFrame:CGRectZero style:UITableViewStylePlain];
        _tableView.backgroundColor = [UIColor whiteColor];
        _tableView.delegate = self;
        _tableView.dataSource = self;
        _tableView.estimatedRowHeight = 44;
        _tableView.estimatedSectionFooterHeight = 0;
        _tableView.estimatedSectionHeaderHeight = 0;
        _tableView.rowHeight = UITableViewAutomaticDimension;
        _tableView.tableFooterView = [UIView new];
        _tableView.separatorInset = UIEdgeInsetsZero;
        [_tableView registerClass:[UITableViewCell class] forCellReuseIdentifier:kTableViewDefaultCellID];
    }
    return _tableView;
}

- (void)viewDidLoad {
    [super viewDidLoad];
   
    self.view.backgroundColor = [UIColor whiteColor];
    self.model = [BaseListModel defaultData];
    [self.view addSubview:self.tableView];
    self.tableView.layer.transform = CATransform3DMakeScale(0.95, 0.95, 1);
    self.tableView.layer.opacity = 0;
    [UIView animateWithDuration:0.7 animations:^{
        self.tableView.layer.opacity = 1;
        self.tableView.layer.transform = CATransform3DIdentity;
    }];
}

- (void)viewDidLayoutSubviews {
    [super viewDidLayoutSubviews];
    self.tableView.frame = self.view.bounds;
}

#pragma mark - tableViewDelegate

-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return self.model.allListModels.count;
}

-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:kTableViewDefaultCellID forIndexPath:indexPath];
    cell.backgroundColor = kRandomColor;
    return cell;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
}

//- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
//    return 44;
//}

- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section {
    return 0.000001;
}

- (CGFloat)tableView:(UITableView *)tableView heightForFooterInSection:(NSInteger)section {
    return 0.000001;
}

@end
