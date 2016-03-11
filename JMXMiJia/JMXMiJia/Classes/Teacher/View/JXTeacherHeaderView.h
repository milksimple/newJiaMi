//
//  JXTeacherHeaderView.h
//  JMXMiJia
//
//  Created by mac on 16/1/20.
//  Copyright © 2016年 mac. All rights reserved.
//

typedef void (^TeacherHeaderClickedButtonAction)();

#import <UIKit/UIKit.h>

@interface JXTeacherHeaderView : UIView

@property (nonatomic, copy) TeacherHeaderClickedButtonAction orderButtonClickedAction;

+ (instancetype)headerView;
/** 自主订单总价 */
@property (nonatomic, assign) NSInteger totalPay;

+ (CGFloat)headerHeight;
@end
