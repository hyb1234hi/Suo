//
//  GAOpenLiveControlView.h
//  Suo
//
//  Created by ysw on 2019/8/1.
//  Copyright © 2019 怪兽 🐙. All rights reserved.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@protocol GAOpenLiveControllerDelegate <NSObject>


@end

@interface GAOpenLiveControlView : UIView
@property(nonatomic,weak)id<GAOpenLiveControllerDelegate> delegate;
@end

NS_ASSUME_NONNULL_END
