//
//  JXAutoOrderHeaderView.h
//  JMXMiJia
//
//  Created by mac on 16/2/15.
//  Copyright © 2016年 mac. All rights reserved.
//

#import <UIKit/UIKit.h>

@class JXFeeGroup;
@interface JXAutoOrderHeaderView : UIView

@property (nonatomic, strong) JXFeeGroup *feeGroup;

@property (nonatomic, copy) NSString *title;

+ (instancetype)headerView;
@end
