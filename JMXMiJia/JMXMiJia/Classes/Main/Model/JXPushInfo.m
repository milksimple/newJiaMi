//
//  JXPushInfo.m
//  JMXMiJia
//
//  Created by mac on 16/3/8.
//  Copyright © 2016年 mac. All rights reserved.
//

#import "JXPushInfo.h"
#import <MJExtension.h>

@implementation JXPushInfo

MJCodingImplementation;

+ (NSDictionary *)mj_replacedKeyFromPropertyName {
    return @{@"ID":@"id"};
}

@end
