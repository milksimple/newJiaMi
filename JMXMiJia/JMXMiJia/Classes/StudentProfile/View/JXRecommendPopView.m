//
//  JXRecommendPopView.m
//  JMXMiJia
//
//  Created by mac on 16/3/11.
//  Copyright © 2016年 mac. All rights reserved.
//

#import "JXRecommendPopView.h"

@interface JXRecommendPopView()

@end

@implementation JXRecommendPopView

+ (instancetype)recommendPopView {
    return [[NSBundle mainBundle] loadNibNamed:NSStringFromClass([JXRecommendPopView class]) owner:nil options:nil].lastObject;
}

@end
