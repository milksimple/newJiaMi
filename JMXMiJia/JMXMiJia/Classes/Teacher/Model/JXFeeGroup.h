//
//  JXFeeGroup.h
//  JMXMiJia
//
//  Created by mac on 16/2/14.
//  Copyright © 2016年 mac. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface JXFeeGroup : NSObject
/** 费用类型 */
@property (nonatomic, copy) NSString *feeType;
/** 数组里面都是JXFee模型 */
@property (nonatomic, strong) NSArray *fees;

@end
