//
//  GAVideoCell.m
//  Suo
//
//  Created by 怪兽 🐙 on 2019/7/26.
//  Copyright © 2019 怪兽 🐙. All rights reserved.
//

#import "GAVideoCell.h"


static CGFloat avatarW = 32.0;
static CGFloat avatarH = 32.0;

@interface GAVideoCell ()
@property(nonatomic,strong) UIImageView *videoCover;    //!<视频封面
@property(nonatomic,strong) UIImageView *avatarView;    //!<头像
@property(nonatomic,strong) UIButton    *followBtn;     //!<关注按钮
@property(nonatomic,strong) UILabel     *titleLabel;    //!<视频标题
@end

@implementation GAVideoCell
- (instancetype)initWithFrame:(CGRect)frame{
    if (self = [super initWithFrame:frame]) {
        [self setupUI];
    }
    return self;
}

- (void)setupUI{
    _videoCover = UIImageView.new;
    _avatarView = UIImageView.new;
    _followBtn  = UIButton.new;
    _titleLabel = UILabel.new;
    
    [self.contentView addSubview:_videoCover];
    [self.contentView addSubview:_avatarView];
    [self.contentView addSubview:_followBtn];
    [self.contentView addSubview:_titleLabel];
    
    
    [_followBtn.titleLabel setFont:[MainFont fontWithSize:14.0]];
    
    [_titleLabel setNumberOfLines:0];
    [_titleLabel setFont:MainBoldFont];
    [_titleLabel setTextColor:ColorWhite];
    
    [_titleLabel setText:@"LookinServer Connected  successfully on 127.0.0.1:47164"];
    [_followBtn setTitle:@"7.6W关注" forState:UIControlStateNormal];
    
   
    [_avatarView setImage:[UIImage imageNamed:@"微信"]];
   // [_avatarView setupMaskWithCorner:avatarH/2.0 rectCorner:UIRectCornerAllCorners];
    
        //action
    UITapGestureRecognizer *tap = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(clickAvatar:)];
    [_avatarView setUserInteractionEnabled:YES];
    [_avatarView addGestureRecognizer:tap];
}

- (void)layoutSubviews{
    [super layoutSubviews];
    
    [self.videoCover mas_remakeConstraints:^(MASConstraintMaker *make) {
        make.edges.mas_equalTo(self.contentView);
    }];
    
    [self.avatarView mas_remakeConstraints:^(MASConstraintMaker *make) {
        make.left.bottom.mas_equalTo(self.contentView).insets(UIEdgeInsetsMake(0, 10, 15, 0));
        make.size.mas_equalTo(CGSizeMake(avatarW, avatarH));
    }];
    [self.followBtn mas_remakeConstraints:^(MASConstraintMaker *make) {
        make.centerY.mas_equalTo(self.avatarView);
        make.left.mas_equalTo(self.avatarView.mas_right).inset(66);
    }];
    [self.titleLabel mas_remakeConstraints:^(MASConstraintMaker *make) {
        make.left.right.mas_equalTo(self.contentView);
        make.bottom.mas_equalTo(self.avatarView.mas_top).inset(6);
    }];
}

- (void)clickAvatar:(UITapGestureRecognizer*)tap{
    if ([self.delegate respondsToSelector:@selector(cellDidClickAvatar:)]) {
        [self.delegate cellDidClickAvatar:self];
    }
}
@end
