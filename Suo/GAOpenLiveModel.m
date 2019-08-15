//
//  GAOpenLiveModel.m
//  Suo
//
//  Created by ysw on 2019/8/14.
//  Copyright © 2019 怪兽 🐙. All rights reserved.
//

#import "GAOpenLiveModel.h"

@implementation GAOpenLiveModel
+ (NSDictionary *)mj_replacedKeyFromPropertyName{
    return @{@"danmu":@"danmu_connect_data"};
}

+ (instancetype)instanceWithDict:(NSDictionary *)dict{
    return [[self alloc] initWithDict:dict];
}
- (instancetype)initWithDict:(NSDictionary *)dict{
    if (self = [super initWithDict:dict]) {
        _danmu.json = [dict valueForKey:@"danmu_connect_data"];
    }
    return self;
}

@end



