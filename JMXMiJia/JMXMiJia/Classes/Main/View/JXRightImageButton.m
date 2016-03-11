//
//  JXRightImageButton.m
//  JMXMiJia
//
//  Created by mac on 16/1/20.
//  Copyright © 2016年 mac. All rights reserved.
//

#import "JXRightImageButton.h"
#import <Masonry.h>

#define JXMargin 0

@interface JXRightImageButton()
@end

@implementation JXRightImageButton

- (instancetype)initWithFrame:(CGRect)frame {
    if (self = [super initWithFrame:frame]) {
//        self.titleLabel.adjustsFontSizeToFitWidth = YES;
    }
    return self;
}


- (void)layoutSubviews {
    [super layoutSubviews];
    
    self.imageEdgeInsets = UIEdgeInsetsMake(0, self.titleLabel.frame.size.width, 0, -self.titleLabel.frame.size.width);
    self.titleEdgeInsets = UIEdgeInsetsMake(0, -self.imageView.frame.size.width, 0, self.imageView.frame.size.width);
}

- (void)setTitle:(NSString *)title forState:(UIControlState)state
{
    [super setTitle:title forState:state];
    
    // 只要修改了文字，就让按钮重新计算自己的尺寸
    [self sizeToFit];
}

- (void)setImage:(UIImage *)image forState:(UIControlState)state
{
    [super setImage:image forState:state];
    
    // 只要修改了图片，就让按钮重新计算自己的尺寸
    [self sizeToFit];
}

- (void)setHighlighted:(BOOL)highlighted {
    
}
@end

