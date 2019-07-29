//
//  GACityWideCollectionCell.m
//  Suo
//
//  Created by 怪兽 🐙 on 2019/7/26.
//  Copyright © 2019 怪兽 🐙. All rights reserved.
//

#import "GACityWideCollectionCell.h"

@interface GACityWideCollectionCell ()
@property(nonatomic,strong) UIImageView *backgroundImage;
@property(nonatomic,strong) UIImageView *avatarView;
@property(nonatomic,strong) UIImageView *locationIcon;
@property(nonatomic,strong) UILabel     *distanceLab;

@property(nonatomic,strong) UIButton    *deleteBtn;


@end


@implementation GACityWideCollectionCell


- (instancetype)initWithFrame:(CGRect)frame{
    if (self = [super initWithFrame:frame]) {
        [self setupUI];
    }
    return self;
}
- (void)setupUI{
    _backgroundImage = UIImageView.new;
    _avatarView      = UIImageView.new;
    _locationIcon    = UIImageView.new;
    _distanceLab     = UILabel.new;
    _deleteBtn       = UIButton.new;
    
    [self.contentView addSubview:_backgroundImage];
    [self.contentView addSubview:_avatarView];
    [self.contentView addSubview:_locationIcon];
    [self.contentView addSubview:_distanceLab];
    [self.contentView addSubview:_deleteBtn];

    [_distanceLab setFont:[MainFont fontWithSize:14]];
    [_distanceLab setTextColor:ColorWhite];
    
    [_deleteBtn addTarget:self action:@selector(deleteAction:) forControlEvents:UIControlEventTouchUpInside];
    
    [_avatarView setImage:[UIImage imageNamed:@"微信"]];
    [_distanceLab setText:@"18.9公里"];
    [_deleteBtn setTitle:@"X" forState:UIControlStateNormal];
}

- (void)layoutSubviews{
    [super layoutSubviews];
    
    [self.backgroundImage mas_remakeConstraints:^(MASConstraintMaker *make) {
        make.edges.mas_equalTo(self.contentView);
    }];
    [self.deleteBtn mas_remakeConstraints:^(MASConstraintMaker *make) {
        make.right.top.mas_equalTo(self.contentView).insets(UIEdgeInsetsMake(13, 0, 0, 13));
        make.size.mas_equalTo(CGSizeMake(24, 24));
    }];
    
    [self.avatarView mas_remakeConstraints:^(MASConstraintMaker *make) {
        make.left.bottom.mas_equalTo(self.contentView).insets(UIEdgeInsetsMake(0, 7, 7, 0));
        make.size.mas_equalTo(CGSizeMake(35, 35));
    }];
    
    [self.distanceLab mas_remakeConstraints:^(MASConstraintMaker *make) {
        make.right.mas_equalTo(self.contentView).inset(7);
        make.centerY.mas_equalTo(self.avatarView);
    }];
    [self.locationIcon mas_remakeConstraints:^(MASConstraintMaker *make) {
        make.right.mas_equalTo(self.distanceLab.mas_left).inset(7);
        make.centerY.mas_equalTo(self.distanceLab);
    }];
}

- (void)deleteAction:(UIButton*)send{
    if ([self.delegate respondsToSelector:@selector(deleteItem:)]) {
        [self.delegate deleteItem:self];
    }
}

@end
