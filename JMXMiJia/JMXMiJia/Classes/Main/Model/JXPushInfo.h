//
//  JXPushInfo.h
//  JMXMiJia
//
//  Created by mac on 16/3/8.
//  Copyright © 2016年 mac. All rights reserved.
//

typedef enum {
    JXPushInfoTypeStartStudy,
    JXPushInfoTypeReceiveComment,
    JXPushInfoTypePass,
    JXPushInfoTypeSignupSuccess
} JXPushInfoType;

#import <Foundation/Foundation.h>

@interface JXPushInfo : NSObject <NSCoding>
/** 推送消息id */
@property (nonatomic, copy) NSString *id;

@property (nonatomic, assign) JXPushInfoType type;
/** 标题 */
@property (nonatomic, copy) NSString *title;
/** 内容 */
@property (nonatomic, copy) NSString *des;
/** 日期 */
@property (nonatomic, copy) NSString *sendTime;
@end
