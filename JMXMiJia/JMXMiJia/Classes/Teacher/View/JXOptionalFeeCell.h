//
//  JXOptionalFeeCell.h
//  JMXMiJia
//
//  Created by mac on 16/2/3.
//  Copyright © 2016年 mac. All rights reserved.
//

typedef void (^JXOptionalFeeCellDidClickedOptionalButtonAction)();

#import <UIKit/UIKit.h>
#import "JXFee.h"

@class JXOptionalFee;

@interface JXOptionalFeeCell : UITableViewCell
/** 可选费用模型数据 */
@property (nonatomic, strong) JXOptionalFee *optionalFee;
/** 可选费用模型数据 */
@property (nonatomic, strong) JXFee *fee;

+ (NSString *)reuseIdentifier;

/** 选择按钮被点击时要做的操作 */
@property (nonatomic, copy) JXOptionalFeeCellDidClickedOptionalButtonAction optionalButtonClickedAction;

@end
