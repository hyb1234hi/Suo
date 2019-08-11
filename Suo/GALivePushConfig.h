//
//  GALivePushConfig.h
//  Suo
//
//  Created by ysw on 2019/8/11.
//  Copyright © 2019 怪兽 🐙. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <AlivcLivePusher/AlivcLivePusher.h>

#import "GABeautyFilterParams.h"

NS_ASSUME_NONNULL_BEGIN

@interface GALivePushConfig : AlivcLivePushConfig
@property(nonatomic,strong)GABeautyFilterParams *params;    //!<默认参数

@end

NS_ASSUME_NONNULL_END
