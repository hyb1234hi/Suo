//
//  GACandidateGoodsViewController.m
//  Suo
//
//  Created by ysw on 2019/8/5.
//  Copyright © 2019 怪兽 🐙. All rights reserved.
//

#import "GACandidateGoodsViewController.h"
#import "GAAPI.h"

@interface GACandidateGoodsViewController ()<UITableViewDelegate,UITableViewDataSource>

@property(nonatomic,strong)UIView *contentView; //!<容器
@property(nonatomic,strong)UILabel *titleLabel;
@property(nonatomic,strong)UITableView *tableView;
@property(nonatomic,strong)UIButton *okButton;


@end

@implementation GACandidateGoodsViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    UISwipeGestureRecognizer *swipe = [[UISwipeGestureRecognizer alloc] initWithTarget:self action:@selector(dismiss)];
    [swipe setDirection:UISwipeGestureRecognizerDirectionDown];
    [self.view addGestureRecognizer:swipe];
    
    [self.view setBackgroundColor:ColorBlackAlpha20];
    
    _contentView    = UIView.new;
    _titleLabel     = UILabel.new;
    _okButton       = UIButton.new;

    [self.contentView addSubview:self.titleLabel];
    [self.contentView addSubview:self.tableView];
    [self.contentView addSubview:self.okButton];
    [self.view addSubview:self.contentView];
    
    [self.contentView setBackgroundColor:ColorWhite];
    
    [self.titleLabel setText:@"选择推送商品"];
}
- (void)viewDidLayoutSubviews{
    [super viewDidLayoutSubviews];
    
    [self.contentView mas_remakeConstraints:^(MASConstraintMaker *make) {
        make.edges.mas_equalTo(self.view).insets(UIEdgeInsetsMake(80, 35, 80, 35));
    }];
    
}





- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return 10;
}
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"cell" forIndexPath:indexPath];
    [cell.textLabel setText:@"商品"];
    
    return cell;
}


- (void)dismiss{
    [self dismissViewControllerAnimated:YES completion:nil];
}

- (UITableView *)tableView{
    if (!_tableView) {
        _tableView = [[UITableView alloc] initWithFrame:CGRectZero style:UITableViewStylePlain];
        [_tableView registerClass:UITableViewCell.class forCellReuseIdentifier:@"cell"];
        [_tableView setDelegate:self];
        [_tableView setDataSource:self];
        [_tableView setAllowsMultipleSelection:YES];
        
        [_tableView setRowHeight:66];
    }
    return _tableView;
}


@end
