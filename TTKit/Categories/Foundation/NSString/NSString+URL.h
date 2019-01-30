//
//  NSString+URL.h
//  Fashion
//
//  Created by 海中金信息中心mac2 on 2017/8/1.
//  Copyright © 2017年 海中金信息中心mac2. All rights reserved.
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN
@interface NSString (URL)

/**
 获取URL中包含的参数 

 @return 参数键值对
 */
- ( NSMutableDictionary * _Nullable)getURLParameters;

/**
 用指定键值对，替换url中所有参数（空字典会删除url参数）

 @param paramters 需要替换的url参数
 @return 替换完成的url
 */
- (NSString *)stringByReplaceURLParameters:( NSDictionary<NSString *,NSString *> * _Nullable )paramters;
@end
NS_ASSUME_NONNULL_END
