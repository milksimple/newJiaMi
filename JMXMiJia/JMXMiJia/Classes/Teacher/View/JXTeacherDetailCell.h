//
//  JXTeacherDetailCell.h
//  JMXMiJia
//
//  Created by mac on 16/1/18.
//  Copyright © 2016年 mac. All rights reserved.
//  教师详情页的cell

#import <UIKit/UIKit.h>
@class JXTeacher;

@protocol JXTeacherDetailCellDelegate <NSObject>

@optional
- (void)teacherDetailCellDidClickedFeeDetailButton;

@end

@interface JXTeacherDetailCell : UITableViewCell
/** 教师模型 */
@property (nonatomic, strong) JXTeacher *teacher;
/** 费用组模型，决定报名学费 */
@property (nonatomic, strong) NSArray *feeGroups;

@property (nonatomic, assign) CGFloat rowHeight;

@property (nonatomic, weak) id<JXTeacherDetailCellDelegate> delegate;
@end
