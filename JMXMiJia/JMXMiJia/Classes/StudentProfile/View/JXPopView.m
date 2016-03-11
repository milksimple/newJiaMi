//
//  JXPopView.m
//  JMXMiJia
//
//  Created by mac on 16/3/11.
//  Copyright © 2016年 mac. All rights reserved.
//

#import "JXPopView.h"

@implementation JXPopView

+ (instancetype)popView {
    return [[NSBundle mainBundle] loadNibNamed:NSStringFromClass([JXPopView class]) owner:nil options:nil].lastObject;
}

@end
