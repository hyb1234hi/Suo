//
//  GADanmuConnect.m
//  Suo
//
//  Created by ysw on 2019/8/14.
//  Copyright © 2019 怪兽 🐙. All rights reserved.
//

#import "GADanmuConnect.h"

@implementation GADanmuConnect
+ (instancetype)instanceWithDict:(NSDictionary *)dict{
    return [[self alloc] initWithDict:dict];
}
- (instancetype)initWithDict:(NSDictionary *)dict{
    if (self = [super initWithDict:dict]) {
        _json = dict;
        NSLog(@" >?????????????");
    }
    return self;
}

- (instancetype)init{
    if (self = [super init]) {
        NSLog(@">>>");
    }
    return self;
}
@end
