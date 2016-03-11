//
//  JXPayViewController.m
//  JMXMiJia
//
//  Created by mac on 16/3/9.
//  Copyright © 2016年 mac. All rights reserved.
//

#import "JXPayViewController.h"

@interface JXPayViewController ()

@end

@implementation JXPayViewController

- (void)viewDidLoad {
    [super viewDidLoad];

    self.navigationItem.title = @"支付状态";
    self.view.backgroundColor = JXGlobalBgColor;
    UILabel *label = [[UILabel alloc] init];
    label.text = @"功能尚未完善，敬请期待!";
    label.frame = CGRectMake(20, 100, 200, 20);
    [self.view addSubview:label];
    
}


@end
