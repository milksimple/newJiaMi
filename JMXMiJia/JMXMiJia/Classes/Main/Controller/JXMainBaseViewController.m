//
//  JXMainBaseViewController.m
//  JMXMiJia
//
//  Created by mac on 16/1/14.
//  Copyright © 2016年 mac. All rights reserved.
//

#import "JXMainBaseViewController.h"
#import <BBBadgeBarButtonItem.h>

@interface JXMainBaseViewController ()
@property (nonatomic, strong) BBBadgeBarButtonItem *letterItem;
@end

@implementation JXMainBaseViewController

- (BBBadgeBarButtonItem *)letterItem {
    if (_letterItem == nil) {
        // 信件按钮
        UIButton *letterButton = [[UIButton alloc] init];
        // 监听按钮点击
        [letterButton addTarget:self action:@selector(letterButtonDidClicked) forControlEvents:UIControlEventTouchUpInside];
        
        letterButton.frame = CGRectMake(0, 0, 26, 17.3);
        [letterButton setImage:[UIImage imageNamed:@"nav_letter"] forState:UIControlStateNormal];
        BBBadgeBarButtonItem *letterItem = [[BBBadgeBarButtonItem alloc] initWithCustomUIButton:letterButton];
        letterItem.badgeOriginX = 20;
        letterItem.badgeOriginY = -10;
        letterItem.badgeMinSize = -10;
        _letterItem = letterItem;
    }
    return _letterItem;
}

/**
 *  信件按钮被点击了
 */
- (void)letterButtonDidClicked {
    self.tabBarController.selectedIndex = 0;
}

- (void)viewDidLoad {
    [super viewDidLoad];

    self.view.backgroundColor = JXGlobalBgColor;
}

- (void)viewWillAppear:(BOOL)animated {
    [super viewWillAppear:animated];
    
    NSString *badge = [JXUserDefaults objectForKey:JXNavLetterItemBadgeKey];
    self.letterItem.badgeValue = badge;
    self.navigationItem.rightBarButtonItem = self.letterItem;
}

@end
