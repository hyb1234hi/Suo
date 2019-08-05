//
//  GAAuthorListCommonView.m
//  Suo
//
//  Created by gajz on 2019/8/4.
//  Copyright © 2019 怪兽 🐙. All rights reserved.
//

#import "GAAuthorListCommonView.h"
#import "GAAuthorListCollectionReusableView.h"
#import "GAAuthListCommonCollectionViewCell.h"

@interface GAAuthorListCommonView()<UICollectionViewDelegate,UICollectionViewDataSource,UICollectionViewDelegateFlowLayout>

@property (nonatomic, strong)UICollectionView *collectionView;

@end

@implementation GAAuthorListCommonView

-(instancetype)initWithFrame:(CGRect)frame {
    self = [super initWithFrame:frame];
    if (self) {
        [self setUI];
    }
    return self;
}

- (void)setUI {
    
    UITapGestureRecognizer *tap = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(viewDidClick)];
    [self addGestureRecognizer:tap];
    
    self.backgroundColor = UIColorFromRGB(0xf8f8f8);
    UICollectionViewFlowLayout *layout = [[UICollectionViewFlowLayout alloc] init];
    layout.minimumLineSpacing = 0;
    layout.minimumInteritemSpacing = 6;
    CGFloat width = self.frame.size.width;
    [layout setHeaderReferenceSize:CGSizeMake(width, 30)];
    [layout setItemSize:CGSizeMake(40, 40)];
    layout.scrollDirection = UICollectionViewScrollDirectionVertical;
    _collectionView = [[UICollectionView alloc] initWithFrame:CGRectZero collectionViewLayout:layout];
    _collectionView.delegate = self;
    _collectionView.dataSource = self;
    _collectionView.backgroundColor = UIColorFromRGB(0xf8f8f8);
    _collectionView.userInteractionEnabled = NO;
    _collectionView.scrollEnabled = NO;
    [self addSubview:_collectionView];
    [_collectionView registerClass:[GAAuthorListCollectionReusableView class] forSupplementaryViewOfKind:UICollectionElementKindSectionHeader withReuseIdentifier:NSStringFromClass([GAAuthorListCollectionReusableView class])];
    [_collectionView registerClass:[GAAuthListCommonCollectionViewCell class] forCellWithReuseIdentifier:NSStringFromClass([GAAuthListCommonCollectionViewCell class])];
}

- (void)viewDidClick {
    if ([self.delegate respondsToSelector:@selector(authorListCommonViewClickWithIndex:)]) {
        [self.delegate authorListCommonViewClickWithIndex:self.index];
    }
}

#pragma mark ---- UICollectionViewDataSource
- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section {
    return 3;
}
- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath {
    GAAuthListCommonCollectionViewCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:NSStringFromClass([GAAuthListCommonCollectionViewCell class]) forIndexPath:indexPath];
    if (_index == 0) {
        cell.isImage = NO;
    }else {
        cell.isImage = YES;
    }
    return cell;
}

- (CGSize)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout *)collectionViewLayout sizeForItemAtIndexPath:(NSIndexPath *)indexPath {
    return CGSizeMake(40, 40);
}

- (UICollectionReusableView *)collectionView:(UICollectionView *)collectionView viewForSupplementaryElementOfKind:(NSString *)kind atIndexPath:(NSIndexPath *)indexPath {
    if ([kind isEqualToString:UICollectionElementKindSectionHeader]) {
        GAAuthorListCollectionReusableView *header = [collectionView dequeueReusableSupplementaryViewOfKind:UICollectionElementKindSectionHeader withReuseIdentifier:NSStringFromClass([GAAuthorListCollectionReusableView class]) forIndexPath:indexPath];
        header.content = @"我是一个标题";
        header.frame = CGRectMake(0, 0, self.frame.size.width, 30);
        return header;
    }else {
        return nil;
    }
}

- (UIEdgeInsets)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout *)collectionViewLayout insetForSectionAtIndex:(NSInteger)section {
    return UIEdgeInsetsMake(3, 14, 0, 14);
}


- (void)layoutSubviews {
    [super layoutSubviews];
    [self.collectionView mas_remakeConstraints:^(MASConstraintMaker *make) {
        make.edges.mas_equalTo(self);
    }];
    [self setupMaskWithCorner:8 rectCorner:UIRectCornerAllCorners];
    
    [self.collectionView setupMaskWithCorner:8 rectCorner:UIRectCornerAllCorners];
}

@end
