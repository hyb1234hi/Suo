//
//  GABannerItem.h
//  Suo
//
//  Created by ysw on 2019/8/8.
//  Copyright © 2019 怪兽 🐙. All rights reserved.
//

#import "GABaseModel.h"

NS_ASSUME_NONNULL_BEGIN

@interface GABannerItem : GABaseModel
@property(nonatomic,copy)NSString *title;
@property(nonatomic,copy)NSString *url;
@property(nonatomic,copy)NSString *img;
@end

NS_ASSUME_NONNULL_END
