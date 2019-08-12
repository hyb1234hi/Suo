//
//  GAGoodsPushSelectView.m
//  Suo
//
//  Created by ysw on 2019/8/5.
//  Copyright © 2019 怪兽 🐙. All rights reserved.
//

#import "GAGoodsPushSelectView.h"
#import "GAGoodsPushCell.h"

@interface GAGoodsPushSelectView ()<UITableViewDelegate,UITableViewDataSource>
@property(nonatomic,strong)UIView *contentView;
@property(nonatomic,strong)UITableView *tableView;

@property(nonatomic,strong)UILabel *titleLabel;
@property(nonatomic,strong)UIButton *okButton;  //!<确认按钮


@end

@implementation GAGoodsPushSelectView
- (instancetype)initWithFrame:(CGRect)frame{
    if (self = [super initWithFrame:frame]) {
        [self setupUI];
    }
    return self;
}

- (void)setupUI{
    
    [self setFrame:ScreenBounds];
    [self setBackgroundColor:ColorBlackAlpha20];
    
    _contentView = UIView.new;
    _titleLabel = UILabel.new;
    _okButton = UIButton.new;
    
    _tableView = [[UITableView alloc] initWithFrame:CGRectZero style:UITableViewStylePlain];
    [_tableView registerClass:GAGoodsPushCell.class forCellReuseIdentifier:GAGoodsPushCell.identifier];
    [_tableView setDataSource:self];
    [_tableView setDelegate: self];
    [_tableView setAllowsMultipleSelection:YES] ;
    [_tableView setRowHeight:80];
    
    [_contentView addSubview:_titleLabel];
    [_contentView addSubview:_tableView];
    [_contentView addSubview:_okButton];
    [self addSubview:_contentView];
    
    [_titleLabel setText:@"推送候选商品"];
    [_titleLabel setTextAlignment:NSTextAlignmentCenter];
    
    [_okButton setTitle:@"确定" forState:UIControlStateNormal];
    [_okButton setTitleColor:ColorBlack forState:UIControlStateNormal];
    [_okButton addTarget:self action:@selector(onOK:) forControlEvents:UIControlEventTouchUpInside];
    
    [_contentView setFrame:CGRectMake(ScreenWidth, 100, ScreenWidth-80, ScreenHeight-200)];
    [_contentView setBackgroundColor:ColorWhite];
}

- (void)layoutSubviews{
    [super layoutSubviews];
    
//    [self.contentView mas_remakeConstraints:^(MASConstraintMaker *make) {
//        make.center.mas_equalTo(self);
//        make.size.mas_equalTo(CGSizeMake(ScreenWidth-160, ScreenHeight-200));
//    }];
    
    [self.titleLabel mas_remakeConstraints:^(MASConstraintMaker *make) {
        make.left.top.right.mas_equalTo(self.contentView);
        make.height.mas_equalTo(30);
    }];
    [self.tableView mas_remakeConstraints:^(MASConstraintMaker *make) {
        make.left.right.mas_equalTo(self.contentView);
        make.top.mas_equalTo(self.titleLabel.mas_bottom);
        make.bottom.mas_equalTo(self.okButton.mas_top);
    }];
    [self.okButton mas_remakeConstraints:^(MASConstraintMaker *make) {
        make.centerX.mas_equalTo(self.contentView);
        make.bottom.mas_equalTo(self.contentView);
    }];
}

- (void)touchesBegan:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event{
    [self dismiss];
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return  5;
}
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    GAGoodsPushCell *cell = [tableView dequeueReusableCellWithIdentifier:GAGoodsPushCell.identifier forIndexPath:indexPath];
    [cell.textLabel setNumberOfLines:0];
    [cell.textLabel setText:@"商品UIViewAlertForUnsatisfiableConstraints to catch this "];
    [cell setSelectionStyle:UITableViewCellSelectionStyleNone];
    [cell.imageView setImage:[UIImage imageNamed:@"icon_home_like_after"]];
    [cell.detailTextLabel setText:@"Y 1-00"];
    
    return cell;
}


- (void)onOK:(UIButton*)send{
    NSArray<NSIndexPath*> *indexPaths = [self.tableView indexPathsForSelectedRows];
    //无选中
    if (indexPaths.count == 0) {
//        UIAlertController *ctl = [UIAlertController alertControllerWithTitle:@"请选择要推送的商品" message:@"" preferredStyle:UIAlertControllerStyleAlert];
//        UIAlertAction *ok = [UIAlertAction actionWithTitle:@"OK" style:UIAlertActionStyleCancel handler:^(UIAlertAction * _Nonnull action) {
//        }];
//        [ctl addAction:ok];
//        [self rootVCPresentViewController:ctl animated:YES completion:nil];
        [self showHUDToView:self.tableView message:@"请选择要推送的商品"];
        
        return;
    }
    
    
    //确认一次 再执行推送
}

- (void)show {
    UIWindow *window = [[[UIApplication sharedApplication] delegate] window];
    [window addSubview:self];
    CGRect frame = self.contentView.frame;
    frame.origin.x = 40;
    [UIView animateWithDuration:0.35 delay:0.0 usingSpringWithDamping:0.8 initialSpringVelocity:0.1 options:UIViewAnimationOptionCurveEaseInOut animations:^{
        self.contentView.frame = frame;
    } completion:^(BOOL finished) {}];
}

- (void)dismiss {
    [UIView animateWithDuration:0.15f
                          delay:0.0f
                        options:UIViewAnimationOptionCurveEaseIn
                     animations:^{
                         CGRect frame = self.contentView.frame;
                         frame.origin.y = frame.origin.y + frame.size.height;
                         self.contentView.frame = frame;
                     }
                     completion:^(BOOL finished) {
                         [self removeFromSuperview];
                     }];
}@end
