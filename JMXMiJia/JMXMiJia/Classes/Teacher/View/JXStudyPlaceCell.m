//
//  JXStudyPlaceCell.m
//  JMXMiJia
//
//  Created by mac on 16/2/14.
//  Copyright © 2016年 mac. All rights reserved.
//

#import "JXStudyPlaceCell.h"
#import "JXSchool.h"

@interface JXStudyPlaceCell()
@property (weak, nonatomic) IBOutlet UILabel *placeLabel;

@end

@implementation JXStudyPlaceCell

+ (instancetype)cell {
    return [[NSBundle mainBundle] loadNibNamed:@"JXStudyPlaceCell" owner:nil options:nil].lastObject;
}

- (void)awakeFromNib {
    // Initialization code
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

- (void)setSchool:(JXSchool *)school {
    _school = school;
    
    self.placeLabel.text = school.name;
}

@end
