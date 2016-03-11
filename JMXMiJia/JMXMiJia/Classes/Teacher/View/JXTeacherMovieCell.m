//
//  JXTeacherMovieCell.m
//  JMXMiJia
//
//  Created by mac on 16/3/4.
//  Copyright © 2016年 mac. All rights reserved.
//

#import "JXTeacherMovieCell.h"
#import "UIView+JXExtension.h"

@interface JXTeacherMovieCell()

@property (nonatomic, weak) UILabel *titleLabel;

@end

@implementation JXTeacherMovieCell
// 空隙
static CGFloat const margin = 20;
static CGFloat const titleHeight = 20;

- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier {
    if (self = [super initWithStyle:style reuseIdentifier:reuseIdentifier]) {
        [self setupTitleLabel];
        
        [self setupMovieView];
    }
    return self;
}

- (void)setupTitleLabel {
    UILabel *titleLabel = [[UILabel alloc] init];
    titleLabel.textColor = JXColor(250, 115, 64);
    titleLabel.text = @"教练风采";
    titleLabel.textAlignment = NSTextAlignmentCenter;
    [self addSubview:titleLabel];
    self.titleLabel = titleLabel;
}

- (void)setupMovieView {
    // 1.获取视频的URL
    NSURL *url = [NSURL URLWithString:@"http://v1.mukewang.com/19954d8f-e2c2-4c0a-b8c1-a4c826b5ca8b/L.mp4"];
    
    // 2.创建控制器
    MPMoviePlayerController *playerController = [[MPMoviePlayerController alloc] initWithContentURL:url];
    
    // 4.将View添加到控制器上
    [self.contentView addSubview:playerController.view];
    
    // 5.设置属性
    playerController.controlStyle = MPMovieControlStyleDefault;
    
    playerController.scalingMode = MPMovieScalingModeAspectFit;
    
    playerController.shouldAutoplay = NO;
    
    self.playerController = playerController;
    
    [playerController prepareToPlay];
}

- (void)setTeacher:(JXTeacher *)teacher {
    _teacher = teacher;
    
//    self.playerController.contentURL = [NSURL URLWithString:[NSString stringWithFormat:@"%@/%@", JXServerName, teacher.]];
}

- (void)didMoveToWindow {
    [super didMoveToWindow];
    
//    [self.playerController prepareToPlay];
}

+ (CGFloat)rowHeight {
    return margin + titleHeight + (JXScreenW - 2 * margin)*9.0/16 + margin;
}

- (void)layoutSubviews {
    [super layoutSubviews];
    
    CGFloat titleW = 100;
    CGFloat titleH = titleHeight;
    CGFloat titleX = (self.jx_width - titleW) * 0.5;
    CGFloat titleY = margin;
    self.titleLabel.frame = CGRectMake(titleX, titleY, titleW, titleH);
    
    CGFloat playerX = 20;
    CGFloat playerW = self.jx_width - 2 * playerX;
    CGFloat playerH = playerW * 9.0 / 16.0;
    CGFloat playerY = CGRectGetMaxY(self.titleLabel.frame) + margin*0.5;
    self.playerController.view.frame = CGRectMake(playerX, playerY, playerW, playerH);
}

@end
