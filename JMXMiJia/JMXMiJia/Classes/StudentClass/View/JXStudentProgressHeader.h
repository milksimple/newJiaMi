//
//  JXStudentProgressHeader.h
//  JMXMiJia
//
//  Created by mac on 16/2/22.
//  Copyright © 2016年 mac. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface JXStudentProgressHeader : UIView

@property (nonatomic, copy) NSString *date;

+ (instancetype)header;

+ (CGFloat)headerHeight;
@end
