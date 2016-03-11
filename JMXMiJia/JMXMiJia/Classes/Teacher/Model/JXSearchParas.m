//
//  JXSearchParas.m
//  JMXMiJia
//
//  Created by mac on 16/1/27.
//  Copyright © 2016年 mac. All rights reserved.
//

#import "JXSearchParas.h"
#import "JXAccount.h"
#import "JXAccountTool.h"
#import "JXFeeGroup.h"
#import "JXFee.h"

@implementation JXSearchParas

- (NSString *)mobile {
    JXAccount *account = [JXAccountTool account];
    return account.mobile;
}

- (NSString *)password {
    JXAccount *account = [JXAccountTool account];
    return account.password;
}

- (void)setStar:(NSInteger)star {
    _star = star;
    
    switch (star) {
        case 0: // 普通教练费用
            self.starFee = 0;
            break;
            
        case 1: // 一星教练费用
            self.starFee = 100;
            break;
            
        case 2:
            self.starFee = 200;
            break;
            
        case 3:
            self.starFee = 300;
            break;
            
        case 4:
            self.starFee = 400;
            break;
            
        case 5:
            self.starFee = 500;
            break;
            
        default:
            break;
    }
}

- (void)setFeeGroups:(NSArray *)feeGroups {
    _feeGroups = feeGroups;
    
    // 费用总额
    NSInteger totalPay = 0;
    for (JXFeeGroup *feeGroup in self.feeGroups) {
        for (JXFee *fee in feeGroup.fees) {
            totalPay += fee.prices * fee.copies;
        }
    }
    self.totalPay = totalPay;
    
    // 可选费用
    NSInteger optionalTotalPay = 0;
    JXFeeGroup *optionalFeeGroup = feeGroups[1];
    for (JXFee *optionalFee in optionalFeeGroup.fees) {
        optionalTotalPay += optionalFee.prices * optionalFee.copies;
    }
    self.optionalTotalPay = optionalTotalPay;
    
    // 星级
    JXFeeGroup *starGroup = self.feeGroups[2];
    for (int i = 0; i < starGroup.fees.count; i ++) {
        JXFee *fee = starGroup.fees[i];
        if (fee.copies == 1) {
            self.star = starGroup.fees.count - 1 - i;
        }
    }
}

@end
