//
//  JXRecommendPopView.h
//  JMXMiJia
//
//  Created by mac on 16/3/11.
//  Copyright © 2016年 mac. All rights reserved.
//

#import <UIKit/UIKit.h>

@protocol JXRecommendPopViewDelegate <NSObject>

@optional
- (void)recommendPopViewDidLongPressed;

@end

@interface JXRecommendPopView : UIView

+ (instancetype)recommendPopView;

@property (nonatomic, weak) id<JXRecommendPopViewDelegate> delegate;

@end
