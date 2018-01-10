//
//  BaseListModel.m
//  TTKitDemo
//
//  Created by apple on 2017/11/22.
//  Copyright © 2017年 shang. All rights reserved.
//

#import "BaseListModel.h"

@implementation BaseListModel

+ (instancetype)defaultData {
    BaseListModel *model = [[BaseListModel alloc]init];
    model.allListModels = @[@"",@"",@"",@"",@""].mutableCopy;
    return model;
}

@end
