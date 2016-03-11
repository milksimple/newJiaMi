//
//  JXChooseSexController.h
//  JMXMiJia
//
//  Created by mac on 16/2/1.
//  Copyright © 2016年 mac. All rights reserved.
//  选择性别控制器

#import <UIKit/UIKit.h>

@protocol JXChooseSexControllerDelegate <NSObject>

@optional
- (void)chooseSexDidFinished:(JXSex)sex;

@end

@interface JXChooseSexController : UITableViewController

@property (nonatomic, weak) id<JXChooseSexControllerDelegate> delegate;
/** 默认(上次)选择的性别 */
@property (nonatomic, assign) JXSex defaultSex;

@end
