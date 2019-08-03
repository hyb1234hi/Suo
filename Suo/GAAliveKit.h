//
//  GAAliveKit.h
//  Suo
//
//  Created by ysw on 2019/8/3.
//  Copyright © 2019 怪兽 🐙. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <AlivcLivePusher/AlivcLivePusher.h>

NS_ASSUME_NONNULL_BEGIN

@interface GAAliveKit : NSObject
@property(nonatomic,strong)AlivcLivePusher *pusher;

@end

NS_ASSUME_NONNULL_END
