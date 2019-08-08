//
//  GAAllTypeLiveData.m
//  Suo
//
//  Created by ysw on 2019/8/8.
//  Copyright © 2019 怪兽 🐙. All rights reserved.
//

#import "GAAllTypeLiveData.h"

@interface GAAllTypeLiveData ()
@property(nonatomic,copy)GALiveType *type;
@end

@implementation GAAllTypeLiveData
- (instancetype)initWithType:(GALiveType *)type{
    if (self = [super init]) {
        _type = type;
        self.title = type.name;
    }
    return self;
}
- (void)reloadDataWithCompletion:(LiveDataBlock)completion{
    self.currentPage = 1;
    [GAAPI.new.videoAPI fetchLiveByTypeForPage:self.currentPage size:self.pageSize typeID:self.type.identifier completion:^(NSDictionary * _Nonnull json, NSURLResponse * _Nonnull response) {
        NSLog(@"json --url==%@ \n id == %@  %@",response.URL.absoluteString,self.type.identifier ,json);
        self.liveItems = [self serializationToModel:json];
        if (completion) {
            completion(self.liveItems);
        }
    }];
}
- (void)loadNextPathWithCompletion:(LiveDataBlock)completion{
    self.currentPage += 1;
    [GAAPI.new.videoAPI fetchLiveByTypeForPage:self.currentPage size:self.pageSize typeID:self.type.identifier completion:^(NSDictionary * _Nonnull json, NSURLResponse * _Nonnull response) {
        NSArray *tmp = [self serializationToModel:json];
        [self.liveItems addObjectsFromArray:tmp];
        if (completion) {
            completion(tmp);
        }
    }];
}
//- (NSMutableArray<GALiveItem *> *)serializationToModel:(NSDictionary *)json{
//    NSMutableArray
//}
@end
