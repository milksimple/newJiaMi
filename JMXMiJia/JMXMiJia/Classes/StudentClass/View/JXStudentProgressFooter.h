//
//  JXStudentProgressFooter.h
//  JMXMiJia
//
//  Created by mac on 16/2/23.
//  Copyright © 2016年 mac. All rights reserved.
//  我的进度页面的footer

#import <UIKit/UIKit.h>
@class JXToStudentComment;

@protocol JXStudentProgressFooterDelegate <NSObject>

@optional
- (void)studentProgressFooterDidClickReplyButton;

@end

@interface JXStudentProgressFooter : UIView

+ (instancetype)footer;

+ (CGFloat)footerHeight;

@property (nonatomic, weak) id<JXStudentProgressFooterDelegate> delegate;
/** 老师给学生的评论模型 */
@property (nonatomic, strong) JXToStudentComment *comment;
@end
