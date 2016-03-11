//
//  JXAccountTool.h
//  JMXMiJia
//
//  Created by mac on 16/1/12.
//  Copyright © 2016年 mac. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "JXAccount.h"

@interface JXAccountTool : NSObject
/**
 *  存储账号信息
 *
 *  @param account 账号模型
 */
+ (void)saveAccount:(JXAccount *)account;

/**
 *  返回账号信息
 *
 *  @return 账号模型
 */
+ (JXAccount *)account;

@end
