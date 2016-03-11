//
//  JXNewFeatureViewController.m
//  JMXMiJia
//
//  Created by mac on 16/3/11.
//  Copyright © 2016年 mac. All rights reserved.
//

#define JXNewfeatureCount 4

#import "JXNewFeatureViewController.h"
#import "UIView+JXExtension.h"
#import "JXTabBarController.h"

@interface JXNewFeatureViewController () <UIScrollViewDelegate>
@property (nonatomic, weak) UIPageControl *pageControl;

@property (nonatomic, weak) UIScrollView *scrollView;

@end

@implementation JXNewFeatureViewController 

- (void)viewDidLoad
{
    [super viewDidLoad];
    // 1.创建一个scrollView：显示所有的新特性图片
    UIScrollView *scrollView = [[UIScrollView alloc] init];
    scrollView.frame = self.view.bounds;
    [self.view addSubview:scrollView];
    self.scrollView = scrollView;
    
    // 2.添加图片到scrollView中
    CGFloat scrollW = scrollView.jx_width;
    CGFloat scrollH = scrollView.jx_height;
    for (int i = 0; i<JXNewfeatureCount; i++) {
        UIImageView *imageView = [[UIImageView alloc] init];
        imageView.jx_width = scrollW;
        imageView.jx_height = scrollH;
        imageView.jx_y = 0;
        imageView.jx_x = i * scrollW;
        // 显示图片
        NSString *name = [NSString stringWithFormat:@"new_feature_%d-667", i + 1];
        if (JXScreenH <= 480) {
            name = [NSString stringWithFormat:@"new_feature_%d", i + 1];
        }
        
        imageView.image = [UIImage imageNamed:name];
        [scrollView addSubview:imageView];
        
        // 如果是最后一个imageView，就往里面添加其他内容
        if (i == JXNewfeatureCount - 1) {
            [self setupLastImageView:imageView];
        }
    }
    
#warning 默认情况下，scrollView一创建出来，它里面可能就存在一些子控件了
#warning 就算不主动添加子控件到scrollView中，scrollView内部还是可能会有一些子控件
    
    // 3.设置scrollView的其他属性
    // 如果想要某个方向上不能滚动，那么这个方向对应的尺寸数值传0即可
    scrollView.contentSize = CGSizeMake(JXNewfeatureCount * scrollW, 0);
    scrollView.bounces = NO; // 去除弹簧效果
    scrollView.pagingEnabled = YES;
    scrollView.showsHorizontalScrollIndicator = NO;
    scrollView.delegate = self;
    
    // 4.添加pageControl：分页，展示目前看的是第几页
    UIPageControl *pageControl = [[UIPageControl alloc] init];
    pageControl.numberOfPages = JXNewfeatureCount;
    pageControl.backgroundColor = [UIColor redColor];
    pageControl.currentPageIndicatorTintColor = JXColor(253, 98, 42);
    pageControl.pageIndicatorTintColor = JXColor(189, 189, 189);
    pageControl.jx_centerX = scrollW * 0.5;
    pageControl.jx_centerY = scrollH - 50;
    [self.view addSubview:pageControl];
    self.pageControl = pageControl;
    
    // UIPageControl就算没有设置尺寸，里面的内容还是照常显示的
    //    pageControl.width = 100;
    //    pageControl.height = 50;
    //    pageControl.userInteractionEnabled = NO;
    
    //    UITextField *text = [[UITextField alloc] init];
    //    text.frame = CGRectMake(10, 20, 100, 50);
    //    text.borderStyle = UITextBorderStyleRoundedRect;
    //    [self.view addSubview:text];
}

- (void)scrollViewDidScroll:(UIScrollView *)scrollView
{
    double page = scrollView.contentOffset.x / scrollView.jx_width;
    // 四舍五入计算出页码
    self.pageControl.currentPage = (int)(page + 0.5);
    // 1.3四舍五入 1.3 + 0.5 = 1.8 强转为整数(int)1.8= 1
    // 1.5四舍五入 1.5 + 0.5 = 2.0 强转为整数(int)2.0= 2
    // 1.6四舍五入 1.6 + 0.5 = 2.1 强转为整数(int)2.1= 2
    // 0.7四舍五入 0.7 + 0.5 = 1.2 强转为整数(int)1.2= 1
}

/**
 *  初始化最后一个imageView
 *  @param imageView 最后一个imageView
 */
- (void)setupLastImageView:(UIImageView *)imageView
{
    // 开启交互功能
    imageView.userInteractionEnabled = YES;
    
    // 2.开始
    UIButton *startBtn = [[UIButton alloc] init];
    CGFloat startW = 100;
    CGFloat startH = 30;
    CGFloat startX = self.view.jx_width - startW - 10;
    CGFloat startY = 30;
    
    startBtn.frame = CGRectMake(startX, startY, startW, startH);
    [startBtn setBackgroundColor:JXColor(249, 107, 27)];
    [startBtn setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
    [startBtn setTitle:@"开始驾米>>" forState:UIControlStateNormal];
    [startBtn addTarget:self action:@selector(startClick) forControlEvents:UIControlEventTouchUpInside];
    [imageView addSubview:startBtn];
}

- (void)shareClick:(UIButton *)shareBtn
{
    // 状态取反
    shareBtn.selected = !shareBtn.isSelected;
}

- (void)startClick
{
    // 切换到JXTabBarController
    /*
     切换控制器的手段
     1.push：依赖于UINavigationController，控制器的切换是可逆的，比如A切换到B，B又可以回到A
     2.modal：控制器的切换是可逆的，比如A切换到B，B又可以回到A
     3.切换window的rootViewController
     */
    UIWindow *window = [UIApplication sharedApplication].keyWindow;
    window.rootViewController = [[JXTabBarController alloc] init];
    
    // modal方式，不建议采取：新特性控制器不会销毁
    //    JXTabBarViewController *main = [[JXTabBarViewController alloc] init];
    //    [self presentViewController:main animated:YES completion:nil];
}
@end
