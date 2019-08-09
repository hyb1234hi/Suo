//
//  GAOpenLiveControlView.m
//  Suo
//
//  Created by ysw on 2019/8/1.
//  Copyright © 2019 怪兽 🐙. All rights reserved.
//

#import "GAOpenLiveControlView.h"
#import "GABaseCollectionViewCell.h"

#import "GALiveInfoView.h"
#import "GABeautyFilterView.h"
#import "GASelectedGoodsView.h"

#import <TZImagePickerController.h>

@interface GAOpenLiveControlView ()

@property(nonatomic,strong)UIButton *switchCamera;  //!<切换相机

@property(nonatomic,strong)GALiveInfoView *infoView;
@property(nonatomic,strong)GASelectedGoodsView *selectedGoodsView; //!<直播商品
@property(nonatomic,strong)GABeautyFilterView *beautyFilter;    //!<美颜&滤镜
@property(nonatomic,strong)UIButton *startLiveBtn;              //!<开始直播

@end

@implementation GAOpenLiveControlView

- (instancetype)initWithFrame:(CGRect)frame{
    if (self = [super initWithFrame:frame]) {
        [self setupUI];
    }
    return self;
}

- (void)setupUI{

    _switchCamera       = UIButton.new;
    _infoView           = GALiveInfoView.new;
    _selectedGoodsView  = GASelectedGoodsView.new;
    _startLiveBtn       = UIButton.new;
    _beautyFilter       = GABeautyFilterView.new;
    
    
    [self addSubview:_switchCamera];
    [self addSubview:_infoView];
    [self addSubview:_selectedGoodsView];
    [self addSubview:_beautyFilter];
    [self addSubview:_startLiveBtn];
  
    [_switchCamera setImage:[UIImage imageNamed:@""] forState:UIControlStateNormal];
    [_switchCamera setTitle:@"switch" forState:UIControlStateNormal];
    
    
    [_startLiveBtn setTitle:@"开启视频直播" forState:UIControlStateNormal];
    [_startLiveBtn.titleLabel setFont:MainFontWithSize(24)];
    [_startLiveBtn setBackgroundColor:RGBA(255, 78, 50, 1)];
    [_startLiveBtn.layer setCornerRadius:8];
    [_startLiveBtn.layer setMasksToBounds:YES];
    

    [_startLiveBtn addTarget:self action:@selector(toggleStartButton:) forControlEvents:UIControlEventTouchUpInside];
    [_switchCamera addTarget:self action:@selector(toggleSwitchCamera:) forControlEvents:UIControlEventTouchUpInside];
}

- (void)layoutSubviews{
    [super layoutSubviews];
    
    CGFloat leftSpace = 19;
    
    [self.switchCamera mas_remakeConstraints:^(MASConstraintMaker *make) {
        make.top.right.mas_equalTo(self).insets(UIEdgeInsetsMake(40, 0, 0, 20));
    }];

    [self.infoView mas_remakeConstraints:^(MASConstraintMaker *make) {
        make.left.right.mas_equalTo(self).inset(leftSpace);
        make.top.mas_equalTo(self.switchCamera.mas_bottom).inset(22);
        CGFloat h = (ScreenWidth - leftSpace*2)*(151/375.0);
        make.height.mas_equalTo(h);
    }];
    
    [self.selectedGoodsView mas_remakeConstraints:^(MASConstraintMaker *make) {
        make.left.right.mas_equalTo(self).insets(UIEdgeInsetsMake(0, leftSpace, 0, leftSpace));
        make.bottom.mas_equalTo(self.beautyFilter.mas_top).inset(30);
        make.height.mas_equalTo(self.selectedGoodsView.mas_width).multipliedBy(140/375.0);
    }];
   
    [self.startLiveBtn mas_remakeConstraints:^(MASConstraintMaker *make) {
        CGFloat space = 24.0;
        make.left.bottom.right.mas_equalTo(self).insets(UIEdgeInsetsMake(0, space, SafeAreaBottomHeight + space, space));
        make.height.mas_equalTo(70);
    }];
    
    [self.beautyFilter mas_remakeConstraints:^(MASConstraintMaker *make) {
        make.left.right.mas_equalTo(self).insets(UIEdgeInsetsMake(0, leftSpace,0, leftSpace));
        make.bottom.mas_equalTo(self.startLiveBtn.mas_top).inset(72);
        make.height.mas_equalTo(self.beautyFilter.mas_width).multipliedBy(140/375.0);
    }];
}


- (void)toggleSwitchCamera:(UIButton*)send{
    if ([self.delegate respondsToSelector:@selector(switchCamera)]) {
        [self.delegate switchCamera];
    }
}

- (void)toggleStartButton:(UIButton*)send{
    if ([self.delegate respondsToSelector:@selector(startLive)]) {
        [self.delegate startLive];
    }
}

@end



