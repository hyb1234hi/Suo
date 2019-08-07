//
//  GALiveRecommendData.m
//  Suo
//
//  Created by ysw on 2019/8/7.
//  Copyright © 2019 怪兽 🐙. All rights reserved.
//

#import "GALiveRecommendData.h"

@implementation GALiveRecommendData
- (instancetype)init{
    if (self = [super init]) {
        _liveItems = @{}.mutableCopy;
        _pageSize = 10;
    }
    return self;
}

- (void)reloadDataWithCompletion:(LiveDataBlock)completion{
    
}
- (void)loadNextPathWithCompletion:(LiveDataBlock)completion{
    
}


@end
