//
//  JXHelpTableViewCell.m
//  JMXMiJia
//
//  Created by 张盼盼 on 16/3/11.
//  Copyright © 2016年 mac. All rights reserved.
//

#import "JXHelpTableViewCell.h"
#import "JXHelpItem.h"

@interface JXHelpTableViewCell()
@property (weak, nonatomic) IBOutlet UILabel *numberLabel;
@property (weak, nonatomic) IBOutlet UILabel *askLabel;
@property (weak, nonatomic) IBOutlet UILabel *responseLabel;

@end

@implementation JXHelpTableViewCell

- (void)setHelpItem:(JXHelpItem *)helpItem {
    _helpItem = helpItem;
    
    self.askLabel.text = helpItem.ask;
    self.responseLabel.text = helpItem.response;
}

- (void)setRowNO:(NSInteger)rowNO {
    _rowNO = rowNO;
    
    self.numberLabel.text = [NSString stringWithFormat:@"%zd、", rowNO + 1];
}

- (CGFloat)rowHeight {
    [self layoutIfNeeded];
    
    return 10 + self.askLabel.jx_height + 10 + self.responseLabel.jx_height + 10;
}

+ (NSString *)reuseIdentifier {
    return @"helpCell";
}

+ (instancetype)cell {
    return [[NSBundle mainBundle] loadNibNamed:NSStringFromClass([JXHelpTableViewCell class]) owner:nil options:nil].lastObject;
}

@end
