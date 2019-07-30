//
//  GAVideoPlayControllerView.h
//  Suo
//
//  Created by 怪兽 🐙 on 2019/7/26.
//  Copyright © 2019 怪兽 🐙. All rights reserved.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@protocol GAVideoPlayControllerDelegate <NSObject>

- (void)viewDidClickUser;

@end

@interface GAVideoPlayControllerView : UIView

@property(nonatomic,weak)id<GAVideoPlayControllerDelegate> delegate;

@end

NS_ASSUME_NONNULL_END
