//
//  JXToStudentComment.h
//  JMXMiJia
//
//  Created by mac on 16/3/1.
//  Copyright © 2016年 mac. All rights reserved.
//  对学生的点评

#import <Foundation/Foundation.h>

@interface JXToStudentComment : NSObject
/*
"date": "2016-02-29",
"starsA": 5,
"starsB": 5,
"state": 1,
"des": "%E5%A4%AA%E4%BC%98%E7%A7%80%E5%95%A6"
 */
/** 点评时间 */
@property (nonatomic, copy) NSString *date;
/** A评分 */
@property (nonatomic, assign) NSInteger starsA;
/** B评分 */
@property (nonatomic, assign) NSInteger starsB;
/** 标注：上课，请假，旷课，早退 */
@property (nonatomic, assign) NSInteger state;
/** 评论内容 */
@property (nonatomic, copy) NSString *des;
/** 是否已回评 */
@property (nonatomic, assign) BOOL replied;
@end
