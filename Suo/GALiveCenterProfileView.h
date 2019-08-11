//
//  GALiveCenterProfileView.h
//  Suo
//
//  Created by ysw on 2019/8/11.
//  Copyright © 2019 怪兽 🐙. All rights reserved.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@protocol GALiveCenterProfileViewDelegate  <NSObject>
- (void)profileViewDidClickAvatarView;
- (void)profileViewDidClickUserName;

- (void)profileViewDidClickFollowButton;
- (void)profileviewDidClickFansButton;
- (void)profileViewDidClickVideoButton;
- (void)profileViewDidClickOpenLiveButton;
- (void)profileViewDidClickPublishButton;
@end

@interface GALiveCenterProfileView : UICollectionReusableView
@property(nonatomic,weak)id<GALiveCenterProfileViewDelegate> delegate;
@end

NS_ASSUME_NONNULL_END
