//
//  GALiveGoodsModel.h
//  Suo
//
//  Created by ysw on 2019/8/12.
//  Copyright © 2019 怪兽 🐙. All rights reserved.
//

#import "GABaseModel.h"

NS_ASSUME_NONNULL_BEGIN

@interface GALiveGoodsModel : GABaseModel
@property(nonatomic,copy)NSString *goods_id;            //!<商品id
@property(nonatomic,copy)NSString *goods_image;         //!<商品图片
@property(nonatomic,copy)NSString *goods_jingle;        //!<广告
@property(nonatomic,copy)NSString *goods_marketprice;   //!<超市价格
@property(nonatomic,copy)NSString *goods_name;          //!<商品名称
@property(nonatomic,copy)NSString *goods_sale_price;    //!<售价
@property(nonatomic,copy)NSString *goods_salenum;       //!<已售数量
@property(nonatomic,copy)NSString *store_id;            //!<商店id
@property(nonatomic,copy)NSString *store_name;          //!<商店名称

@end

NS_ASSUME_NONNULL_END
