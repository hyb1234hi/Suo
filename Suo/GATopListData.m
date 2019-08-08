//
//  GATopListData.m
//  Suo
//
//  Created by ysw on 2019/8/8.
//  Copyright © 2019 怪兽 🐙. All rights reserved.
//

#import "GATopListData.h"

@implementation GATopListData

- (instancetype)init{
    if (self = [super init]) {
        self.title = @"排行榜";
    }
    return self;
}

- (void)reloadDataWithCompletion:(LiveDataBlock)completion{
    self.currentPage = 1;
    [GAAPI.new.videoAPI fetchLiveTopListForPage:self.currentPage size:self.pageSize completion:^(NSDictionary * _Nonnull json, NSURLResponse * _Nonnull response) {
        //NSLog(@"排行榜 -- %@",json);
        self.liveItems = [self serializationToModel:json];
        if (completion) {
            completion(self.liveItems);
        }
    }];
}
- (void)loadNextPathWithCompletion:(LiveDataBlock)completion{
    self.currentPage += 1;
    [GAAPI.new.videoAPI fetchLiveTopListForPage:self.currentPage size:self.pageSize completion:^(NSDictionary * _Nonnull json, NSURLResponse * _Nonnull response) {
        //NSLog(@"排行榜nextPage -- %@",json);
        NSArray *tmp = [self serializationToModel:json];
        [self.liveItems addObjectsFromArray:tmp];
        if (completion) {
            completion(tmp);
        }
    }];
}

@end
