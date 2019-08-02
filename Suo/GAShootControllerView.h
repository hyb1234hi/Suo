//
//  GAShootControllerView.h
//  Suo
//
//  Created by ysw on 2019/7/30.
//  Copyright © 2019 怪兽 🐙. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "GARecordButton.h"

NS_ASSUME_NONNULL_BEGIN

@protocol GAShootControllerViewDelegate <NSObject>

- (void)switchLens;
- (void)toggleRecord:(GARecordButton*)send;

@end

@interface GAShootControllerView : UIView
@property(nonatomic,weak)id<GAShootControllerViewDelegate> delegate;
@end

NS_ASSUME_NONNULL_END
