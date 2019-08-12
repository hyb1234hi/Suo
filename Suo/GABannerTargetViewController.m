//
//  GABannerTargetViewController.m
//  Suo
//
//  Created by ysw on 2019/8/9.
//  Copyright © 2019 怪兽 🐙. All rights reserved.
//

#import "GABannerTargetViewController.h"
#import "GABannerItem.h"
#import <WebKit/WebKit.h>

@interface GABannerTargetViewController ()
@property(nonatomic,strong)GABannerItem *bannerItem;
@property(nonatomic,strong)WKWebView *webView;

@end

@implementation GABannerTargetViewController

- (instancetype)initWithBanner:(GABannerItem *)banner{
    if (self = [super init]) {
        _bannerItem = banner;
    }
    return self;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    NSURL *url  = [NSURL URLWithString:self.bannerItem.url];
    NSMutableURLRequest *request = [NSMutableURLRequest requestWithURL:url];
    self.webView = [[WKWebView alloc] initWithFrame:self.view.bounds];
    [self.view addSubview:self.webView];
    [self.webView loadRequest:request];
    
    [self.view setBackgroundColor:ColorWhite];
}

- (void)viewWillAppear:(BOOL)animated{
    [super viewWillAppear:animated];

    [self.navigationController.navigationBar setBackgroundImage:[self imageForSize:CGSizeMake(1, 1) color:ColorWhite] forBarMetrics:UIBarMetricsDefault];
    [self.navigationController setNavigationBarHidden:NO];
}

-(void)viewWillDisappear:(BOOL)animated{
    [super viewWillDisappear:animated];
    [self.navigationController.navigationBar setBackgroundImage:UIImage.new forBarMetrics:UIBarMetricsDefault];
}



@end
