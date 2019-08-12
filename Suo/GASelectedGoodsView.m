//
//  GASelectedGoodsView.m
//  Suo
//
//  Created by ysw on 2019/8/9.
//  Copyright © 2019 怪兽 🐙. All rights reserved.
//

#import "GASelectedGoodsView.h"
#import "GABaseCollectionViewCell.h"

#import "GASelectedGoodsViewController.h"
//#import "GACandidateGoodsViewController.h"

@interface _SelectedGoodsCell : GABaseCollectionViewCell
@property(nonatomic,strong)UIImageView *imageView;  //!<商品图片
@property(nonatomic,strong)UIButton *deleteBtn;     //!<删除按钮
@end

@interface GASelectedGoodsView ()<UICollectionViewDelegate,UICollectionViewDataSource,UICollectionViewDelegateFlowLayout>
@property(nonatomic,strong)UILabel *titleLabel;     //!<标题
@property(nonatomic,strong)UICollectionView *collectionView;

@property(nonatomic,strong)NSArray *goodsArray;


@end

@implementation GASelectedGoodsView

- (void)touchesBegan:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event{}

- (instancetype)initWithFrame:(CGRect)frame{
    if (self = [super initWithFrame:frame]) {
        _goodsArray = @[@"icon_profile_share_qqZone",
                        @"icon_profile_share_qqZone",
                        @"icon_profile_share_qqZone",
                        @"icon_profile_share_qqZone",
                        @"icon_profile_share_qqZone",
                        @"icon_profile_share_qqZone",
                        @"icon_profile_share_qqZone",
                        @"icon_profile_share_qqZone",
                        ];
        [self setupUI];
        
        [self setBackgroundColor:ColorBlackAlpha40];
        [self.layer setCornerRadius:6];
        [self.layer setMasksToBounds:YES];
    }
    return self;
}
- (void)setupUI{
    _titleLabel = UILabel.new;
    [_titleLabel setText:@"已选推送商品"];
    [_titleLabel setTextColor:ColorWhite];
    
    UICollectionViewFlowLayout *layout = [[UICollectionViewFlowLayout alloc] init];
    [layout setScrollDirection:UICollectionViewScrollDirectionHorizontal];
    [layout setMinimumInteritemSpacing:8];
    
    _collectionView = [[UICollectionView alloc] initWithFrame:CGRectZero collectionViewLayout:layout];
    [_collectionView registerClass:_SelectedGoodsCell.class forCellWithReuseIdentifier:_SelectedGoodsCell.identifier];
    [_collectionView registerClass:UICollectionReusableView.class forSupplementaryViewOfKind:UICollectionElementKindSectionFooter withReuseIdentifier:@"footer"];
    [_collectionView setDelegate:self];
    [_collectionView setDataSource:self];
    [_collectionView setBackgroundColor:UIColor.clearColor];
    
    [self addSubview:_titleLabel];
    [self addSubview:_collectionView];
}


- (void)layoutSubviews{
    [super layoutSubviews];
    
    [self.titleLabel mas_remakeConstraints:^(MASConstraintMaker *make) {
        make.left.top.mas_equalTo(self).insets(UIEdgeInsetsMake(17, 25, 0, 0));
    }];
    [self.collectionView mas_remakeConstraints:^(MASConstraintMaker *make) {
        make.left.right.bottom.mas_equalTo(self).insets(UIEdgeInsetsMake(0, 25, 25, 25));
        make.top.mas_equalTo(self.titleLabel.mas_bottom).inset(22);
    }];
}

- (NSInteger)numberOfSectionsInCollectionView:(UICollectionView *)collectionView{
    return 2;
}

- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section{
    if (section == 1) {
        return 1;
    }
    
    return self.goodsArray.count;
}

-(UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath{
    _SelectedGoodsCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:_SelectedGoodsCell.identifier forIndexPath:indexPath];
    
    if (indexPath.section == 1) {
        //[cell.imageView setImage:[UIImage imageNamed:@"chooser-button-input-highlighted"]];
        [cell.imageView setBackgroundColor:UIColor.grayColor];
        [cell.deleteBtn setHidden:YES];
    }else{
        //[cell.imageView setImage:[UIImage imageNamed:self.goodsArray[indexPath.row]]];
        [cell.deleteBtn setHidden:NO];
    }
    
    return cell;
}

- (UICollectionReusableView *)collectionView:(UICollectionView *)collectionView viewForSupplementaryElementOfKind:(NSString *)kind atIndexPath:(NSIndexPath *)indexPath{
    if ([kind isEqualToString:UICollectionElementKindSectionFooter]) {
        UICollectionReusableView *footer = [collectionView dequeueReusableSupplementaryViewOfKind:kind withReuseIdentifier:@"footer" forIndexPath:indexPath];
        return footer;
    }
    return nil;
}
- (void)collectionView:(UICollectionView *)collectionView didSelectItemAtIndexPath:(NSIndexPath *)indexPath{
    if (indexPath.section == 1) {
        //GACandidateGoodsViewController *vc = GACandidateGoodsViewController.new;
        
        GASelectedGoodsViewController * vc = GASelectedGoodsViewController.new;
        UINavigationController *nav = [[UINavigationController alloc] initWithRootViewController:vc];
        
        nav.modalPresentationStyle = UIModalPresentationOverCurrentContext;
        [self rootVCPresentViewController:nav animated:YES completion:nil];
    }
}

- (CGSize)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout *)collectionViewLayout sizeForItemAtIndexPath:(NSIndexPath *)indexPath{
    CGFloat h = CGRectGetHeight(collectionView.bounds);
    return CGSizeMake(h, h);
}
- (CGSize)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout *)collectionViewLayout referenceSizeForFooterInSection:(NSInteger)section{
    if (section == 0) {
        return CGSizeMake(8, 0);
    }
    return CGSizeZero;
}
@end


@implementation _SelectedGoodsCell

- (instancetype)initWithFrame:(CGRect)frame{
    if (self = [super initWithFrame:frame]) {
        _imageView = UIImageView.new;
        _deleteBtn = UIButton.new;
        [_deleteBtn setTitle:@"X" forState:UIControlStateNormal];
        
        [_imageView setBackgroundColor:UIColor.redColor];
        
        [self.contentView addSubview:_imageView];
        [self.contentView addSubview:_deleteBtn];
    }
    return self;
}

- (void)layoutSubviews{
    [super layoutSubviews];
    
    [self.imageView mas_remakeConstraints:^(MASConstraintMaker *make) {
        make.edges.mas_equalTo(0);
    }];
    [self.deleteBtn mas_remakeConstraints:^(MASConstraintMaker *make) {
        make.top.right.mas_equalTo(self.contentView);
        
    }];
}
@end
