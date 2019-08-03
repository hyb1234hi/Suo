//
//  GACommentDetailTableViewCell.m
//  Suo
//
//  Created by gajz on 2019/8/3.
//  Copyright © 2019 怪兽 🐙. All rights reserved.
//

#import "GACommentDetailTableViewCell.h"

@interface GACommentDetailTableViewCell()

@property (nonatomic, strong)UILabel *contentLabel;

@end

@implementation GACommentDetailTableViewCell

- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier{
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        [self setUI];
    }
    return self;
}

- (void)setUI {
    self.contentLabel = UILabel.new;
    self.contentLabel.font = [UIFont systemFontOfSize:13];
    self.contentLabel.text = @"WebKit.NetworkingWebKit.Networking.WebKit.Networking.WebKit.Networking.WebKit.Networking";
    self.contentLabel.numberOfLines = 0;
    [self.contentView addSubview:self.contentLabel];
}

- (void)layoutSubviews {
    [super layoutSubviews];
    
    [self.contentLabel mas_remakeConstraints:^(MASConstraintMaker *make) {
        make.top.left.bottom.right.mas_equalTo(self.contentView).insets(UIEdgeInsetsMake(3, 80, 3, 16));
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
