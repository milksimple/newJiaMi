//
//  JXStudentProgressCell.h
//  JMXMiJia
//
//  Created by mac on 16/2/17.
//  Copyright © 2016年 mac. All rights reserved.
//  学生课堂进度
/*
 *!!!
 *!!!   暂时不需要这个控件
 *!!!
 */

#import <UIKit/UIKit.h>
@class JXStudentProgress;

@interface JXStudentProgressCell : UITableViewCell

+ (instancetype)cell;
/** 进度模型 */
@property (nonatomic, strong) NSArray *progresses;

+ (CGFloat)rowHeight;
@end
