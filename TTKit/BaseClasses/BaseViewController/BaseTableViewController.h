//
//  BaseTableViewController.h
//  TTKitDemo
//
//  Created by apple on 2017/11/22.
//  Copyright © 2017年 shang. All rights reserved.
//

#import <UIKit/UIKit.h>

UIKIT_EXTERN NSString *const kTableViewDefaultCellID;

@class BaseListModel;
@interface BaseTableViewController : UIViewController
<UITableViewDelegate,UITableViewDataSource>

@property (nonatomic, strong) UITableView *tableView;
/**数据模型*/
@property (nonatomic, strong) __kindof BaseListModel *model;

@end
