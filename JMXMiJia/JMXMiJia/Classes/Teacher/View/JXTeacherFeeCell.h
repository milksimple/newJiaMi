//
//  JXTeacherFeeCell.h
//  JMXMiJia
//
//  Created by mac on 16/2/14.
//  Copyright © 2016年 mac. All rights reserved.
//

typedef void (^JXTeacherFeeCellDidClickedOptionalButtonAction)();

#import <UIKit/UIKit.h>
#import "JXFee.h"

@interface JXTeacherFeeCell : UITableViewCell

@property (nonatomic, strong) JXFee *fee;

+ (NSString *)reuseIdentifier;

/** 选择按钮被点击时要做的操作 */
@property (nonatomic, copy) JXTeacherFeeCellDidClickedOptionalButtonAction optionalButtonClickedAction;
@end
