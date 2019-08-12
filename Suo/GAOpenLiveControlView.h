//
//  GAOpenLiveControlView.h
//  Suo
//
//  Created by ysw on 2019/8/1.
//  Copyright © 2019 怪兽 🐙. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <AlivcLivePusher/AlivcLivePusher.h>
#import <CoreLocation/CoreLocation.h>

#import "GALiveGoodsModel.h"
#import "GABeautyFilterParams.h"
NS_ASSUME_NONNULL_BEGIN

@protocol GAOpenLiveControllerDelegate <NSObject>


/**
 开始直播

 @param title       直播title
 @param cover       直播封面
 @param location    位置信息
 @param goodsList   选择直播商品
 */
- (void)startLiveWiteTitle:(NSString*)title image:(UIImage*)cover location:(CLLocationCoordinate2D)location selectedGoods:(NSArray<GALiveGoodsModel*>*)goodsList;

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
