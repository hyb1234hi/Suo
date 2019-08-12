//
//  GALiveCenterProfileView.m
//  Suo
//
//  Created by ysw on 2019/8/11.
//  Copyright © 2019 怪兽 🐙. All rights reserved.
//

#import "GALiveCenterProfileView.h"

@interface GALiveCenterProfileView ()
@property(nonatomic,strong)UIImageView *avatarView; //!<主播头像
@property(nonatomic,strong)UILabel *nameLab;        //!<主播名称
@property(nonatomic,strong)UILabel *locationLab;    //!<用户位置

@property(nonatomic,strong)UIButton *followBtn;     //!<关注列表btn
@property(nonatomic,strong)UIButton *fansBtn;       //!<粉丝列表Btn
@property(nonatomic,strong)UIButton *videoBtn;     //!<用户视频列表Btn

@property(nonatomic,strong)UILabel *followNumLab;   //!<关注数量Lab
@property(nonatomic,strong)UILabel *fansNumLab;     //!<粉丝数量Lab
@property(nonatomic,strong)UILabel *videoNumLab;    //!<视频数量Lab

@property(nonatomic,strong)UILabel *noticeLab;      //!<公告lab

@property(nonatomic,strong)UIButton *openLiveBtn;   //!<开播Btn
@property(nonatomic,strong)UIButton *publishBtn;    //!<发布Btn


@end

@implementation GALiveCenterProfileView
- (instancetype)initWithFrame:(CGRect)frame{
    if (self = [super initWithFrame:frame]) {
        [self setupUI];
    }
    return self;
}

- (void)setupUI{
    _avatarView     = UIImageView.new;
    
    _nameLab        = UILabel.new;
    _locationLab    = UILabel.new;
    _followNumLab   = UILabel.new;
    _fansNumLab     = UILabel.new;
    _videoNumLab    = UILabel.new;
    _noticeLab      = UILabel.new;
    
    [self addSubview:_avatarView];
    [self addSubview:_nameLab];
    [self addSubview:_locationLab];
    [self addSubview:_followNumLab];
    [self addSubview:_fansNumLab];
    [self addSubview:_videoNumLab];
    [self addSubview:_noticeLab];
    
    UIButton*(^createBtn)(NSString*title) = ^(NSString*title){
        UIButton *button = UIButton.new;
        
        [button setTitle:title forState:UIControlStateNormal];
        [button.titleLabel setFont:MainFontWithSize(18)];
        [button setTitleColor:UIColor.blackColor forState:UIControlStateNormal];
        [button addTarget:self action:@selector(onButtonAction:) forControlEvents:UIControlEventTouchUpInside];
        [self addSubview:button];
        
        return button;
    };
    
    _followBtn  = createBtn(@"关注");
    _fansBtn    = createBtn(@"粉丝");
    _videoBtn   = createBtn(@"视频");
    _openLiveBtn= createBtn(@"开播");
    _publishBtn = createBtn(@"发布");
    
    // setter
    [_nameLab setFont:MainBoldFontWithSize(22)];
    [_locationLab setFont:MainFontWithSize(12)];
    [_noticeLab setFont:MainFontWithSize(11)];
    
    _followNumLab.font = _fansNumLab.font = _videoNumLab.font = MainFontWithSize(13) ;
    _noticeLab.textColor = _followNumLab.textColor = _fansNumLab.textColor = _videoNumLab.textColor = RGBA(102, 102, 102, 1);
    
    _openLiveBtn.backgroundColor = _publishBtn.backgroundColor = RGBA(195, 14, 24, 1);
    _openLiveBtn.titleLabel.font = _publishBtn.titleLabel.font = MainFontWithSize(14);
    [_openLiveBtn setTitleColor:UIColor.whiteColor forState:UIControlStateNormal];
    [_publishBtn setTitleColor:UIColor.whiteColor forState:UIControlStateNormal];
    
    
    //action
    UITapGestureRecognizer *tapAvatar = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(onTapViewAction:)];
    UITapGestureRecognizer *tapUserNam= [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(onTapViewAction:)];
    [self.avatarView addGestureRecognizer:tapAvatar];
    [self.avatarView setUserInteractionEnabled:YES];
    [self.nameLab addGestureRecognizer:tapUserNam];
    
    
    [_avatarView setImage:[UIImage imageNamed:@"icon_profile_share_weibo"]];
    [_nameLab setText:@"主播名称"];
    [_locationLab setText:@"🏖 GZ"];
    _followNumLab.text = _fansNumLab.text = _videoNumLab.text = @"88";
    [_noticeLab setText:@"每晚7点，准时开播 INFO"];
    
}
- (void)layoutSubviews{
    [super layoutSubviews];
    
    CGFloat h = CGRectGetHeight(self.bounds)*(104/192.0);
    [self.avatarView mas_remakeConstraints:^(MASConstraintMaker *make) {
        make.left.top.mas_equalTo(self).insets(UIEdgeInsetsMake(25, 13, 0, 0));
        make.size.mas_equalTo(CGSizeMake(h, h));
        //[self.avatarView setupMaskWithCorner:h/2.0 rectCorner:UIRectCornerAllCorners];
    }];
    
    
    [self.nameLab mas_remakeConstraints:^(MASConstraintMaker *make) {
        make.top.mas_equalTo(self.avatarView).inset(4);
        make.left.mas_equalTo(self.avatarView.mas_right).inset(22);
        make.right.mas_equalTo(self.locationLab.mas_left).inset(10);
    }];
    
    [self.locationLab mas_remakeConstraints:^(MASConstraintMaker *make) {
        make.centerY.mas_equalTo(self.nameLab);
        make.right.mas_equalTo(self).inset(22);
    }];
    
    CGFloat leftOffset = h + 22;
    NSArray *btnArray = @[_followBtn,_fansBtn,_videoBtn];
    [btnArray mas_distributeViewsAlongAxis:MASAxisTypeHorizontal withFixedSpacing:22 leadSpacing:leftOffset tailSpacing:22];
    [btnArray mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerY.mas_equalTo(self.avatarView);
    }];
    
    CGFloat space = 2;
    [self.followNumLab mas_remakeConstraints:^(MASConstraintMaker *make) {
        make.centerX.mas_equalTo(self.followBtn);
        make.top.mas_equalTo(self.followBtn.mas_bottom).inset(space);
    }];
    [self.fansNumLab mas_remakeConstraints:^(MASConstraintMaker *make) {
        make.centerX.mas_equalTo(self.fansBtn);
        make.top.mas_equalTo(self.fansBtn.mas_bottom).inset(space);
    }];
    [self.videoNumLab mas_remakeConstraints:^(MASConstraintMaker *make) {
        make.centerX.mas_equalTo(self.videoBtn);
        make.top.mas_equalTo(self.videoBtn.mas_bottom).inset(space);
    }];
    
    [self.noticeLab mas_remakeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_equalTo(self.nameLab);
        make.right.mas_equalTo(self.locationLab);
        make.centerY.mas_equalTo(self.avatarView.mas_bottom);
        //make.top.mas_equalTo(self.avatarView.mas_bottom);
    }];
    
     CGSize size = CGSizeMake(74, 28);
    [self.openLiveBtn mas_remakeConstraints:^(MASConstraintMaker *make) {
        make.bottom.mas_equalTo(self).inset(20);
        make.right.mas_equalTo(self.mas_centerX);
        make.size.mas_equalTo(size);
    }];
    [self.publishBtn mas_remakeConstraints:^(MASConstraintMaker *make) {
        make.centerY.mas_equalTo(self.openLiveBtn);
        make.centerX.mas_equalTo(self).multipliedBy(1.5);
        make.size.mas_equalTo(size);
    }];
    
    
    CGFloat corner = size.height/2.0;
    [self.openLiveBtn.layer setCornerRadius:corner];
    [self.openLiveBtn.layer setMasksToBounds:YES];
    [self.publishBtn.layer setCornerRadius:corner];
    [self.publishBtn.layer setMasksToBounds:YES];
}

- (void)onButtonAction:(UIButton*)send{
    
    void(^sendAction)(SEL sel) = ^(SEL sel){
        if ([self.delegate respondsToSelector:sel]) {
            [self.delegate performSelector:sel];
        }
    };
    
    if (send == self.followBtn) {
        sendAction(@selector(profileViewDidClickFollowButton));
    }
    if (send == self.fansBtn) {
        sendAction(@selector(profileviewDidClickFansButton));
    }
    if (send == self.videoBtn) {
        sendAction(@selector(profileViewDidClickVideoButton));
    }
    if (send == self.openLiveBtn) {
        sendAction(@selector(profileViewDidClickOpenLiveButton));
    }
    if (send == self.publishBtn) {
        sendAction(@selector(profileViewDidClickPublishButton));
    }
    
}
- (void)onTapViewAction:(UITapGestureRecognizer*)tap{
    if (tap.view == self.avatarView) {
        if ([self.delegate respondsToSelector:@selector(profileViewDidClickAvatarView)]) {
            [self.delegate profileViewDidClickAvatarView];
        }
    }
    if (tap.view == self.nameLab) {
        if ([self.delegate respondsToSelector:@selector(profileViewDidClickUserName)]) {
            [self.delegate profileViewDidClickUserName];
        }
    }
}
@end
