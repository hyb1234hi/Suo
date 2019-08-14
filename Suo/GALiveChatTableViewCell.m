//
//  GALiveChatTableViewCell.m
//  Suo
//
//  Created by gajz on 2019/8/5.
//  Copyright © 2019 怪兽 🐙. All rights reserved.
//

#import "GALiveChatTableViewCell.h"

@interface GALiveChatTableViewCell()

/**icon**/
@property (nonatomic, strong)UIImageView *icon;
/**name**/
@property (nonatomic, strong)UILabel *userName;
/**contentLabel**/
@property (nonatomic, strong)UILabel *content;

@end

@implementation GALiveChatTableViewCell

- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier {
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        [self setUI];
    }
    return self;
}

- (void)setUI {
    _icon = UIImageView.new;
    [self.contentView addSubview:_icon];
    
    _userName = UILabel.new;
    _userName.font = [MainFont fontWithSize:16];
    [self.contentView addSubview:_userName];
    
    _content = UILabel.new;
    _content.font = [MainFont fontWithSize:14];
    _content.textColor = UIColorFromRGB(0x808080);
    [self.contentView addSubview:_content];
    
    [_icon setImage:[UIImage imageNamed:@"微信"]];
    
    _userName.text = @"芒果🥭";
    _content.text = @"由于对方不是好友由于对方不是好友由于对方不是好友由于对方不是好友";
}

- (void)layoutSubviews {
    [super layoutSubviews];
    
    [self.icon mas_remakeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_equalTo(self.contentView).inset(22);
        make.centerY.mas_equalTo(self.contentView);
        make.size.mas_equalTo(CGSizeMake(50, 50));
    }];
    
    [self.userName mas_remakeConstraints:^(MASConstraintMaker *make) {
        make.top.mas_equalTo(self.icon);
        make.left.mas_equalTo(self.icon.mas_right).inset(8);
    }];
    
    [self.content mas_remakeConstraints:^(MASConstraintMaker *make) {
        make.top.mas_equalTo(self.userName.mas_bottom).inset(4);
        make.left.mas_equalTo(self.userName);
        make.right.mas_equalTo(self.contentView).inset(70);
    }];
}

- (void)awakeFromNib {
    [super awakeFromNib];
    // Initialization code
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end
