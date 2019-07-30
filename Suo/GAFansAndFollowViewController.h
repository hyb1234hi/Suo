//
//  GAFansAndFollowViewController.h
//  Suo
//
//  Created by ysw on 2019/7/30.
//  Copyright © 2019 怪兽 🐙. All rights reserved.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

//内容类型
typedef NS_ENUM(NSUInteger, ViewControllerType) {
    ViewControllerTypeFans,
    ViewControllerTypeFollow,
};


@interface GAFansAndFollowViewController : UIViewController
- (instancetype)initWithType:(ViewControllerType)type;
@end

NS_ASSUME_NONNULL_END
