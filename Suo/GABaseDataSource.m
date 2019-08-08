//
//  GABaseDataSource.m
//  Suo
//
//  Created by ysw on 2019/8/8.
//  Copyright © 2019 怪兽 🐙. All rights reserved.
//

#import "GABaseDataSource.h"

@implementation GABaseDataSource

- (instancetype)init{
    if (self = [super init]) {
        _liveItems = @[].mutableCopy;
        _pageSize = 10;
        _currentPage = 1;
        _title = @"推荐直播";
        
        //加载数据
        //[self reloadDataWithCompletion:nil];
    }
    return self;
}

- (void)reloadDataWithCompletion:(LiveDataBlock)completion{
    
}
-(void)loadNextPathWithCompletion:(LiveDataBlock)completion{
    
}
- (NSMutableArray<GALiveItem *> *)serializationToModel:(NSDictionary *)json{

    NSMutableArray<GALiveItem*> *lists = @[].mutableCopy;
    if ([json valueForKeyPath:@"datas.data"]) {
        NSArray *tmp = [json valueForKeyPath:@"datas.data"];
        for (NSDictionary *dict in tmp) {
            [lists addObject:[GALiveItem instanceWithDict:dict]];
        }
    }
    
    return lists;
}
@end
