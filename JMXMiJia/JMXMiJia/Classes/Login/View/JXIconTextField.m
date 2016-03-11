//
//  JXIconTextField.m
//  JMXMiJia
//
//  Created by mac on 16/1/13.
//  Copyright © 2016年 mac. All rights reserved.
//

#import "JXIconTextField.h"

@interface JXIconTextField()
@property (nonatomic, strong) UIImage *editingImage;
@property (nonatomic, strong) UIImage *endEditImage;

@property (nonatomic, weak) UIImageView *iconView;
@end

@implementation JXIconTextField

- (instancetype)initWithFrame:(CGRect)frame {
    if (self = [super initWithFrame:frame]) {
        UIImageView *iconView = [[UIImageView alloc] init];
        iconView.contentMode = UIViewContentModeCenter;
        self.leftView = iconView;
        self.leftViewMode = UITextFieldViewModeAlways;
        self.iconView = iconView;
        
        self.layer.borderWidth = 1;
        
        // 监听自己编辑状态的通知
        [JXNotificationCenter addObserver:self selector:@selector(textFieldBeginEditing) name:UITextFieldTextDidBeginEditingNotification object:self];
        [JXNotificationCenter addObserver:self selector:@selector(textFieldEndEditing) name:UITextFieldTextDidEndEditingNotification object:self];
    }
    return self;
}

- (void)setEditingImage:(UIImage *)editingImage endEditImage:(UIImage *)endEditImage {
    self.iconView.image = endEditImage;
    self.layer.borderColor = JXColor(211, 211, 211).CGColor;
    self.editingImage = editingImage;
    self.endEditImage = endEditImage;
}

- (void)textFieldBeginEditing {
    if (self.editingImage) {
        self.iconView.image = self.editingImage;
    }
    self.layer.borderColor = JXColor(200, 222, 134).CGColor;
}

- (void)textFieldEndEditing {
    if (self.endEditImage) {
        self.iconView.image = self.endEditImage;
    }
    self.layer.borderColor = JXColor(211, 211, 211).CGColor;
}

- (void)layoutSubviews {
    [super layoutSubviews];
    
    self.layer.cornerRadius = self.frame.size.height * 0.5;
    
    CGFloat leftViewX = 0;
    CGFloat leftViewY = 0;
    CGFloat leftViewW = self.frame.size.height;
    CGFloat leftViewH = leftViewW;
    self.leftView.frame = CGRectMake(leftViewX, leftViewY, leftViewW, leftViewH);
}

@end
