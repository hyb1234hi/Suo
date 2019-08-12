//
//  GAAllTypeLiveData.h
//  Suo
//
//  Created by ysw on 2019/8/8.
//  Copyright © 2019 怪兽 🐙. All rights reserved.
//

#import "GABaseDataSource.h"
#import "GALiveType.h"

NS_ASSUME_NONNULL_BEGIN


/**
 指定类型的直播数据
 */
@interface GAAllTypeLiveData : GABaseDataSource
- (instancetype)initWithType:(GALiveType*)type;
@end

NS_ASSUME_NONNULL_END
