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
@end


