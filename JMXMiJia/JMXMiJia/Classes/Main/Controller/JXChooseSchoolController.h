//
//  JXChooseSchoolController.h
//  JMXMiJia
//
//  Created by mac on 16/2/1.
//  Copyright © 2016年 mac. All rights reserved.
//

#import <UIKit/UIKit.h>
@class JXSchool;

@protocol JXChooseSchoolControllerDelegate <NSObject>

@optional
- (void)chooseSchoolDidFinished:(JXSchool *)school;

@end

@interface JXChooseSchoolController : UITableViewController

@property (nonatomic, weak) id<JXChooseSchoolControllerDelegate> delegate;
/** 默认(上次)选中的学校 */
@property (nonatomic, strong) JXSchool *defaultSchool;

@end
