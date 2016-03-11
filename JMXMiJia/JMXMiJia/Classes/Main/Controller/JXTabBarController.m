//
//  JXTabBarController.m
//  JMXMiJia
//
//  Created by mac on 15/12/23.
//  Copyright © 2015年 mac. All rights reserved.
//

#import "JXTabBarController.h"
#import "JXNavigationController.h"
#import "JXInfoController.h"
#import "JXTeacherController.h"
#import "JXTeacherClassController.h"
#import "JXTeacherProfileController.h"
#import "JXStudentClassController.h"
#import "JXStudentController.h"
#import "JXStudentProfileController.h"
#import "UIView+Extension.h"
#import "JXNavLetterButton.h"
#import <BBBadgeBarButtonItem.h>
#import <CoreLocation/CoreLocation.h>
#import "JXAccountTool.h"

@interface JXTabBarController () <CLLocationManagerDelegate>
/** 位置管理者 */
@property (nonatomic, strong) CLLocationManager *locMgr;
@end

@implementation JXTabBarController

- (CLLocationManager *)locMgr {
    if (_locMgr == nil) {
        _locMgr = [[CLLocationManager alloc] init];
        _locMgr.delegate = self;
        _locMgr.distanceFilter = 100;
        _locMgr.desiredAccuracy = kCLLocationAccuracyNearestTenMeters;
        
    }
    return _locMgr;
}

- (void)viewDidLoad {
    [super viewDidLoad];

    JXInfoController *infoVC = [[JXInfoController alloc] init];
    [self addChildVC:infoVC image:@"tabbar_info_normal" selectedImage:@"tabbar_info_selected" title:@"资讯"];
    
    JXTeacherController *teacherVC = [[JXTeacherController alloc] init];
    [self addChildVC:teacherVC image:@"tabbar_person_normal" selectedImage:@"tabbar_person_selected" title:@"报名"];
    
    JXStudentClassController *studentClassVC = [[JXStudentClassController alloc] init];
    [self addChildVC:studentClassVC image:@"tabbar_class_normal" selectedImage:@"tabbar_class_selected" title:@"课堂"];
    
    JXStudentProfileController *studentProfileVC = [[JXStudentProfileController alloc] init];
    [self addChildVC:studentProfileVC image:@"tabbar_profile_normal" selectedImage:@"tabbar_profile_selected" title:@"个人"];
    
    
    if ([self.locMgr respondsToSelector:@selector(requestWhenInUseAuthorization)]) {
        [self.locMgr requestWhenInUseAuthorization];
        
        if ([CLLocationManager locationServicesEnabled]) {
            [self.locMgr startUpdatingLocation];
        }
    }
    
}

- (void)addChildVC:(UIViewController *)childVC image:(NSString *)image selectedImage:(NSString *)selectedImage title:(NSString *)title {
    childVC.tabBarItem.image = [UIImage imageNamed:image];
    childVC.tabBarItem.selectedImage = [[UIImage imageNamed:selectedImage] imageWithRenderingMode:UIImageRenderingModeAlwaysOriginal];
    childVC.tabBarItem.title = title;
    [childVC.tabBarItem setTitleTextAttributes:@{NSForegroundColorAttributeName:JXColor(177, 177, 177)} forState:UIControlStateNormal];
    [childVC.tabBarItem setTitleTextAttributes:@{NSForegroundColorAttributeName:JXColor(82, 195, 233)} forState:UIControlStateSelected];
    JXNavigationController *nav = [[JXNavigationController alloc] initWithRootViewController:childVC];
    
    [self addChildViewController:nav];
}

#pragma mark - CLLocationManagerDelegate
- (void)locationManager:(CLLocationManager *)manager didUpdateLocations:(NSArray<CLLocation *> *)locations {
    JXAccount *account = [JXAccountTool account];
    account.location = locations.firstObject;
    [JXAccountTool saveAccount:account];
    
    [manager stopUpdatingLocation];
}


@end
