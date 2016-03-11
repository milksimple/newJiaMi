//
//  JXChangeRealnameController.h
//  JMXMiJia
//
//  Created by mac on 16/1/25.
//  Copyright © 2016年 mac. All rights reserved.
//  修改真实姓名控制器

#import <UIKit/UIKit.h>

@protocol JXChangeRealnameControllerDelegate <NSObject>

@optional
- (void)changeRealnameControllerDidFinished;

@end

@interface JXChangeRealnameController : UIViewController

@property (nonatomic, copy) NSString *defaultName;

@property (nonatomic, weak) id<JXChangeRealnameControllerDelegate> delegate;
@end
