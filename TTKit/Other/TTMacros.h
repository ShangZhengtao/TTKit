//
//  TTMacros.h
//  TTKitDemo
//
//  Created by apple on 2017/11/21.
//  Copyright © 2017年 shang. All rights reserved.
//

#ifndef TTMacros_h
#define TTMacros_h

//*****************Utils************************

//✨获取系统对象
#define kApplication        [UIApplication sharedApplication]
#define kAppWindow          [UIApplication sharedApplication].delegate.window
#define kAppDelegate        [AppDelegate shareAppDelegate]
#define kRootViewController [UIApplication sharedApplication].delegate.window.rootViewController
#define kUserDefaults       [NSUserDefaults standardUserDefaults]
#define kNotificationCenter [NSNotificationCenter defaultCenter]

//✨设备尺寸
#define kStatusBarHeight [[UIApplication sharedApplication] statusBarFrame].size.height
#define kNavBarHeight 44.0
#define kTabBarHeight ([[UIApplication sharedApplication] statusBarFrame].size.height>20?83:49)
#define kTopHeight (kStatusBarHeight + kNavBarHeight)

#define kScreenWidth    [[UIScreen mainScreen] bounds].size.width
#define kScreenHeight   [[UIScreen mainScreen] bounds].size.height
#define kScreenBounds   [UIScreen mainScreen].bounds

#define kiPhone6ScaleWidth KScreenWidth/375.0
#define kiPhone6ScaleHeight KScreenHeight/667.0
#define kRealValue(with) ((with)*(KScreenWidth/375.0f)) //根据iPhone6(4.7寸)的屏幕来拉伸

#define kiPhone4  ([UIScreen mainScreen].bounds.size.height == 480)
#define kiPhone5  ([UIScreen mainScreen].bounds.size.height == 568)
#define kiPhone6  ([UIScreen mainScreen].bounds.size.height == 667)
#define kiPhone6Plus  ([UIScreen mainScreen].bounds.size.height == 736)
#define kiPhoneX ([UIScreen mainScreen].bounds.size.height == 812)

//✨系统信息
//iOS 版本判断
#define IOSAVAILABLEVERSION(version) ([[UIDevice currentDevice] availableVersion:version] < 0)
//当前系统版本
#define kCurrentSystemVersion [[UIDevice currentDevice].systemVersion doubleValue]
//当前语言
#define kCurrentLanguage (［NSLocale preferredLanguages] objectAtIndex:0])

//✨Log
#ifdef DEBUG
#define DLog(fmt, ...) NSLog((@"%s [Line %d] " fmt), __PRETTY_FUNCTION__, __LINE__, ##__VA_ARGS__);
#else
#define DLog(...)
#endif

//✨颜色
#define kRGBColor(r,g,b,a)   [UIColor colorWithRed:(r)/255.0f green:(g)/255.0f blue:(b)/255.0f alpha:(a)]
#define kRandomColor    kRGBColor(arc4random_uniform(256),arc4random_uniform(256),arc4random_uniform(256),1)        //随机色生成
#define kUIColorFromRGB(rgbValue)\
[UIColor colorWithRed:((float)((rgbValue & 0xFF0000) >> 16))/255.0 \
green:((float)((rgbValue & 0xFF00) >> 8))/255.0 \
blue:((float)(rgbValue & 0xFF))/255.0 \
alpha:1.0]
#define kThemeColor     kUIColorFromRGB(0x05AEEF)//主题色
#define kTextColorDark  kUIColorFromRGB(0x222222)//文字—深
#define kTextColorLight kUIColorFromRGB(0xadadad)//文字-浅

//✨字体
#define BOLDSYSTEMFONT(FONTSIZE)[UIFont boldSystemFontOfSize:FONTSIZE]
#define SYSTEMFONT(FONTSIZE)    [UIFont systemFontOfSize:FONTSIZE]
#define FONT(NAME, FONTSIZE)    [UIFont fontWithName:(NAME) size:(FONTSIZE)]

//✨发送通知
#define kPostNotification(name,obj) [[NSNotificationCenter defaultCenter] postNotificationName:name object:obj];

//✨单例类
#define SINGLETON_FOR_HEADER(className) \
\
+ (className *)shared##className;

#define SINGLETON_FOR_CLASS(className) \
\
+ (className *)shared##className { \
static className *shared##className = nil; \
static dispatch_once_t onceToken; \
dispatch_once(&onceToken, ^{ \
shared##className = [[self alloc] init]; \
}); \
return shared##className; \
}

/**
 取消自动适配 ScrollView 的 Insets 行为适配iOS 11
 @param scrollView 滑动视图
 @param vc 所在控制器
 */
#define kDisbaleAutoAdjustScrollViewInsets(scrollView, vc)\
do { \
_Pragma("clang diagnostic push") \
_Pragma("clang diagnostic ignored \"-Warc-performSelector-leaks\"") \
if ([UIScrollView instancesRespondToSelector:NSSelectorFromString(@"setContentInsetAdjustmentBehavior:")]) {\
[scrollView   performSelector:NSSelectorFromString(@"setContentInsetAdjustmentBehavior:") withObject:@(2)];\
} else {\
vc.automaticallyAdjustsScrollViewInsets = NO;\
}\
_Pragma("clang diagnostic pop") \
} while (0)


//*****************config************************

//appid 由开发者账号后台创建应用时生成
#define kAppID @"122321"



#endif /* TTMacros_h */
