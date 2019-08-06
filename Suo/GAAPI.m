//
//  GAAPI.m
//  Suo
//
//  Created by ysw on 2019/8/6.
//  Copyright © 2019 怪兽 🐙. All rights reserved.
//

#import "GAAPI.h"

@implementation GAAPI

- (GALiveVideoAPI *)videoAPI{
    if (!_videoAPI) {
        _videoAPI = GALiveVideoAPI.new;
    }
    return _videoAPI;
}

@end
