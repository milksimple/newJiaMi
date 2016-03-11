//
//  JXTeacherDetailController.h
//  JMXMiJia
//
//  Created by mac on 16/1/18.
//  Copyright © 2016年 mac. All rights reserved.
//

#import <UIKit/UIKit.h>
@class JXTeacher;
@class JXSearchParas;

@interface JXTeacherDetailController : UITableViewController
/** 教师模型 */
@property (nonatomic, strong) JXTeacher *teacher;
/** 用来显示学费明细 */
@property (nonatomic, strong) NSArray *feeGroups;
@end
