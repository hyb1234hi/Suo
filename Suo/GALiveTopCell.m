//
//  GALiveTopCell.m
//  Suo
//
//  Created by ysw on 2019/8/8.
//  Copyright © 2019 怪兽 🐙. All rights reserved.
//

#import "GALiveTopCell.h"
#import "GABaseTableViewCell.h"

/**
 排行榜cell
 */
@interface _RankingCell : GABaseTableViewCell
@property(nonatomic,strong)UIImageView *imageView1;
@property(nonatomic,strong)UIImageView *imageView2;
@property(nonatomic,strong)UIImageView *imageView3;

@end

@interface GALiveTopCell()<UITableViewDelegate,UITableViewDataSource>
@property(nonatomic,strong)UITableView *tableView;
@property(nonatomic,strong) NSTimer *timer;

@end

@implementation GALiveTopCell
- (instancetype)initWithFrame:(CGRect)frame{
    if (self = [super initWithFrame:frame]) {
        [self setupUI];
    }
    return self;
}

- (void)setupUI{
    _tableView = [[UITableView alloc] initWithFrame:CGRectZero style:UITableViewStylePlain];
    [_tableView setDataSource:self];
    [_tableView setDelegate:self];
    [_tableView setSeparatorStyle:UITableViewCellSeparatorStyleNone];
    
    
    [self.contentView addSubview:_tableView];
}
- (void)layoutSubviews{
    [super layoutSubviews];
    
    [self.tableView mas_remakeConstraints:^(MASConstraintMaker *make) {
        make.edges.mas_equalTo(self.contentView);
    }];
    [self.timer fire];
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return 2;
}
-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"cell"];
    if (!cell) {
        cell = [[_RankingCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:@"cell"];
        [cell setAccessoryType:UITableViewCellAccessoryDisclosureIndicator];
    }
    NSString *text = [NSString stringWithFormat:@"🛍 主播榜 %ld",indexPath.row];
    [cell.textLabel setText:text];
    [cell.textLabel setFont:MainFontWithSize(14)];
    [cell setSelectionStyle:UITableViewCellSelectionStyleNone];
    
    return cell;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    if ([self.delegate respondsToSelector:@selector(liveTopCellDidSelected:)]) {
        [self.delegate liveTopCellDidSelected:self];
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
                dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(4 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
                    [wself.tableView scrollToRowAtIndexPath:indexPath0 atScrollPosition:UITableViewScrollPositionTop animated:NO];
                });
            }];
        }];
    }
    return _timer;
}
@end



@implementation _RankingCell

- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier{
    if (self = [super initWithStyle:style reuseIdentifier:reuseIdentifier]) {
        CGRect frame = CGRectMake(0, 0, 25, 25) ;
        _imageView1 = [[UIImageView alloc] initWithFrame:frame];
        _imageView2 = [[UIImageView alloc] initWithFrame:frame];
        _imageView3 = [[UIImageView alloc] initWithFrame:frame];
        
        UIImage *image = [UIImage imageNamed:@"icon_profile_share_weibo"];
        _imageView3.image = _imageView2.image = _imageView1.image = [UIImage imageNamed:@"icon_profile_share_weibo"];
        
        
        [_imageView3 setContentMode:UIViewContentModeScaleAspectFill];
        
        [self.contentView addSubview:_imageView1];
        [self.contentView addSubview:_imageView2];
        [self.contentView addSubview:_imageView3];
    }
    return self;
}

- (void)layoutSubviews{
    [super layoutSubviews];
    
    CGSize size = CGSizeMake(30, 30);
    [self.imageView3 mas_remakeConstraints:^(MASConstraintMaker *make) {
        make.centerY.mas_equalTo(self.contentView);
        make.right.mas_equalTo(self.contentView).inset(11);
        make.size.mas_equalTo(size);
    }];
    [self.imageView2 mas_remakeConstraints:^(MASConstraintMaker *make) {
        make.centerY.mas_equalTo(0);
        make.right.mas_equalTo(self.imageView3.mas_left).inset(11);
        make.size.mas_equalTo(size);
    }];
    [self.imageView1 mas_remakeConstraints:^(MASConstraintMaker *make) {
        make.centerY.mas_equalTo(0);
        make.right.mas_equalTo(self.imageView2.mas_left).inset(11);
        make.size.mas_equalTo(size);
    }];
    
    
}

@end
