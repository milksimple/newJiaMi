//
//  JXStudentProgress.m
//  JMXMiJia
//
//  Created by mac on 16/2/17.
//  Copyright © 2016年 mac. All rights reserved.
//

#import "JXStudentProgress.h"
#import <MJExtension.h>
#import "JXToStudentComment.h"

@implementation JXStudentProgress

+ (NSDictionary *)mj_objectClassInArray {
    return @{@"rows":[JXToStudentComment class]};
}

@end
