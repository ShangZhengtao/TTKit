//
//  NSString+URL.m
//  Fashion
//
//  Created by 海中金信息中心mac2 on 2017/8/1.
//  Copyright © 2017年 海中金信息中心mac2. All rights reserved.
//

#import "NSString+URL.h"

@implementation NSString (URL)

/**
 *  截取URL中的参数
 *
 *  @return NSMutableDictionary parameters
 */
- (NSMutableDictionary *)getURLParameters {
    // 查找参数
    NSRange range = [self rangeOfString:@"?"];
    if (range.location == NSNotFound) {
        return nil;
    }
    NSMutableDictionary *params = [NSMutableDictionary dictionary];
    // 截取参数
    NSString *parametersString = [self substringFromIndex:range.location + 1];
    // 判断参数是单个参数还是多个参数
    if ([parametersString containsString:@"&"]) {
        // 多个参数，分割参数
        NSArray *urlComponents = [parametersString componentsSeparatedByString:@"&"];
        for (NSString *keyValuePair in urlComponents) {
            // 生成Key/Value
            NSArray *pairComponents = [keyValuePair componentsSeparatedByString:@"="];
            NSString *key = [pairComponents.firstObject stringByRemovingPercentEncoding];
            NSString *value = @"";
            for (NSInteger i = 0; i < pairComponents.count; i++) {
                if (i ==  0) continue; //忽略key
                NSString *componet = [pairComponents[i] stringByRemovingPercentEncoding];
                if (componet.length ==0) { //参数中包含"="情况
                    componet = @"=";
                }
                value = [value stringByAppendingString:componet];
            }
            // Key不能为nil
            if (key == nil || value == nil) {
                continue;
            }
            id existValue = [params valueForKey:key];
            if (existValue != nil) {
                // 已存在的值，生成数组
                if ([existValue isKindOfClass:[NSArray class]]) {
                    // 已存在的值生成数组
                    NSMutableArray *items = [NSMutableArray arrayWithArray:existValue];
                    [items addObject:value];
                    [params setValue:items forKey:key];
                } else {
                    // 非数组
                    [params setValue:@[existValue, value] forKey:key];
                }
            } else {
                // 设置值
                [params setValue:value forKey:key];
            }
        }
    } else {
        // 生成Key/Value
        NSArray *pairComponents = [parametersString componentsSeparatedByString:@"="];
        // 只有一个参数，没有值
        if (pairComponents.count == 1) {
            return nil;
        }
        // 分隔值
        NSString *key = [pairComponents.firstObject stringByRemovingPercentEncoding];
        NSString *value = [pairComponents.lastObject stringByRemovingPercentEncoding];
        // Key不能为nil
        if (key == nil || value == nil) {
            return nil;
        }
        // 设置值
        [params setValue:value forKey:key];
    }
    return params;
}


- (NSString *)stringByReplaceURLParameters:( NSDictionary<NSString *,NSString *> * _Nullable )paramters {
    NSMutableString *url = @"".mutableCopy;
    if (self.length == 0) return url;
    
    if ([self containsString:@"?"]) {
        url = [self substringToIndex:[self rangeOfString:@"?"].location].mutableCopy;
    }else{
        url = self.mutableCopy;
    }
    if (paramters.count == 0) return url;
    [url appendString:@"?"];
    [paramters enumerateKeysAndObjectsUsingBlock:^(id  _Nonnull key, NSString * obj, BOOL * _Nonnull stop) {
        if ([obj isKindOfClass:[NSString class]] && obj.length != 0) {
            [url appendFormat:@"%@=%@&",key,obj];
        }
    }];
    if ([url hasSuffix:@"&"] || [url hasSuffix:@"?"]) {
        [url replaceCharactersInRange:NSMakeRange(url.length -1, 1) withString:@""];
    }
    
    return url;
}

@end
