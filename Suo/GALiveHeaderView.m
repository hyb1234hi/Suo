//
//  GALiveHeaderView.m
//  Suo
//
//  Created by 怪兽 🐙 on 2019/7/28.
//  Copyright © 2019 怪兽 🐙. All rights reserved.
//

#import "GALiveHeaderView.h"

#import <SDCycleScrollView.h>
#import <WMMenuView.h>

@interface GALiveHeaderView ()<SDCycleScrollViewDelegate,UITableViewDelegate,UITableViewDataSource,WMMenuViewDataSource,WMMenuViewDelegate>
@property(nonatomic,strong) SDCycleScrollView *cycleView; //!<轮播图
@property(nonatomic,strong) UITableView *tableView;       //!<主播榜单
@property(nonatomic,strong) WMMenuView *menuView;         //!<分页
@property(nonatomic,strong) NSArray *titles;

@property(nonatomic,strong) NSTimer *timer;                //定时滚动tableView cell
@end

@implementation GALiveHeaderView

- (instancetype)initWithFrame:(CGRect)frame{
    if (self = [super initWithFrame:frame]) {
        [self setupUI];
    }
    return self;
}

- (void)setupUI{
    _cycleView = SDCycleScrollView.new;
    _tableView = [[UITableView alloc] initWithFrame:CGRectZero style:UITableViewStylePlain];
    _menuView  = [[WMMenuView alloc] initWithFrame:CGRectMake(0, 0, ScreenWidth, 44)];
    
    
    [self addSubview:_cycleView];
    [self addSubview:_tableView];
    [self addSubview:_menuView];
    
    [_cycleView setDelegate:self];
    [_cycleView setImageURLStringsGroup:@[@"",@"",@""]];
    
    [_tableView setDataSource:self];
    [_tableView setDelegate:self];
    [_tableView setSeparatorStyle:UITableViewCellSeparatorStyleNone];
    
    [_menuView setDataSource:self];
    [_menuView setDelegate:self];
    [_menuView selectItemAtIndex:0];
    
    _titles = @[@"推荐",@"游戏",@"电台"];
    [_menuView reload];
}

- (void)layoutSubviews{
    [super layoutSubviews];
    
    [self.cycleView mas_remakeConstraints:^(MASConstraintMaker *make) {
        make.left.top.right.mas_equalTo(self);
        make.height.mas_equalTo(ScreenWidth*0.3);
    }];
    [self.tableView mas_remakeConstraints:^(MASConstraintMaker *make) {
        make.left.right.mas_equalTo(self);
        make.top.mas_equalTo(self.cycleView.mas_bottom);
        make.height.mas_equalTo(44);
    }];
    [self.menuView mas_remakeConstraints:^(MASConstraintMaker *make) {
        make.left.bottom.right.mas_equalTo(self);
        make.top.mas_equalTo(self.tableView.mas_bottom).inset(6);
    }];
    
    [self.timer fire];
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return 2;
}
-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"cell"];
    if (!cell) {
        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:@"cell"];
        [cell setAccessoryType:UITableViewCellAccessoryDisclosureIndicator];
    }
    NSString *text = [NSString stringWithFormat:@"👤 主播榜 %ld",indexPath.row];
    [cell.textLabel setText:text];
    [cell setSelectionStyle:UITableViewCellSelectionStyleNone];
    
    return cell;
}

- (NSInteger)numbersOfTitlesInMenuView:(WMMenuView *)menu{
    return self.titles.count;
}
- (NSString *)menuView:(WMMenuView *)menu titleAtIndex:(NSInteger)index{
    return self.titles[index];
}
- (UIColor *)menuView:(WMMenuView *)menu titleColorForState:(WMMenuItemState)state atIndex:(NSInteger)index{
    switch (state) {
        case WMMenuItemStateNormal:
            return ColorBlack;
            break;
            
        case WMMenuItemStateSelected:
            return  UIColor.redColor;
            break ;
    }
}
- (WMMenuItem *)menuView:(WMMenuView *)menu initialMenuItem:(WMMenuItem *)initialMenuItem atIndex:(NSInteger)index{
    [initialMenuItem setFont:[MainFont fontWithSize:18]];
    return initialMenuItem;
}

- (void)menuView:(WMMenuView *)menu didSelesctedIndex:(NSInteger)index currentIndex:(NSInteger)currentIndex{
    if ([self.delegate respondsToSelector:@selector(menuView:selectedIndex:)]) {
        [self.delegate menuView:menu selectedIndex:index];
    }
}

- (NSTimer *)timer{
    if (!_timer) {
        __weak typeof(self) wself = self;
        NSIndexPath *indexPath0 = [NSIndexPath indexPathForRow:0 inSection:0];
        NSIndexPath *indexPath1 = [NSIndexPath indexPathForRow:1 inSection:0];
        _timer = [NSTimer scheduledTimerWithTimeInterval:2.35 repeats:YES block:^(NSTimer * _Nonnull timer) {
            
            [UIView animateWithDuration:0.35 animations:^{
                [wself.tableView scrollToRowAtIndexPath:indexPath1 atScrollPosition:UITableViewScrollPositionTop animated:YES];
            } completion:^(BOOL finished) {
                dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(2 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
                    [wself.tableView scrollToRowAtIndexPath:indexPath0 atScrollPosition:UITableViewScrollPositionTop animated:NO];
                });
            }];
        }];
    }
    return _timer;
}
@end
