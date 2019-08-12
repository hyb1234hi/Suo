//
//  GAUser.h
//  Suo
//
//  Created by 怪兽 🐙 on 2019/7/27.
//  Copyright © 2019 怪兽 🐙. All rights reserved.
//

#import "GABaseModel.h"

NS_ASSUME_NONNULL_BEGIN

@interface GAUser : GABaseModel
@property(nonatomic,copy)NSString *identifier;
@property(nonatomic,copy)NSString *name;
@property(nonatomic,copy)NSString *avatarURL;


@end

NS_ASSUME_NONNULL_END
