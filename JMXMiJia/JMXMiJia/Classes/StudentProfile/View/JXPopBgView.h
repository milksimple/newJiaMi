//
//  JXPopBgView.h
//  JMXMiJia
//
//  Created by mac on 16/3/11.
//  Copyright © 2016年 mac. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface JXPopBgView : UIView

@property (nonatomic, weak) UIView *contentView;

+ (instancetype)popBgViewWithContentView:(UIView *)contentView contentSize:(CGSize)size;

- (void)show;

- (void)dismiss;
@end
