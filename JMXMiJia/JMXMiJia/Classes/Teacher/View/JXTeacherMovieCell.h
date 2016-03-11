//
//  JXTeacherMovieCell.h
//  JMXMiJia
//
//  Created by mac on 16/3/4.
//  Copyright © 2016年 mac. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <MediaPlayer/MediaPlayer.h>
@class JXTeacher;

@interface JXTeacherMovieCell : UITableViewCell


@property (nonatomic, strong) MPMoviePlayerController *playerController;

@property (nonatomic, strong) JXTeacher *teacher;

+ (CGFloat)rowHeight;
@end
