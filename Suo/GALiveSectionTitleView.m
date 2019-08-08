//
//  GALiveSectionTitleView.m
//  Suo
//
//  Created by ysw on 2019/8/7.
//  Copyright © 2019 怪兽 🐙. All rights reserved.
//

#import "GALiveSectionTitleView.h"

@implementation GALiveSectionTitleView
- (instancetype)initWithFrame:(CGRect)frame{
    if (self = [super initWithFrame:frame]) {
        _titleLabel = UILabel.new;
        [_titleLabel setFont:MainBoldFontWithSize(22)];
        [_titleLabel setText:@"推荐直播"];
        
        [self addSubview:_titleLabel];
        [_titleLabel mas_remakeConstraints:^(MASConstraintMaker *make) {
            make.centerY.mas_equalTo(self);
            make.left.mas_equalTo(self).inset(17);
        }];
    }
    return self;
}
@end
