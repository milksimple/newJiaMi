//
//  AppDelegate.m
//  JMXMiJia
//
//  Created by mac on 15/12/23.
//  Copyright © 2015年 mac. All rights reserved.
//  13116296826 // 测试账号
//  13708803633  111111  进度测试接口
//  18213857463

#define JXPushInfoPath [[NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES) lastObject] stringByAppendingPathComponent:@"pushInfo.archive"]

#import "AppDelegate.h"
#import "JXTabBarController.h"
#import <BBBadgeBarButtonItem.h>
#import "UIView+Extension.h"
#import "JXAccountTool.h"
#import "JXLoginViewController.h"
#import <IQKeyboardManager.h>
#import <SDWebImageManager.h>
#import <CoreMotion/CoreMotion.h>
#import <MediaPlayer/MediaPlayer.h>
#import "UIWindow+Extension.h"

@interface AppDelegate ()

@property (nonatomic, strong) CMMotionManager *motionManager;

@end

@implementation AppDelegate {
    BOOL _isFullScreen;
}

- (BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions {
    if ([[[UIDevice currentDevice] systemVersion] floatValue] >= 8.0) {
        UIUserNotificationType myTypes = UIRemoteNotificationTypeBadge | UIRemoteNotificationTypeAlert | UIRemoteNotificationTypeSound;
        UIUserNotificationSettings *settings = [UIUserNotificationSettings settingsForTypes:myTypes categories:nil];
        [[UIApplication sharedApplication] registerUserNotificationSettings:settings];
    }else
    {
        UIRemoteNotificationType myTypes = UIRemoteNotificationTypeBadge|UIRemoteNotificationTypeAlert|UIRemoteNotificationTypeSound;
        [[UIApplication sharedApplication] registerForRemoteNotificationTypes:myTypes];
    }

    self.window = [[UIWindow alloc] init];
    self.window.frame = [UIScreen mainScreen].bounds;
    self.window.backgroundColor = [UIColor whiteColor];
    [self.window makeKeyAndVisible];
    
    // 判断之前是否登录过
    JXAccount *account = [JXAccountTool account];
    if (account.hasLogin) { // 之前登录过
        [self.window switchRootViewController];
    }
    else {
        JXLoginViewController *loginVC = [[JXLoginViewController alloc] init];
        self.window.rootViewController = loginVC;
    }
    
    // 初始化智能键盘
    [self setupIQKeyboardManager];
    
    // 监听视频进入全屏状态
    [self setupNotification];
    
    return YES;
}

/**
 *  初始化智能键盘
 */
- (void)setupIQKeyboardManager {
    IQKeyboardManager *keyboard = [IQKeyboardManager sharedManager];
    keyboard.toolbarDoneBarButtonItemText = @"完成";
    keyboard.toolbarTintColor = [UIColor grayColor];
    keyboard.enable = YES;
}

#ifdef __IPHONE_8_0
- (void)application:(UIApplication *)application didRegisterUserNotificationSettings:(UIUserNotificationSettings *)notificationSettings
{
    [application registerForRemoteNotifications];
}
#endif

-(void)application:(UIApplication *)application didRegisterForRemoteNotificationsWithDeviceToken:(NSData *)deviceToken
{
    JXAccount *account = [JXAccountTool account];
    NSString *pushToken = [[[[deviceToken description]
                             
                             stringByReplacingOccurrencesOfString:@"<" withString:@""]
                            
                            stringByReplacingOccurrencesOfString:@">" withString:@""]
                           
                           stringByReplacingOccurrencesOfString:@" " withString:@""];
    
    account.pushToken = pushToken;
    [JXAccountTool saveAccount:account];
}

- (void)applicationDidReceiveMemoryWarning:(UIApplication *)application {
    SDWebImageManager *mgr = [SDWebImageManager sharedManager];
    // 1.取消下载
    [mgr cancelAll];
    
    // 2.清除内存中的所有图片
    [mgr.imageCache clearMemory];
}

- (void)application:(UIApplication *)application didReceiveRemoteNotification:(NSDictionary *)userInfo {
    
    [JXUserDefaults setObject:@"1" forKey:JXNavLetterItemBadgeKey];
}

#pragma mark - 以下是检测屏幕方向和监听视频进入全屏，是实现用户横屏 视频自动进入横屏全屏 的实现的重要方法
/**
 *  监听视频进入全屏状态
 */
- (void)setupNotification {
    [JXNotificationCenter addObserver:self selector:@selector(willEnterFullScreen:) name:MPMoviePlayerWillEnterFullscreenNotification object:nil];
    
    [JXNotificationCenter addObserver:self selector:@selector(willExitFullScreen:) name:MPMoviePlayerWillExitFullscreenNotification object:nil];
}

- (void)willEnterFullScreen:(NSNotification *)notification
{
    _isFullScreen = YES;
}

- (void)willExitFullScreen:(NSNotification *)notification
{
    _isFullScreen = NO;
}

/**
 *  此方法时屏幕进入全屏是进入横屏全屏，而不是竖屏全屏
 */
- (UIInterfaceOrientationMask)application:(UIApplication *)application supportedInterfaceOrientationsForWindow:(UIWindow *)window {
    if (_isFullScreen) {
        return UIInterfaceOrientationMaskLandscapeLeft | UIInterfaceOrientationMaskLandscapeRight;
    }
    else {
        return UIInterfaceOrientationMaskPortrait;
    }
}

/**
 *  陀螺仪管理者
 */
- (CMMotionManager *)motionManager {
    if (_motionManager == nil) {
        _motionManager = [[CMMotionManager alloc] init];
    }
    return _motionManager;
}

/**
 *  陀螺仪开始监测
 */
- (void)applicationDidBecomeActive:(UIApplication *)application{
    [self.motionManager startDeviceMotionUpdates];
}

/**
 *  陀螺仪停止监测
 */
- (void)applicationWillResignActive:(UIApplication *)application{
    [self.motionManager stopDeviceMotionUpdates];
}

/**
 *  获取屏幕的方向
 */
- (UIDeviceOrientation)realDeviceOrientation{
    CMDeviceMotion *deviceMotion = self.motionManager.deviceMotion;
    double x = deviceMotion.gravity.x;
    double y = deviceMotion.gravity.y;
    if (fabs(y) >= fabs(x))    {
        if (y >= 0)
            return UIDeviceOrientationPortraitUpsideDown;
        else
            return UIDeviceOrientationPortrait;
    }
    else
    {
        if (x >= 0)
            return UIDeviceOrientationLandscapeRight;
        else
            return UIDeviceOrientationLandscapeLeft;
    }
}

@end
