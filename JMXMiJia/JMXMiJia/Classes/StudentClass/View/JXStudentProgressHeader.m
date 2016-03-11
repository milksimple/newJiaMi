//
//  JXStudentProgressHeader.m
//  JMXMiJia
//
//  Created by mac on 16/2/22.
//  Copyright © 2016年 mac. All rights reserved.
//

#import "JXStudentProgressHeader.h"

@interface JXStudentProgressHeader()
@property (weak, nonatomic) IBOutlet UILabel *currentDateLabel;

@end

@implementation JXStudentProgressHeader

- (void)awakeFromNib {
    NSDateFormatter *formatter = [[NSDateFormatter alloc] init];
    formatter.dateFormat = @"yyyy年MM月dd日";
    NSDate *currentDate = [NSDate date];
    NSString *dateStr = [formatter stringFromDate:currentDate];
    self.currentDateLabel.text = dateStr;
}

+ (instancetype)header {
    return [[NSBundle mainBundle] loadNibNamed:NSStringFromClass([JXStudentProgressHeader class]) owner:nil options:nil].lastObject;
}

+ (CGFloat)headerHeight {
    return 60;
}

- (void)setDate:(NSString *)date {
    _date = date;
    
    self.currentDateLabel.text = date;
}
@end
