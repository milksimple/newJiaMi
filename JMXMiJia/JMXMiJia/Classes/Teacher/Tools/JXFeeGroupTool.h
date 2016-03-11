//
//  JXFeeGroupTool.h
//  JMXMiJia
//
//  Created by mac on 16/2/17.
//  Copyright © 2016年 mac. All rights reserved.
//  费用工具(订单工具)

#import <Foundation/Foundation.h>

@interface JXFeeGroupTool : NSObject
/** 由费用组得出费用总额 */
+ (NSInteger)totalPayWithFeeGroups:(NSArray *)feeGroups;
/** 有费用组得出报名需要的aidItem */
+ (NSString *)aidItemWithFeeGroups:(NSArray *)feeGroups;
@end
