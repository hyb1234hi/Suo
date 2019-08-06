//
//  GATalkingMineTableViewCell.m
//  Suo
//
//  Created by gajz on 2019/8/5.
//  Copyright © 2019 怪兽 🐙. All rights reserved.
//

#import "GATalkingMineTableViewCell.h"

@interface GATalkingMineTableViewCell()

/**icon**/
@property (nonatomic, strong)UIImageView *icon;
/**talking内容**/
@property (nonatomic, strong)UILabel *talkingLabel;
/**talking容器**/
@property (nonatomic, strong)UIView *talkingView;

@end

@implementation GATalkingMineTableViewCell

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
    
    _talkingView = UIView.new;
    _talkingView.backgroundColor = UIColorFromRGB(0xf0f0f0);
    _talkingView.layer.cornerRadius = 8;
    [self.contentView addSubview:_talkingView];
    
    _talkingLabel = UILabel.new;
    _talkingLabel.font = [MainFont fontWithSize:16];
    _talkingLabel.numberOfLines = 0;
    [self.talkingView addSubview:_talkingLabel];
    
    [self.icon setImage:[UIImage imageNamed:@"微信"]];
    
    self.talkingLabel.text = @"保护我方小卤蛋。保护我方小卤蛋。保护我方小卤蛋。保护我方小卤蛋。保护我方小卤蛋。";
}

- (void)layoutSubviews {
    [super layoutSubviews];
    
    [self.icon mas_remakeConstraints:^(MASConstraintMaker *make) {
        make.right.mas_equalTo(self.contentView).inset(24);
        make.top.mas_equalTo(self.contentView).inset(5);
        make.size.mas_equalTo(CGSizeMake(50, 50));
    }];
    
    [self.talkingView mas_remakeConstraints:^(MASConstraintMaker *make) {
        make.top.mas_equalTo(self.icon);
        make.right.mas_equalTo(self.icon.mas_left).inset(10);
        make.left.greaterThanOrEqualTo(self.contentView.mas_left).inset(80);
        make.bottom.greaterThanOrEqualTo(self.contentView.mas_bottom).inset(10);
    }];
    [self.talkingLabel mas_remakeConstraints:^(MASConstraintMaker *make) {
        make.top.mas_equalTo(self.talkingView).inset(8);
        make.right.mas_equalTo(self.talkingView).inset(10);
        make.left.mas_equalTo(self.talkingView).inset(10);
        make.bottom.mas_equalTo(self.talkingView).inset(8);
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
