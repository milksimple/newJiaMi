//
//  JXChooseNumberView.m
//  JMXMiJia
//
//  Created by mac on 16/3/7.
//  Copyright © 2016年 mac. All rights reserved.
//

#import "JXChooseNumberView.h"

@interface JXChooseNumberView()
@property (weak, nonatomic) IBOutlet UILabel *numberLabel;

@end

@implementation JXChooseNumberView

+ (instancetype)numberView {
    return [[NSBundle mainBundle] loadNibNamed:NSStringFromClass([JXChooseNumberView class]) owner:nil options:nil].lastObject;
}

- (IBAction)plus {
    NSInteger number = [self.numberLabel.text integerValue];
    number += 10;
    self.numberLabel.text = [NSString stringWithFormat:@"%zd", number];
}

- (IBAction)minus {
    NSInteger number = [self.numberLabel.text integerValue];
    if (number > 0) {
        number -= 10;
        self.numberLabel.text = [NSString stringWithFormat:@"%zd", number];
    }
}

- (NSInteger)money {
    return [self.numberLabel.text integerValue];
}

@end
