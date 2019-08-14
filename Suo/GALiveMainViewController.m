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
<<<<<<< HEAD
#import "GAShootingViewController.h"
#import "GALiveChatViewController.h" // 私信

#import <WMPageController.h>
#import <DCPathButton.h>
=======
>>>>>>> pwxPro



@interface GALiveMainViewController ()
@property(nonatomic,strong) NSArray<NSString*> *pages;

@end

@implementation GALiveMainViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    
    self.pages = @[@"直播",@"视频",@"同城"];
   
<<<<<<< HEAD
    [self.navigationController.navigationBar setBackgroundImage:UIImage.new forBarMetrics:UIBarMetricsDefault];
    [self.navigationController.navigationBar setShadowImage:UIImage.new];
    
    UIButton *chatBtn = UIButton.new;
    [chatBtn setImage:[UIImage imageNamed:@"微信"] forState:UIControlStateNormal];
    [chatBtn addTarget:self action:@selector(rightItemClick) forControlEvents:UIControlEventTouchUpInside];
    UIBarButtonItem *chatItem = [[UIBarButtonItem alloc] initWithCustomView:chatBtn];
    self.navigationItem.rightBarButtonItem = chatItem;
=======
 //   [self.navigationController.navigationBar setBackgroundImage:UIImage.new forBarMetrics:UIBarMetricsDefault];
 //   [self.navigationController.navigationBar setShadowImage:UIImage.new];
>>>>>>> pwxPro

    //[self setShowOnNavigationBar:YES];
    [self setMenuViewStyle:WMMenuViewStyleLine];
    [self setProgressColor:UIColor.redColor];
    [self setProgressViewCornerRadius:2.0];
    [self setProgressHeight:4];
    [self setProgressWidth:40];
    [self setTitleFontName:@"Helvetica-BoldOblique"];
    
    [self.menuView reload];
    [self reloadData];
    [self.menuView selectItemAtIndex:0];
    
<<<<<<< HEAD
    // add button
    _addButton = UIButton.new;
    [_addButton setImage:[UIImage imageNamed:@"chooser-button-tab"] forState:UIControlStateNormal];
    [_addButton setImage:[UIImage imageNamed:@"chooser-button-tab-highlighted"] forState:UIControlStateHighlighted];
    [_addButton addTarget:self action:@selector(addButtonAction:) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:_addButton];
}

- (void)rightItemClick {
    GALiveChatViewController *chatVC = GALiveChatViewController.new;
    [self.navigationController pushViewController:chatVC animated:YES];
}

- (void)addButtonAction:(UIButton*)send{
    GAShootingViewController *vc = GAShootingViewController.new;
    [self presentViewController:vc animated:YES completion:nil];
=======
>>>>>>> pwxPro
}

//- (void)addButtonAction:(UIButton*)send{
//    UIViewController *vc = GAOpenLiveViewController.new; //GAShootingViewController.new;
//    [self presentViewController:vc animated:YES completion:nil];
//}


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

    CGFloat menuViewMaxY = CGRectGetMaxY(pageController.menuView.frame);
    CGFloat bottom = self.view.safeAreaInsets.bottom;
    CGRect frame = self.view.bounds;
    
    frame.origin.y = menuViewMaxY + 6; // 6.o 间距
    frame.size.height -= (menuViewMaxY+bottom);
    return frame;
}

@end
