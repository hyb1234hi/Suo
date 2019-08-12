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
#import "GATopListData.h"

#import <SDCycleScrollView.h>
#import <UIImageView+YYWebImage.h>

/**
 轮播图cell
 */
@interface _BannerCell : GABaseCollectionViewCell
@property(nonatomic,strong)UIImageView *imageView;
@end



@interface GALiveHeaderView ()<SDCycleScrollViewDelegate>
@property(nonatomic,strong) SDCycleScrollView *cycleView; //!<轮播图
@property(nonatomic,strong) NSArray *urls;
@end

@implementation GALiveHeaderView

- (instancetype)initWithFrame:(CGRect)frame{
    if (self = [super initWithFrame:frame]) {
        [self setupUI];
    }
    return self;
}

- (void)setupUI{
    //UIImage *image = [UIImage imageNamed:@"banner"];
    _cycleView = [SDCycleScrollView cycleScrollViewWithFrame:CGRectZero delegate:self placeholderImage:nil] ;
    [self addSubview:_cycleView];
    [_cycleView setBackgroundColor:ColorWhite];
}

- (void)layoutSubviews{
    [super layoutSubviews];
    
    [self.cycleView mas_remakeConstraints:^(MASConstraintMaker *make) {
        make.edges.mas_equalTo(self);
    }];
}


- (void)setBanners:(NSArray<GABannerItem *> *)banners{
    if (_banners != banners) {
        _banners = banners;
        
        NSMutableArray *urlList = @[].mutableCopy;
        for (GABannerItem *item in banners) {
            [urlList addObject:item.img];
        }
        self.urls = urlList;
        [self.cycleView setImageURLStringsGroup:self.urls];
    }
}
#pragma mark - SDCycleScrollViewDelegate
-(Class)customCollectionViewCellClassForCycleScrollView:(SDCycleScrollView *)view{
    return _BannerCell.class;
}

- (void)setupCustomCell:(UICollectionViewCell *)cell forIndex:(NSInteger)index cycleScrollView:(SDCycleScrollView *)view{
    //setup image
    if ([cell isKindOfClass:_BannerCell.class]) {
        
        _BannerCell *bcell = (_BannerCell*)cell;
        NSURL *url =  [NSURL URLWithString:self.banners[index].img];
        [bcell.imageView setImageWithURL:url placeholder:nil options:YYWebImageOptionProgressive completion:^(UIImage * _Nullable image, NSURL * _Nonnull url, YYWebImageFromType from, YYWebImageStage stage, NSError * _Nullable error) {
            [bcell.imageView setupMaskWithCorner:6 rectCorner:UIRectCornerAllCorners];
            NSLog(@"cell .image --- %@",bcell.imageView);
        }];
    }
}

- (void)cycleScrollView:(SDCycleScrollView *)cycleScrollView didSelectItemAtIndex:(NSInteger)index{
    if ([self.delegate respondsToSelector:@selector(liveHeaderView:didSelectedBanner:)]) {
        [self.delegate liveHeaderView:self didSelectedBanner:self.banners[index]];
    }
}

@end


@implementation _BannerCell

- (instancetype)initWithFrame:(CGRect)frame{
    if (self = [super initWithFrame:frame]) {
        _imageView = UIImageView.new;
        [_imageView setBackgroundColor:ColorWhite];
        [self.contentView addSubview:_imageView];
    }
    return self;
}
- (void)layoutSubviews{
    [super layoutSubviews];
    
    UIEdgeInsets padding = UIEdgeInsetsMake(11, 11, 0, 11);
    [self.imageView mas_remakeConstraints:^(MASConstraintMaker *make) {
        make.edges.mas_equalTo(self.contentView).insets(padding);
    }];
}

@end

