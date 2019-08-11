//
//  GALiveVideoAPI.m
//  Suo
//
//  Created by ysw on 2019/8/6.
//  Copyright © 2019 怪兽 🐙. All rights reserved.
//

#import "GALiveVideoAPI.h"

@implementation GALiveVideoAPI



@end

@implementation GALiveVideoAPI (Live)

- (void)fetchLiveWithToken:(NSString *)token completion:(CallBack)completion{
    NSString *api = @"api/mobile/index.php?w=live&t=live_index";
    NSMutableDictionary *payload = @{}.mutableCopy;
    [payload setValue:token forKey:@"key"];
    
    NSURLRequest *request = [self createRequestWithPath:api parameter:payload method:@"GET"];
    [self dataTaskWithRequest:request dataCallback:completion];
}

- (void)fetchLiveTopListForPage:(int)page size:(int)pageSize completion:(CallBack)completion{
    NSString *api = @"api/mobile/index.php?w=live&t=getTopLiveList";
    if (pageSize == 0) {
        pageSize = 10;
    }
    
    NSMutableDictionary *payload = @{}.mutableCopy;
    [payload setValue:@(page) forKey:@"page_num"];
    [payload setValue:@(pageSize) forKey:@"page_limits"];
    
    NSURLRequest *request = [self createRequestWithPath:api parameter:payload method:@"GET"];
    [self dataTaskWithRequest:request dataCallback:completion];
}

- (void)fetchLiveRecommendListForPage:(int)page size:(int)pageSize completion:(CallBack)completion{
    NSString *api = @"api/mobile/index.php?w=live&t=getRecoomedLiveList";
    if (pageSize == 0) {
        pageSize = 10;
    }
    
    NSMutableDictionary *payload = @{}.mutableCopy;
    [payload setValue:@(pageSize) forKey:@"page_limits"];
    [payload setValue:@(page) forKey:@"page_num"];
    
    NSURLRequest *request = [self createRequestWithPath:api parameter:payload method:@"GET"];
    [self dataTaskWithRequest:request dataCallback:completion];
}

- (void)fetchLiveByTypeForPage:(int)page size:(int)pageSize typeID:(NSString*)typeID completion:(CallBack)completion{
    NSString *api = @"api/mobile/index.php?w=live&t=getLiveListByType";
    if (pageSize == 0) {
        pageSize = 10;
    }
    
    NSMutableDictionary *payload = @{}.mutableCopy;
    [payload setValue:@(page) forKey:@"page_num"];
    [payload setValue:@(pageSize) forKey:@"page_limits"];
    [payload setValue:typeID forKey:@"type_id"];
    
    NSURLRequest *request = [self createRequestWithPath:api parameter:payload method:@"GET"];
    [self dataTaskWithRequest:request dataCallback:completion];
}


- (void)fetchLiveFollowListForKey:(NSString *)userKey page:(int)page size:(int)pageSize completion:(CallBack)completion{
    NSString *api = @"api/mobile/index.php?w=live&t=getFollowLiveList";
    if (pageSize == 0) {
        pageSize = 10;
    }
    
    NSMutableDictionary *payload = @{}.mutableCopy;
    [payload setValue:@(page) forKey:@"page_num"];
    [payload setValue:@(pageSize) forKey:@"page_limits"];
    [payload setValue:userKey forKey:@"key"];
    
    NSURLRequest *request = [self createRequestWithPath:api parameter:payload method:@"GET"];
    [self dataTaskWithRequest:request dataCallback:completion];
}

- (void)fetchLiveTypeCompletion:(CallBack)completion{
    NSString *api = @"api/mobile/index.php?w=live&t=getLiveIndexTypeList";
    
    NSURLRequest *request = [self createRequestWithPath:api parameter:nil method:@"GET"];
    [self dataTaskWithRequest:request dataCallback:completion];
}

- (void)fetchLiveBannerCompletion:(CallBack)completion{
    NSString *api = @"api/mobile/index.php?w=live&t=getLiveBannerList";
    
    NSURLRequest *request = [self createRequestWithPath:api parameter:nil method:@"GET"];
    [self dataTaskWithRequest:request dataCallback:completion];
}

- (void)fetchLiveGoodsForKey:(NSString *)key withGoodsKey:(NSString *)goodsKey page:(int)page size:(int)pageSize completion:(CallBack)completion{
    NSString *api = @"api/mobile/index.php?w=live_center&t=get_can_push_goods_list";
    
    NSMutableDictionary *payload = @{}.mutableCopy;
    [payload setValue:key forKey:@"key"];
    [payload setValue:@(page) forKey:@"page_num"];
    [payload setValue:@(pageSize) forKey:@"page_limits"];
    [payload setValue:goodsKey forKey:@"search"];
    
    NSURLRequest *request = [self createRequestWithPath:api parameter:payload method:@"GET"];
    [self dataTaskWithRequest:request dataCallback:completion];
}
@end

