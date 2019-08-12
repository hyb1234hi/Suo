//
//  GAOpenLiveControlView.h
//  Suo
//
//  Created by ysw on 2019/8/1.
//  Copyright © 2019 怪兽 🐙. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <AlivcLivePusher/AlivcLivePusher.h>

#import "GABeautyFilterParams.h"
NS_ASSUME_NONNULL_BEGIN

@protocol GAOpenLiveControllerDelegate <NSObject>

/**
 开启直播点击
 */
- (void)startLive;

/**
 切换镜头点击
 */
-(void)switchCamera;

@end

@interface GAOpenLiveControlView : UIView
@property(nonatomic,weak)id<GAOpenLiveControllerDelegate> delegate;

@property(nonatomic,strong)GABeautyFilterParams *params;
@property(nonatomic,strong)AlivcLivePusher *pusher;

@end

NS_ASSUME_NONNULL_END
