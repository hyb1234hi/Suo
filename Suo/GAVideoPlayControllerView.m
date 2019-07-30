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
    
    
    UILabel*(^createLabel)(NSString *text) = ^(NSString*text){
        UILabel *label = UILabel.new;
        [label setText:text];
        [label setTextColor:ColorWhite];
        [label setFont:[MainFont fontWithSize:14]];
        [self addSubview:label];
        return label;
    };
    
    UIButton*(^createButton)(SEL ,NSString*) = ^(SEL sel, NSString *title){
        UIButton *button = UIButton.new;
        [button addTarget:self action:sel forControlEvents:UIControlEventTouchUpInside];
        [button setTitle:title forState:UIControlStateNormal];
        
        return button;
    };
    
    //右边栈视图
    _commentBtn     = createButton(@selector(commentAction:),@"6590");
    _likeBtn        = createButton(@selector(likeAction:),@"700");
    _shareBtn       = createButton(@selector(shareAction:),@"900");
    _rightStackView = [[UIStackView alloc] initWithArrangedSubviews:@[_commentBtn,_likeBtn,_shareBtn]];
    [_rightStackView setDistribution:UIStackViewDistributionFillEqually];
    

    _writeCommentBtn = createButton(@selector(writeCommentAction:),@"说点什么");
    [_writeCommentBtn setBackgroundColor:RGBA(255, 255, 255, 0.45)];
    [_writeCommentBtn.titleLabel setFont:[MainFont fontWithSize:15]];
    
    _followBtn      = createButton(@selector(followAction:),@"关注");
    [_followBtn setTitle:@"已关注" forState:UIControlStateSelected];
    [_followBtn.titleLabel setFont:[MainFont fontWithSize:14]];
    [_followBtn setBackgroundColor:RGBA(255, 23, 45, 1)];
    
    _tagButton = createButton(@selector(tagAction:),@"# 音乐");
    [_tagButton setBackgroundColor:RGBA(255, 255, 255, 0.45)];
    [_tagButton.titleLabel setFont:[MainFont fontWithSize:15]];

    
    _avatarView = UIImageView.new;
    [_avatarView setImage:[UIImage imageNamed:@"微信"]];
    [_avatarView setUserInteractionEnabled:YES];
    UITapGestureRecognizer *tap = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(clickUser)];
    [_avatarView addGestureRecognizer:tap];
    
   
    _musicLab = createLabel(@"🎵 宠爱");

    _commentLab = createLabel(@"66666666");
    [_commentLab setFont:[MainFont fontWithSize:15]];
    
    _userNameLab = createLabel(@"滑板鞋");
    [_userNameLab setFont:[MainBoldFont fontWithSize:22]];
    [_userNameLab setUserInteractionEnabled:YES];
    UITapGestureRecognizer *tapName = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(clickUser)];
    [_userNameLab addGestureRecognizer:tapName];
    
    
    //add
    [self addSubview:_writeCommentBtn];
    [self addSubview:_rightStackView];

    [self addSubview:_tagButton];
    [self addSubview:_avatarView];
    [self addSubview:_followBtn];
    
    
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

- (void)clickUser{
    if ([self.delegate respondsToSelector:@selector(viewDidClickUser)]) {
        [self.delegate viewDidClickUser];
    }
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

- (void)tagAction:(UIButton*)send{
    
}

-(BOOL)textFieldShouldBeginEditing:(UITextField *)textField{
    return YES;
}
@end
