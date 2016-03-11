//
//  JXFilterViewController.h
//  JMXMiJia
//
//  Created by mac on 16/2/1.
//  Copyright © 2016年 mac. All rights reserved.
//  报名页面点击筛选按钮 弹出的筛选控制器

#import <UIKit/UIKit.h>
#import <Foundation/Foundation.h>
#import "JXSearchParas.h"

@interface JXFilterViewController : UITableViewController
/** 筛选参数 */
@property (nonatomic, strong) JXSearchParas *searchParas;

@end
