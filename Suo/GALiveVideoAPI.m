//
//  GALiveVideoAPI.m
//  Suo
//
//  Created by ysw on 2019/8/6.
//  Copyright © 2019 怪兽 🐙. All rights reserved.
//

#import "GALiveVideoAPI.h"
#import <AFNetworking.h>

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
    
    if (pageSize == 0) {
        pageSize = 10;
    }
    
    NSMutableDictionary *payload = @{}.mutableCopy;
    [payload setValue:key forKey:@"key"];
    [payload setValue:@(page) forKey:@"page_num"];
    [payload setValue:@(pageSize) forKey:@"page_limits"];
    [payload setValue:goodsKey forKey:@"search"];
    
    NSURLRequest *request = [self createRequestWithPath:api parameter:payload method:@"GET"];
    [self dataTaskWithRequest:request dataCallback:completion];
}


- (void)openLiveWithKey:(NSString *)key title:(NSString *)title type:(int)type coverImage:(UIImage *)image tag:(NSArray *)tagList goodsList:(NSArray *)goodsIDList lng:(double)lng lat:(double)lat address:(NSString*)address completion:(CallBack)completion{
    NSString *api = @"api/mobile/index.php?w=live_center&t=open_live";
    
    NSMutableDictionary *payload = @{}.mutableCopy;
    
    [payload setValue:key forKey:@"key"];
    [payload setValue:title forKey:@"title"];
    [payload setValue:@(type) forKey:@"type"];
    //[payload setValue:image forKey:@"cover_img"];
    
    [payload setValue:tagList forKey:@"tag"];
    [payload setValue:goodsIDList forKey:@"goods_id_arr"];
    [payload setValue:@(lng) forKey:@"lng"];
    [payload setValue:@(lat) forKey:@"lat"];
    [payload setValue:address forKey:@"address"];

    //转换为字符串
    NSMutableString *str = NSMutableString.new;
    for (NSString *idv in goodsIDList) {
        [str appendFormat:@"%@,",idv];
    }
    str = [NSString stringWithFormat:@"%@",str].mutableCopy;
    [payload setValue:str forKey:@"goods_id_arr"];
   
    api = @"http://www.suo.com/api/mobile/index.php?w=live_center&t=open_live";
    AFHTTPSessionManager *manage = [AFHTTPSessionManager manager];
    manage.responseSerializer.acceptableContentTypes = [NSSet setWithObjects:@"text/plain", @"multipart/form-data", @"application/json", @"text/html", @"image/jpeg", @"image/png", @"application/octet-stream", @"text/json", nil];
    [manage POST:api parameters:payload constructingBodyWithBlock:^(id<AFMultipartFormData>  _Nonnull formData) {
        NSData *data = UIImagePNGRepresentation(image);
        [formData appendPartWithFileData:data name:@"cover_img" fileName:@"cover_img.png" mimeType:@"image/png"];
    } progress:^(NSProgress * _Nonnull uploadProgress) {
        
    } success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
        if (completion) {
            completion(responseObject,task.response);
        }
    } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
        if (completion) {
            completion(@{@"error":error},task.response);
        }
    }];
    
   // NSURLRequest *request = [self createRequestWithPath:api parameter:payload method:@"POST"];
    //[self dataTaskWithRequest:request dataCallback:completion];
}

- (void)fetchLiveTypeForKey:(NSString *)key completion:(CallBack)completion{
    NSString *api = @"api/mobile/index.php?w=live_center&t=get_live_type_list";
    NSMutableDictionary *payload = @{}.mutableCopy;
    [payload setValue:key forKey:@"key"];
    
    NSURLRequest *request = [self createRequestWithPath:api parameter:payload method:@"GET"];
    [self dataTaskWithRequest:request dataCallback:completion];
}
@end

