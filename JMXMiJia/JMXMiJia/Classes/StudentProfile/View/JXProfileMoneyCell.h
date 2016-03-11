//
//  JXProfileMoneyCell.h
//  JMXMiJia
//
//  Created by mac on 16/1/18.
//  Copyright © 2016年 mac. All rights reserved.
//

#import <UIKit/UIKit.h>
@class JXAccount;

@protocol JXProfileMoneyCellDelegate <NSObject>

@optional
- (void)profileMoneyCellDidClickedCommentButton;

- (void)profileMoneyCellDidClickedRedBagButton;

@end

@interface JXProfileMoneyCell : UITableViewCell

@property (nonatomic, strong) JXAccount *account;

+ (instancetype)moneyCell;

@property (nonatomic, weak) id<JXProfileMoneyCellDelegate> delegate;
@end
