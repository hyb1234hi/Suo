//
//  GALiveVideoAPI.m
//  Suo
//
//  Created by ysw on 2019/8/6.
//  Copyright © 2019 怪兽 🐙. All rights reserved.
//

#import "GALiveVideoAPI.h"

@implementation GALiveVideoAPI


- (void)fetchLiveWithToken:(NSString *)token completion:(CallBack)completion{
    NSString *api = @"api/mobile/index.php?w=live&t=live_index";
    NSMutableDictionary *payload = @{}.mutableCopy;
    [payload setValue:token forKey:@"key"];
    
    NSURLRequest *request = [self createRequestWithPath:api parameter:payload method:@"GET"];
    [self dataTaskWithRequest:request dataCallback:completion];
}
@end
