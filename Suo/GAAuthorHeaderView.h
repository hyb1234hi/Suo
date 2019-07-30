//
//  GAAuthorHeaderView.h
//  Suo
//
//  Created by ysw on 2019/7/30.
//  Copyright © 2019 怪兽 🐙. All rights reserved.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@class GAAuthorHeaderView;

@protocol GAAuthorHeaderViewDelegate <NSObject>

- (void)headerViewFansListClick:(GAAuthorHeaderView*)view;
- (void)headerViewFollowListClick:(GAAuthorHeaderView*)view;
- (void)headerViewHotClick:(GAAuthorHeaderView*)view;
- (void)headerViewFollowAuthorClick:(GAAuthorHeaderView*)view;
- (void)headerViewAvatarClick:(GAAuthorHeaderView*)view;

@end

@interface GAAuthorHeaderView : UICollectionReusableView
@property(nonatomic,weak)id<GAAuthorHeaderViewDelegate> delegate;
@end

NS_ASSUME_NONNULL_END
