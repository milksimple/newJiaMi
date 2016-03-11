//
//  JXFilterView.h
//  JMXMiJia
//
//  Created by mac on 16/1/28.
//  Copyright © 2016年 mac. All rights reserved.
//  筛选view

#import <UIKit/UIKit.h>
#import "JXSearchParas.h"

@interface JXFilterView : UIView

+ (instancetype)filterView;

/** 内容view */
@property (nonatomic, strong) UIView *content;
/** 内容控制器 */
@property (nonatomic, strong) UIViewController *contentViewController;
/** 显示 */
- (void)show;
/** 消失 */
- (void)dismiss;
@end
