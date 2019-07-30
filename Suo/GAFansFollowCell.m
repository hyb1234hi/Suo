//
//  GAFansFollowCell.m
//  Suo
//
//  Created by ysw on 2019/7/30.
//  Copyright © 2019 怪兽 🐙. All rights reserved.
//

#import "GAFansFollowCell.h"

@interface GAFansFollowCell ()
@property(nonatomic,strong)UIButton *button;

@end

@implementation GAFansFollowCell


- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier{
    if (self = [super initWithStyle:style reuseIdentifier:reuseIdentifier]) {
        [self setupUI];
    }
    return self;
}

- (void)setupUI{
    _button = UIButton.new;
    
    UIColor *color = RGBA(233, 100, 124, 1);
    [_button.layer setBorderColor:color.CGColor];
    [_button.layer setBorderWidth:1];
    [_button setTitleColor:color forState:UIControlStateNormal];
    [_button setTitle:@"关注" forState:UIControlStateNormal];
    [_button setTitle:@"已关注" forState:UIControlStateSelected];
    
    [_button.titleLabel setFont:[MainFont fontWithSize:14]];
    [_button.layer setCornerRadius:10];
    [_button.layer setMasksToBounds:YES];
    [_button addTarget:self action:@selector(buttonAction:) forControlEvents:UIControlEventTouchUpInside];
    
    [self.contentView addSubview:_button];
}


- (void)layoutSubviews{
    [super layoutSubviews];
    
    [self.button mas_remakeConstraints:^(MASConstraintMaker *make) {
        make.centerY.mas_equalTo(self.contentView);
        make.right.mas_equalTo(self.contentView).inset(24);
        make.size.mas_equalTo(CGSizeMake(50, 20));
    }];
    //[self.button setupMaskWithCorner:10 rectCorner:UIRectCornerAllCorners];
}
- (void)awakeFromNib {
    [super awakeFromNib];
    // Initialization code
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

- (void)buttonAction:(UIButton*)send{
    [_button setSelected:!send.selected];
}

@end
