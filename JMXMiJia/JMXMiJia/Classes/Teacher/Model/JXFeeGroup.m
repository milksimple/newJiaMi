//
//  JXFeeGroup.m
//  JMXMiJia
//
//  Created by mac on 16/2/14.
//  Copyright © 2016年 mac. All rights reserved.
//

#import "JXFeeGroup.h"
#import <MJExtension.h>
#import "JXFee.h"

@implementation JXFeeGroup

+ (NSDictionary *)mj_objectClassInArray {
    return @{@"fees":[JXFee class]};
}

@end
