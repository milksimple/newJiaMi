//
//  JXStudentScoreCell.h
//  JMXMiJia
//
//  Created by mac on 16/2/22.
//  Copyright © 2016年 mac. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface JXStudentScoreCell : UITableViewCell

+ (instancetype)cell;

- (CGFloat)rowHeight;
/** 评论内容 */
@property (nonatomic, copy) NSString *comment;
@end
