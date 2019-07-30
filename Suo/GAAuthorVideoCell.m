//
//  GAAuthorVideoCell.m
//  Suo
//
//  Created by ysw on 2019/7/30.
//  Copyright © 2019 怪兽 🐙. All rights reserved.
//

#import "GAAuthorVideoCell.h"


@interface GAAuthorVideoCell ()
@property(nonatomic,strong)UIImageView *videoCover; //!<封面
@property(nonatomic,strong)UIButton *loveButton;    //!<喜欢数量按钮

@end

@implementation GAAuthorVideoCell


- (instancetype)initWithFrame:(CGRect)frame{
    if (self = [super initWithFrame:frame]) {
        [self setupUI];
    }
    return self;
}
- (void)setupUI{

    _videoCover = UIImageView.new ;
    _loveButton = UIButton.new;
    [_loveButton setTitle:@"❤️ 800" forState:UIControlStateNormal];
    [_loveButton .titleLabel setFont:[MainFont fontWithSize:14]];
    
    
    [self.contentView addSubview:_videoCover];
    [self.contentView addSubview:_loveButton];
}


- (void)layoutSubviews{
    [super layoutSubviews];
    
    [_videoCover mas_remakeConstraints:^(MASConstraintMaker *make) {
        make.edges.mas_equalTo(self.contentView);
    }];
    [self.loveButton mas_remakeConstraints:^(MASConstraintMaker *make) {
        make.right.bottom.mas_equalTo(self.contentView).insets(UIEdgeInsetsMake(0, 0, 2, 5));
    }];
}
@end
