//
//  GACityWideViewController.m
//  Suo
//
//  Created by 怪兽 🐙 on 2019/7/24.
//  Copyright © 2019 怪兽 🐙. All rights reserved.
//

#import "GACityWideViewController.h"
#import "GACityWideSubViewController.h"

@interface GACityWideViewController ()
@property(strong,nonatomic) NSArray<NSString*> *pages;

@end

static CGFloat menuViewHeight = 38.0;
@implementation GACityWideViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    _pages = @[@"同城",@"搞笑",@"美食",@"任务"];
    [self setTitleColorSelected:RGBA(234, 92, 59, 1)];
    self.titleSizeSelected = self.titleSizeNormal;
    
    [self reloadData];
    [self.menuView reload];
}


- (NSString *)pageController:(WMPageController *)pageController titleAtIndex:(NSInteger)index{
    return self.pages[index];
}

- (NSInteger)numbersOfChildControllersInPageController:(WMPageController *)pageController{
    return self.pages.count;
}

- (UIViewController *)pageController:(WMPageController *)pageController viewControllerAtIndex:(NSInteger)index{
    UIViewController *vc = GACityWideSubViewController.new;
  
    return vc;
}


- (CGRect)pageController:(WMPageController *)pageController preferredFrameForMenuView:(WMMenuView *)menuView{
    
    return CGRectMake(0, 0, ScreenWidth, menuViewHeight);
}

- (CGRect)pageController:(WMPageController *)pageController preferredFrameForContentView:(WMScrollView *)contentView{
    CGRect frame = self.view.bounds;
    frame.origin.y += menuViewHeight;
    frame.size.height -= menuViewHeight;
    
    NSLog(@"self ----------------- %@",self.view);
    
    return frame;
}

- (void)menuView:(WMMenuView *)menu didLayoutItemFrame:(WMMenuItem *)menuItem atIndex:(NSInteger)index{
    
    [menuItem setFont:[MainBoldFont fontWithSize:15]];
    CGRect bounds = menuItem.bounds;
    bounds.size.height = 30;
    menuItem.bounds = bounds;
    
    CGFloat corner = CGRectGetHeight(menuItem.bounds)/2.0;
    [menuItem setupMaskWithCorner:corner rectCorner:UIRectCornerAllCorners];
    [menuItem setBackgroundColor:RGBA(248, 248, 248, 1)];
}


@end
