//
//  JXProfileInfoIconCell.m
//  JMXMiJia
//
//  Created by mac on 16/1/22.
//  Copyright © 2016年 mac. All rights reserved.
//

#import "JXProfileInfoIconCell.h"
#import <Masonry.h>

@interface JXProfileInfoIconCell()

@end

@implementation JXProfileInfoIconCell
// cell内部控件距离父控件间距
static CGFloat const margin = 10;

#pragma mark - 初始化
- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier {
    if (self = [super initWithStyle:UITableViewCellStyleDefault reuseIdentifier:reuseIdentifier]) {
        self.accessoryType = UITableViewCellAccessoryDisclosureIndicator;
        [self setup];
    }
    return self;
}

- (void)setup {
    // 右边图片
//    UIImageView *rightImageView = [[UIImageView alloc] init];
//    rightImageView.clipsToBounds = YES;
//    [self addSubview:rightImageView];
//    self.rightImageView = rightImageView;
}

- (void)layoutSubviews {
    [super layoutSubviews];
    
//    CGFloat rightImageH = self.frame.size.height - margin;
//    CGFloat rightImageW = rightImageH;
//    CGFloat rightImageX = self.frame.size.width - rightImageW - 40;
//    CGFloat rightImageY = margin * 0.5;
//    self.rightImageView.frame = CGRectMake(rightImageX, rightImageY, rightImageW, rightImageH);
//    self.rightImageView.layer.cornerRadius = rightImageH*0.5;
}
@end
