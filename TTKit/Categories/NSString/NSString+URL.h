//
//  NSString+URL.h
//  Fashion
//
//  Created by 海中金信息中心mac2 on 2017/8/1.
//  Copyright © 2017年 海中金信息中心mac2. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface NSString (URL)

/**
 获取URL中包含的参数 

 @return 参数键值对
 */
- (NSMutableDictionary *)getURLParameters;
@end
