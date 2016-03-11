//
//  JXAutoOrderCell.h
//  JMXMiJia
//
//  Created by mac on 16/1/22.
//  Copyright © 2016年 mac. All rights reserved.
//

#import <UIKit/UIKit.h>

@class JXOrderForm;
@interface JXAutoOrderCell : UITableViewCell
/** 订单模型 */
@property (nonatomic, strong) JXOrderForm *orderForm;

/** 标题 */
@property (weak, nonatomic) IBOutlet UILabel *titleLabel;
/** 单价 */
@property (weak, nonatomic) IBOutlet UILabel *unitPriceLabel;
/** 金额 */
@property (weak, nonatomic) IBOutlet UILabel *moneyLabel;
@end
