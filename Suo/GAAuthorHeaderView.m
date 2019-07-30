//
//  GAAuthorHeaderView.m
//  Suo
//
//  Created by ysw on 2019/7/30.
//  Copyright © 2019 怪兽 🐙. All rights reserved.
//

#import "GAAuthorHeaderView.h"


@interface GAAuthorHeaderView ()
@property(nonatomic,strong)UIImageView *avatarView;  //!<头像

@property(nonatomic,strong)UIStackView *stackView;  //粉丝数量等按钮容器
@property(nonatomic,strong)UIButton *fansListBtn;   //!<粉丝列表按钮
@property(nonatomic,strong)UIButton *followListBtn; //!<关注列表按钮
@property(nonatomic,strong)UIButton *hotListBtn;    //!<热度按钮

@property(nonatomic,strong)UIButton *followBtn;     //!<关注按钮



@end

@implementation GAAuthorHeaderView

- (instancetype)initWithFrame:(CGRect)frame{
    if (self = [super initWithFrame:frame]) {
        [self setupUI];
    }
    return self;
}

- (void)setupUI{
    
    //创建相同样式的btn
    UIButton*(^createListBtn)(NSString*) = ^(NSString*title){
        UIButton *button = UIButton.new;
        [button setTitle:title forState:UIControlStateNormal];
        [button setTitleColor:ColorBlack forState:UIControlStateNormal];
        [button.titleLabel setFont:[MainFont fontWithSize:16]];
        return button;
    };
    
    _avatarView = UIImageView.new;
    _fansListBtn = createListBtn(@"7W粉丝");
    _followListBtn = createListBtn(@"500关注");
    _hotListBtn = createListBtn(@"4万火力");
    _followBtn = UIButton.new;
    
    _stackView = [[UIStackView alloc] initWithArrangedSubviews:@[_fansListBtn,_followListBtn,_hotListBtn]];
    [_stackView setAxis:UILayoutConstraintAxisHorizontal];
    [_stackView setDistribution:UIStackViewDistributionFillEqually];
    
    [self addSubview:_avatarView];
    [self addSubview:_stackView];
    [self addSubview:_followBtn];
    
    [_avatarView setImage:[UIImage imageNamed:@"icon_profile_share_wxTimeline"]];

    [_followBtn setTitle:@"关注" forState:UIControlStateNormal];
    [_followBtn setBackgroundColor:RGBA(255, 23, 45, 1)];
    
    //action
    UITapGestureRecognizer *tap = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(avatarClick:)];
    [_avatarView setUserInteractionEnabled:YES];
    [_avatarView addGestureRecognizer:tap];
    
    UIControlEvents events = UIControlEventTouchUpInside ;
    [_fansListBtn addTarget:self action:@selector(fansList:) forControlEvents:events];
    [_followListBtn addTarget:self action:@selector(followList:) forControlEvents:events];
    [_hotListBtn addTarget:self action:@selector(hot:) forControlEvents:events];
    [_followBtn addTarget:self action:@selector(followAuthor:) forControlEvents:events];
}

- (void)layoutSubviews{
    [super layoutSubviews];
    
    [self.avatarView mas_remakeConstraints:^(MASConstraintMaker *make) {
        make.top.left.mas_equalTo(self).insets(UIEdgeInsetsMake(11, 15, 0, 0));
        make.size.mas_equalTo(CGSizeMake(75, 75));
    }];
    
    [self.stackView mas_remakeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_equalTo(self.avatarView.mas_right).inset(20);
        make.right.mas_equalTo(self).inset(15);
        make.bottom.mas_equalTo(self.avatarView.mas_centerY);
        make.height.mas_equalTo(44);
    }];
    
    [self.followBtn mas_remakeConstraints:^(MASConstraintMaker *make) {
        make.size.mas_equalTo(CGSizeMake(210, 30));
        make.left.mas_equalTo(self.avatarView.mas_right).inset(20);
        make.top.mas_equalTo(self.avatarView.mas_centerY).inset(10);
    }];
    [self.followBtn setupMaskWithCorner:4 rectCorner:UIRectCornerAllCorners];
}

//Action
- (void)fansList:(UIButton*)send{
    if ([self.delegate respondsToSelector:@selector(headerViewFansListClick:)]) {
        [self.delegate headerViewFansListClick:self];
    }
}
- (void)followList:(UIButton*)send{
    if ([self.delegate respondsToSelector:@selector(headerViewFollowListClick:)]) {
        [self.delegate headerViewFollowListClick:self];
    }
}
- (void)hot:(UIButton*)send{
    if ([self.delegate respondsToSelector:@selector(headerViewHotClick:)]) {
        [self.delegate headerViewHotClick:self];
    }
}
- (void)followAuthor:(UIButton*)send{
    if ([self.delegate respondsToSelector:@selector(headerViewFollowAuthorClick:)]) {
        [self.delegate headerViewFollowAuthorClick:self];
    }
}
- (void)avatarClick:(UITapGestureRecognizer*)tap{
    if ([self.delegate respondsToSelector:@selector(headerViewAvatarClick:)]) {
        [self.delegate headerViewAvatarClick:self];
    }
}
@end
