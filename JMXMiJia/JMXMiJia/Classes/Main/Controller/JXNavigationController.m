//
//  JXNavigationController.m
//  JMXMiJia
//
//  Created by mac on 15/12/23.
//  Copyright © 2015年 mac. All rights reserved.
//

#import "JXNavigationController.h"
#import <BBBadgeBarButtonItem.h>
#import "UIView+Extension.h"

@interface JXNavigationController ()

@end

@implementation JXNavigationController

- (void)viewDidLoad {
    [super viewDidLoad];

    // 设置外观
    UINavigationBar *navBar = [UINavigationBar appearance];
    [navBar setTitleTextAttributes:@{NSFontAttributeName:[UIFont systemFontOfSize:20]}];
    
    UIBarButtonItem *barItem = [UIBarButtonItem appearance];
    [barItem setTitleTextAttributes:@{NSForegroundColorAttributeName:[UIColor lightGrayColor]} forState:UIControlStateNormal];
}

- (void)pushViewController:(UIViewController *)viewController animated:(BOOL)animated {
    if (self.childViewControllers.count >= 1) {
        viewController.hidesBottomBarWhenPushed = YES;
        
        UIButton *button = [UIButton buttonWithType:UIButtonTypeCustom];
        [button setImage:[UIImage imageNamed:@"nav_back"] forState:UIControlStateNormal];
        button.size = CGSizeMake(70, 30);
        // 让按钮内部的所有内容左对齐
        button.contentHorizontalAlignment = UIControlContentHorizontalAlignmentLeft;
        // 让按钮的内容往左边偏移10
        button.contentEdgeInsets = UIEdgeInsetsMake(0, -10, 0, 0);
        [button addTarget:self action:@selector(back) forControlEvents:UIControlEventTouchUpInside];
        
        // 修改导航栏左边的item
        viewController.navigationItem.leftBarButtonItem = [[UIBarButtonItem alloc] initWithCustomView:button];
        
//        //在自定义leftBarButtonItem后添加下面代码就可以完美解决返回手势无效的情况
//        if ([self respondsToSelector:@selector(interactivePopGestureRecognizer)]) {
//            self.interactivePopGestureRecognizer.delegate = nil;
//        }
    }
    [viewController.navigationItem.backBarButtonItem setBackButtonBackgroundImage:[UIImage imageNamed:@"nav_back"] forState:UIControlStateNormal barMetrics:UIBarMetricsDefault];
    
    [super pushViewController:viewController animated:animated];
    
}

- (void)back {
    [self popViewControllerAnimated:YES];
}



@end
