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
#import "GALiveTypeSelectedView.h"

#import "GAAPI.h"

@interface GAOpenLiveControlView ()

@property(nonatomic,strong)UILabel *typeTitleLabel;
@property(nonatomic,strong)UIButton *selectTypeBtn;     //!<选择直播类型按钮

@property(nonatomic,strong)UIButton *switchCamera;      //!<切换相机
@property(nonatomic,strong)UIButton *beautyBtn;         //!<美颜按钮
@property(nonatomic,strong)UIButton *filterBtn;         //!<滤镜✨💫按钮
@property(nonatomic,strong)UIButton *selectBtn;         //!<选择商品


@property(nonatomic,strong)GALiveInfoView *infoView;
@property(nonatomic,strong)GASelectedGoodsView *selectedGoodsView;  //!<直播商品
@property(nonatomic,strong)GABeautyFilterView *beautyFilter;        //!<美颜&滤镜
@property(nonatomic,strong)GALiveTypeSelectedView *typeView;        //!<直播类型视图

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
            [wself.infoView mas_remakeConstraints:^(MASConstraintMaker *make) {
                make.left.right.mas_equalTo(wself).inset(space);
                make.bottom.mas_equalTo(wself).inset(bottomOffset);
                make.height.mas_equalTo(wself.infoView.mas_width).multipliedBy(151/375.0);
            }];
            [UIView animateWithDuration:0.35 animations:^{
                [wself layoutIfNeeded];
            }];
        }];
        [nc addObserverForName:UIKeyboardWillHideNotification object:nil queue:nil usingBlock:^(NSNotification * _Nonnull note) {
            [wself infoViewShowLayout];
        }];
    }
    return self;
}

- (void)setupUI{
    _selectTypeBtn      = UIButton.new;
    _switchCamera       = UIButton.new;
    _beautyBtn          = UIButton.new;
    _filterBtn          = UIButton.new;
    _selectBtn          = UIButton.new;
    _startLiveBtn       = UIButton.new;
    
    _infoView           = GALiveInfoView.new;
    _selectedGoodsView  = GASelectedGoodsView.new;
    _beautyFilter       = GABeautyFilterView.new;
    _typeView           = GALiveTypeSelectedView.new;

    [self addSubview:_switchCamera];
    [self addSubview:_beautyBtn];
    [self addSubview:_filterBtn];
    [self addSubview:_selectBtn];
    [self addSubview:_startLiveBtn];
    [self addSubview:_selectTypeBtn];
    [self addSubview:_infoView];
    [self addSubview:_selectedGoodsView];
    [self addSubview:_beautyFilter];
    [self addSubview:_typeView];
    
    [_selectTypeBtn setBackgroundColor:UIColor.grayColor];
    [_selectTypeBtn setTitle:@"直播类型 ▲" forState:UIControlStateNormal];
    [_selectTypeBtn setTitle:@"直播类型 ▼" forState:UIControlStateSelected];
    [_selectTypeBtn.titleLabel setFont:MainFontWithSize(15)];
    
    [_switchCamera setImage:[UIImage imageNamed:@""] forState:UIControlStateNormal];
    [_switchCamera setTitle:@"📷" forState:UIControlStateNormal];
    
    [_startLiveBtn setTitle:@"开启视频直播" forState:UIControlStateNormal];
    [_startLiveBtn.titleLabel setFont:MainFontWithSize(24)];
    [_startLiveBtn setBackgroundColor:RGBA(255, 78, 50, 1)];
    [_startLiveBtn.layer setCornerRadius:8];
    [_startLiveBtn.layer setMasksToBounds:YES];
    
    
    [_beautyBtn setTitle:@"☠️" forState:UIControlStateNormal];
    [_selectBtn setTitle:@"🛍" forState:UIControlStateNormal];
    
    //初始布局
    [self infoViewShowLayout];
    [self beautyFilterViewHinddenLayout];
    [self selectedGoodsViewHinddenLayout];
    
    UIControlEvents event = UIControlEventTouchUpInside ;
    [_selectTypeBtn addTarget:self action:@selector(toggleSelectedTypeButton:) forControlEvents:event];
    [_filterBtn addTarget:self action:@selector(toggleFilterButton:) forControlEvents:event];
    [_beautyBtn addTarget:self action:@selector(toggleBeautyButton:) forControlEvents:event];
    [_selectBtn addTarget:self action:@selector(toggleSelectedGoodsButton:) forControlEvents:event];
    [_startLiveBtn addTarget:self action:@selector(toggleStartButton:) forControlEvents:event];
    [_switchCamera addTarget:self action:@selector(toggleSwitchCamera:) forControlEvents:event];
    
    CGFloat corner = 16;
    [_infoView.layer setCornerRadius:corner];
    [_infoView.layer setMasksToBounds:YES];
    [_selectedGoodsView.layer setCornerRadius:corner];
    [_selectedGoodsView.layer setMasksToBounds:YES];
    
    
    [_startLiveBtn mas_remakeConstraints:^(MASConstraintMaker *make) {
        CGFloat space = 24.0;
        make.left.bottom.right.mas_equalTo(self).insets(UIEdgeInsetsMake(0, space, SafeAreaBottomHeight + space, space));
        make.height.mas_equalTo(70);
    }];
    
    [self typeViewHinddenLayout];
    
    [self.filterBtn setUserInteractionEnabled:NO];
    
    __weak typeof(self) wself = self;
    [_typeView setSelectedBlock:^(GALiveTypeModel * _Nonnull type) {
        NSString *nor = [NSString stringWithFormat:@"%@ ▲",type.name];
        NSString *sel = [NSString stringWithFormat:@"%@ ▼",type.name];
        
        [wself.selectTypeBtn setTitle:nor forState:UIControlStateNormal];
        [wself.selectTypeBtn setTitle:sel forState:UIControlStateSelected];
        wself.selectedType = type;
        [wself typeViewHinddenLayout];
        [wself.selectTypeBtn setSelected:NO];
        
    }];
}

- (void)layoutSubviews{
    [super layoutSubviews];
    
    [self.selectTypeBtn mas_remakeConstraints:^(MASConstraintMaker *make) {
        make.centerX.mas_equalTo(self);
        make.top.mas_equalTo(self).inset(self.safeAreaInsets.top);
        make.size.mas_equalTo(CGSizeMake(100, 30));
    }];
    [self.selectTypeBtn.layer setCornerRadius:15];
    [self.selectTypeBtn.layer setMasksToBounds:YES];
    
    
    [self.switchCamera mas_remakeConstraints:^(MASConstraintMaker *make) {
        make.top.right.mas_equalTo(self).insets(UIEdgeInsetsMake(self.safeAreaInsets.top,0,0,20));
    }];
    
    [self.beautyBtn mas_remakeConstraints:^(MASConstraintMaker *make) {
        make.left.top.mas_equalTo(self).insets(UIEdgeInsetsMake(self.safeAreaInsets.top, 20, 0, 0));
    }];
    
    
    [self.selectBtn mas_remakeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_equalTo(self.beautyBtn.mas_right).inset(20);
        make.top.mas_equalTo(self.beautyBtn);
    }];

 
}

- (void)setParams:(GABeautyFilterParams *)params{
    if (_params != params) {
        _params = params;
        [self.beautyFilter setParams:params];
    }
}
- (void)setPusher:(AlivcLivePusher *)pusher{
    if (_pusher != pusher) {
        _pusher = pusher;
        [self.beautyFilter setPusher:pusher];
    }
}

#pragma mark 视图状态
//信息视图原始坐标
- (void)infoViewShowLayout{
    
    [_infoView mas_remakeConstraints:^(MASConstraintMaker *make) {
        make.left.right.mas_equalTo(self).inset(space);
        make.bottom.mas_equalTo(self.startLiveBtn.mas_top).inset(20);
        make.height.mas_equalTo(self.infoView.mas_width).multipliedBy(151/375.0);
    }];
    [_startLiveBtn mas_remakeConstraints:^(MASConstraintMaker *make) {
        CGFloat space = 24.0;
        make.left.bottom.right.mas_equalTo(self).insets(UIEdgeInsetsMake(0, space, SafeAreaBottomHeight + space, space));
        make.height.mas_equalTo(70);
    }];

    [UIView animateWithDuration:0.35 animations:^{
        [self layoutIfNeeded];
    }];
}
- (void)infoViewHinddenLayout{
    [_startLiveBtn mas_remakeConstraints:^(MASConstraintMaker *make) {
        CGFloat space = 24.0;
        make.left.bottom.right.mas_equalTo(self).insets(UIEdgeInsetsMake(0, space, -(800), space));
        make.height.mas_equalTo(70);
    }];
}

- (void)selectedGoodsViewHinddenLayout{
    [_selectedGoodsView mas_remakeConstraints:^(MASConstraintMaker *make) {
        make.width.mas_equalTo(ScreenWidth-space*2);
        make.height.mas_equalTo(self.selectedGoodsView.mas_width).multipliedBy(140/375.0);
        //make.bottom.mas_equalTo(self.startLiveBtn.mas_top).inset(20);
        make.bottom.mas_equalTo(self).inset(SafeAreaBottomHeight + 20);
        
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
        make.height.mas_equalTo(self.beautyFilter.mas_width).multipliedBy((140/375.0)+(44/375.0));
        //make.bottom.mas_equalTo(self.startLiveBtn.mas_top).inset(20);
         make.bottom.mas_equalTo(self).inset(SafeAreaBottomHeight + 20);
        make.left.mas_equalTo(self.mas_right);
    }];
    
    [UIView animateWithDuration:0.35 animations:^{
        [self layoutIfNeeded];
    } completion:^(BOOL finished) {}];
}
- (void)beautyFilterViewShowLayout{
    [_beautyFilter mas_updateConstraints:^(MASConstraintMaker *make) {
//        make.width.mas_equalTo(ScreenWidth-space*2);
//        make.height.mas_equalTo(self.beautyFilter.mas_width).multipliedBy((140/375.0)+(44/375.0));
//        make.bottom.mas_equalTo(self.startLiveBtn.mas_top).inset(20);
//        make.left.mas_equalTo(self).inset(space);
        make.left.mas_equalTo(self).inset(space);
    }];
    [UIView animateWithDuration:0.35 animations:^{
        [self layoutIfNeeded];
    } completion:^(BOOL finished) {}];
}

- (void)typeViewHinddenLayout{
    [self.typeView mas_remakeConstraints:^(MASConstraintMaker *make) {
        make.left.right.mas_equalTo(self.startLiveBtn);
        make.top.mas_equalTo(self.selectTypeBtn.mas_bottom).inset(8);
        make.height.mas_equalTo(0);
    }];
    [UIView animateWithDuration:0.25 animations:^{
        [self layoutIfNeeded];
    }];
}
- (void)typeViewShowLayout{
    [self.typeView mas_remakeConstraints:^(MASConstraintMaker *make) {
        make.left.right.mas_equalTo(self.startLiveBtn);
        make.top.mas_equalTo(self.selectTypeBtn.mas_bottom).inset(8);
        make.height.mas_equalTo(self.typeView.mas_width).multipliedBy(167/383.0);
    }];
    [UIView animateWithDuration:0.25 animations:^{
        [self layoutIfNeeded];
    }];

}

//注销响应者， 恢复布局
- (void)touchesBegan:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event{
    [self endEditing:YES];
    
        //恢复原始布局
    [self selectedGoodsViewHinddenLayout];
    [self beautyFilterViewHinddenLayout];
    [self typeViewHinddenLayout];
    
    [self infoViewShowLayout];
}
#pragma mark button Action
- (void)toggleSelectedTypeButton:(UIButton*)send{
    BOOL selected = send.selected;
    [send setSelected:!selected];
    
    if (!selected) {
        [self selectedGoodsViewHinddenLayout];
        [self beautyFilterViewHinddenLayout];
        [self typeViewShowLayout];
    }else{
        [self typeViewHinddenLayout];
    }
}
- (void)toggleSwitchCamera:(UIButton*)send{
    if ([self.delegate respondsToSelector:@selector(switchCamera)]) {
        [self.delegate switchCamera];
    }
}

- (void)toggleBeautyButton:(UIButton*)send{
    [self infoViewHinddenLayout];
    [self selectedGoodsViewHinddenLayout];
    [self typeViewHinddenLayout];
    
    [self beautyFilterViewShowLayout];
    [self.beautyFilter selectedState:BFViewStateBeauty];
}
- (void)toggleFilterButton:(UIButton*)send{
    [self infoViewHinddenLayout];
    [self selectedGoodsViewHinddenLayout];
    [self typeViewHinddenLayout];
    
    [self beautyFilterViewShowLayout];
    [self.beautyFilter selectedState:BFViewStateFilter];
}
- (void)toggleSelectedGoodsButton:(UIButton*)send{
    [self infoViewHinddenLayout];
    [self beautyFilterViewHinddenLayout];
    [self typeViewHinddenLayout];
    
     [self selectedGoodsViewShowLayout];
}


- (void)toggleStartButton:(UIButton*)send{
    if ([self.delegate respondsToSelector:@selector(startLiveWiteTitle:image:location:selectedGoods:)]) {
        NSString *title = self.infoView.titleTextField.text;
        UIImage *image =  self.infoView.coverView.image;
        
        [self.delegate startLiveWiteTitle:title image:image location:self.infoView.info selectedGoods:self.selectedGoodsView.goodsArray];
    }
}

@end



