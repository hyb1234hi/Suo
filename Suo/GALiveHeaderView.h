//
//  GALiveHeaderView.h
//  Suo
//
//  Created by 怪兽 🐙 on 2019/7/28.
//  Copyright © 2019 怪兽 🐙. All rights reserved.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@class GALiveHeaderView,WMMenuView;

@protocol GALiveHeaderViewDelegate <NSObject>

//- (void)menuView:(WMMenuView*)menuView selected:()

@end

@interface GALiveHeaderView : UICollectionReusableView

@end

NS_ASSUME_NONNULL_END
