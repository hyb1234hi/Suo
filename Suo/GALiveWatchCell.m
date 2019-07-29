//
//  GALiveWatchCell.m
//  Suo
//
//  Created by 怪兽 🐙 on 2019/7/27.
//  Copyright © 2019 怪兽 🐙. All rights reserved.
//

#import "GALiveWatchCell.h"

@interface GALiveWatchCell ()
@property(nonatomic,strong) UIToolbar *toolbar;
@property(nonatomic,strong) UIView *anchorView;         //!<主播信息容器
@property(nonatomic,strong) UIImageView *anchorAvatar;  //!<主播头像
@property(nonatomic,strong) UILabel *anchorName;        //!<主播名称
@property(nonatomic,strong) UILabel *anchorHot;         //!<主播人气热度

@property(nonatomic,strong) UIButton *followBtn;        //!<关注主播按钮
@property(nonatomic,strong) UIBarButtonItem *userItem1;//!<用户1
@property(nonatomic,strong) UIBarButtonItem *userItem2;//!<用户2
@end

@implementation GALiveWatchCell


- (instancetype)initWithFrame:(CGRect)frame{
    if (self = [super initWithFrame:frame]) {
        [self setupUI];
    }
    return self;
}

- (void)setupUI{
    
    UIImage *image = [UIImage imageNamed:@"icon_profile_share_qq"];
    image = [image imageWithRenderingMode:UIImageRenderingModeAlwaysOriginal];
    
    
    _toolbar = [[UIToolbar alloc] initWithFrame:CGRectMake(33, 0, ScreenWidth-33, 44)];
    
    
    //用户信息
    ({
        _anchorView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, 160, 40)];
        _anchorAvatar = UIImageView.new;
        
        _anchorName = UILabel.new;
        [_anchorName setFont:[MainFont fontWithSize:16]];
        [_anchorName setTextColor:ColorWhite];
        
        _anchorHot = UILabel.new;
        [_anchorHot setFont:[MainFont fontWithSize:14]];
        [_anchorHot setTextColor:ColorWhite];
        
        [_anchorView addSubview:_anchorAvatar];
        [_anchorView addSubview:_anchorName];
        [_anchorView addSubview:_anchorHot];
        
        [_anchorName setText:@"userName"];
        [_anchorHot setText:@"600万人气"];
        [_anchorAvatar setImage:image];
        
    });
    
    _followBtn = [[UIButton alloc] initWithFrame:CGRectMake(0, 0, 55, 30)];
    [_followBtn setTitle:@"关注" forState:UIControlStateNormal];
    [_followBtn setTitle:@"已关注" forState:UIControlStateSelected];
    [_followBtn setBackgroundColor:UIColor.redColor];
    [_followBtn setupMaskWithCorner:15 rectCorner:UIRectCornerAllCorners];
    [_followBtn.titleLabel setFont:[MainFont fontWithSize:16]];
    
    UIBarButtonItem *userItem = [[UIBarButtonItem alloc] initWithCustomView:_anchorView];
    [userItem setWidth:180];
    
    UIBarButtonItem *followItem = [[UIBarButtonItem alloc] initWithCustomView:_followBtn];
    
    _userItem1 = UIBarButtonItem.new;
    [_userItem1 setImage:image];
    
    _userItem2 = UIBarButtonItem.new;
    [_userItem2 setImage:image];
    
    [_toolbar setItems:@[userItem,followItem,_userItem1,_userItem2] animated:YES];
    [_toolbar setBackgroundImage:UIImage.new forToolbarPosition:UIBarPositionAny barMetrics:UIBarMetricsDefault];
    [_toolbar setShadowImage:UIImage.new forToolbarPosition:UIBarPositionAny];
    
    [self.contentView addSubview:_toolbar];
}


- (void)layoutSubviews{
    [super layoutSubviews];
    
    [self.toolbar mas_remakeConstraints:^(MASConstraintMaker *make) {
        make.left.top.right.mas_equalTo(self.contentView).insets(UIEdgeInsetsMake(SafeAreaTopHeight-44, 33, 0, 0));
        make.height.mas_equalTo(44);
    }];
    
    [self.anchorAvatar mas_remakeConstraints:^(MASConstraintMaker *make) {
        make.top.left.bottom.mas_equalTo(self.anchorView);
        make.width.mas_equalTo(self.anchorAvatar.mas_height);
    }];
    
    [self.anchorName mas_remakeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_equalTo(self.anchorAvatar.mas_right).inset(4);
        make.bottom.mas_equalTo(self.anchorAvatar.mas_centerY).inset(2);
    }];
    [self.anchorHot mas_remakeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_equalTo(self.anchorAvatar.mas_right).inset(4);
        make.top.mas_equalTo(self.anchorAvatar.mas_centerY).inset(2);
    }];
}


@end
