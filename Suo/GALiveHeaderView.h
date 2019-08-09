//
//  GALiveHeaderView.h
//  Suo
//
//  Created by 怪兽 🐙 on 2019/7/28.
//  Copyright © 2019 怪兽 🐙. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "GABannerItem.h"

NS_ASSUME_NONNULL_BEGIN

@class GALiveHeaderView,WMMenuView;

@protocol GALiveHeaderViewDelegate <NSObject>

- (void)liveHeaderView:(GALiveHeaderView*)header didSelectedBanner:(GABannerItem*)item;

@end

@interface GALiveHeaderView : UICollectionReusableView
@property(nonatomic,strong)NSArray<GABannerItem*> *banners;

@property(nonatomic,weak)id<GALiveHeaderViewDelegate> delegate;
@end

NS_ASSUME_NONNULL_END
