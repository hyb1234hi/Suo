//
//  GALiveCenterHeaderView.m
//  Suo
//
//  Created by ysw on 2019/8/11.
//  Copyright © 2019 怪兽 🐙. All rights reserved.
//

#import "GALiveCenterHeaderView.h"

@implementation GALiveCenterHeaderView
- (instancetype)initWithFrame:(CGRect)frame{
    if (self = [super initWithFrame:frame]) {
        [self setupUI];
    }
    return self;
}
- (void)setupUI{
    _titleLabel = UILabel.new;
    _moreButton = UIButton.new;
    
    [_titleLabel setText:@"Section Name"];
    [_titleLabel setFont:MainFontWithSize(17)];
    
    [_moreButton setTitle:@" >>>" forState:UIControlStateNormal];
    [_moreButton setTitleColor:UIColor.blackColor forState:UIControlStateNormal];
    
    [self addSubview:_titleLabel];
    [self addSubview:_moreButton];
}
- (void)layoutSubviews{
    [super layoutSubviews];
    
    [self.titleLabel mas_remakeConstraints:^(MASConstraintMaker *make) {
        make.centerY.mas_equalTo(self);
        make.left.mas_equalTo(self).inset(16);
    }];
    [self.moreButton mas_remakeConstraints:^(MASConstraintMaker *make) {
        make.centerY.mas_equalTo(self);
        make.right.mas_equalTo(self).inset(16);
    }];
}
@end
