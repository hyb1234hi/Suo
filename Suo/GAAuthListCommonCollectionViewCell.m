//
//  GAAuthListCommonCollectionViewCell.m
//  Suo
//
//  Created by gajz on 2019/8/4.
//  Copyright © 2019 怪兽 🐙. All rights reserved.
//

#import "GAAuthListCommonCollectionViewCell.h"

@interface GAAuthListCommonCollectionViewCell()

@property (nonatomic, strong)UIView *shadowView;
@property (nonatomic, strong)UILabel *days;
@property (nonatomic, strong)UIImageView *icon;

@end

@implementation GAAuthListCommonCollectionViewCell

- (instancetype)initWithFrame:(CGRect)frame {
    self = [super initWithFrame:frame];
    if (self) {
        [self setUI];
    }
    return self;
}

- (void)setUI {
    
    _shadowView = UIView.new;
    _shadowView.backgroundColor = ColorGray;
    [self.contentView addSubview:_shadowView];
    _shadowView.layer.cornerRadius = 20;
    _days = UILabel.new;
    _days.font = [MainFont fontWithSize:14];
    _days.numberOfLines = 2;
    _days.textColor = ColorGray;
    [self.shadowView addSubview:_days];
    _icon = UIImageView.new;
    [_icon setImage:[UIImage imageNamed:@"微信"]];
    _icon.layer.cornerRadius = 20;
    [self.contentView addSubview:_icon];
}

- (void)setDayNums:(NSString *)dayNums {
    _dayNums = dayNums;
    self.days.text = dayNums;
}

- (void)setIsImage:(BOOL)isImage {
    _isImage = isImage;
    if (isImage) {
        _shadowView.hidden = YES;
        _icon.hidden = NO;
    }else {
        _shadowView.hidden = NO;
        _icon.hidden = YES;
    }
}


- (void)layoutSubviews {
    [super layoutSubviews];
    [self.shadowView mas_remakeConstraints:^(MASConstraintMaker *make) {
        make.edges.mas_equalTo(self.contentView);
    }];
    [self.days mas_remakeConstraints:^(MASConstraintMaker *make) {
        make.edges.mas_equalTo(self.shadowView);
    }];
    [self.icon mas_remakeConstraints:^(MASConstraintMaker *make) {
        make.edges.mas_equalTo(self.contentView);
    }];
}

@end
