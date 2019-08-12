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
//        _liveItems = @[].mutableCopy;
//        _pageSize = 10;
//        _currentPage = 1;
        self.title = @"推荐直播";
        
        //加载数据
        //[self reloadDataWithCompletion:nil];
    }
    return self;
}

- (void)reloadDataWithCompletion:(LiveDataBlock)completion{
    self.currentPage = 1;
    [GAAPI.new.videoAPI fetchLiveRecommendListForPage:self.currentPage size:self.pageSize completion:^(NSDictionary * _Nonnull json, NSURLResponse * _Nonnull response) {
        self.liveItems = [self serializationToModel:json];
        if (completion) {
            completion(self.liveItems);
        }
        
       // NSLog(@"推荐直播 ----- %@",json);
    }];
}

- (void)loadNextPathWithCompletion:(LiveDataBlock)completion{
    self.currentPage += 1;
    [GAAPI.new.videoAPI fetchLiveRecommendListForPage:self.currentPage size:self.pageSize completion:^(NSDictionary * _Nonnull json, NSURLResponse * _Nonnull response) {
        NSArray *array = [self serializationToModel:json];
        [self.liveItems addObjectsFromArray:array];
        if (completion) {
            completion(array);
        }
    }];
}


@end
