//
//  GALiveMainViewController.m
//  Suo
//
//  Created by 怪兽 🐙 on 2019/7/24.
//  Copyright © 2019 怪兽 🐙. All rights reserved.
//

#import "GALiveMainViewController.h"

#import "GALiveViewController.h"
#import "GAVideoViewController.h"
#import "GACityWideViewController.h"

#import "GAShootingViewController.h"
#import "GALiveChatViewController.h" // 私信

#import <WMPageController.h>
#import <DCPathButton.h>




@interface GALiveMainViewController ()
@property(nonatomic,strong) NSArray<NSString*> *pages;

@end

@implementation GALiveMainViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    
    self.pages = @[@"直播",@"视频",@"同城"];
   

    [self.navigationController.navigationBar setBackgroundImage:UIImage.new forBarMetrics:UIBarMetricsDefault];
    [self.navigationController.navigationBar setShadowImage:UIImage.new];
    
    UIButton *chatBtn = UIButton.new;
    [chatBtn setImage:[UIImage imageNamed:@"微信"] forState:UIControlStateNormal];
    [chatBtn addTarget:self action:@selector(rightItemClick) forControlEvents:UIControlEventTouchUpInside];
    UIBarButtonItem *chatItem = [[UIBarButtonItem alloc] initWithCustomView:chatBtn];
    self.navigationItem.rightBarButtonItem = chatItem;

    [self setMenuViewStyle:WMMenuViewStyleLine];
    [self setProgressColor:UIColor.redColor];
    [self setProgressViewCornerRadius:2.0];
    [self setProgressHeight:4];
    [self setProgressWidth:40];
    [self setTitleFontName:@"Helvetica-BoldOblique"];
   
    
    [self.menuView reload];
    [self reloadData];
    [self.menuView selectItemAtIndex:0];
}

- (void)rightItemClick {
    GALiveChatViewController *chatVC = GALiveChatViewController.new;
    [self.navigationController pushViewController:chatVC animated:YES];
}


- (void)viewWillAppear:(BOOL)animated{
    [super viewWillAppear:animated];
    [self.navigationController setNavigationBarHidden:YES animated:YES];
}

- (NSInteger)numbersOfChildControllersInPageController:(WMPageController *)pageController{
    return  self.pages.count;
}

- (NSString *)pageController:(WMPageController *)pageController titleAtIndex:(NSInteger)index{
    return  self.pages[index];
}
- (UIViewController *)pageController:(WMPageController *)pageController viewControllerAtIndex:(NSInteger)index{
    
    UIColor *color = UIColor.whiteColor;
    UIViewController *vc = UIViewController.new;
    [vc.view setBackgroundColor:color];
    
    if (index == 0) {
        vc = GALiveViewController.new;
    }
    
    if (index == 1) {
        vc = [GAVideoViewController new];
    }
    if (index == 2) {
        vc = GACityWideViewController.new;
    }
    
    return vc;
}

- (CGRect)pageController:(WMPageController *)pageController preferredFrameForMenuView:(WMMenuView *)menuView{
    [menuView setBackgroundColor:UIColor.whiteColor];
    
    return  CGRectMake(0, self.view.safeAreaInsets.top, ScreenWidth, 44);
}
- (CGRect)pageController:(WMPageController *)pageController preferredFrameForContentView:(WMScrollView *)contentView{

    
    CGFloat topOffset = 44 + self.view.safeAreaInsets.top + 6;
    CGFloat bottom = self.view.safeAreaInsets.bottom;
    
    CGRect frame = self.view.bounds;

    frame.origin.y = topOffset + 4; // 4.o 间距
    frame.size.height -= (topOffset+bottom);
    
    return frame;
}

@end
