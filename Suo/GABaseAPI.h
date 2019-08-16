//
//  GABaseAPI.h
//  Suo
//
//  Created by ysw on 2019/8/6.
//  Copyright © 2019 怪兽 🐙. All rights reserved.
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

typedef void(^CallBack)(NSDictionary *json,NSURLResponse *response);


static NSString *const rootPath = Domain_URL;
@interface GABaseAPI : NSObject



/**
 POST 请求

 @param api 接口路径
 @param parameter 参数字典
 @param competion 回调
 */
- (void)POSTWithAPI:(NSString*)api parameter:(NSDictionary*)parameter completion:(CallBack)completion;


/**
 GET 请求

 @param api 接口路径
 @param parameter 参数
 @param completion 回调
 */
- (void)GETWithAPI:(NSString*)api parameter:(NSDictionary*)parameter completion:(CallBack)completion;

/**
通过子路径创建请求体

 @param path        子路径
 @param parameter   参数
 @param method      请求方式
 @return            请求对象
 */
- (NSURLRequest*)createRequestWithPath:(NSString*)path parameter:(NSDictionary*__nullable)parameter method:(NSString*__nullable)method;


/**
 获取指定请求对象的数据

 @param request     请求对象
 @param callBack    数据回调
 */
- (void)dataTaskWithRequest:(NSURLRequest*)request dataCallback:(CallBack __nullable)callBack;


/**
 获取用户信息

 @param key         用户登录key
 @param completion  数据回调
 */
- (void)fetchUserInfoWithKey:(NSString*)key completion:(CallBack __nullable)completion;
@end

NS_ASSUME_NONNULL_END
