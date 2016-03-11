//
//  JXFeeGroupTool.m
//  JMXMiJia
//
//  Created by mac on 16/2/17.
//  Copyright © 2016年 mac. All rights reserved.
//

#import "JXFeeGroupTool.h"
#import "JXFee.h"
#import "JXFeeGroup.h"

@implementation JXFeeGroupTool

/** 由费用组得出费用总额 */
+ (NSInteger)totalPayWithFeeGroups:(NSArray *)feeGroups {
    // 费用总额
    NSInteger totalPay = 0;
    for (JXFeeGroup *feeGroup in feeGroups) {
        for (JXFee *fee in feeGroup.fees) {
            totalPay += fee.prices * fee.copies;
        }
    }
    return totalPay;
}

/** 有费用组得出报名需要的aidItem */
+ (NSString *)aidItemWithFeeGroups:(NSArray *)feeGroups {
    NSMutableString *aidItem =[NSMutableString string];
    
    JXFeeGroup *optionalFeeGroup = feeGroups[1];
    for (JXFee *optionalFee in optionalFeeGroup.fees) {
        [aidItem appendString:[NSString stringWithFormat:@",%zd", optionalFee.copies]];
    }
    // 去除第一个逗号
    if (aidItem.length > 0) {
        [aidItem deleteCharactersInRange:NSMakeRange(0, 1)];
    }

    return aidItem;
}

@end
