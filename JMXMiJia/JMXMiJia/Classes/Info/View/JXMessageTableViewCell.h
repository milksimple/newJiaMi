//
//  JXMessageTableViewCell.h
//  JMXMiJia
//
//  Created by mac on 16/2/24.
//  Copyright © 2016年 mac. All rights reserved.
//

typedef void (^JXMessageTableViewCellDidClickedAccessoryButtonAction)();

#import <UIKit/UIKit.h>
@class JXPushInfo;

@interface JXMessageTableViewCell : UITableViewCell

- (CGFloat)rowHeight;
/** 是否展开 */
@property (nonatomic, assign) BOOL expland;
/** 推送消息模型 */
@property (nonatomic, strong) JXPushInfo *pushInfo;

@property (nonatomic, copy) JXMessageTableViewCellDidClickedAccessoryButtonAction corverButtonClickedAction;
@end
