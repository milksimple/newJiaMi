//
//  JXTeachersTool.m
//  JMXMiJia
//
//  Created by mac on 16/1/26.
//  Copyright © 2016年 mac. All rights reserved.
//

#import "JXTeachersTool.h"
#import <FMDB.h>

@implementation JXTeachersTool

static FMDatabase *_db;
+ (void)initialize {
    // 1.打开数据库
    NSString *path = [[NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES) lastObject] stringByAppendingPathComponent:@"teachers.sqlite"];
    _db = [FMDatabase databaseWithPath:path];
    [_db open];
    
    // 2.创表
    [_db executeUpdate:@"CREATE TABLE IF NOT EXISTS t_teachers (id integer PRIMARY KEY, teacher blob NOT NULL, uid text NOT NULL);"];
}
+ (NSArray *)teachersWithParas:(NSDictionary *)paras {
    // sql语句
    NSString *sql;
    // 获取多少条记录
    NSUInteger count = [paras[@"count"] integerValue];
    if (count == 0) { // 默认8条
        count = 8;
    }
    if (paras[@"start"]) { // 获取比这个id小的数据,默认20条
        sql = [NSString stringWithFormat:@"SELECT * FROM t_teacher WHERE uid < %@ ORDER BY uid DESC LIMIT %zd;", paras[@"start"], count];
    }
    else { // 获取最新的 count 条数据
        sql = [NSString stringWithFormat:@"SELECT *FROM t_teacher ORDER BY uid DESC LIMIT %zd;", count];
    }
    
    // 执行SQL
    FMResultSet *set = [_db executeQuery:sql];
    NSMutableArray *teachers = [NSMutableArray array];
    while (set.next) {
        NSData *teacherData = [set objectForColumnName:@"teacher"];
        NSDictionary *teacher = [NSKeyedUnarchiver unarchiveObjectWithData:teacherData];
        [teachers addObject:teacher];
    }
    return teachers;
}

+ (void)saveTeachersWithTeachers:(NSArray *)teachers {
    for (NSDictionary *teacher in teachers) {
        // NSDictionary --> NSData
        NSData *teacherData = [NSKeyedArchiver archivedDataWithRootObject:teacher];
        [_db executeUpdateWithFormat:@"INSERT INTO t_teacher(teacher, uid) VALUES (%@, %@);", teacherData, teacher[@"uid"]];
    }
}

@end
