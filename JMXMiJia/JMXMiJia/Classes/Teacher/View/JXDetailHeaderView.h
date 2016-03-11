//
//  JXDetailHeaderView.h
//  JMXMiJia
//
//  Created by mac on 16/1/20.
//  Copyright © 2016年 mac. All rights reserved.
//

#import <UIKit/UIKit.h>

@class JXTeacher;
@interface JXDetailHeaderView : UIView

@property (nonatomic, strong) JXTeacher *teacher;

+ (instancetype)headerView;

+ (CGFloat)headerHeight;
@end
