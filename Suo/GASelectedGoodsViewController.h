//
//  GASelectedGoodsViewController.h
//  Suo
//
//  Created by ysw on 2019/8/12.
//  Copyright © 2019 怪兽 🐙. All rights reserved.
//

#import "GABaseViewController.h"
#import "GALiveGoodsModel.h"

NS_ASSUME_NONNULL_BEGIN

/**
 开播前选择推送商品
 */
@interface GASelectedGoodsViewController : GABaseViewController
@property(nonatomic,strong)void(^selectedGoods)(NSArray<GALiveGoodsModel*> *) ;

@end

NS_ASSUME_NONNULL_END
