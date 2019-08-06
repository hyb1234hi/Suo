//
//  GALiveTalkingViewController.m
//  Suo
//
//  Created by gajz on 2019/8/5.
//  Copyright © 2019 怪兽 🐙. All rights reserved.
//

#import "GALiveTalkingViewController.h"
#import "GATalkingHeader.h"
#import "GATalkingFooter.h"
#import "GATalkingMineTableViewCell.h"
#import "GATalkingOtherTableViewCell.h"

@interface GALiveTalkingViewController ()<UITableViewDelegate,UITableViewDataSource>

/**table**/
@property (nonatomic, strong)UITableView *tableView;

@end

@implementation GALiveTalkingViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.title = self.talkName;
    self.view.backgroundColor = ColorSmoke;
    
    [self.view addSubview:self.tableView];
    
    
}

#pragma mark ---- UITableViewDataSource
- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return 3;
}
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return 3;
}
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    if (indexPath.row/2 == 1) {
        GATalkingMineTableViewCell *mineCell = [tableView dequeueReusableCellWithIdentifier:GATalkingMineTableViewCell.identifier];
        mineCell.selectionStyle = UITableViewCellSelectionStyleNone;
        return mineCell;
    }else {
        GATalkingOtherTableViewCell *otherCell = [tableView dequeueReusableCellWithIdentifier:GATalkingOtherTableViewCell.identifier];
        otherCell.selectionStyle = UITableViewCellSelectionStyleNone;
        return otherCell;
    }
}
- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    
    return 160.f;
}

- (UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section {
    GATalkingHeader *header = [tableView dequeueReusableHeaderFooterViewWithIdentifier:NSStringFromClass([GATalkingHeader class])];
    header.timeString = @"2019年08月05日11:36:59";
    return header;
}
- (UIView *)tableView:(UITableView *)tableView viewForFooterInSection:(NSInteger)section {
    if (section == 1) {
        UIView *view = UIView.new;
        return view;
    }
    GATalkingFooter *footer = [tableView dequeueReusableHeaderFooterViewWithIdentifier:NSStringFromClass([GATalkingFooter class])];
    return footer;
}
- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section {
    return 15.f;
}
- (CGFloat)tableView:(UITableView *)tableView heightForFooterInSection:(NSInteger)section {
    if (section == 1) {
        return 0.01;
    }
    return 51.f;
}

- (void)viewDidLayoutSubviews {
    [super viewDidLayoutSubviews];
    [self.tableView mas_remakeConstraints:^(MASConstraintMaker *make) {
        make.edges.mas_equalTo(self.view).insets(self.view.safeAreaInsets);
    }];
}

- (UITableView *)tableView {
    if (!_tableView) {
        _tableView = UITableView.new;
        _tableView.delegate = self;
        _tableView.dataSource = self;
        _tableView.separatorStyle = UITableViewCellSeparatorStyleNone;
        [_tableView registerClass:GATalkingMineTableViewCell.class forCellReuseIdentifier:GATalkingMineTableViewCell.identifier];
        [_tableView registerClass:GATalkingOtherTableViewCell.class forCellReuseIdentifier:GATalkingOtherTableViewCell.identifier];
        [_tableView registerClass:[GATalkingHeader class] forHeaderFooterViewReuseIdentifier:NSStringFromClass([GATalkingHeader class])];
        [_tableView registerClass:[GATalkingFooter class] forHeaderFooterViewReuseIdentifier:NSStringFromClass([GATalkingFooter class])];
    }
    return _tableView;
}


- (void)viewWillAppear:(BOOL)animated {
    [super viewWillAppear:animated];
    [self.navigationController setNavigationBarHidden:NO];
}
- (void)viewWillDisappear:(BOOL)animated {
    [super viewWillDisappear:animated];
    
}

@end
