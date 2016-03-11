//
//  JXProfileHeaderView.h
//  JMXMiJia
//
//  Created by mac on 16/1/18.
//  Copyright © 2016年 mac. All rights reserved.
//

#import <UIKit/UIKit.h>
@class JXAccount;
@protocol JXProfileHeaderViewDelegate <NSObject>

@optional
- (void)profileHeaderViewDidClickedProfileInfoButton;

@end

@interface JXProfileHeaderView : UIView

@property (nonatomic, strong) JXAccount *account;

@property (nonatomic, weak) id<JXProfileHeaderViewDelegate> delegate;

@end
