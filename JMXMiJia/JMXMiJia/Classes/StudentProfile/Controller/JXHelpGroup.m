//
//  JXHelpGroup.m
//  JMXMiJia
//
//  Created by 张盼盼 on 16/3/11.
//  Copyright © 2016年 mac. All rights reserved.
//

#import "JXHelpGroup.h"
#import <MJExtension.h>
#import "JXHelpItem.h"

@implementation JXHelpGroup

+ (NSDictionary *)mj_objectClassInArray {
    return @{@"helpItems":[JXHelpItem class]};
}

@end
