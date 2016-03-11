//
//  JXFeeDetailController.h
//  JMXMiJia
//
//  Created by mac on 16/2/17.
//  Copyright © 2016年 mac. All rights reserved.
//  学费明细控制器

#import <UIKit/UIKit.h>
@class JXSearchParas;

@protocol JXFeeDetailControllerDelegate <NSObject>

@optional
- (void)feeDetailDidFinishedChooseWithFeeGroups:(NSArray *)feeGroups;

@end

@interface JXFeeDetailController : UITableViewController
/** 费用模型 */
@property (nonatomic, strong) NSArray *feeGroups;

@property (nonatomic, weak) id<JXFeeDetailControllerDelegate> delegate;
@end
