//
//  GALiveTabBarViewController.m
//  Suo
//
//  Created by ysw on 2019/8/10.
//  Copyright © 2019 怪兽 🐙. All rights reserved.
//

#import "GALiveTabBarViewController.h"
#import "GALiveMainViewController.h"
#import "GAHomeViewController.h"
@interface GALiveTabBarViewController ()<UITabBarControllerDelegate>
@property(nonatomic,strong)GAHomeViewController *homeVC;

@end

@implementation GALiveTabBarViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    GAHomeViewController *home = GAHomeViewController.new;
    _homeVC = home;
    [home setTitle:@"Home"];
    
    UIViewController *liveMain = GALiveMainViewController.new;
    [liveMain setTitle:@"直播推荐"];
    
    UIViewController *openVC = UIViewController.new;
    [openVC setTitle:@"开播"];
    
    UIViewController *classVC = UIViewController.new;
    [classVC setTitle:@"直播分类"];
    
    UIViewController *centre = UIViewController.new;
    [centre setTitle:@"个人中心"];
    
    [self addChildViewController:home];
    [self addChildViewController:liveMain];
    [self addChildViewController:openVC];
    [self addChildViewController:classVC];
    [self addChildViewController:centre];
    
    
    [self setDelegate:self];
}


- (void)tabBarController:(UITabBarController *)tabBarController didSelectViewController:(UIViewController *)viewController{
    if (viewController == self.homeVC) {
        [self.navigationController popViewControllerAnimated:YES];
        [self.navigationController setNavigationBarHidden:NO animated:YES];

    }
}



@end
