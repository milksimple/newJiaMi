//
//  JXFilterView.m
//  JMXMiJia
//
//  Created by mac on 16/1/28.
//  Copyright © 2016年 mac. All rights reserved.
//

#import "JXFilterView.h"
#import "UIView+JXExtension.h"

@interface JXFilterView()
/** 容器 */
@property (nonatomic, weak) UIView *containerView;

@end

@implementation JXFilterView

+ (instancetype)filterView {
    return [[self alloc] init];
}

- (instancetype)initWithFrame:(CGRect)frame {
    if (self = [super initWithFrame:frame]) {
        // 遮盖
        self.backgroundColor = [UIColor colorWithRed:230/255.0 green:230/255.0 blue:230/255.0 alpha:0.4];
        self.frame = [UIScreen mainScreen].bounds;
        
        // 容器
        UIView *containerView = [[UIView alloc] init];
        CGFloat containerViewW = JXScreenW * 0.7;
        CGFloat containerViewH = JXScreenH;
        CGFloat containerViewX = JXScreenW;
        CGFloat containerViewY = 0;
        containerView.frame = CGRectMake(containerViewX, containerViewY, containerViewW, containerViewH);
        containerView.backgroundColor = [UIColor redColor];
        [self addSubview:containerView];
        self.containerView = containerView;
    }
    return self;
}

- (void)setContent:(UIView *)content {
    _content = content;
    
    content.frame = self.containerView.bounds;
    [self.containerView addSubview:content];
}

- (void)setContentViewController:(UIViewController *)contentViewController {
    _contentViewController = contentViewController;
    
    self.content = contentViewController.view;
}

- (void)show {
    UIWindow *window = [UIApplication sharedApplication].windows.lastObject;
    [window addSubview:self];
    [UIView animateWithDuration:0.2 animations:^{
        self.containerView.jx_x = JXScreenW - self.containerView.jx_width;
    }];
}

- (void)dismiss {
    [UIView animateWithDuration:0.2 animations:^{
        self.containerView.jx_x = JXScreenW;
    } completion:^(BOOL finished) {
        [self removeFromSuperview];
    }];
}

- (void)touchesBegan:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event {
    [self dismiss];
}

@end
