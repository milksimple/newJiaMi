//
//  JXStarView.h
//  JMXMiJia
//
//  Created by mac on 16/3/2.
//  Copyright © 2016年 mac. All rights reserved.
//

typedef enum {
    JXStarViewTypeFee, // 报名学费
    JXStarViewTypeIntro // 个人介绍
} JXStarViewType;

#import <UIKit/UIKit.h>

@protocol JXStarViewDelegate <NSObject>

@optional


@end

@interface JXStarView : UIView

+ (instancetype)starView;

@property (nonatomic, copy) NSString *title;

@property (nonatomic, assign) JXStarViewType type;

/** 分数 */
@property (nonatomic, assign, readonly) NSInteger score;
@end
