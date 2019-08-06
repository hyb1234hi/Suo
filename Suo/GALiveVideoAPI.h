//
//  GALiveVideoAPI.h
//  Suo
//
//  Created by ysw on 2019/8/6.
//  Copyright © 2019 怪兽 🐙. All rights reserved.
//

#import "GABaseAPI.h"



@interface GALiveVideoAPI : GABaseAPI
- (void)fetchLiveWithToken:(NSString*)token completion:(CallBack)completion;
@end


