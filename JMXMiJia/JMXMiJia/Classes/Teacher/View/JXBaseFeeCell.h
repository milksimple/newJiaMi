//
//  JXBaseFeeCell.h
//  JMXMiJia
//
//  Created by mac on 16/2/3.
//  Copyright © 2016年 mac. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "JXFee.h"
@class JXBaseFee;

@interface JXBaseFeeCell : UITableViewCell
/** 模型数据 */
@property (nonatomic, strong) JXBaseFee *baseFee;

/** 模型数据 */
@property (nonatomic, strong) JXFee *fee;

+ (instancetype)baseFeeCell;

+ (NSString *)reuseIdentifier;
@end
