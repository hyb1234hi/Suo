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
#import "GAOpenLiveViewController.h"


#import <WMPageController.h>
#import <DCPathButton.h>


@interface GALiveMainViewController ()
//@property(nonatomic,strong)WMMenuView *menuView

@property(nonatomic,strong) NSArray<NSString*> *pages;

@property(nonatomic,strong) DCPathButton *pathButton;

@property(nonatomic,strong) UIButton *addButton;
@end

@implementation GALiveMainViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
  //  [self.view setBackgroupColor:UIColor.whiteColor];
    
    //[self setTitle:@""];
    
    self.pages = @[@"直播",@"视频",@"同城"];
   
 //   [self.navigationController.navigationBar setBackgroundImage:UIImage.new forBarMetrics:UIBarMetricsDefault];
 //   [self.navigationController.navigationBar setShadowImage:UIImage.new];

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
    
    // add button
//    _addButton = UIButton.new;
//    [_addButton setImage:[UIImage imageNamed:@"chooser-button-tab"] forState:UIControlStateNormal];
//    [_addButton setImage:[UIImage imageNamed:@"chooser-button-tab-highlighted"] forState:UIControlStateHighlighted];
//    [_addButton addTarget:self action:@selector(addButtonAction:) forControlEvents:UIControlEventTouchUpInside];
//    [self.view addSubview:_addButton];
}

- (void)addButtonAction:(UIButton*)send{
    UIViewController *vc = GAOpenLiveViewController.new; //GAShootingViewController.new;
    [self presentViewController:vc animated:YES completion:nil];
}


- (void)viewDidLayoutSubviews{
    [super viewDidLayoutSubviews];
    

//   // [self setShowOnNavigationBar:YES];
//    [self.addButton mas_remakeConstraints:^(MASConstraintMaker *make) {
//        make.right.bottom.mas_equalTo(self.view).insets(UIEdgeInsetsMake(0, 0, SafeAreaBottomHeight+10, 16));
//        make.size.mas_equalTo(CGSizeMake(50, 50));
//    }];
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
    return  CGRectMake(0, 20, ScreenWidth, 44);
    
    //return self.navigationController.navigationBar.frame;
}
- (CGRect)pageController:(WMPageController *)pageController preferredFrameForContentView:(WMScrollView *)contentView{
//    CGFloat y = CGRectGetMaxY(self.navigationController.navigationBar.frame);
//    CGFloat h = ScreenHeight - y - SafeAreaBottomHeight;
//    CGRect frame  = ScreenBounds;
//    frame.origin.y = y;
//    frame.size.height = h;
    
    CGRect frame = ScreenBounds;
    frame.origin.y = CGRectGetHeight(pageController.menuView.bounds);

    return frame;
}

@end
