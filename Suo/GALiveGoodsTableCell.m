//
//  GALiveGoodsTableCell.m
//  Suo
//
//  Created by ysw on 2019/8/12.
//  Copyright © 2019 怪兽 🐙. All rights reserved.
//

#import "GALiveGoodsTableCell.h"

#import <BEMCheckBox.h>
#import <UIImageView+WebCache.h>

@interface GALiveGoodsTableCell ()
@property(nonatomic,strong)UIImageView *goodsImageView;
@property(nonatomic,strong)UILabel *nameLabel;
@property(nonatomic,strong)UILabel *priceLabel;
@property(nonatomic,strong)UILabel *infoLabel;
@property(nonatomic,strong)BEMCheckBox *box;

@end

@implementation GALiveGoodsTableCell

- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier{
    if (self  = [super initWithStyle:style reuseIdentifier:reuseIdentifier]) {
        [self setupUI];
    }
    return self;
}



- (void)setupUI{
    _goodsImageView = UIImageView.new;
    _nameLabel      = UILabel.new;
    _priceLabel     = UILabel.new;
    _infoLabel      = UILabel.new;
    _box            = BEMCheckBox.new;
    
    [_box setUserInteractionEnabled:NO];
    [_box setOffAnimationType:BEMAnimationTypeBounce];
    [_box setOnAnimationType:BEMAnimationTypeBounce];
    [_box setOnFillColor:_box.onTintColor];
    [_box setOnTintColor:UIColor.whiteColor];
    [_box setOnCheckColor:UIColor.whiteColor];
    
    
    [_nameLabel setFont:MainBoldFontWithSize(19)];
    
    [_priceLabel setFont:MainFontWithSize(15)];
    [_priceLabel setTextColor:UIColor.grayColor];
    
    [_infoLabel setFont:MainFontWithSize(14)];
    [_infoLabel setTextColor:UIColor.grayColor];
    
    [self.contentView addSubview:_goodsImageView];
    [self.contentView addSubview:_nameLabel];
    [self.contentView addSubview:_priceLabel];
    [self.contentView addSubview:_infoLabel];
    [self.contentView addSubview:_box];
}
- (void)layoutSubviews{
    [super layoutSubviews];
    
    [self.box mas_remakeConstraints:^(MASConstraintMaker *make) {
        make.centerY.mas_equalTo(self.contentView);
        make.left.mas_equalTo(self.contentView).inset(16);
        make.size.mas_equalTo(CGSizeMake(30, 30));
    }];
    
    [self.goodsImageView mas_remakeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_equalTo(self.box.mas_right).inset(20);
        make.top.bottom.mas_equalTo(self.contentView).insets(UIEdgeInsetsMake(11, 0, 11, 0));
        make.width.mas_equalTo(self.goodsImageView.mas_height);
    }];
    
    [self.nameLabel mas_remakeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_equalTo(self.goodsImageView.mas_right).inset(11);
        make.bottom.mas_equalTo(self.priceLabel.mas_top).inset(2);
    }];
    [self.priceLabel mas_remakeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_equalTo(self.nameLabel);
        make.centerY.mas_equalTo(self.contentView);
    }];
    [self.infoLabel mas_remakeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_equalTo(self.nameLabel);
        make.top.mas_equalTo(self.priceLabel.mas_bottom).inset(2);
    }];
    
    [self setupMaskWithCorner:2 rectCorner:UIRectCornerAllCorners];
    
    NSLog(@"image frame === %@",self.goodsImageView);
}

- (void)setGoods:(GALiveGoodsModel *)goods{
    
    [self.nameLabel setText:goods.goods_name];
    [self.priceLabel setText:goods.goods_sale_price];
    [self.infoLabel setText:goods.goods_salenum] ;
    
    [self.goodsImageView sd_setImageWithURL:[NSURL URLWithString:goods.goods_image]];
}

- (void)awakeFromNib {
    [super awakeFromNib];
    // Initialization code
    
    [self setupUI];
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
    [self.box setOn:selected animated:YES];
}

@end
