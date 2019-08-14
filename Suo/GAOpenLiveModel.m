//
//  GAOpenLiveModel.m
//  Suo
//
//  Created by ysw on 2019/8/14.
//  Copyright © 2019 怪兽 🐙. All rights reserved.
//

#import "GAOpenLiveModel.h"

@implementation GAOpenLiveModel
+ (instancetype)instanceWithDict:(NSDictionary *)dict{
    NSLog(@">>>>>><<<<<<<");
    return [[self alloc] initWithDict:dict];
}
- (instancetype)initWithDict:(NSDictionary *)dict{
    if (self = [super initWithDict:dict]) {
        NSLog(@"OLOLOLLLLLLLL");
    
    }
    return self;
}

@end



