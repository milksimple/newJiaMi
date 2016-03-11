//
//  NSString+Extension.h
//  JMXMiJia
//
//  Created by mac on 16/1/19.
//  Copyright © 2016年 mac. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface NSString (Extension)
/**
 *  获得一段文字的在label的size
 *
 *  @param font 字体
 *  @param maxW 期望文字占的最大宽度
 */
- (CGSize)sizeWithFont:(UIFont *)font maxW:(CGFloat)maxW;
@end
