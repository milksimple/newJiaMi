//
//  JXDetailFooterView.h
//  JMXMiJia
//
//  Created by mac on 16/1/20.
//  Copyright © 2016年 mac. All rights reserved.
//

typedef void (^DetailFooterClickedButtonAction)();

#import <UIKit/UIKit.h>

@protocol JXDetailFooterViewDelegate <NSObject>

@optional
/** 点击了报名按钮 */
- (void)detailFooterViewDidClickedSignupButton;
/** 点击了拨打电话按钮 */
- (void)detailFooterViewDidClickedCallButton;
@end

@interface JXDetailFooterView : UIView

+ (instancetype)footerView;

+ (CGFloat)footerHeight;
/** 报名按钮被点击要进行的操作 */
@property (nonatomic, copy) DetailFooterClickedButtonAction signupButtonClickedAction;
/** 拨打电话按钮被点击要进行的操作 */
@property (nonatomic, copy) DetailFooterClickedButtonAction callButtonClickedAction;

@property (nonatomic, weak) id<JXDetailFooterViewDelegate> delegate;

@property (nonatomic, copy) NSString *mobile;
@end
