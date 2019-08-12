//
//  GALiveCell.m
//  Suo
//
//  Created by 怪兽 🐙 on 2019/7/27.
//  Copyright © 2019 怪兽 🐙. All rights reserved.
//

#import "GALiveCell.h"
#import "GALiveItem.h"
#import <UIImageView+WebCache.h>
#import <UIImageView+YYWebImage.h>

@interface GALiveCell ()
@property(nonatomic,strong) UIButton *state;                //!<直播状态
@property(nonatomic,strong)UILabel *watchNumLabel;          //!<观看数

@property(nonatomic,strong)UIImageView *coverImage;        //!<封面

@property(nonatomic,strong)UIImageView *avatarView;         //!<头像
@property(nonatomic,strong)UILabel *nameLabel;              //!<用户名
@property(nonatomic,strong)UIButton *likeNum;               //!<喜欢数量
@property(nonatomic,strong)UILabel *titleLabel;             //!<直播title

@end

@implementation GALiveCell
- (void)prepareForReuse{
    [super prepareForReuse];
    
    [self.coverImage setImage:nil];
}

- (instancetype)initWithFrame:(CGRect)frame{
    if (self = [super initWithFrame:frame]) {
        [self setupUI];
    }
    return self;
}

- (void)setupUI{
    _state          = UIButton.new;
    _watchNumLabel  = UILabel.new;
    _coverImage     = UIImageView.new;
    _avatarView     = UIImageView.new;
    _nameLabel      = UILabel.new;
    _likeNum        = UIButton.new;
    _titleLabel     = UILabel.new;
    

    [self.contentView addSubview:_coverImage];
    [self.contentView addSubview:_watchNumLabel];
    [self.contentView addSubview:_state];
    [self.contentView addSubview:_avatarView];
    [self.contentView addSubview:_nameLabel];
    [self.contentView addSubview:_likeNum];
    [self.contentView addSubview:_titleLabel];

    
    [_state.titleLabel setFont:[MainFont fontWithSize:10]];
    [_state setBackgroundColor:RGBA(252, 12, 23, 1)];
    [_state setTitle:@"直播ing" forState:UIControlStateNormal];
    
    [_watchNumLabel setText:@"    40万观看"];
    [_watchNumLabel setBackgroundColor:RGBA(0, 0, 0, 0.3)];
    [_watchNumLabel setTextColor:ColorWhite];
    [_watchNumLabel setFont:MainFontWithSize(10)];

    [_avatarView setImage:[UIImage imageNamed:@"icon_profile_share_wxTimeline"]];
    [_avatarView setContentMode:UIViewContentModeScaleAspectFill];
    
    [_nameLabel setTextColor:ColorWhite];
    [_nameLabel setText:@"章鱼🐙"];
    [_nameLabel setFont:MainFontWithSize(12)];
    
    [_likeNum setTitle:@"💞 4.5万" forState:UIControlStateNormal];
    [_likeNum.titleLabel setFont:MainFontWithSize(11)];
    
    [_titleLabel setFont:MainBoldFontWithSize(14)];
    [_titleLabel setTextColor:ColorWhite];
    [_titleLabel setText:@"Reveal Server started"];
    [_titleLabel setNumberOfLines:0];
    
}

-(void)layoutSubviews{
    [super layoutSubviews];
    

    [self.coverImage mas_remakeConstraints:^(MASConstraintMaker *make) {
        make.edges.mas_equalTo(0.0);
    }];
    
    [self.state mas_remakeConstraints:^(MASConstraintMaker *make) {
        make.left.top.mas_equalTo(self.contentView).insets(UIEdgeInsetsMake(11, 9, 0, 0));
        make.size.mas_equalTo(CGSizeMake(47, 17));
    }];
    [self.watchNumLabel mas_remakeConstraints:^(MASConstraintMaker *make) {
        make.centerY.mas_equalTo(self.state);
        make.height.mas_equalTo(self.state);
        make.left.mas_equalTo(self.state.mas_right).inset(-4);
    }];
    
    [self.avatarView mas_remakeConstraints:^(MASConstraintMaker *make) {
        make.left.bottom.mas_equalTo(self.contentView).insets(UIEdgeInsetsMake(0, 12, 6, 0));
        make.size.mas_equalTo(CGSizeMake(22, 22));
    }];
    
    [self.nameLabel mas_remakeConstraints:^(MASConstraintMaker *make) {
        make.centerY.mas_equalTo(self.avatarView);
        make.left.mas_equalTo(self.avatarView.mas_right).inset(5);
    }];
    
    [self.likeNum mas_remakeConstraints:^(MASConstraintMaker *make) {
        make.centerY.mas_equalTo(self.avatarView);
        make.right.bottom.mas_equalTo(self.contentView).insets(UIEdgeInsetsMake(0, 0, 11, 8));
    }];
    [self.titleLabel mas_remakeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_equalTo(self.avatarView);
        make.bottom.mas_equalTo(self.avatarView.mas_top).inset(6);
        make.right.mas_equalTo(self.contentView).inset(12);
    }];
    
    
    //CGFloat h = CGRectGetHeight(self.state.bounds);
    [self.state setupMaskWithCorner:4.0 rectCorner:UIRectCornerAllCorners];
    [self.watchNumLabel setupMaskWithCorner:3 rectCorner:UIRectCornerAllCorners];
}

- (void)setLiveItem:(GALiveItem *)liveItem{
    if (_liveItem != liveItem) {
        _liveItem = liveItem;
        
        [self.coverImage setImageURL:[NSURL URLWithString:liveItem.cover_img]];
        [self.nameLabel setText:liveItem.member_name];
        [self.titleLabel setText:liveItem.title];
        
        NSString *watch = [NSString stringWithFormat:@"   %@观看",liveItem.online_num];
        [self.watchNumLabel setText:watch];
        
        [self.avatarView setImageURL:[NSURL URLWithString:liveItem.member_avatar]];
    }
}

@end
