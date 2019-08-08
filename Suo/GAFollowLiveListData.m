//
//  GAFollowLiveListData.m
//  Suo
//
//  Created by ysw on 2019/8/8.
//  Copyright © 2019 怪兽 🐙. All rights reserved.
//

#import "GAFollowLiveListData.h"

@interface GAFollowLiveListData ()
@property(nonatomic,copy)NSString *key;
@end

@implementation GAFollowLiveListData

- (instancetype)initWithUserKey:(NSString *)key{
    if (self = [super init]) {
        self.title = @"我关注的主播";
        _key = key;
    }
    return self;
}

- (void)reloadDataWithCompletion:(LiveDataBlock)completion{
    self.currentPage = 1;
    [GAAPI.new.videoAPI fetchLiveFollowListForKey:self.key page:self.currentPage size:self.pageSize completion:^(NSDictionary * _Nonnull json, NSURLResponse * _Nonnull response) {
        self.liveItems = [self serializationToModel:json];
        if (completion) {
            completion(self.liveItems);
        }
    }];
}
- (void)loadNextPathWithCompletion:(LiveDataBlock)completion{
    self.currentPage += 1;
    [GAAPI.new.videoAPI fetchLiveFollowListForKey:self.key page:self.currentPage size:self.pageSize completion:^(NSDictionary * _Nonnull json, NSURLResponse * _Nonnull response) {
        NSArray *tmp = [self serializationToModel:json];
        [self.liveItems addObjectsFromArray:tmp];
        if (completion) {
            completion(tmp);
        }
    }];
}
//-(NSMutableArray<GALiveItem *> *)serializationToModel:(NSDictionary *)json{
// 
//}
@end
