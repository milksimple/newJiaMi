//
//  JXHelpGroup.h
//  JMXMiJia
//
//  Created by 张盼盼 on 16/3/11.
//  Copyright © 2016年 mac. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface JXHelpGroup : NSObject
/** 组名 */
@property (nonatomic, copy) NSString *groupName;
/** 里面装的是JXHelpItem模型 */
@property (nonatomic, strong) NSArray *helpItems;
@end
