//
//  JXTeacher.h
//  JMXMiJia
//
//  Created by mac on 15/12/24.
//  Copyright © 2015年 mac. All rights reserved.
//

/*
typedef enum {
    JXTeacherTeachTypeA1,
    JXTeacherTeachTypeA2,
    JXTeacherTeachTypeB1,
    JXTeacherTeachTypeB2,
    JXTeacherTeachTypeC1,
    JXTeacherTeachTypeC2
} JXTeacherTeachType;
 */

#import <Foundation/Foundation.h>
#import <CoreLocation/CoreLocation.h>
@class JXSchool;

/*
    school = 阳安驾校;
	uid = 14447075166381;
	star = 3;
	models = C1;
	price = 4580;
	distance = 未知;
	qual = 二级;
	year = 3年;
	photo = CoachPhoto?isSource=0&uid=14447075166381;
	name = 资永俊;
 
 */

@interface JXTeacher : NSObject
/** 姓名 */
@property (nonatomic, copy) NSString *name;
/** id */
@property (nonatomic, copy) NSString *uid;
/** 所在驾校 */
@property (nonatomic, copy) NSString *school;
/** 教师级别,比如：二级 */
@property (nonatomic, copy) NSString *qual;
/** 教师等级,代表多少颗星 */
@property (nonatomic, assign) NSUInteger star;
/** 学费 */
@property (nonatomic, assign) float price;
/** 工作年限 */
@property (nonatomic, copy) NSString *year;
/** 学车类别,比如“C1” */
@property (nonatomic, copy) NSString *models;
/** 头像地址 */
@property (nonatomic, copy) NSString *photo;
/** 当前距离 */
@property (nonatomic, copy) NSString *distance;

/** 个人介绍 */
@property (nonatomic, copy) NSString *des;
/** 电话号码 */
@property (nonatomic, copy) NSString *mobile;
/** 报名人数 */
@property (nonatomic, assign) NSUInteger count;
/** 学校id */
@property (nonatomic, copy) NSString *schoolID;
/** 证件照片地址 */
@property (nonatomic, copy) NSString *credentials;
@end
