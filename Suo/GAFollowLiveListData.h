//
//  GAFollowLiveListData.h
//  Suo
//
//  Created by ysw on 2019/8/8.
//  Copyright © 2019 怪兽 🐙. All rights reserved.
//

#import "GABaseDataSource.h"

NS_ASSUME_NONNULL_BEGIN


/**
 用户关注的主播 直播数据
 */
@interface GAFollowLiveListData : GABaseDataSource

/**
 获取指定用户的关注主播

 @param key 用户key
 @return 数据源
 */
- (instancetype)initWithUserKey:(NSString*)key;

@end

NS_ASSUME_NONNULL_END
