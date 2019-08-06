//
//  GAGoodsPushCell.m
//  Suo
//
//  Created by ysw on 2019/8/5.
//  Copyright © 2019 怪兽 🐙. All rights reserved.
//

#import "GAGoodsPushCell.h"

#import <BEMCheckBox.h>

@interface GAGoodsPushCell ()
@property(nonatomic,strong)BEMCheckBox *box;

@end

@implementation GAGoodsPushCell
- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier{
    if (self = [super initWithStyle:style reuseIdentifier:reuseIdentifier]) {
        [self setupUI];
    }
    return self;
}

- (void)setupUI{
    _box = BEMCheckBox.new;
    //[_box setBoxType:BEMBoxTypeSquare];
    [_box setFrame:CGRectMake(0, 0, 30, 30)];
    [_box setOnAnimationType:BEMAnimationTypeBounce];
    [_box setUserInteractionEnabled:NO];
    [_box setOnFillColor:_box.onTintColor];
    [_box setOnCheckColor:ColorWhite];
    
    [self.contentView addSubview:_box];
}

- (void)layoutSubviews{
    [super layoutSubviews];
    
    [self.box mas_remakeConstraints:^(MASConstraintMaker *make) {
        make.centerY.mas_equalTo(self.contentView);
        make.right.mas_equalTo(self.contentView).inset(20);
    }];
}
- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];
    
        // Configure the view for the selected state
    [_box setOn:selected animated:YES];
}

@end
