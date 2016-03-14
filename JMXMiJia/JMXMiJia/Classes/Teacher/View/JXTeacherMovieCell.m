//
//  JXTeacherMovieCell.m
//  JMXMiJia
//
//  Created by mac on 16/3/4.
//  Copyright © 2016年 mac. All rights reserved.
//

#import "JXTeacherMovieCell.h"
#import "UIView+JXExtension.h"
#import "JXTeacher.h"

@interface JXTeacherMovieCell() <UIWebViewDelegate>

@property (nonatomic, weak) UILabel *titleLabel;

@property (nonatomic, weak) UIWebView *webView;

@property (nonatomic, weak) UILabel *corverLabel;
@end

@implementation JXTeacherMovieCell
// 空隙
static CGFloat const margin = 20;
static CGFloat const titleHeight = 20;

- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier {
    if (self = [super initWithStyle:style reuseIdentifier:reuseIdentifier]) {
        [self setupTitleLabel];
        self.selectionStyle = UITableViewCellSelectionStyleNone;
        
        [self setupWebview];
        
        [self setupCorverLabel];
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

- (void)setupWebview {
    UIWebView *webView = [[UIWebView alloc] init];
    [self.contentView addSubview:webView];
    self.webView = webView;
}

- (void)setupCorverLabel {
    UILabel *corverLabel = [[UILabel alloc] init];
    corverLabel.textAlignment = NSTextAlignmentCenter;
    corverLabel.backgroundColor = JXColor(200, 200, 200);
    corverLabel.textColor = [UIColor darkGrayColor];
    corverLabel.text = @"暂无视频信息";
    [self.contentView addSubview:corverLabel];
    self.corverLabel = corverLabel;
}

- (void)setTeacher:(JXTeacher *)teacher {
    _teacher = teacher;
    
    if (teacher.videos.count > 0) {
        self.corverLabel.hidden = YES;
        
        NSDictionary *videosDict = teacher.videos[0];
        NSURL *videoURL = [NSURL URLWithString:videosDict[@"videoPath"]];
        NSURLRequest *request = [NSURLRequest requestWithURL:videoURL];
        [self.webView loadRequest:request];
    }
    else {
        self.corverLabel.hidden = NO;
    }
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
    self.webView.frame = CGRectMake(playerX, playerY, playerW, playerH);
    
    self.corverLabel.frame = self.webView.frame;
}

/*
- (void)setupMovieView {
    NSURL *videoURL = [NSURL URLWithString:@"http://player.youku.com/embed/XMTQ4MTU0NTM4MA"];
    // 1.创建控制器
    MPMoviePlayerController *playerController = [[MPMoviePlayerController alloc] initWithContentURL:videoURL];
    
    // 2.将View添加到控制器上
    [self.contentView addSubview:playerController.view];
    
    // 3.设置属性
    playerController.controlStyle = MPMovieControlStyleDefault;
    
    playerController.scalingMode = MPMovieScalingModeAspectFit;
    
    playerController.shouldAutoplay = NO;
    
    self.playerController = playerController;
    
    [playerController prepareToPlay];
}
*/
@end
