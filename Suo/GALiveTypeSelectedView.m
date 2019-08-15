//
//  GALiveTypeSelectedView.m
//  Suo
//
//  Created by ysw on 2019/8/14.
//  Copyright © 2019 怪兽 🐙. All rights reserved.
//

#import "GALiveTypeSelectedView.h"
#import "GAAPI.h"
#import "GABaseCollectionViewCell.h"

@interface _GALiveTypeCell : GABaseCollectionViewCell
@property(nonatomic,strong)UILabel *titleLabel;

@end

@interface GALiveTypeSelectedView ()<UICollectionViewDelegate,UICollectionViewDataSource>
@property(nonatomic,strong)UICollectionView *collectionView;
@property(nonatomic,strong)NSArray<GALiveTypeModel*> *typeList;

@end

@implementation GALiveTypeSelectedView

- (instancetype)initWithFrame:(CGRect)frame{
    if (self  = [super initWithFrame:frame]) {
        
        [self.layer setCornerRadius:16];
        [self.layer setMasksToBounds:YES];
        
        [self setBackgroundColor:ColorBlackAlpha40];
        [self setupUI];
    }
    return self;
}

- (void)setupUI{
    _typeList = @[];
    
    UICollectionViewFlowLayout *layout = [[UICollectionViewFlowLayout alloc] init];
    [layout setItemSize:CGSizeMake(100, 35)];
    _collectionView = [[UICollectionView alloc] initWithFrame:CGRectZero collectionViewLayout:layout];
    [_collectionView registerClass:_GALiveTypeCell.class forCellWithReuseIdentifier:_GALiveTypeCell.identifier];
    
    [_collectionView setDelegate:self];
    [_collectionView setDataSource:self];
    [_collectionView setBackgroundColor:UIColor.clearColor];
    
    
    [self addSubview:_collectionView];
    [self reloadData];
}

- (void)layoutSubviews{
    [super layoutSubviews];
    
    [self.collectionView mas_remakeConstraints:^(MASConstraintMaker *make) {
        make.edges.mas_equalTo(self).insets(UIEdgeInsetsMake(11, 11, 11, 11));
    }];
    if (self.typeList.count <= 0) {
        [self reloadData];
    }
}

- (void)reloadData{
    [GAAPI.new.videoAPI fetchLiveTypeForKey:self.loginKey completion:^(NSDictionary * _Nonnull json, NSURLResponse * _Nonnull response) {
        if ([json valueForKey:@"datas"]) {
            NSArray *tmp = [json valueForKey:@"datas"];
            NSMutableArray *list = @[].mutableCopy;
            for (NSDictionary*dict in tmp) {
                [list addObject:[GALiveTypeModel instanceWithDict:dict]];
            }
            self.typeList = list;
            [self.collectionView reloadData];
        }
    }];
}

- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section{
    return self.typeList.count;
}
- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath{
    _GALiveTypeCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:_GALiveTypeCell.identifier forIndexPath:indexPath];
    [cell.titleLabel setText:self.typeList[indexPath.row].name];
    return cell;
}

- (void)collectionView:(UICollectionView *)collectionView didSelectItemAtIndexPath:(NSIndexPath *)indexPath{
    if (self.selectedBlock) {
        self.selectedBlock(self.typeList[indexPath.row]);
    }
}

@end


@implementation _GALiveTypeCell

- (instancetype)initWithFrame:(CGRect)frame{
    if (self = [super initWithFrame:frame]) {
        _titleLabel = UILabel.new;
        [_titleLabel setFont:MainFontWithSize(12)];
        [_titleLabel setTextColor:ColorWhite];
        [_titleLabel setTextAlignment:NSTextAlignmentCenter];
        
        [self.contentView addSubview:_titleLabel];
    }
    return self;
}
- (void)layoutSubviews{
    [super layoutSubviews];
    
    [self.titleLabel mas_remakeConstraints:^(MASConstraintMaker *make) {
        make.edges.mas_equalTo(self.contentView);
    }];
    
    
    CGFloat corner = CGRectGetHeight(self.bounds)/2.0;
    [self.layer setCornerRadius:corner];
    [self.layer setMasksToBounds:YES];
    [self.layer setBorderColor:UIColor.whiteColor.CGColor];
    [self.layer setBorderWidth:1];
}

- (void)setSelected:(BOOL)selected{
    [super setSelected:selected];
    
    UIColor *color = selected ? UIColor.redColor : UIColor.whiteColor;
    [self.layer setBorderColor:color.CGColor];
}
@end
