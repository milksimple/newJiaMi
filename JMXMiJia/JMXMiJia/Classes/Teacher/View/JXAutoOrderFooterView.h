//
//  JXAutoOrderFooterView.h
//  JMXMiJia
//
//  Created by mac on 16/2/15.
//  Copyright © 2016年 mac. All rights reserved.
//

#import <UIKit/UIKit.h>
@class JXFeeGroup;

@protocol JXAutoOrderFooterViewDelegate <NSObject>

@optional
- (void)autoOrderFooterViewDidClickedConfirmButton;

@end

@interface JXAutoOrderFooterView : UIView

/** 总价 */
@property (nonatomic, assign) NSInteger totalPay;

@property (nonatomic, weak) id<JXAutoOrderFooterViewDelegate> delegate;

+ (instancetype)footerView;

@end
