//
//  ESAccountManager.m
//  Special
//
//  Created by 空灵圣君 on 16/7/8.
//  Copyright © 2016年 YunYS. All rights reserved.
//

#import "ESAccountManager.h"
#import "ESEncryptor.h"

@implementation ESAccountInfo

- (instancetype)init{
    self = [super init];
    if (self) {
        _accountType = [[ESEncryptor es_decrypt:[self objectInUserDefaultsForKey:@"accountType"]] integerValue];
        _userID = [ESEncryptor es_decrypt:[self objectInUserDefaultsForKey:@"userID"]];
        _password = [ESEncryptor es_decrypt:[self objectInUserDefaultsForKey:@"password"]];
        _token = [ESEncryptor es_decrypt:[self objectInUserDefaultsForKey:@"token"]];
        _refreshToken = [ESEncryptor es_decrypt:[self objectInUserDefaultsForKey:@"refreshToken"]];
        _username = [ESEncryptor es_decrypt:[self objectInUserDefaultsForKey:@"username"]];
        _phoneNumber = [ESEncryptor es_decrypt:[self objectInUserDefaultsForKey:@"phoneNumber"]];
        _genderType =[[ESEncryptor es_decrypt:[self objectInUserDefaultsForKey:@"genderType"]] integerValue];
        _nickname = [ESEncryptor es_decrypt:[self objectInUserDefaultsForKey:@"nickname"]];
        _avatarURLPath = [ESEncryptor es_decrypt:[self objectInUserDefaultsForKey:@"avatarURLPath"]];
        _signature = [ESEncryptor es_decrypt:[self objectInUserDefaultsForKey:@"signature"]];
        _birthday = [ESEncryptor es_decrypt:[self objectInUserDefaultsForKey:@"birthday"]];
        _email = [ESEncryptor es_decrypt:[self objectInUserDefaultsForKey:@"email"]];
        _vendorData = [ESEncryptor es_decryptDictionary:[self objectInUserDefaultsForKey:@"vendorData"]];
    }
    return self;
}

#pragma mark geters
/** 登录类型 默认 ESSignedInTypeMytee */
//- (ESSignedInType)signedInType{
//    return _signedInType;
//}

/** 用户ID 默认 ""*/
- (NSString *)userID{
    return _userID;
}

/** 用户密码 默认 ""*/
- (NSString *)password{
    return _password;
}

/** token 默认 ""*/
- (NSString *)token{
    return _token;
}

/** refresh token 默认 ""*/
- (NSString *)refreshToken{
    return _refreshToken;
}

/** 用户姓名 默认 ""*/
- (NSString *)username{
    return _username;
}

/** 用户手机 默认 ""*/
- (NSString *)phoneNumber{
    return _phoneNumber;
}

/** 用户昵称 默认 ""*/
- (NSString *)nickname{
    return _nickname;
}

/** 用户头像地址 默认 ""*/
- (NSString *)avatarURLPath{
    return _avatarURLPath;
}

/** 用户签名 默认 ""*/
- (NSString *)signature{
    return _signature;
}

/** 用户生日 默认 当前时间*/
- (NSString *)birthday{
    return _birthday;
}

/** 用户邮件地址 默认 ""*/
- (NSString *)email{
    return _email;
}
/** 第三方登录数据 默认 @{}*/
- (NSDictionary *)vendorData {
    return _vendorData;
}
#pragma mark reset

/**重置登录类型*/
- (void)resetAccountType:(ESAccountType) newAccountType;{
    _accountType = newAccountType;
    
    NSData *encryptSignedType = [ESEncryptor es_encrypt:[NSString stringWithFormat:@"%ld", (long)_accountType]];
   [self setObjectInUserDefaults:encryptSignedType withKey:@"accountType"];
}

/**重置用户ID*/
- (void)resetUserID:(NSString *)newUserID{
    _userID = newUserID;

    NSData *encryptUserID = [ESEncryptor es_encrypt:_userID];
    [self setObjectInUserDefaults:encryptUserID withKey:@"userID"];
}

/** 重置用户密码*/
- (void)resetPassword:(NSString *)newPassword{
    _password = newPassword;
    
    NSData *encryptPassword = [ESEncryptor es_encrypt:_password];
    [self setObjectInUserDefaults:encryptPassword withKey:@"password"];
}

/** 重置token*/
- (void)resetToken:(NSString *)newToken{
    _token = newToken;
    
    NSData *encryptToken = [ESEncryptor es_encrypt:_token];
    [self setObjectInUserDefaults:encryptToken withKey:@"token"];
}

/** 重置 refresh token*/
- (void)resetRefreshToken:(NSString *)newRefreshToken{
    _refreshToken = newRefreshToken;
    
    NSData *encryptRefreshToken = [ESEncryptor es_encrypt:_refreshToken];
    [self setObjectInUserDefaults:encryptRefreshToken withKey:@"refreshToken"];
    
}

/** 重置用户名称*/
- (void)resetUsername:(NSString *)newUsername{
    _username = newUsername;
    
    NSData *encryptUsername = [ESEncryptor es_encrypt:_username];
    [self setObjectInUserDefaults:encryptUsername withKey:@"username"];
}

/** 重置用户手机号*/
- (void)resetPhoneNumber:(NSString *)newPhoneNumber{
    _phoneNumber = newPhoneNumber;
    
    NSData *encryptPhoneNumber = [ESEncryptor es_encrypt:_phoneNumber];
    [self setObjectInUserDefaults:encryptPhoneNumber withKey:@"phoneNumber"];
}

- (void)resetGenderType:(ESGenderType)newGenderType{
    _genderType = newGenderType;
    NSData *encryptGenderType = [ESEncryptor es_encrypt:[NSString stringWithFormat:@"%ld", (long)_genderType]];
    [self setObjectInUserDefaults:encryptGenderType withKey:@"genderType"];
}

/** 重置用户昵称*/
- (void)resetNickname:(NSString *)newNickname{
    _nickname = newNickname;
    
    NSData *encryptNickname = [ESEncryptor es_encrypt:_nickname];
    [self setObjectInUserDefaults:encryptNickname withKey:@"nickname"];
}

/** 重置用户头像地址*/
- (void)resetAvatarURLPath:(NSString *)newAvatarURLPath{
    _avatarURLPath = newAvatarURLPath;
    
    NSData *encryptAvartarURLPath = [ESEncryptor es_encrypt:_avatarURLPath];
    [self setObjectInUserDefaults:encryptAvartarURLPath withKey:@"avatarURLPath"];
}

/** 重置用户个性签名*/
- (void)resetSignture:(NSString *)newSignture{
    _signature = newSignture;
    
    NSData *encryptSignture = [ESEncryptor es_encrypt:_signature];
    [self setObjectInUserDefaults:encryptSignture withKey:@"signature"];
}

/** 重置用户生日*/
- (void)resetBirthday:(NSString *)newBirthday{
    _birthday = newBirthday;
    
    NSData *encryptBirthday = [ESEncryptor es_encrypt:_birthday];
    [self setObjectInUserDefaults:encryptBirthday withKey:@"birthday"];
}

/** 重置用户邮件地址*/
- (void)resetEmail:(NSString *)newEmail{
    _email = newEmail;
    
    NSData *encryptEmail = [ESEncryptor es_encrypt:_email];
    [self setObjectInUserDefaults:encryptEmail withKey:@"email"];
}

/** 重置第三方数据*/
- (void)resetVendorData:(NSDictionary *)newVendorData {
    _vendorData = newVendorData;
    NSData *encryptVendorData = [ESEncryptor es_encryptDictionary:newVendorData];
    [self setObjectInUserDefaults:encryptVendorData withKey:@"vendorData"];
}

/** 重置所有用户信息*/
- (void)resetAccountInfo{
    [self resetAccountType:ESAccountTypeAppPlatfrom];
    [self resetUserID:@""];
    [self resetPassword:@""];
    [self resetToken:@""];
    [self resetRefreshToken:@""];
    [self resetUsername:@""];
    [self resetPhoneNumber:@""];
    [self resetGenderType:ESGenderTypeSecrecy];
    [self resetNickname:@""];
    [self resetAvatarURLPath:@""];
    [self resetSignture:@""];
    [self resetBirthday:@""];
    [self resetEmail:@""];
    [self resetVendorData:@{}];
}

#pragma mark private
//目前采样NSUserDefaults存取账号信息
- (id)objectInUserDefaultsForKey:(NSString*)key{
    NSUserDefaults *ud = [NSUserDefaults standardUserDefaults];
    return [ud objectForKey:key];
}

- (void)setObjectInUserDefaults:(id)object withKey:(NSString*)key{
    NSUserDefaults *ud = [NSUserDefaults standardUserDefaults];
    [ud setObject:object forKey:key];
    [ud synchronize];
}

@end

@interface ESAccountManager ()

@property (nonatomic, strong) ESAccountInfo *accountInfo;

@end

static ESAccountManager *_defaultManagerInstance = nil;

@implementation ESAccountManager

+ (ESAccountManager *)defaultManager{
        static dispatch_once_t predicate;
        dispatch_once(&predicate, ^{
            _defaultManagerInstance = [[ESAccountManager alloc] init];
        });
    return _defaultManagerInstance;
}

- (instancetype)init{
    self = [super init];
    if (self) {
        _accountInfo  = [[ESAccountInfo alloc] init];
    }
    return self;
}

/** 用户是否登录 默认 NO*/
- (BOOL)isSignedIn{
    return _accountInfo.userID.length;
}

- (NSString *)genderDescription{
    if (_accountInfo.genderType == 1) {
        return @"男";
    }else if (_accountInfo.genderType == 2){
        return @"女";
    }else{
        return @"保密";
    }
}

/** 登录类型 默认 ESSignedInTypeMytee */
- (ESAccountType)accountType{
    return _accountInfo.accountType;
}

/** 用户ID 默认 ""*/
- (NSString *)userID{
    return _accountInfo.userID;
}

/** 用户密码 默认 ""*/
- (NSString *)password {
    return _accountInfo.password;
}

/** token 默认 ""*/
- (NSString *)token {
    return _accountInfo.token;
}

/** refresh token 默认 ""*/
- (NSString *)refreshToken {
    return _accountInfo.refreshToken;
}

/** 用户姓名 默认 ""*/
- (NSString *)username{
    return _accountInfo.username;
}

/** 用户手机 默认 ""*/
- (NSString *)phoneNumber{
    return _accountInfo.phoneNumber;
}

- (ESGenderType)genderType{
    return _accountInfo.genderType;
}

/** 用户昵称 默认 ""*/
- (NSString *)nickname{
    return _accountInfo.nickname;
}

/** 用户头像地址 默认 ""*/
- (NSString *)avatarURLPath{
    return _accountInfo.avatarURLPath;
}

/** 用户签名 默认 ""*/
- (NSString *)signature{
    return _accountInfo.signature;
}

/** 用户生日 默认 当前时间*/
- (NSString *)birthday{
    return _accountInfo.birthday;
}

/** 用户邮件地址 默认 ""*/
- (NSString *)email{
    return _accountInfo.email;
}

/** 用户第三方登录数据 默认 @{} ""*/
- (NSDictionary *)vendorData{
    return _accountInfo.vendorData;
}

#pragma mark reset

/**重置登录类型*/
- (void)resetAccountType:(ESAccountType)newAccountType{
    [_accountInfo resetAccountType:newAccountType];
}

/**重置用户ID*/
- (void)resetUserID:(NSString *)newUserID{
    [_accountInfo resetUserID:newUserID];
}

/** 重置用户密码*/
- (void)resetPassword:(NSString *)newPassword{
    [_accountInfo resetPassword:newPassword];
}

/** 重置token*/
- (void)resetToken:(NSString *)newToken{
    [_accountInfo resetToken:newToken];
}

/** 重置 refresh token*/
- (void)resetRefreshToken:(NSString *)newRefreshToken{
    [_accountInfo resetRefreshToken:newRefreshToken];
}

/** 重置用户名称*/
- (void)resetUsername:(NSString *)newUsername{
    [_accountInfo resetUsername:newUsername];
}

/** 重置用户手机号*/
- (void)resetPhoneNumber:(NSString *)newPhoneNumber{
    [_accountInfo resetPhoneNumber:newPhoneNumber];
}

- (void)resetGenderType:(ESGenderType)newGenderType{
    [_accountInfo resetGenderType:newGenderType];
}
/** 重置用户昵称*/
- (void)resetNickname:(NSString *)newNickname{
    [_accountInfo resetNickname:newNickname];
}

/** 重置用户头像地址*/
- (void)resetAvatarURLPath:(NSString *)newAvatarURLPath{
    [_accountInfo resetAvatarURLPath:newAvatarURLPath];
}

/** 重置用户个性签名*/
- (void)resetSignture:(NSString *)newSignture{
    [_accountInfo resetSignture:newSignture];
}

/** 重置用户生日*/
- (void)resetBirthday:(NSString *)newBirthday{
    [_accountInfo resetBirthday:newBirthday];
}

/** 重置用户邮件地址*/
- (void)resetEmail:(NSString *)newEmail{
    [_accountInfo resetEmail:newEmail];
}

/** 重置第三方登录数据*/
- (void)resetVendorData:(NSDictionary *)newVendorData {
    [_accountInfo resetVendorData:newVendorData];
}


/** 重置所有用户信息*/
- (void)resetAccountInfo{
    [_accountInfo resetAccountInfo];
}

@end
