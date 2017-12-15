//
//  ESEncryptor.h
//  Special
//
//  Created by 空灵圣君 on 16/7/8.
//  Copyright © 2016年 YunYS. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface ESEncryptor : NSObject

/**
 加密字符串 保存为二进制数据在本地
 
 @param encryptionString 需要加密的字符串
 @return 加密后的二进制数据
 */
+ (NSData*)es_encrypt:(NSString*)encryptionString;

/**
 解密本地二进制数据 返回原始字符串
 
 @param decryptionData 需要解密的二进制数据
 @return 原始字符串
 */
+ (NSString*)es_decrypt:(NSData*)decryptionData;

/**
 加密字典
 */
+ (NSData*)es_encryptDictionary:(NSDictionary*)encryptionDictionary;

/**
 解密字典
 */
+ (NSDictionary*)es_decryptDictionary:(NSData*)decryptionData;

@end

@interface NSData (ESEncryptor)

- (NSData *)es_AES256EncryptWithKey:(NSString *)key;   //加密

- (NSData *)es_AES256DecryptWithKey:(NSString *)key;   //解密

- (NSString *)es_newStringInBase64FromData;            //追加64编码

+ (NSString*)es_base64encode:(NSString*)str;           //同上64编码

@end
