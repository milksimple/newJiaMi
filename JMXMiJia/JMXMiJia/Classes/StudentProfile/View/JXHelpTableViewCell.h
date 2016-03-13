//
//  JXHelpTableViewCell.h
//  JMXMiJia
//
//  Created by 张盼盼 on 16/3/11.
//  Copyright © 2016年 mac. All rights reserved.
//

#import <UIKit/UIKit.h>
@class JXHelpItem;

@interface JXHelpTableViewCell : UITableViewCell

@property (nonatomic, strong) JXHelpItem *helpItem;

@property (nonatomic, assign) NSInteger rowNO;

- (CGFloat)rowHeight;

+ (NSString *)reuseIdentifier;

+ (instancetype)cell;
@end
