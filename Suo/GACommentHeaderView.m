//
//  GACommentHeaderView.m
//  Suo
//
//  Created by gajz on 2019/8/2.
//  Copyright © 2019 怪兽 🐙. All rights reserved.
//

#import "GACommentHeaderView.h"

@interface GACommentHeaderView()

@property(nonatomic,strong)UIImageView *avatarView; //!<评论用户头像
@property(nonatomic,strong)UILabel *userNameLab;    //!<评论用户
@property(nonatomic,strong)UILabel *contentLab;     //!<评论内容

@end

static CGFloat avatarH = 50;
static CGFloat avatarW = 50;
@implementation GACommentHeaderView

- (instancetype)initWithReuseIdentifier:(NSString *)reuseIdentifier {
    self = [super initWithReuseIdentifier:reuseIdentifier];
    if (self) {
        [self setUI];
    }
    return self;
}

- (void)setUI {
    self.backgroundColor = ColorWhite;
    _avatarView     = UIImageView.new;
    _userNameLab    = UILabel.new;
    _contentLab     = UILabel.new;
    
    [self.contentView addSubview:_avatarView];
    [self.contentView addSubview:_userNameLab];
    [self.contentView addSubview:_contentLab];
    
    [_userNameLab setTextColor:ColorGray];
    [_userNameLab setFont:[MainFont fontWithSize:14]];
    
    [_contentLab setFont:[MainFont fontWithSize:15]];
    [_contentLab setNumberOfLines:2];
    
    [_userNameLab setText:@"时代峰峻看"];
    [_contentLab setText:@"内容回复"];
    UIImage *image = [UIImage imageNamed:@"微信"];
    [_avatarView setImage:image];
}

- (void)layoutSubviews{
    [super layoutSubviews];
    
    [self.avatarView mas_remakeConstraints:^(MASConstraintMaker *make) {
        make.left.top.mas_equalTo(self.contentView).insets(UIEdgeInsetsMake(11, 16, 0, 0));
        make.size.mas_equalTo(CGSizeMake(avatarW,avatarH));
    }];
    [self.userNameLab mas_remakeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_equalTo(self.avatarView.mas_right).inset(14);
        make.top.mas_equalTo(self.avatarView);
        //make.bottom.mas_equalTo(self.avatarView.mas_centerY).inset(2);
    }];
    [self.contentLab mas_remakeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_equalTo(self.userNameLab);
        make.top.mas_equalTo(self.userNameLab.mas_bottom).inset(8);
        make.right.mas_equalTo(self.contentView).inset(16);
    }];
   
    
    // [_avatarView setupMaskWithCorner:avatarH/2.0 rectCorner:UIRectCornerAllCorners];
}


@end
