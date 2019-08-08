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
    _cycleView = SDCycleScrollView.new;
   

    [self addSubview:_cycleView];
    

    [_cycleView setDelegate:self];
    
    NSString *path = [NSBundle.mainBundle pathForResource:@"banner" ofType:@"jpeg"];
    
    _urls = @[path,path,path];
    [_cycleView setImageURLStringsGroup:_urls];
    [_cycleView setBackgroundColor:ColorWhite];
    
}

- (void)layoutSubviews{
    [super layoutSubviews];
    
    [self.cycleView mas_remakeConstraints:^(MASConstraintMaker *make) {
        make.edges.mas_equalTo(self);
    }];

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
    
    UIEdgeInsets padding = UIEdgeInsetsMake(11, 11, 0, 11);
    [self.imageView mas_remakeConstraints:^(MASConstraintMaker *make) {
        make.edges.mas_equalTo(self.contentView).insets(padding);
        [self.imageView layoutIfNeeded];
    }];
    
    //[self.imageView setupMaskWithCorner:6 rectCorner:UIRectCornerAllCorners];;
}

@end

