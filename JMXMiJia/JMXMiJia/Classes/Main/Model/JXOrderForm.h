//
//  JXOrderForm.h
//  JMXMiJia
//
//  Created by mac on 16/1/21.
//  Copyright © 2016年 mac. All rights reserved.
//  订单

#import <Foundation/Foundation.h>

@interface JXOrderForm : NSObject
/** 课时费 */
@property (nonatomic, assign) NSUInteger classFee;
/** 培训费 */
@property (nonatomic, assign) NSUInteger trainingFee;
/** 考试费 */
@property (nonatomic, assign) NSUInteger examinFee;
/** 保险费 */
@property (nonatomic, assign) NSUInteger insuranceFee;
/** 资料费 */
@property (nonatomic, assign) NSUInteger dataFee;
/** 接送费 */
@property (nonatomic, assign) NSUInteger shuttleFee;
/** 体检费 */
@property (nonatomic, assign) NSUInteger bodyExaminFee;
/** 办暂住证费 */
@property (nonatomic, assign) NSUInteger TRPFee;
/** 食宿费 */
@property (nonatomic, assign) NSUInteger accommodationFee;
/** 驾校 */
@property (nonatomic, copy) NSString *school;

@end
