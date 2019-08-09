//
//  GAOpenLiveControlView.m
//  Suo
//
//  Created by ysw on 2019/8/1.
//  Copyright © 2019 怪兽 🐙. All rights reserved.
//

#import "GAOpenLiveControlView.h"

#import "GALiveInfoView.h"
#import "GABeautyFilterView.h"
#import "GASelectedGoodsView.h"

@interface GAOpenLiveControlView ()

@property(nonatomic,strong)UIButton *switchCamera;      //!<切换相机
@property(nonatomic,strong)UIButton *beautyBtn;         //!<美颜按钮
@property(nonatomic,strong)UIButton *filterBtn;         //!<滤镜✨💫按钮
@property(nonatomic,strong)UIButton *selectBtn;         //!<选择商品
@property(nonatomic,strong)UIButton *startLiveBtn;      //!<开始直播

@property(nonatomic,strong)GALiveInfoView *infoView;
@property(nonatomic,strong)GASelectedGoodsView *selectedGoodsView; //!<直播商品
@property(nonatomic,strong)GABeautyFilterView *beautyFilter;    //!<美颜&滤镜

@end

static CGFloat space = 19.0;

@implementation GAOpenLiveControlView

- (instancetype)initWithFrame:(CGRect)frame{
    if (self = [super initWithFrame:frame]) {
        [self setupUI];
        
        __weak typeof(self) wself = self;
        NSNotificationCenter *nc = [NSNotificationCenter defaultCenter];
        [nc addObserverForName:UIKeyboardWillShowNotification object:nil queue:nil usingBlock:^(NSNotification * _Nonnull note) {
            
            CGRect rect = [[note.userInfo valueForKey:UIKeyboardFrameEndUserInfoKey] CGRectValue];
            CGFloat bottomOffset = CGRectGetHeight(rect);
            [wself.infoView mas_updateConstraints:^(MASConstraintMaker *make) {
                make.bottom.mas_equalTo(wself).inset(bottomOffset+20);
            }];
            [UIView animateWithDuration:0.35 animations:^{
                [wself.infoView layoutIfNeeded];
            }];
        }];
        [nc addObserverForName:UIKeyboardWillHideNotification object:nil queue:nil usingBlock:^(NSNotification * _Nonnull note) {
            [wself infoViewShowLayout];
        }];
    }
    return self;
}

- (void)setupUI{

    _switchCamera       = UIButton.new;
    _beautyBtn          = UIButton.new;
    _filterBtn          = UIButton.new;
    _selectBtn          = UIButton.new;
    _startLiveBtn       = UIButton.new;
    
    _infoView           = GALiveInfoView.new;
    _selectedGoodsView  = GASelectedGoodsView.new;
    _beautyFilter       = GABeautyFilterView.new;
    
    [self addSubview:_switchCamera];
    [self addSubview:_beautyBtn];
    [self addSubview:_filterBtn];
    [self addSubview:_selectBtn];
    [self addSubview:_startLiveBtn];
    
    [self addSubview:_infoView];
    [self addSubview:_selectedGoodsView];
    [self addSubview:_beautyFilter];
    
    [_switchCamera setImage:[UIImage imageNamed:@""] forState:UIControlStateNormal];
    [_switchCamera setTitle:@"switch" forState:UIControlStateNormal];
    
    [_startLiveBtn setTitle:@"开启视频直播" forState:UIControlStateNormal];
    [_startLiveBtn.titleLabel setFont:MainFontWithSize(24)];
    [_startLiveBtn setBackgroundColor:RGBA(255, 78, 50, 1)];
    [_startLiveBtn.layer setCornerRadius:8];
    [_startLiveBtn.layer setMasksToBounds:YES];
    
    
    [_beautyBtn setTitle:@"美颜" forState:UIControlStateNormal];
    [_filterBtn setTitle:@"滤镜" forState:UIControlStateNormal];
    [_selectBtn setTitle:@"商品" forState:UIControlStateNormal];
    
    //初始布局
    [self infoViewShowLayout];
    [self beautyFilterViewHinddenLayout];
    [self selectedGoodsViewHinddenLayout];
    
    UIControlEvents event = UIControlEventTouchUpInside ;
    [_filterBtn addTarget:self action:@selector(toggleFilterButton:) forControlEvents:event];
    [_beautyBtn addTarget:self action:@selector(toggleBeautyButton:) forControlEvents:event];
    [_selectBtn addTarget:self action:@selector(toggleSelectedGoodsButton:) forControlEvents:event];
    [_startLiveBtn addTarget:self action:@selector(toggleStartButton:) forControlEvents:event];
    [_switchCamera addTarget:self action:@selector(toggleSwitchCamera:) forControlEvents:event];
    
    CGFloat corner = 16;
    [_infoView.layer setCornerRadius:corner];
    [_infoView.layer setMasksToBounds:YES];
    [_beautyFilter.layer setCornerRadius:corner];
    [_beautyFilter.layer setMasksToBounds:YES];
    [_selectedGoodsView.layer setCornerRadius:corner];
    [_selectedGoodsView.layer setMasksToBounds:YES];
    
}

- (void)layoutSubviews{
    [super layoutSubviews];
    
    [self.switchCamera mas_remakeConstraints:^(MASConstraintMaker *make) {
        make.top.right.mas_equalTo(self).insets(UIEdgeInsetsMake(40, 0, 0, 20));
    }];
    [self.beautyBtn mas_remakeConstraints:^(MASConstraintMaker *make) {
        make.centerX.mas_equalTo(self.switchCamera);
        make.top.mas_equalTo(self.switchCamera.mas_bottom).inset(16);
    }];
    [self.filterBtn mas_remakeConstraints:^(MASConstraintMaker *make) {
        make.centerX.mas_equalTo(self.switchCamera);
        make.top.mas_equalTo(self.beautyBtn.mas_bottom).inset(16);
    }];
    [self.selectBtn mas_remakeConstraints:^(MASConstraintMaker *make) {
        make.centerX.mas_equalTo(self.switchCamera);
        make.top.mas_equalTo(self.filterBtn.mas_bottom).inset(16);
    }];

    [self.startLiveBtn mas_remakeConstraints:^(MASConstraintMaker *make) {
        CGFloat space = 24.0;
        make.left.bottom.right.mas_equalTo(self).insets(UIEdgeInsetsMake(0, space, SafeAreaBottomHeight + space, space));
        make.height.mas_equalTo(70);
    }];
}


#pragma mark 视图状态
//信息视图原始坐标
- (void)infoViewShowLayout{
    
    [_infoView mas_remakeConstraints:^(MASConstraintMaker *make) {
        make.left.right.mas_equalTo(self).inset(space);
        make.bottom.mas_equalTo(self.startLiveBtn.mas_top).inset(20);
        make.height.mas_equalTo(self.infoView.mas_width).multipliedBy(151/375.0);
    }];
    
    [UIView animateWithDuration:0.35 animations:^{
        [self layoutIfNeeded];
    }];
}
- (void)infoViewHinddenLayout{
    [_infoView mas_remakeConstraints:^(MASConstraintMaker *make) {
        make.left.right.mas_equalTo(self).inset(space);
        make.bottom.mas_equalTo(self).inset(-500);
        make.height.mas_equalTo(self.infoView.mas_width).multipliedBy(151/375.0);
    }];
}


- (void)selectedGoodsViewHinddenLayout{
    [_selectedGoodsView mas_remakeConstraints:^(MASConstraintMaker *make) {
        make.width.mas_equalTo(ScreenWidth-space*2);
        make.height.mas_equalTo(self.selectedGoodsView.mas_width).multipliedBy(140/375.0);
        make.bottom.mas_equalTo(self.startLiveBtn.mas_top).inset(20);
        make.left.mas_equalTo(self.mas_right);
    }];
    [UIView animateWithDuration:0.1 animations:^{
        [self->_selectedGoodsView layoutIfNeeded];
    }];
}
- (void)selectedGoodsViewShowLayout{
    [_selectedGoodsView mas_updateConstraints:^(MASConstraintMaker *make) {
        make.left.mas_equalTo(self).inset(space);
    }];
    [UIView animateWithDuration:0.35 animations:^{
        [self layoutIfNeeded];
    }];
}

- (void)beautyFilterViewHinddenLayout{
    [_beautyFilter mas_remakeConstraints:^(MASConstraintMaker *make) {
        make.width.mas_equalTo(ScreenWidth-space*2);
        make.height.mas_equalTo(self.beautyFilter.mas_width).multipliedBy(140/375.0);
        make.bottom.mas_equalTo(self.startLiveBtn.mas_top).inset(20);
        make.left.mas_equalTo(self.mas_right);
    }];
    
    [UIView animateWithDuration:0.35 animations:^{
        [self->_beautyFilter layoutIfNeeded];
    }];
}
- (void)beautyFilterViewShowLayout{
    [_beautyFilter mas_remakeConstraints:^(MASConstraintMaker *make) {
        make.width.mas_equalTo(ScreenWidth-space*2);
        make.height.mas_equalTo(self.beautyFilter.mas_width).multipliedBy(140/375.0);
        make.bottom.mas_equalTo(self.startLiveBtn.mas_top).inset(20);
        make.left.mas_equalTo(self).inset(space);
    }];
    [UIView animateWithDuration:0.35 animations:^{
        [self layoutIfNeeded];
    }];
}

//注销响应者， 恢复布局
- (void)touchesBegan:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event{
    [self endEditing:YES];
    
        //恢复原始布局
    [self selectedGoodsViewHinddenLayout];
    [self beautyFilterViewHinddenLayout];
    
    [self infoViewShowLayout];
}
#pragma mark button Action

- (void)toggleSwitchCamera:(UIButton*)send{
    if ([self.delegate respondsToSelector:@selector(switchCamera)]) {
        [self.delegate switchCamera];
    }
}

- (void)toggleBeautyButton:(UIButton*)send{
    [self infoViewHinddenLayout];
    [self selectedGoodsViewHinddenLayout];
    
    [self beautyFilterViewShowLayout];
    [self.beautyFilter selectedState:BFViewStateBeauty];
}
- (void)toggleFilterButton:(UIButton*)send{
    [self infoViewHinddenLayout];
    [self selectedGoodsViewHinddenLayout];
    
    [self beautyFilterViewShowLayout];
    [self.beautyFilter selectedState:BFViewStateFilter];
}
- (void)toggleSelectedGoodsButton:(UIButton*)send{
    [self infoViewHinddenLayout];
    [self beautyFilterViewHinddenLayout];
    
     [self selectedGoodsViewShowLayout];
}


- (void)toggleStartButton:(UIButton*)send{
    if ([self.delegate respondsToSelector:@selector(startLive)]) {
        [self.delegate startLive];
    }
}

@end



