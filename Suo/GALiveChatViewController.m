//
//  GALiveChatViewController.m
//  Suo
//
//  Created by gajz on 2019/8/5.
//  Copyright © 2019 怪兽 🐙. All rights reserved.
//

#import "GALiveChatViewController.h"
#import "GALiveChatTableViewCell.h"
#import "GALiveTalkingViewController.h"

@interface GALiveChatViewController ()<UITableViewDelegate,UITableViewDataSource>

/**table**/
@property (nonatomic, strong)UITableView *tableView;

@end

@implementation GALiveChatViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.view.backgroundColor = ColorWhite;
    self.title = @"私信";
    self.navigationController.navigationBar.backgroundColor = ColorWhite;
    [self.view addSubview:self.tableView];
    
    if (@available(iOS 11.0, *)) {
        self.tableView.contentInsetAdjustmentBehavior=UIScrollViewContentInsetAdjustmentNever;
    }else {
        self.automaticallyAdjustsScrollViewInsets = NO;
    }
    
}

#pragma mark ---- UITableViewDataSource
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return 10;
}
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    GALiveChatTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:GALiveChatTableViewCell.identifier];
    
    return cell;
}
- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    return 62.f;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    GALiveTalkingViewController *talkingVC = GALiveTalkingViewController.new;
    talkingVC.talkName = @"芒果🥭";
    [self.navigationController pushViewController:talkingVC animated:YES];
}


- (UITableView *)tableView {
    if (!_tableView) {
        _tableView = UITableView.new;
        _tableView.frame = CGRectMake(0, SafeAreaTopHeight, ScreenWidth, ScreenHeight-SafeAreaTopHeight);
        _tableView.delegate = self;
        _tableView.dataSource = self;
        _tableView.backgroundColor = ColorSmoke;
        [_tableView setSeparatorStyle:UITableViewCellSeparatorStyleNone];
        [_tableView registerClass:GALiveChatTableViewCell.class forCellReuseIdentifier:GALiveChatTableViewCell.identifier];
    }
    return _tableView;
}

- (void)viewWillAppear:(BOOL)animated {
    [super viewWillAppear:animated];
    
    [self.navigationController setNavigationBarHidden:NO];
}

- (void)viewWillDisappear:(BOOL)animated {
    [super viewWillDisappear:animated];
    
    [self.navigationController setNavigationBarHidden:YES];
}

@end
