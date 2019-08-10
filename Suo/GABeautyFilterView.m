//
//  GABeautyFilterView.m
//  Suo
//
//  Created by ysw on 2019/8/9.
//  Copyright © 2019 怪兽 🐙. All rights reserved.
//

#import "GABeautyFilterView.h"
#import "GABaseCollectionViewCell.h"


@interface _EffectCell : GABaseCollectionViewCell
@property(nonatomic,strong)UIImageView *imageView;
@property(nonatomic,strong)UILabel *titleLabel;

@end


@interface GABeautyFilterView ()<
UICollectionViewDelegate,UICollectionViewDataSource,UICollectionViewDelegateFlowLayout
>

@property(nonatomic,strong)UIView *containerView;

@property(nonatomic,strong)UIButton *beautyBtn; //!<滤镜按钮
@property(nonatomic,strong)UIButton *filterBtn; //!<美颜按钮

@property(nonatomic,strong)UICollectionView *collectionView; //!<效果预览
@property(nonatomic,strong)UISlider *slider;                //!<效果大小 0-100;


@property(nonatomic,strong)NSArray<NSDictionary*> *beautyArray;    //美颜效果
@property(nonatomic,strong)NSArray<NSDictionary*> *filterArray;    //滤镜效果
@property(nonatomic,assign)BFViewState viewState;   //当前显示那个数据 默认美颜
@end

@implementation GABeautyFilterView

- (void)touchesBegan:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event{
    
}

- (instancetype)initWithFrame:(CGRect)frame{
    if (self = [super initWithFrame:frame]) {
        
        _viewState = BFViewStateBeauty;
        _beautyArray = @[@{@"磨皮":@""},
                         @{@"美白":@""},
                         @{@"红润":@""},
                         @{@"缩下巴":@""},
                         @{@"大眼":@""},
                         @{@"瘦脸":@""},
                         @{@"腮红":@""},
                         ];
        _filterArray = @[@{@"黑白":@""},
                         @{@"日系":@""},
                         @{@"薄荷":@""},
                         @{@"美食":@""},
                         @{@"活力":@""},
                         @{@"薄荷":@""},
                         @{@"美食":@""},
                         @{@"活力":@""},
                         @{@"无滤镜":@""}
                       ];
        
        [self setupUI];
        
        [self setBackgroundColor:UIColor.clearColor];
    }
    return self;
}

- (void)setupUI{
    _containerView = UIView.new;
    
    _beautyBtn = UIButton.new;
    _filterBtn = UIButton.new;
    
    UICollectionViewFlowLayout *layout = UICollectionViewFlowLayout.new;
    [layout setMinimumInteritemSpacing:8];
    [layout setScrollDirection:UICollectionViewScrollDirectionHorizontal];
    
    _collectionView = [[UICollectionView alloc] initWithFrame:CGRectZero collectionViewLayout:layout];
    [_collectionView setBackgroundColor:UIColor.clearColor];
    [_collectionView setDelegate:self];
    [_collectionView setDataSource:self];
    [_collectionView registerClass:_EffectCell.class forCellWithReuseIdentifier:_EffectCell.identifier];
    [_collectionView setShowsHorizontalScrollIndicator:NO];
    
    [_containerView addSubview:_beautyBtn];
    [_containerView addSubview:_filterBtn];
    [_containerView addSubview:_collectionView];
    [self addSubview:_containerView];
    
    [_beautyBtn setTitle:@"美颜" forState:UIControlStateNormal];
    [_beautyBtn setTitleColor:UIColor.redColor forState:UIControlStateSelected];
    [_beautyBtn setSelected:YES];
    
    [_filterBtn setTitle:@"滤镜" forState:UIControlStateNormal];
    [_filterBtn  setTitleColor:UIColor.redColor forState:UIControlStateSelected];
    
    [_beautyBtn addTarget:self action:@selector(onButtonAction:) forControlEvents:UIControlEventTouchUpInside];
    [_filterBtn addTarget:self action:@selector(onButtonAction:) forControlEvents:UIControlEventTouchUpInside];
    
    [_containerView setBackgroundColor:ColorBlackAlpha40];
    [self setBackgroundColor:UIColor.clearColor];
}

- (void)layoutSubviews{
    [super layoutSubviews];
    
    [self.containerView mas_remakeConstraints:^(MASConstraintMaker *make) {
        make.edges.mas_equalTo(self).insets(UIEdgeInsetsMake(44, 0, 0, 0));
    }];
    
    [self.beautyBtn mas_remakeConstraints:^(MASConstraintMaker *make) {
        make.centerX.mas_equalTo(-ScreenWidth/4.0);
        make.bottom.mas_equalTo(self.containerView).inset(10);
    }];
    [self.filterBtn mas_remakeConstraints:^(MASConstraintMaker *make) {
        make.centerX.mas_equalTo(ScreenWidth/4.0);
        make.bottom.mas_equalTo(self.beautyBtn);
    }];
    
    [self.collectionView mas_remakeConstraints:^(MASConstraintMaker *make) {
        make.left.top.right.mas_equalTo(self.containerView).insets(UIEdgeInsetsMake(10, 25, 10, 25));
        make.bottom.mas_equalTo(self.beautyBtn.mas_top).inset(10);
    }];
    
    [self.containerView setupMaskWithCorner:16 rectCorner:UIRectCornerAllCorners] ;
}

- (void)onButtonAction:(UIButton*)button{
    
    [button setSelected:YES];
    if (button == self.beautyBtn) {
        [self.filterBtn setSelected:NO];
        
        self.viewState = BFViewStateBeauty;
        [self.collectionView reloadData];
    }
    if (button == self.filterBtn) {
        [self.beautyBtn setSelected:NO];
        self.viewState = BFViewStateFilter;
        [self.collectionView reloadData];
    }
}

- (void)selectedState:(BFViewState)state{
    //self.viewState = state;
    switch (state) {
        case BFViewStateBeauty:
            [self onButtonAction:self.beautyBtn];
            break;
            
        case BFViewStateFilter:
            [self onButtonAction:self.filterBtn];
            break;
    }
}



- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section{
    switch (self.viewState) {
        case BFViewStateBeauty:{
            return self.beautyArray.count;
        }break;
        case BFViewStateFilter:{
            return self.filterArray.count;
        }break;
    }
}
- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath{
    _EffectCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:_EffectCell.identifier forIndexPath:indexPath];
    
    NSDictionary *dict = nil;
    switch (self.viewState) {
        case BFViewStateBeauty:{
            dict = [self.beautyArray objectAtIndex:indexPath.row];
        }break;
            
        case BFViewStateFilter:{
            dict = [self.filterArray objectAtIndex:indexPath.row];
        }break;
    }
    
    [cell.titleLabel setText:dict.allKeys.firstObject];
    
    return cell;
}

-(CGSize)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout *)collectionViewLayout sizeForItemAtIndexPath:(NSIndexPath *)indexPath{
    CGFloat h = CGRectGetHeight(collectionView.bounds);
    CGFloat w = h - 20;
    return CGSizeMake(w, h);
}

- (void)collectionView:(UICollectionView *)collectionView didSelectItemAtIndexPath:(NSIndexPath *)indexPath{
    
    [self addSubview:self.slider];
    [self.slider setFrame:CGRectMake(0, -30, 414, 44)];

}

- (void)sliderValueChange:(UISlider*)slider{
    
}


- (UISlider *)slider{
    if (!_slider) {
        _slider = [[UISlider alloc] init];
        [_slider addTarget:self action:@selector(sliderValueChange:) forControlEvents:UIControlEventValueChanged];
    }
    return _slider;
}
@end




@implementation _EffectCell

- (instancetype)initWithFrame:(CGRect)frame{
    if (self = [super initWithFrame:frame]) {
        _imageView = UIImageView.new;
        _titleLabel = UILabel.new;
        [_titleLabel setTextColor:ColorWhite];
        [_titleLabel setFont:MainFontWithSize(12)];
        [_titleLabel setTextAlignment:NSTextAlignmentCenter];
        
        [self.contentView addSubview:_imageView];
        [self.contentView addSubview:_titleLabel];
        
        [_imageView setBackgroundColor:ColorWhite];
    }
    return self;
}


- (void)layoutSubviews{
    [super layoutSubviews];
    
    [self.imageView mas_remakeConstraints:^(MASConstraintMaker *make) {
        make.left.top.right.mas_equalTo(self.contentView);
        make.height.mas_equalTo(self.imageView.mas_width);
    }];
    [self.titleLabel mas_remakeConstraints:^(MASConstraintMaker *make) {
        make.left.bottom.right.mas_equalTo(self.contentView);
        make.top.mas_equalTo(self.imageView.mas_bottom);
    }];
}


- (void)select:(id)sender{
    [super select:sender];
    
    
}
@end


