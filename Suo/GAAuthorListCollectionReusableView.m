//
//  GAAuthorListCollectionReusableView.m
//  Suo
//
//  Created by gajz on 2019/8/4.
//  Copyright © 2019 怪兽 🐙. All rights reserved.
//

#import "GAAuthorListCollectionReusableView.h"

@interface GAAuthorListCollectionReusableView()

@property (nonatomic, strong)UILabel *titleLabel;
@property (nonatomic, strong)UIImageView *icon;

@end

@implementation GAAuthorListCollectionReusableView

- (instancetype)initWithFrame:(CGRect)frame {
    self = [super initWithFrame:frame];
    if (self) {
        [self setUI];
    }
    return self;
}

- (void)setUI {
    _titleLabel = UILabel.new;
    _titleLabel.textColor = UIColorFromRGB(0x404040);
    _titleLabel.font = [MainFont fontWithSize:14];
    _titleLabel.text = self.content;
    [self addSubview:_titleLabel];
    
    _icon = UIImageView.new;
    [_icon setImage:[UIImage imageNamed:@"微信"]];
    [self addSubview:_icon];
    
}

- (void)setContent:(NSString *)content {
    _content = content;
    self.titleLabel.text = content;
}

- (void)layoutSubviews {
    [super layoutSubviews];
    [self.titleLabel mas_remakeConstraints:^(MASConstraintMaker *make) {
        make.top.mas_equalTo(10);
        make.left.mas_equalTo(8);
    }];
    [self.icon mas_remakeConstraints:^(MASConstraintMaker *make) {
        make.centerY.mas_equalTo(self.titleLabel);
        make.right.mas_equalTo(self);
    }];
}


@end
