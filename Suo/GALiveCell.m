//
//  GALiveCell.m
//  Suo
//
//  Created by 怪兽 🐙 on 2019/7/27.
//  Copyright © 2019 怪兽 🐙. All rights reserved.
//

#import "GALiveCell.h"

@interface GALiveCell ()
@property(nonatomic,strong) UIButton *state;                //!<直播状态

@property(nonatomic,strong) UIImageView *backgroundImage;   //!<背景
@property(nonatomic,strong) UIImageView *coverImage;        //!<封面

@property(nonatomic,strong) UIImageView *locationIcon;      //!<位置图标
@property(nonatomic,strong) UILabel *locationLab;              //!<位置（市区）
@property(nonatomic,strong) UILabel *titleLab;              //!<直播主题
@property(nonatomic,strong) UILabel *watchLab;              //!<观看人数
@end

@implementation GALiveCell


- (instancetype)initWithFrame:(CGRect)frame{
    if (self = [super initWithFrame:frame]) {
        [self setupUI];
    }
    return self;
}

- (void)setupUI{
    _state = UIButton.new;
    
    _backgroundImage = UIImageView.new;
    _coverImage     = UIImageView.new;
    _locationIcon   = UIImageView.new;
    
    _locationLab = UILabel.new;
    _titleLab    = UILabel.new;
    _watchLab    = UILabel.new;
    
    
    [self.contentView addSubview:_backgroundImage];
    [self.contentView addSubview:_coverImage];
    
    [self.contentView addSubview:_state];
    [self.contentView addSubview:_locationIcon];
    [self.contentView addSubview:_locationLab];
    [self.contentView addSubview:_titleLab];
    [self.contentView addSubview:_watchLab];
    
    [_locationLab setFont:[MainFont fontWithSize:14]];
    [_titleLab setFont:[MainBoldFont fontWithSize:20]];
    [_watchLab setFont:[MainFont fontWithSize:16]];
    
    [_backgroundImage setBackgroundColor:UIColor.grayColor];
    [_coverImage setBackgroundColor:UIColor.yellowColor];
    
    [_state.titleLabel setFont:[MainFont fontWithSize:14]];
    [_state setBackgroundColor:RGBA(255, 255, 255, 0.3)];
    
    [_state setTitle:@"直播ing" forState:UIControlStateNormal];
    [_locationIcon setBackgroundColor:UIColor.greenColor];
    [_locationLab setText:@"广州"];
    [_titleLab setText:@"Codeing"];
    [_watchLab setText:@"1人"];
}

-(void)layoutSubviews{
    [super layoutSubviews];
    
    [self.backgroundImage mas_remakeConstraints:^(MASConstraintMaker *make) {
        make.edges.mas_equalTo(self.contentView);
    }];
    [self.coverImage mas_remakeConstraints:^(MASConstraintMaker *make) {
        make.right.bottom.mas_equalTo(self.contentView);
        make.top.mas_equalTo(self.contentView).inset(66);
        make.width.mas_equalTo(ScreenWidth/2.0);
    }];
    
    [self.state mas_remakeConstraints:^(MASConstraintMaker *make) {
        make.right.top.mas_equalTo(self.contentView).insets(UIEdgeInsetsMake(16, 0, 0, 16));
        make.size.mas_equalTo(CGSizeMake(60, 20));
    }];
    
    [self.watchLab mas_remakeConstraints:^(MASConstraintMaker *make) {
        make.left.bottom.mas_equalTo(self.contentView).insets(UIEdgeInsetsMake(0, 16, 10, 0));
    }];
    [self.titleLab mas_remakeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_equalTo(self.watchLab);
        make.bottom.mas_equalTo(self.watchLab.mas_top).inset(4);
    }];
    [self.locationIcon mas_remakeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_equalTo(self.titleLab);
        make.bottom.mas_equalTo(self.titleLab.mas_top).inset(4);
        make.size.mas_equalTo(CGSizeMake(24, 24));
    }];
    [self.locationLab mas_remakeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_equalTo(self.locationIcon.mas_right).inset(4);
        make.centerY.mas_equalTo(self.locationIcon);
    }];
    
    CGFloat h = CGRectGetHeight(self.state.bounds);
    [self.state setupMaskWithCorner:h/2.0 rectCorner:UIRectCornerAllCorners];
}

@end
