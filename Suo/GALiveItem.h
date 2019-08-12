//
//  GALiveItem.h
//  Suo
//
//  Created by ysw on 2019/8/7.
//  Copyright © 2019 怪兽 🐙. All rights reserved.
//

#import "GABaseModel.h"

NS_ASSUME_NONNULL_BEGIN

@interface GALiveItem : GABaseModel

// public
@property(nonatomic,copy)NSString *member_avatar;   //!<用户头像URL
@property(nonatomic,copy)NSString *member_id;       //!<用户id
@property(nonatomic,copy)NSString *member_name;     //!<用户名称
@property(nonatomic,copy)NSString *room_id;         //!<房间id

//live 推荐
@property(nonatomic,copy)NSString *title;           //!<直播标题
@property(nonatomic,copy)NSString *tag;             //!<标签
@property(nonatomic,copy)NSString *cover_img;       //!<封面地址
@property(nonatomic,copy)NSString *great;           //!<
@property(nonatomic,copy)NSString *online_num;      //!<当前观看人数

//排行榜
@property(nonatomic,copy)NSString *sum_max_views;   //!<观看总数

@end

NS_ASSUME_NONNULL_END
