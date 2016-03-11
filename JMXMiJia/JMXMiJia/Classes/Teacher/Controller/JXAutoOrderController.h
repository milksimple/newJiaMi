//
//  JXAutoOrderController.h
//  JMXMiJia
//
//  Created by mac on 16/1/21.
//  Copyright © 2016年 mac. All rights reserved.
//

#import <UIKit/UIKit.h>
@class JXSearchParas;

@protocol JXAutoOrderControllerDelegate <NSObject>

@optional
- (void)autoOrderDidFinishedWithSearchParas:(JXSearchParas *)searchParas;

@end

@interface JXAutoOrderController : UITableViewController
/** 筛选参数模型 */
@property (nonatomic, strong) JXSearchParas *searchParas;

@property (nonatomic, weak) id<JXAutoOrderControllerDelegate> delegate;

@end
