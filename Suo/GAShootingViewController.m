//
//  GAShootingViewController.m
//  Suo
//
//  Created by ysw on 2019/7/30.
//  Copyright © 2019 怪兽 🐙. All rights reserved.
//

#import "GAShootingViewController.h"

#import "GAShootingView.h"
#import "GAShootControllerView.h"
#import "GACaptureConfiguration.h"
#import <AVKit/AVKit.h>

@interface GAShootingViewController ()
@property(nonatomic,strong)GAShootingView *shootingView;
@property(nonatomic,strong)GAShootControllerView *controllerView;

@property(nonatomic,strong)GACaptureConfiguration *configuration;


@end

@implementation GAShootingViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    [self.view setBackgroundColor:UIColor.whiteColor];
    
    UISwipeGestureRecognizer *swipe = [[UISwipeGestureRecognizer alloc] initWithTarget:self action:@selector(dismiss)];
    [swipe setDirection:UISwipeGestureRecognizerDirectionDown];
    [self.view addGestureRecognizer:swipe];
    
    _configuration = GACaptureConfiguration.new;
    _shootingView = [[GAShootingView alloc] initWithFrame:ScreenBounds];
    [_shootingView.captureVideoPreviewLayer setSession:_configuration.captureSession];
    
    _controllerView = GAShootControllerView.new;
    
    [self.view addSubview:_shootingView];
    [self.view addSubview:_controllerView];
    
}

- (void)viewDidLayoutSubviews{
    [super viewDidLayoutSubviews];
    
    [self.shootingView mas_remakeConstraints:^(MASConstraintMaker *make) {
        make.edges.mas_equalTo(self.view);
    }];
    [self.controllerView mas_remakeConstraints:^(MASConstraintMaker *make) {
        make.edges.mas_equalTo(self.view);
    }];
}

- (void)dismiss{
    [self dismissViewControllerAnimated:YES completion:nil];
}



@end
