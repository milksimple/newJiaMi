//
//  JXSearchBar.h
//  JMXMiJia
//
//  Created by mac on 15/12/24.
//  Copyright © 2015年 mac. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "JXRightImageButton.h"

@protocol JXSearchBarDelegate <NSObject>

@optional
- (void)searchBarButtonDidClickedWithSearchContent:(NSString *)searchContent;
/** 搜索框内容清空了 */
- (void)searchBarDidClearedSearchText;
/** 筛选按钮被点击了 */
- (void)searchBarDidClickedFilterButton;
@end

@interface JXSearchBar : UIView

+ (CGFloat)height;

- (void)quitKeyboard;
@property (nonatomic, weak) id<JXSearchBarDelegate> delegate;
@end
