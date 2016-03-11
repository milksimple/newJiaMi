//
//  JXTeacherToolBar.m
//  JMXMiJia
//
//  Created by mac on 15/12/25.
//  Copyright © 2015年 mac. All rights reserved.
//

#import "JXTeacherToolBar.h"
#import <Masonry.h>

@interface JXTeacherToolBar()



@end

@implementation JXTeacherToolBar

- (instancetype)initWithFrame:(CGRect)frame {
    if (self = [super initWithFrame:frame]) {
        self.backgroundColor = [UIColor whiteColor];
        self.layer.borderWidth = 1;
        self.layer.borderColor = JXColor(238, 238, 238).CGColor;
        
        [self setup];
    }
    return self;
}

- (void)awakeFromNib {
    [super awakeFromNib];
}

- (void)setup {
    UIButton *sumUpButton = [[UIButton alloc] init];
    [sumUpButton setTitle:@"综合排序" forState:UIControlStateNormal];
    [sumUpButton setTitleColor:JXColor(144, 144, 144) forState:UIControlStateNormal];
    [self addSubview:sumUpButton];
    
    UIButton *nearbyButton = [[UIButton alloc] init];
    [nearbyButton setTitle:@"附近" forState:UIControlStateNormal];
    [nearbyButton setTitleColor:JXColor(144, 144, 144) forState:UIControlStateNormal];
    [self addSubview:nearbyButton];
    
    UIButton *filterButton = [[UIButton alloc] init];
    [filterButton setTitle:@"筛选" forState:UIControlStateNormal];
    [filterButton setTitleColor:JXColor(144, 144, 144) forState:UIControlStateNormal];
    [self addSubview:filterButton];
    
    UIView *spearator1 = [[UIView alloc] init];
    spearator1.backgroundColor = JXColor(213, 213, 213);
    [self addSubview:spearator1];
    
    UIView *spearator2 = [[UIView alloc] init];
    spearator2.backgroundColor = JXColor(213, 213, 213);
    [self addSubview:spearator2];
    
    MASAttachKeys(sumUpButton, nearbyButton, filterButton);
    
    [sumUpButton mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.top.bottom.offset(0);
        make.right.equalTo(nearbyButton.left);
        make.width.equalTo(nearbyButton);
    }];
    
    [nearbyButton mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(sumUpButton.right).offset(0);
        make.top.bottom.offset(0);
        make.width.equalTo(sumUpButton);
        make.right.equalTo(filterButton.left);
    }];
    
    [filterButton mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(nearbyButton.right).offset(0);
        make.top.bottom.right.offset(0);
        make.width.equalTo(sumUpButton);
    }];
    
    [spearator1 mas_makeConstraints:^(MASConstraintMaker *make) {
        make.width.offset(1);
        make.height.offset(15);
        make.centerY.offset(0);
        make.left.equalTo(sumUpButton.right);
    }];
    
    [spearator2 mas_makeConstraints:^(MASConstraintMaker *make) {
        make.width.offset(1);
        make.height.offset(15);
        make.centerY.offset(0);
        make.left.equalTo(nearbyButton.right);
    }];
}

+ (instancetype)toolbar {
    return [[NSBundle mainBundle] loadNibNamed:@"JXTeacherToolBar" owner:nil options:nil].lastObject;
}

/**
 *  综合排序
 */
- (IBAction)sumUp:(UIButton *)sender {
    
}

/**
 *  附近
 */
- (IBAction)nearby:(UIButton *)sender {
    
}

/**
 *  筛选
 */
- (IBAction)filter:(UIButton *)sender {
    
}

+ (CGFloat)height {
    return 50;
}

@end
