//
//  JXFee.h
//  JMXMiJia
//
//  Created by mac on 16/2/14.
//  Copyright © 2016年 mac. All rights reserved.
//  费用模型

#import <Foundation/Foundation.h>

@interface JXFee : NSObject
/** 费用代码 */
@property (nonatomic, copy) NSString *itemNum;
/** 费用名称 */
@property (nonatomic, copy) NSString *des;
/** 费用 */
@property (nonatomic, assign) NSInteger prices;

/** 份数 */
@property (nonatomic, assign) NSInteger copies;
/** 说明(备注) */
@property (nonatomic, copy) NSString *caption;
@end
