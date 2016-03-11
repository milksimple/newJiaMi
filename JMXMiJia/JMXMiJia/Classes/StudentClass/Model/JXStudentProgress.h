//
//  JXStudentProgress.h
//  JMXMiJia
//
//  Created by mac on 16/2/17.
//  Copyright © 2016年 mac. All rights reserved.
//  学生的课堂进度

//typedef enum {
//    JXStudentProgressPhraseStatusNotStart, // 未开始
//    JXStudentProgressPhraseStatusStuding, // 在学
//    JXStudentProgressPhraseStatusComplete // 完成
//} JXStudentProgressPhraseStatus;

#import <Foundation/Foundation.h>

@interface JXStudentProgress : NSObject
/** 科目 */
@property (nonatomic, assign) NSInteger subjectNO;
/** 阶段状态：未开始，在学，合格 */
@property (nonatomic, assign) NSInteger state;
/** 里面装的是每一小节课的评论模型 */
@property (nonatomic, strong) NSArray *rows;
/** 完成时间 */
@property (nonatomic, copy) NSString *endDate;
@end
