//
//  GAVideoPlayControllerView.m
//  Suo
//
//  Created by 怪兽 🐙 on 2019/7/26.
//  Copyright © 2019 怪兽 🐙. All rights reserved.
//

#import "GAVideoPlayControllerView.h"
#import "GACommentPopView.h"
#import "GASharePopView.h"
#import "GACommentTextView.h"


@interface GAVideoPlayControllerView ()<UITextFieldDelegate>
@property(nonatomic,strong)UIButton *writeCommentBtn;
@property(nonatomic,strong)UIButton *commentBtn;
@property(nonatomic,strong)UIButton *likeBtn;
@property(nonatomic,strong)UIButton *shareBtn;
@property(nonatomic,strong)UIStackView *rightStackView;

@property(nonatomic,strong)UILabel *musicLab;
@property(nonatomic,strong)UILabel *commentLab;
@property(nonatomic,strong)UIButton *tagButton;
@property(nonatomic,strong)UIImageView *avatarView;
@property(nonatomic,strong)UILabel *userNameLab;
@property(nonatomic,strong)UIButton *followBtn;

@end


static CGFloat avatarH = 60;
static CGFloat avatarW = 60;
@implementation GAVideoPlayControllerView

- (instancetype)initWithFrame:(CGRect)frame{
    if (self = [super initWithFrame:frame]) {
        [self setupUI];
    }
    return self;
}

- (void)setupUI{
    _writeCommentBtn = UIButton.new;
    _commentBtn = UIButton.new;
    _likeBtn = UIButton.new;
    _shareBtn = UIButton.new;
    _rightStackView = [[UIStackView alloc] initWithArrangedSubviews:@[_commentBtn,_likeBtn,_shareBtn]];
    
    _musicLab = UILabel.new;
    _commentLab = UILabel.new;
    _tagButton = UIButton.new;
    _avatarView = UIImageView.new;
    _userNameLab = UILabel.new;
    _followBtn = UIButton.new;
    
    
    //add
    [self addSubview:_writeCommentBtn];
    [self addSubview:_rightStackView];
    [self addSubview:_musicLab];
    [self addSubview:_commentLab];
    [self addSubview:_tagButton];
    [self addSubview:_avatarView];
    [self addSubview:_userNameLab];
    [self addSubview:_followBtn];
    
    
    [_rightStackView setDistribution:UIStackViewDistributionFillEqually];

    [_writeCommentBtn setBackgroundColor:RGBA(255, 255, 255, 0.45)];
    [_writeCommentBtn.titleLabel setFont:[MainFont fontWithSize:15]];
    //[_writeCommentBtn setupMaskWithCorner:10 rectCorner:UIRectCornerAllCorners];
    
    UIFont *font = [MainFont fontWithSize:14];
    [_commentBtn.titleLabel setFont:font];
    [_likeBtn.titleLabel setFont:font];
    [_shareBtn.titleLabel setFont:font];
    
   // [_avatarView setupMaskWithCorner:avatarH/2.0 rectCorner:UIRectCornerAllCorners];
    
    [_musicLab setTextColor:ColorWhite];
    [_musicLab setFont:[MainFont fontWithSize:14]];
    [_commentLab setFont:[MainFont fontWithSize:14]];
    [_commentLab setTextColor:ColorWhite];
    
    [_userNameLab setTextColor:ColorWhite];
    [_userNameLab setFont:[MainBoldFont fontWithSize:22]];
    
    [_followBtn setTitle:@"关注" forState:UIControlStateNormal];
    [_followBtn setTitle:@"已关注" forState:UIControlStateSelected];
    [_followBtn.titleLabel setFont:[MainFont fontWithSize:14]];
    [_followBtn setBackgroundColor:RGBA(255, 23, 45, 1)];
    
    
    [_commentLab setFont:[MainFont fontWithSize:15]];
    
    [_tagButton setBackgroundColor:RGBA(255, 255, 255, 0.45)];
    [_tagButton.titleLabel setFont:[MainFont fontWithSize:15]];
    
    [_writeCommentBtn setTitle:@"说点什么" forState:UIControlStateNormal];
    [_commentBtn setTitle:@"2563" forState:UIControlStateNormal];
    [_likeBtn setTitle:@"1W" forState:UIControlStateNormal];
    [_shareBtn setTitle:@"7K" forState:UIControlStateNormal];
    
    [_musicLab setText:@"晴天"];
    [_commentLab setText:@"66666"];
    [_tagButton setTitle:@" # music" forState:UIControlStateNormal];
    [_userNameLab setText:@"滑板鞋"];
    [_avatarView setImage:[UIImage imageNamed:@"微信"]];
    
    
    UIControlEvents events = UIControlEventTouchUpInside;
    [_followBtn addTarget:self action:@selector(followAction:) forControlEvents:events];
    [_writeCommentBtn addTarget:self action:@selector(writeCommentAction:) forControlEvents:events];
    [_commentBtn addTarget:self action:@selector(commentAction:) forControlEvents:events];
    [_likeBtn addTarget:self action:@selector(likeAction:) forControlEvents:events];
    [_shareBtn addTarget:self action:@selector(shareAction:) forControlEvents:events];
    

}

- (void)layoutSubviews{
    [super layoutSubviews];
    
    [self.writeCommentBtn mas_remakeConstraints:^(MASConstraintMaker *make) {
        make.left.bottom.mas_equalTo(self).insets(UIEdgeInsetsMake(0, 25, 23, 0));
        make.width.mas_equalTo(145);
    }];
    [self.rightStackView mas_remakeConstraints:^(MASConstraintMaker *make) {
        make.centerY.mas_equalTo(self.writeCommentBtn);
        make.left.mas_equalTo(self.writeCommentBtn.mas_right);
        make.right.mas_equalTo(self);
    }];
    
    [self.musicLab mas_remakeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_equalTo(self.writeCommentBtn);
        make.bottom.mas_equalTo(self.writeCommentBtn.mas_top).inset(15);
    }];
    [self.commentLab mas_remakeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_equalTo(self.writeCommentBtn);
        make.bottom.mas_equalTo(self.musicLab.mas_top).inset(15);
    }];
    [self.tagButton mas_remakeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_equalTo(self.writeCommentBtn);
        make.bottom.mas_equalTo(self.commentLab.mas_top).inset(15);
        make.size.mas_equalTo(CGSizeMake(80, 35));
    }];
    [self.avatarView mas_remakeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_equalTo(self.writeCommentBtn);
        make.bottom.mas_equalTo(self.tagButton.mas_top).inset(15);
        make.size.mas_equalTo(CGSizeMake(avatarW, avatarH));
    }];
    [self.userNameLab mas_remakeConstraints:^(MASConstraintMaker *make) {
        make.centerY.mas_equalTo(self.avatarView);
        make.left.mas_equalTo(self.avatarView.mas_right).inset(16);
    }];
    [self.followBtn mas_remakeConstraints:^(MASConstraintMaker *make) {
        make.centerY.mas_equalTo(self.avatarView);
        make.left.mas_equalTo(self.userNameLab.mas_right).inset(30);
        make.size.mas_equalTo(CGSizeMake(60, 30));
    }];
    
    CGFloat corner = CGRectGetHeight(self.writeCommentBtn.bounds)/2.0;
    [_writeCommentBtn setupMaskWithCorner:corner rectCorner:UIRectCornerAllCorners];
    
    corner = CGRectGetHeight(self.followBtn.bounds)/2.0;
    [self.followBtn setupMaskWithCorner:corner rectCorner:UIRectCornerAllCorners];
    
    corner = CGRectGetHeight(self.followBtn.bounds)/2.0;
    [self.tagButton setupMaskWithCorner:corner rectCorner:UIRectCornerAllCorners];
    

}


- (void)followAction:(UIButton*)send{
    [send setSelected:!send.selected];
}

- (void)writeCommentAction:(UIButton*)send{
    GACommentTextView *comnentText = [GACommentTextView new];
    [comnentText show];
}
- (void)commentAction:(UIButton*)send{
    GACommentPopView *comment = [GACommentPopView new];
    [comment show];
}

- (void)likeAction:(UIButton*)send{
    
}
- (void)shareAction:(UIButton*)send{
    [GASharePopView.new show];
}

-(BOOL)textFieldShouldBeginEditing:(UITextField *)textField{
    return YES;
}
@end
