//
//  JXStudyPlaceCell.h
//  JMXMiJia
//
//  Created by mac on 16/2/14.
//  Copyright © 2016年 mac. All rights reserved.
//  学习场地

#import <UIKit/UIKit.h>

@class JXSchool;
@interface JXStudyPlaceCell : UITableViewCell
/** 学校 */
@property (nonatomic, strong) JXSchool *school;

+ (instancetype)cell;
@end
