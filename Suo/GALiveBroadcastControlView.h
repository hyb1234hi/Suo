//
//  GALiveBroadcastControlView.h
//  Suo
//
//  Created by ysw on 2019/8/2.
//  Copyright © 2019 怪兽 🐙. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "GAOpenLiveModel.h"

NS_ASSUME_NONNULL_BEGIN


@protocol GALiveBroadcastControlViewDelegate <NSObject>

/**
 停止直播
 */
- (void)stopLive;

@end

@interface GALiveBroadcastControlView : UIView
@property(nonatomic,weak)id<GALiveBroadcastControlViewDelegate> delegate;
@property(nonatomic,strong)GAOpenLiveModel *liveMode;       //!<数据直播模型
@end

NS_ASSUME_NONNULL_END
