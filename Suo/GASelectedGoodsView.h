//
//  GASelectedGoodsView.h
//  Suo
//
//  Created by ysw on 2019/8/9.
//  Copyright © 2019 怪兽 🐙. All rights reserved.
//

#import <UIKit/UIKit.h>
@class GALiveGoodsModel;

NS_ASSUME_NONNULL_BEGIN

@interface GASelectedGoodsView : UIView
@property(nonatomic,strong)NSArray<GALiveGoodsModel*> *goodsArray; //!<选中的商品

@end

NS_ASSUME_NONNULL_END
