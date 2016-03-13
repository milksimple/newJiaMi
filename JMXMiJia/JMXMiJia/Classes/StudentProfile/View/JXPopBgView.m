//
//  JXPopBgView.m
//  JMXMiJia
//
//  Created by mac on 16/3/11.
//  Copyright © 2016年 mac. All rights reserved.
//

#import "JXPopBgView.h"
#import "UIView+JXExtension.h"

@interface JXPopBgView()

@property (nonatomic, weak) UIView *contentView;

@end

@implementation JXPopBgView

+ (instancetype)popBgViewWithContentView:(UIView *)contentView contentSize:(CGSize)size {
    JXPopBgView *popBgView = [[JXPopBgView alloc] init];
    popBgView.backgroundColor = [UIColor colorWithRed:100.0/255 green:100.0/255 blue:100.0/255 alpha:0.6];
    popBgView.frame = CGRectMake(0, 0, JXScreenW, JXScreenH);
    contentView.jx_size = size;
    
    CGFloat contentW = size.width;
    CGFloat contentH = size.height;
    CGFloat contentX = (JXScreenW - contentW) * 0.5;
    CGFloat contentY = (JXScreenH - contentH) * 0.5;
    contentView.frame = CGRectMake(contentX, contentY, contentW, contentH);
    contentView.layer.cornerRadius = size.width * 0.05;
    [popBgView addSubview:contentView];
    popBgView.contentView = contentView;
    return popBgView;
}

- (void)layoutSubviews {
    [super layoutSubviews];
    
    CGFloat contentW = self.contentView.jx_size.width;
    CGFloat contentH = self.contentView.jx_size.height;
    CGFloat contentX = (self.jx_width - contentW) * 0.5;
    CGFloat contentY = (self.jx_height - contentH) * 0.5;
    self.contentView.frame = CGRectMake(contentX, contentY, contentW, contentH);
}

- (void)show {
    self.frame = CGRectMake(0, 0, JXScreenW, JXScreenH);
    UIWindow *topWindow = [UIApplication sharedApplication].windows.lastObject;
    [topWindow addSubview:self];
}

- (void)dismiss {
    [self removeFromSuperview];
}

- (void)touchesBegan:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event {
    [self dismiss];
}

@end
