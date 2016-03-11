//
//  JXStudentProgressDetailCell.h
//  JMXMiJia
//
//  Created by mac on 16/2/22.
//  Copyright © 2016年 mac. All rights reserved.
//

//typedef void (^JXStudentProgressDetailCellClickedCorverButtonAction)();

#import <UIKit/UIKit.h>
#import "JXToStudentComment.h"

@interface JXStudentProgressDetailCell : UITableViewCell
/** 评论模型 */
@property (nonatomic, strong) JXToStudentComment *comment;

+ (NSString *)reuseIdentifier;

+ (instancetype)cell;

+ (CGFloat)rowHeight;

//@property (nonatomic, copy) JXStudentProgressDetailCellClickedCorverButtonAction corverButtonClickedAction;
@end
