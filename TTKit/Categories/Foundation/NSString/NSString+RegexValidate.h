//
//  NSString+RegexValidate.h
//  ESOUtils
//
//  Created by 空灵圣君 on 15/10/22.
//  Copyright © 2015年 EmptySoulOffice. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface NSString (RegexValidate)

- (BOOL)isValidNumber;
- (BOOL)isValidUsername;
- (BOOL)isValidMobile;
- (BOOL)isValidEmail;
- (BOOL)isValidPassword;
- (BOOL)isValidZipCode;
- (BOOL)isValidateIdentityCard;

- (BOOL)isContainsEmoji;
- (BOOL)isBlankString;
- (BOOL)isChinese;
- (BOOL)includeChinese;
- (BOOL)includeEnglish;

- (NSString *)filterEmoji;

@end
