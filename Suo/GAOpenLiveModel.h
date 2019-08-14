//
//  GAOpenLiveModel.h
//  Suo
//
//  Created by ysw on 2019/8/14.
//  Copyright © 2019 怪兽 🐙. All rights reserved.
//

#import "GABaseModel.h"
#import "GADanmuConnect.h"

NS_ASSUME_NONNULL_BEGIN


@interface GAOpenLiveModel : GABaseModel
@property(nonatomic,strong)NSArray *goods_data;     //!<商品数据
@property(nonatomic,copy)NSString *push_url;        //!<推送地址
@property(nonatomic,strong)GADanmuConnect *danmu_connect_data;   //!<弹幕连接详情

@end

NS_ASSUME_NONNULL_END
