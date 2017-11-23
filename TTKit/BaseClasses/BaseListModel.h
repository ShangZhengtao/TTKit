//
//  BaseListModel.h
//  TTKitDemo
//
//  Created by apple on 2017/11/22.
//  Copyright © 2017年 shang. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface BaseListModel : NSObject

@property (nonatomic, strong) NSArray *allListModels;
/**模拟数据*/
+(instancetype)defaultData;
@end
