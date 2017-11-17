//
//  ESAccountManager.h
//  Special
//
//  Created by 空灵圣君 on 16/7/8.
//  Copyright © 2016年 YunYS. All rights reserved.
//

#import <Foundation/Foundation.h>



typedef NS_ENUM(NSInteger, ESAccountType) {
    ESAccountTypeAppPlatfrom = 0,
    ESAccountTypeWeChat,
    ESAccountTypeQQ,
    ESAccountTypeSina
};

typedef NS_ENUM(NSInteger, ESGenderType) {
    ESGenderTypeSecrecy = 0,
    ESGenderTypeMale = 1,
    ESGenderTypeFeminine = 2
};


@interface ESAccountManager : NSObject

/** 用户是否登录 默认 NO*/
@property (nonatomic, getter=isSignedIn) BOOL signedIn;
/** 用户性别 默认 保密*/
@property (nonatomic, copy) NSString *genderDescription;


+ (ESAccountManager *)defaultManager;


#pragma mark getters


/** 登录类型 默认 ESAccountTypeAppPlatfrom */
- (ESAccountType)accountType;
/** 用户ID 默认 ""*/
- (NSString *)userID;
/** 用户密码 默认 ""*/
- (NSString *)password;
/** token 默认 ""*/
- (NSString *)token;
/** refresh token 默认 ""*/
- (NSString *)refreshToken;
/** 用户姓名 默认 ""*/
- (NSString *)username;
/** 用户手机 默认 ""*/
- (NSString *)phoneNumber;
/** 用户性别 默认 保密*/
- (ESGenderType)genderType;
/** 用户昵称 默认 ""*/
- (NSString *)nickname;
/** 用户头像地址 默认 ""*/
- (NSString *)avatarURLPath;
/** 用户签名 默认 ""*/
- (NSString *)signature;
/** 用户生日 默认 @""*/
- (NSString *)birthday;
/** 用户邮件地址 默认 ""*/
- (NSString *)email;
/**第三方登录数据*/
- (NSDictionary *)vendorData;

#pragma mark reset


/**重置登录类型*/
- (void)resetAccountType:(ESAccountType) newAccountType;
/**重置用户ID*/
- (void)resetUserID:(NSString *)newUserID;
/** 重置用户密码*/
- (void)resetPassword:(NSString *)newPassword;
/** 重置token*/
- (void)resetToken:(NSString *)newToken;
/** 重置 refresh token*/
- (void)resetRefreshToken:(NSString *)newRefreshToken;
/** 重置用户名称*/
- (void)resetUsername:(NSString *)newUsername;
/** 重置用户手机号*/
- (void)resetPhoneNumber:(NSString *)newPhoneNumber;
/** 重置用户性别*/
- (void)resetGenderType:(ESGenderType)newGenderType;
/** 重置用户昵称*/
- (void)resetNickname:(NSString *)newNickname;
/** 重置用户头像地址*/
- (void)resetAvatarURLPath:(NSString *)newAvatarURLPath;
/** 重置用户个性签名*/
- (void)resetSignture:(NSString *)newSignture;
/** 重置用户生日*/
- (void)resetBirthday:(NSString *)newBirthday;
/** 重置用户邮件地址*/
- (void)resetEmail:(NSString *)newEmail;
/** 重置第三方登录数据*/
- (void)resetVendorData:(NSDictionary *)newVendorData;

/** 重置所有用户信息*/
- (void)resetAccountInfo;

@end


//维护本地信息
@interface ESAccountInfo : NSObject

@property (nonatomic) ESAccountType accountType;
@property (nonatomic) ESGenderType genderType;

@property (nonatomic, copy) NSString *userID;
@property (nonatomic, copy) NSString *password;
@property (nonatomic, copy) NSString *token;
@property (nonatomic, copy) NSString *refreshToken;
@property (nonatomic, copy) NSString *username;
@property (nonatomic, copy) NSString *phoneNumber;
@property (nonatomic, copy) NSString *nickname;
@property (nonatomic, copy) NSString *avatarURLPath;
@property (nonatomic, copy) NSString *signature;
@property (nonatomic, copy) NSString *birthday;
@property (nonatomic, copy) NSString *email;
@property (nonatomic, strong) NSDictionary *vendorData;


@end
