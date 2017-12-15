//
//  ESEncryptor.m
//  Special
//
//  Created by 空灵圣君 on 16/7/8.
//  Copyright © 2016年 YunYS. All rights reserved.
//

#import "ESEncryptor.h"

#define kEncryptionKey  @"5E29C2DD8C8176BB480D46CBFAD916E3"

@implementation ESEncryptor

/**
 加密字符串 保存为二进制数据在本地

 @param encryptionString 需要加密的字符串
 @return 加密后的二进制数据
 */
+ (NSData*)es_encrypt:(NSString*)encryptionString{
    NSData *plain = [encryptionString dataUsingEncoding:NSUTF8StringEncoding];
    NSData *cipher = [plain es_AES256EncryptWithKey:kEncryptionKey];
    return cipher;
}

/**
 解密本地二进制数据 返回原始字符串

 @param decryptionData 需要解密的二进制数据
 @return 原始字符串
 */
+ (NSString*)es_decrypt:(NSData*)decryptionData{
    NSData *plain = [decryptionData es_AES256DecryptWithKey:kEncryptionKey];
    return [[NSString alloc] initWithData:plain encoding:NSUTF8StringEncoding];
}

/**
 加密字典
 */
+ (NSData*)es_encryptDictionary:(NSDictionary*)encryptionDictionary{
    if (encryptionDictionary == nil) { return nil; }
    NSData *plain = [NSJSONSerialization dataWithJSONObject:encryptionDictionary options:NSJSONWritingPrettyPrinted error:nil];
    NSData *cipher = [plain es_AES256EncryptWithKey:kEncryptionKey];
    return cipher;
}
/**
 解密字典
 */
+ (NSDictionary*)es_decryptDictionary:(NSData*)decryptionData{
    if (decryptionData == nil) { return nil;}
    NSData *plain = [decryptionData es_AES256DecryptWithKey:kEncryptionKey];
    return [NSJSONSerialization JSONObjectWithData:plain options:NSJSONReadingMutableLeaves error:nil];
}

@end



#import <CommonCrypto/CommonCryptor.h>

static char base64[] = "ABCDEFGHIJKLMNOPQRSTUVWXYZabcdefghijklmnopqrstuvwxyz0123456789+/=";

@implementation NSData(ESEncryptor)

- (NSData *)es_AES256EncryptWithKey:(NSString *)key {
    // 'key' should be 32 bytes for AES256, will be null-padded otherwise
    char keyPtr[kCCKeySizeAES256+1]; // room for terminator (unused)
    bzero(keyPtr, sizeof(keyPtr)); // fill with zeroes (for padding)
    
    // fetch key data
    [key getCString:keyPtr maxLength:sizeof(keyPtr) encoding:NSUTF8StringEncoding];
    
    NSUInteger dataLength = [self length];
    
    //See the doc: For block ciphers, the output size will always be less than or
    //equal to the input size plus the size of one block.
    //That's why we need to add the size of one block here
    size_t bufferSize = dataLength + kCCBlockSizeAES128;
    void *buffer = malloc(bufferSize);
    
    size_t numBytesEncrypted = 0;
    CCCryptorStatus cryptStatus = CCCrypt(kCCEncrypt, kCCAlgorithmAES128, kCCOptionPKCS7Padding,
                                          keyPtr, kCCKeySizeAES256,
                                          NULL /* initialization vector (optional) */,
                                          [self bytes], dataLength, /* input */
                                          buffer, bufferSize, /* output */
                                          &numBytesEncrypted);
    if (cryptStatus == kCCSuccess) {
        //the returned NSData takes ownership of the buffer and will free it on deallocation
        return [NSData dataWithBytesNoCopy:buffer length:numBytesEncrypted];
    }
    
    free(buffer); //free the buffer;
    return nil;
}

- (NSData *)es_AES256DecryptWithKey:(NSString *)key {
    // 'key' should be 32 bytes for AES256, will be null-padded otherwise
    char keyPtr[kCCKeySizeAES256+1]; // room for terminator (unused)
    bzero(keyPtr, sizeof(keyPtr)); // fill with zeroes (for padding)
    
    // fetch key data
    [key getCString:keyPtr maxLength:sizeof(keyPtr) encoding:NSUTF8StringEncoding];
    
    NSUInteger dataLength = [self length];
    
    //See the doc: For block ciphers, the output size will always be less than or
    //equal to the input size plus the size of one block.
    //That's why we need to add the size of one block here
    size_t bufferSize = dataLength + kCCBlockSizeAES128;
    void *buffer = malloc(bufferSize);
    
    size_t numBytesDecrypted = 0;
    CCCryptorStatus cryptStatus = CCCrypt(kCCDecrypt, kCCAlgorithmAES128, kCCOptionPKCS7Padding,
                                          keyPtr, kCCKeySizeAES256,
                                          NULL /* initialization vector (optional) */,
                                          [self bytes], dataLength, /* input */
                                          buffer, bufferSize, /* output */
                                          &numBytesDecrypted);
    
    if (cryptStatus == kCCSuccess) {
        //the returned NSData takes ownership of the buffer and will free it on deallocation
        return [NSData dataWithBytesNoCopy:buffer length:numBytesDecrypted];
    }
    
    free(buffer); //free the buffer;
    return nil;
}

- (NSString *)es_newStringInBase64FromData            //追加64编码
{
    NSMutableString *dest = [[NSMutableString alloc] initWithString:@""];
    
    unsigned char * working = (unsigned char *)[self bytes];
    
    int srcLen = (int)[self length];
    
    for (int i=0; i<srcLen; i += 3) {
        
        for (int nib=0; nib<4; nib++) {
            
            int byt = (nib == 0)?0:nib-1;
            
            int ix = (nib+1)*2;
            
            if (i+byt >= srcLen) break;
            
            unsigned char curr = ((working[i+byt] << (8-ix)) & 0x3F);
            
            if (i+nib < srcLen) curr |= ((working[i+nib] >> ix) & 0x3F);
            
            [dest appendFormat:@"%c", base64[curr]];
            
        }
    }
    return dest;
}

+ (NSString*)es_base64encode:(NSString*)str
{
    if ([str length] == 0)
        return @"";
    
    const char *source = [str UTF8String];
    
    int strlength  = (int)strlen(source);
    
    char *characters = malloc(((strlength + 2) / 3) * 4);
    
    if (characters == NULL)
        
        return nil;
    
    NSUInteger length = 0;
    
    NSUInteger i = 0;
    
    while (i < strlength) {
        
        char buffer[3] = {0,0,0};
        
        short bufferLength = 0;
        
        while (bufferLength < 3 && i < strlength)
            
            buffer[bufferLength++] = source[i++];
        
        characters[length++] = base64[(buffer[0] & 0xFC) >> 2];
        
        characters[length++] = base64[((buffer[0] & 0x03) << 4) | ((buffer[1] & 0xF0) >> 4)];
        
        if (bufferLength > 1)
            
            characters[length++] = base64[((buffer[1] & 0x0F) << 2) | ((buffer[2] & 0xC0) >> 6)];
        
        else characters[length++] = '=';
        
        if (bufferLength > 2)
            
            characters[length++] = base64[buffer[2] & 0x3F];
        
        else characters[length++] = '=';
        
    }
    
    NSString *g = [[NSString alloc] initWithBytesNoCopy:characters length:length encoding:NSASCIIStringEncoding freeWhenDone:YES];
    return g;
}



@end
