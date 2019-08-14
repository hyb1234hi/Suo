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
    NSLog(@">>>>>>>>>>>>>>>>>>>>>");
    
    return [[self alloc] initWithDict:dict];
}
- (instancetype)initWithDict:(NSDictionary *)dict{
    NSLog(@"init ----->>>>>>>>>>>>>>>>- ");
    if (self = [super initWithDict:dict]) {
        NSLog(@" OOOOOOOOOOOOOOOOOO");
        _json = dict;
    }
    return self;
}
@end
