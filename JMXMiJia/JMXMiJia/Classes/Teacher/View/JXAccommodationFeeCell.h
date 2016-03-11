//
//  JXAccommodationFeeCell.h
//  JMXMiJia
//
//  Created by mac on 16/2/14.
//  Copyright © 2016年 mac. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "JXFee.h"

@class JXOptionalFee;

@protocol JXAccommodationFeeCellDelegate <NSObject>

@optional
/** 点击了加号按钮 */
- (void)accommodationFeeCellDidClickedPlusButton;
/** 点击了减号按钮 */
- (void)accommodationFeeCellDidClickedMinusButton;

@end

@interface JXAccommodationFeeCell : UITableViewCell
/** 可选费用模型数据 */
@property (nonatomic, strong) JXOptionalFee *optionalFee;

/** 可选费用模型数据 */
@property (nonatomic, strong) JXFee *fee;
/** 重用标示 */
+ (NSString *)reuseIdentifier;

+ (instancetype)cell;

@property (nonatomic, weak) id<JXAccommodationFeeCellDelegate> delegate;
@end
