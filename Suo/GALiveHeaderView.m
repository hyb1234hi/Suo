//
//  GALiveHeaderView.m
//  Suo
//
//  Created by 怪兽 🐙 on 2019/7/28.
//  Copyright © 2019 怪兽 🐙. All rights reserved.
//

#import "GALiveHeaderView.h"

#import "GABaseTableViewCell.h"
#import "GABaseCollectionViewCell.h"

#import <SDCycleScrollView.h>

// 内部Cell

@interface _BannerCell : GABaseCollectionViewCell
@property(nonatomic,strong)UIImageView *imageView;
@end


/**
 排行榜
 */
@interface _RankingCell : GABaseTableViewCell
@property(nonatomic,strong)UIImageView *imageView1;
@property(nonatomic,strong)UIImageView *imageView2;
@property(nonatomic,strong)UIImageView *imageView3;

@end



@interface GALiveHeaderView ()<SDCycleScrollViewDelegate,UITableViewDelegate,UITableViewDataSource>
@property(nonatomic,strong) SDCycleScrollView *cycleView; //!<轮播图
@property(nonatomic,strong) UITableView *tableView;       //!<主播榜单

@property(nonatomic,strong) NSTimer *timer;                //定时滚动tableView cell
@property(nonatomic,strong)NSArray *urls;

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

    [self addSubview:_cycleView];
    [self addSubview:_tableView];
    
    [_cycleView setDelegate:self];
    
    NSString *path = [NSBundle.mainBundle pathForResource:@"banner" ofType:@"jpeg"];
    
    _urls = @[path,path,path];
    [_cycleView setImageURLStringsGroup:_urls];
    [_cycleView setBackgroundColor:ColorWhite];
    
    [_tableView setDataSource:self];
    [_tableView setDelegate:self];
    [_tableView setSeparatorStyle:UITableViewCellSeparatorStyleNone];
}

- (void)layoutSubviews{
    [super layoutSubviews];
    
    [self.cycleView mas_remakeConstraints:^(MASConstraintMaker *make) {
        make.left.top.right.mas_equalTo(self);
        make.bottom.mas_equalTo(self.tableView.mas_top);
    }];
    [self.tableView mas_remakeConstraints:^(MASConstraintMaker *make) {
        make.left.bottom.right.mas_equalTo(self);
        make.height.mas_equalTo(44);
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
    NSString *text = [NSString stringWithFormat:@"👤 主播榜 %ld",indexPath.row];
    [cell.textLabel setText:text];
    [cell.textLabel setFont:MainFontWithSize(14)];
    [cell setSelectionStyle:UITableViewCellSelectionStyleNone];
    
    return cell;
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

#pragma mark - SDCycleScrollViewDelegate
-(Class)customCollectionViewCellClassForCycleScrollView:(SDCycleScrollView *)view{
    return _BannerCell.class;
}
- (void)setupCustomCell:(UICollectionViewCell *)cell forIndex:(NSInteger)index cycleScrollView:(SDCycleScrollView *)view{
    //setup image
    if ([cell isKindOfClass:_BannerCell.class]) {
        UIImage *image = [UIImage imageNamed:_urls[index]];
        
        [((_BannerCell*)cell).imageView setImage:image];
    }
  
}
@end


@implementation _BannerCell

- (instancetype)initWithFrame:(CGRect)frame{
    if (self = [super initWithFrame:frame]) {
        _imageView = UIImageView.new;
        [_imageView setBackgroundColor:ColorWhite];
        [_imageView.layer setCornerRadius:6];
        [_imageView.layer setMasksToBounds:YES];
        
        [self.contentView addSubview:_imageView];
    }
    return self;
}
- (void)layoutSubviews{
    [super layoutSubviews];
    
    UIEdgeInsets padding = UIEdgeInsetsMake(11, 11, 11, 11);
    [self.imageView mas_remakeConstraints:^(MASConstraintMaker *make) {
        make.edges.mas_equalTo(self.contentView).insets(padding);
        [self.imageView layoutIfNeeded];
    }];
    
    //[self.imageView setupMaskWithCorner:6 rectCorner:UIRectCornerAllCorners];;
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
