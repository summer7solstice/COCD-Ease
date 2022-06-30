//
//  CommonConstant.h
//  ZNZNew
//
//  Created by xjhuang on 2018/7/11.
//  Copyright © 2018年 xjhuang. All rights reserved.
//

#ifndef CommonConstant_h
#define CommonConstant_h
//主窗口
#define XJ_MAINWINDOW UIApplication.sharedApplication.keyWindow

/// 存储应用版本的key
#define XJApplicationVersionKey   @"SBApplicationVersionKey"
/// 应用名称
#define XJ_APP_NAME    ([[[NSBundle mainBundle] infoDictionary] objectForKey:@"CFBundleName"])
/// 应用版本号
#define XJ_APP_VERSION ([[[NSBundle mainBundle] infoDictionary] objectForKey:@"CFBundleShortVersionString"])
/// 应用build
#define XJ_APP_BUILD   ([[[NSBundle mainBundle] infoDictionary] objectForKey:@"CFBundleVersion"])



// 输出日志 (格式: [时间] [哪个方法] [哪行] [输出内容])
#ifdef DEBUG
#define NSLog(format, ...)  printf("\n[%s] %s [第%d行] 💕 %s\n", __TIME__, __FUNCTION__, __LINE__, [[NSString stringWithFormat:format, ##__VA_ARGS__] UTF8String]);
#else

#define NSLog(format, ...)

#endif
// 打印方法
#define XJLogFunc NSLog(@"%s", __func__)
// 打印请求错误信息
#define XJLogError(error) NSLog(@"Error: %@", error)
// 销毁打印
#define XJDealloc NSLog(@"\n =========+++ %@  销毁了 +++======== \n",[self class])

#define XJLogLastError(db) NSLog(@"lastError: %@, lastErrorCode: %d, lastErrorMessage: %@", [db lastError], [db lastErrorCode], [db lastErrorMessage]);





/// 类型相关
#define XJ_IS_IPAD (UI_USER_INTERFACE_IDIOM() == UIUserInterfaceIdiomPad)
#define XJ_IS_IPHONE (UI_USER_INTERFACE_IDIOM() == UIUserInterfaceIdiomPhone)
#define XJ_IS_RETINA ([[UIScreen mainScreen] scale] >= 2.0)

/// 屏幕尺寸相关
#define XJ_SCREEN_WIDTH  ([[UIScreen mainScreen] bounds].size.width)
#define XJ_SCREEN_HEIGHT ([[UIScreen mainScreen] bounds].size.height)
#define XJ_SCREEN_BOUNDS ([[UIScreen mainScreen] bounds])
#define XJ_SCREEN_MAX_LENGTH (MAX(XJ_SCREEN_WIDTH, XJ_SCREEN_HEIGHT))
#define XJ_SCREEN_MIN_LENGTH (MIN(XJ_SCREEN_WIDTH, XJ_SCREEN_HEIGHT))
#define XJ_BILI_WIDTH(__Number) (XJ_SCREEN_WIDTH * __Number / 375.0)
#define XJ_BILI_HEIGHT(__Number) (XJ_SCREEN_HEIGHT * __Number / 667.0)

/// 手机类型相关
#define XJ_IS_IPHONE_4_OR_LESS  (XJ_IS_IPHONE && XJ_SCREEN_MAX_LENGTH  < 568.0)
#define XJ_IS_IPHONE_5          (XJ_IS_IPHONE && XJ_SCREEN_MAX_LENGTH == 568.0)
#define XJ_IS_IPHONE_6          (XJ_IS_IPHONE && XJ_SCREEN_MAX_LENGTH == 667.0)
#define XJ_IS_IPHONE_6P         (XJ_IS_IPHONE && XJ_SCREEN_MAX_LENGTH == 736.0)
#define XJ_IS_IPHONE_X          (XJ_IS_IPHONE && XJ_SCREEN_MAX_LENGTH >= 812.0)


/// 导航条高度
#define XJ_APPLICATION_TOP_BAR_HEIGHT (XJ_IS_IPHONE_X?88.0f:64.0f)
/// tabBar高度
#define XJ_APPLICATION_TAB_BAR_HEIGHT (XJ_IS_IPHONE_X?83.0f:49.0f)
/// 工具条高度 (常见的高度)
#define XJ_APPLICATION_TOOL_BAR_HEIGHT_44  44.0f
#define XJ_APPLICATION_TOOL_BAR_HEIGHT_49  49.0f
/// 状态栏高度
#define XJ_APPLICATION_STATUS_BAR_HEIGHT (XJ_IS_IPHONE_X?44:20.0f)




///------
/// iOS Version
///------
#define XJIOSVersion ([[[UIDevice currentDevice] systemVersion] floatValue])

#define XJ_iOS7_VERSTION_LATER ([UIDevice currentDevice].systemVersion.floatValue >= 7.0)
#define XJ_iOS8_VERSTION_LATER ([UIDevice currentDevice].systemVersion.floatValue >= 8.0)
#define XJ_iOS9_VERSTION_LATER ([UIDevice currentDevice].systemVersion.floatValue >= 9.0)
#define XJ_iOS10_VERSTION_LATER ([UIDevice currentDevice].systemVersion.floatValue >= 10.0)

#define XJ_SYSTEM_VERSION_EQUAL_TO(v) ([[[UIDevice currentDevice] systemVersion] compare:v options:NSNumericSearch] == NSOrderedSame)
#define XJ_SYSTEM_VERSION_GREATER_THAN(v) ([[[UIDevice currentDevice] systemVersion] compare:v options:NSNumericSearch] == NSOrderedDescending)
#define XJ_SYSTEM_VERSION_GREATER_THAN_OR_EQUAL_TO(v) ([[[UIDevice currentDevice] systemVersion] compare:v options:NSNumericSearch] != NSOrderedAscending)
#define XJ_SYSTEM_VERSION_LESS_THAN(v) ([[[UIDevice currentDevice] systemVersion] compare:v options:NSNumericSearch] == NSOrderedAscending)
#define XJ_SYSTEM_VERSION_LESS_THAN_OR_EQUAL_TO(v) ([[[UIDevice currentDevice] systemVersion] compare:v options:NSNumericSearch] != NSOrderedDescending)


// KVO获取监听对象的属性 有自动提示
// 宏里面的#，会自动把后面的参数变成c语言的字符串
#define XJKeyPath(objc,keyPath) @(((void)objc.keyPath ,#keyPath))

// 颜色
#define XJColor(r, g, b) [UIColor colorWithRed:(r)/255.0 green:(g)/255.0 blue:(b)/255.0 alpha:1.0]
// 颜色+透明度
#define XJColorAlpha(r, g, b, a) [UIColor colorWithRed:(r)/255.0 green:(g)/255.0 blue:(b)/255.0 alpha:a]
// 随机色
#define XJRandomColor XJColor(arc4random_uniform(256), arc4random_uniform(256), arc4random_uniform(256))
// 根据rgbValue获取对应的颜色
#define XJColorFromRGB(__rgbValue) [UIColor colorWithRed:((float)((__rgbValue & 0xFF0000) >> 16))/255.0 green:((float)((__rgbValue & 0xFF00) >> 8))/255.0 blue:((float)(__rgbValue & 0xFF))/255.0 alpha:1.0]

#define XJColorFromRGBAlpha(rgbValue, a) [UIColor colorWithRed:((float)((rgbValue & 0xFF0000) >> 16))/255.0 green:((float)((rgbValue & 0xFF00) >> 8))/255.0 blue:((float)(rgbValue & 0xFF))/255.0 alpha:(a)]


// AppCaches 文件夹路径
#define XJCachesDirectory [NSSearchPathForDirectoriesInDomains(NSCachesDirectory, NSUserDomainMask, YES) lastObject]
// App DocumentDirectory 文件夹路径
#define XJDocumentDirectory [NSSearchPathForDirectoriesInDomains(NSDocumentDirectory,NSUserDomainMask, YES) lastObject]

// 系统放大倍数
#define XJScale [[UIScreen mainScreen] scale]

// 设置图片
#define XJImageNamed(__imageName) [UIImage imageNamed:__imageName]

/// 根据hex 获取颜色
#define XJColorfromHexString(__hexString__) ([UIColor colorfromHexString:__hexString__])

//  通知中心
#define XJNotificationCenter [NSNotificationCenter defaultCenter]


/// 全局细下滑线颜色 以及分割线颜色
#define XJGlobalBottomLineColor     [UIColor colorfromHexString:@"#D9D9D9"]

// 是否为空对象
#define XJObjectIsNil(__object)  ((nil == __object) || [__object isKindOfClass:[NSNull class]])

// 字符串为空
#define XJStringIsEmpty(__string) ((__string.length == 0) || XJObjectIsNil(__string))

// 字符串不为空
#define XJStringIsNotEmpty(__string)  (!XJStringIsEmpty(__string))

// 数组为空
#define XJArrayIsEmpty(__array) ((XJObjectIsNil(__array)) || (__array.count==0))

/// 适配iPhone X + iOS 11
#define  XJAdjustsScrollViewInsets_Never(__scrollView)\
do {\
_Pragma("clang diagnostic push")\
_Pragma("clang diagnostic ignored \"-Warc-performSelector-leaks\"")\
if ([__scrollView respondsToSelector:NSSelectorFromString(@"setContentInsetAdjustmentBehavior:")]) {\
NSMethodSignature *signature = [UIScrollView instanceMethodSignatureForSelector:@selector(setContentInsetAdjustmentBehavior:)];\
NSInvocation *invocation = [NSInvocation invocationWithMethodSignature:signature];\
NSInteger argument = 2;\
invocation.target = __scrollView;\
invocation.selector = @selector(setContentInsetAdjustmentBehavior:);\
[invocation setArgument:&argument atIndex:2];\
[invocation retainArguments];\
[invocation invoke];\
}\
_Pragma("clang diagnostic pop")\
} while (0)


//// --------------------  下面是公共配置  --------------------

/// 微信项目重要数据备份的文件夹名称（Documents/WeChatDoc）利用NSFileManager来访问
#define XJ_WECHAT_DOC_NAME  @"WeChatDoc"

/// 微信项目轻量数据数据备份的文件夹（Library/Caches/WeChatCache）利用NSFileManager来访问
#define XJ_WECHAT_CACHE_NAME  @"WeChatCache"



/// AppDelegate
#define XJSharedAppDelegate ((AppDelegate *)[UIApplication sharedApplication].delegate)

////  整个应用的主题配置（颜色+字体）MAIN 代表全局都可以修改 使用前须知
#define XJ_MAIN_NAVIGATIONBAR_BACKGROUNDCOLOR_1 [UIColor colorWithRed:.1 green:.1 blue:.1 alpha:0.65]
#define XJ_MAIN_NAVIGATIONBAR_BACKGROUNDCOLOR_2 [UIColor colorfromHexString:@"#EFEFF4"]
#define XJ_MAIN_NAVIGATIONBAR_BACKGROUNDCOLOR_3 [UIColor colorfromHexString:@"#F3F3F3"]
#define XJ_MAIN_NAVIGATIONBAR_BACKGROUNDCOLOR_4 [UIColor colorfromHexString:@"#E6A863"]
/// 全局青色 tintColor
#define XJ_MAIN_TINTCOLOR [UIColor colorWithRed:(10 / 255.0) green:(193 / 255.0) blue:(42 / 255.0) alpha:1]

/// 整个应用的视图的背景色 BackgroundColor
#define XJ_MAIN_BACKGROUNDCOLOR [UIColor colorfromHexString:@"#EFEFF4"]
/// 整个应用的分割线颜色
#define XJ_MAIN_LINE_COLOR_1 [UIColor colorfromHexString:@"#D9D8D9"]

/// 文字颜色
/// #56585f
#define XJ_MAIN_TEXT_COLOR_1 [UIColor colorfromHexString:@"#B2B2B2"]
/// #9CA1B2
#define XJ_MAIN_TEXT_COLOR_2 [UIColor colorfromHexString:@"#20DB1F"]
/// #FE583E
#define XJ_MAIN_TEXT_COLOR_3 [UIColor colorfromHexString:@"#FE583E"]
/// #0ECCCA
#define XJ_MAIN_TEXT_COLOR_4 [UIColor colorfromHexString:@"#0ECCCA"]
/// #3C3E44
#define XJ_MAIN_TEXT_COLOR_5 [UIColor colorfromHexString:@"#3C3E44"]





/// ---- YYWebImage Option
/// 手动设置image
#define XJWebImageOptionManually (YYWebImageOptionAllowInvalidSSLCertificates|YYWebImageOptionAllowBackgroundTask|YYWebImageOptionSetImageWithFadeAnimation|YYWebImageOptionAvoidSetImage)


/// 自动设置Image
#define XJWebImageOptionAutomatic (YYWebImageOptionAllowInvalidSSLCertificates|YYWebImageOptionAllowBackgroundTask|YYWebImageOptionSetImageWithFadeAnimation)
#endif /* CommonConstant_h */
