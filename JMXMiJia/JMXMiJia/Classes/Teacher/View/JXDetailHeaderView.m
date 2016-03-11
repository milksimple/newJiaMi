//
//  JXDetailHeaderView.m
//  JMXMiJia
//
//  Created by mac on 16/1/20.
//  Copyright © 2016年 mac. All rights reserved.
//

#import "JXDetailHeaderView.h"
#import "JXTeacher.h"
#import "JXSchool.h"
#import <SDWebImageManager.h>

@interface JXDetailHeaderView() <SDWebImageManagerDelegate>
@property (weak, nonatomic) IBOutlet UIImageView *iconView;
@property (weak, nonatomic) IBOutlet UIImageView *gradeView;
@property (weak, nonatomic) IBOutlet UILabel *nameLabel;
@property (weak, nonatomic) IBOutlet UIImageView *sexView;
@property (weak, nonatomic) IBOutlet UILabel *schoolLabel;
@property (weak, nonatomic) IBOutlet UIImageView *starView;
@property (weak, nonatomic) IBOutlet UIButton *signCountButton;
@property (weak, nonatomic) IBOutlet UIButton *distanceButton;
@property (nonatomic, strong) SDWebImageManager *manager;
@end

@implementation JXDetailHeaderView

- (SDWebImageManager *)manager {
    if (_manager == nil) {
        _manager = [SDWebImageManager sharedManager];
        _manager.delegate = self;
    }
    return _manager;
}

+ (instancetype)headerView {
    return [[NSBundle mainBundle] loadNibNamed:@"JXDetailHeaderView" owner:nil options:nil].lastObject;
}

+ (CGFloat)headerHeight {
    return 116;
}

- (void)setTeacher:(JXTeacher *)teacher {
    _teacher = teacher;
    


     NSString *iconUrl = [NSString stringWithFormat:@"%@/%@", JXServerName, teacher.photo];
    __weak typeof(self) weakSelf = self;
    [self.manager downloadImageWithURL:[NSURL URLWithString:iconUrl] options:0 progress:nil completed:^(UIImage *image, NSError *error, SDImageCacheType cacheType, BOOL finished, NSURL *imageURL) {
        
        weakSelf.iconView.image = image;
    }];
    
    self.nameLabel.text = teacher.name;
    self.schoolLabel.text = teacher.school;
    self.starView.image = [UIImage imageNamed:[NSString stringWithFormat:@"star_%zd", teacher.star]];
    [self.signCountButton setTitle:[NSString stringWithFormat:@"%zd 人", teacher.count] forState:UIControlStateNormal];
    [self.distanceButton  setTitle:teacher.distance forState:UIControlStateNormal];
}

/**
 *  将图片裁剪为圆形图片
 *
 *  @param originImage 原始图片
 *
 *  @param diameter 目标直径
 */
- (UIImage *)circleImageWithOriginImage:(UIImage *)originImage diameter:(CGFloat)diameter {
    // 1.开启图形上下文
    UIGraphicsBeginImageContext(CGSizeMake(diameter, diameter));
    
    // 2. 获取上下文
    CGContextRef ctx = UIGraphicsGetCurrentContext();
    
    // 3.画圆
    CGContextAddEllipseInRect(ctx, CGRectMake(0, 0, diameter, diameter));
    
    // 4.按当前路径剪切
    CGContextClip(ctx);
    
    // 5. 画图
    [originImage drawInRect:CGRectMake(0, 0, originImage.size.width, originImage.size.height)];
    
    // 6. 获得图片
    UIImage *newImage = UIGraphicsGetImageFromCurrentImageContext();
    
    // 7.关闭上下文
    UIGraphicsEndImageContext();
    
    return newImage;
}

#pragma mark - SDWebImageManagerDelegate
- (BOOL)imageManager:(SDWebImageManager *)imageManager shouldDownloadImageForURL:(NSURL *)imageURL {
    return YES;
}

- (UIImage *)imageManager:(SDWebImageManager *)imageManager transformDownloadedImage:(UIImage *)image withURL:(NSURL *)imageURL {
    // 以宽为直径裁剪为圆形
    UIImage *newImage = [self circleImageWithOriginImage:image diameter:image.size.width];
    return newImage;
}

@end
