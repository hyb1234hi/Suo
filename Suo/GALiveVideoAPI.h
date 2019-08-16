//
//  GALiveVideoAPI.h
//  Suo
//
//  Created by ysw on 2019/8/6.
//  Copyright © 2019 怪兽 🐙. All rights reserved.
//

#import "GABaseAPI.h"


@interface GALiveVideoAPI : GABaseAPI


@end



@interface GALiveVideoAPI (Live)

/**
 直播首页所有数据
 
 @param token       用户key
 @param completion  数据返回
 */
- (void)fetchLiveWithToken:(NSString*)token completion:(CallBack)completion;

/**
 直播 主播排行榜
 
 @param page        当前页码
 @param pageSize    分页大小 默认10
 @param completion  数据返回
 */
- (void)fetchLiveTopListForPage:(int)page size:(int)pageSize completion:(CallBack)completion;



/**
 直播 推荐直播列表
 
 @param page        当前分页
 @param pageSize    分页大小
 @param completion  数据返回
 */
- (void)fetchLiveRecommendListForPage:(int)page size:(int)pageSize completion:(CallBack)completion;



/**
 直播 获取指定类型的直播

 @param page        当前分页
 @param pageSize    分页大小
 @param typeID      分类id （0 == 全部）
 @param completion  数据返回
 */
- (void)fetchLiveByTypeForPage:(int)page size:(int)pageSize typeID:(NSString*)typeID completion:(CallBack)completion;



/**
 直播 获取关注列表

 @param userKey     用户标识key
 @param page        当前分页
 @param pageSize    分页大小
 @param completion  数据返回
 */
- (void)fetchLiveFollowListForKey:(NSString*)userKey page:(int)page size:(int)pageSize completion:(CallBack)completion;


/**
 获取所有直播分类

 @param completion 数据返回
 */
- (void)fetchLiveTypeCompletion:(CallBack)completion;


/**
 获取banner

 @param completion 数据返回
 */
- (void)fetchLiveBannerCompletion:(CallBack)completion;



/**
 获取用户可以推送的商品

 @param key         用户key
 @param goodsKey    商品搜索关键字
 @param page        当前分页
 @param pageSize    分页大小
 @param completion  数据返回
 */
- (void)fetchLiveGoodsForKey:(NSString*)key withGoodsKey:(NSString*)goodsKey page:(int)page size:(int)pageSize completion:(CallBack)completion;





/**
 开播

 @param key 用户key
 @param title 直播title
 @param type 直播类型
 @param image 封面
 
 @param tagList 标签列表 option
 @param goodsIDList 商品id列表 option
 @param lng 经度
 @param lat 纬度
 @param address 定位地址
 @param completion 数据回调
 */
- (void)openLiveWithKey:(NSString*)key title:(NSString*)title type:(int)type coverImage:(UIImage*)image tag:(NSArray*)tagList goodsList:(NSArray*)goodsIDList  lng:(double)lng lat:(double)lat address:(NSString*)address completion:(CallBack)completion;



/**
 获取开播的类型

 @param key 用户key
 @param completion 数据回调
 */
- (void)fetchLiveTypeForKey:(NSString*)key completion:(CallBack)completion;


/**
 退出直播

 @param key         用户key
 @param completion  数据返回
 */
- (void)closeLiveForKey:(NSString*)key completion:(CallBack)completion;


/**
 发送弹幕

 @param key         用户key
 @param roomID      房间号
 @param msg         弹幕文字
 @param completion  数据回调
 */
- (void)sendBarrageForKey:(NSString*)key roomID:(NSString*)roomID msg:(NSString*)msg completion:(CallBack)completion;



/**
 打赏礼物

 @param key 用户key
 @param roomID 房间id
 @param num 打赏数量
 @param giftID 礼物id
 @param pwd 密码MD5
 @param completion 数据返回
 */
- (void)rewardForKey:(NSString*)key roomID:(NSString*)roomID num:(NSString*)num giftID:(NSString*)giftID pwd:(NSString*)pwd completion:(CallBack)completion;



/**
 获取可打赏礼物列表

 @param completion 数据回调
 */
- (void)fetchRewardListWithCompletion:(CallBack)completion;


/**
 直播点赞

 @param key         用户key
 @param roomID      房间id
 @param completion  数据回调
 */
- (void)liveLikeForKey:(NSString*)key roomID:(NSString*)roomID completion:(CallBack)completion;


/**
 直播推送商品

 @param key         用户key
 @param goodsID     商品id
 @param completion  数据回调
 */
- (void)livePushGoodsForKey:(NSString*)key goodsID:(NSString*)goodsID completion:(CallBack)completion;


/**
 商品推送消息

 @param roomID      房间id
 @param type        视频类型
 @param key         用户key
 @param completion  数据回调
 */
- (void)fetchGoodsPushMessageForRoomID:(NSString*)roomID videoType:(NSString*__nullable)type key:(NSString*__nullable)key completion:(CallBack __nullable)completion;
@end


