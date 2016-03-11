//
//  JXStudentClassHeaderView.h
//  JMXMiJia
//
//  Created by mac on 16/2/29.
//  Copyright © 2016年 mac. All rights reserved.
//

typedef void (^JXStudentClassHeaderViewDidClickedAction)();

#import <UIKit/UIKit.h>
@class JXStudentProgress;

@interface JXStudentClassHeaderView : UIView

+ (instancetype)header;

+ (CGFloat)headerHeight;
/** 进度模型 */
@property (nonatomic, strong) JXStudentProgress *progress;

@property (nonatomic, copy) JXStudentClassHeaderViewDidClickedAction headerViewClickedAction;
@end
