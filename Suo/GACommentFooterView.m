//
//  GACommentFooterView.m
//  Suo
//
//  Created by gajz on 2019/8/3.
//  Copyright © 2019 怪兽 🐙. All rights reserved.
//

#import "GACommentFooterView.h"

@interface GACommentFooterView()



@end

@implementation GACommentFooterView

- (instancetype)initWithReuseIdentifier:(NSString *)reuseIdentifier {
    self = [super initWithReuseIdentifier:reuseIdentifier];
    if (self) {
        [self setUI];
    }
    return self;
}

- (void)setUI {
    self.returnButton = UIButton.new;
    [self.returnButton setTitle:@"查看更多回复 >" forState:UIControlStateNormal];
    [self.returnButton setTitle:@"收回 <" forState:UIControlStateSelected];
    [self.returnButton setTitleColor:ColorBlack forState:UIControlStateNormal];
    [self.returnButton setTitleColor:ColorBlack forState:UIControlStateSelected];
    self.returnButton.titleLabel.font = [MainFont fontWithSize:13];
    [self.returnButton addTarget:self action:@selector(returnButtonClick) forControlEvents:UIControlEventTouchUpInside];
    [self.contentView addSubview:self.returnButton];
}

- (void)returnButtonClick {
    self.returnButton.selected = !self.returnButton.selected;
    if ([self.delegate respondsToSelector:@selector(commentFooterViewWithSection:withSelection:)]) {
        [self.delegate commentFooterViewWithSection:self.index withSelection:self.returnButton.selected];
    }
}

- (void)layoutSubviews {
    [super layoutSubviews];
    [self.returnButton mas_remakeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_equalTo(80);
        make.top.mas_equalTo(self.contentView);
        make.height.mas_equalTo(20);
    }];
    self.returnButton.selected = self.isSelected;
}


@end
