//
//  JXTeachersTool.h
//  JMXMiJia
//
//  Created by mac on 16/1/26.
//  Copyright © 2016年 mac. All rights reserved.
//

#import <Foundation/Foundation.h>


@interface JXTeachersTool : NSObject

+ (NSArray *)teachersWithParas:(NSDictionary *)paras;

+ (void)saveTeachersWithTeachers:(NSArray *)teachers;
@end
