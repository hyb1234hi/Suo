//
//  GABaseModel.h
//  Suo
//
//  Created by 怪兽 🐙 on 2019/7/27.
//  Copyright © 2019 怪兽 🐙. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <MJExtension.h>

NS_ASSUME_NONNULL_BEGIN

@interface GABaseModel : NSObject

+ (instancetype)instanceWithDict:(NSDictionary*)dict;
- (instancetype)initWithDict:(NSDictionary*)dict;

@end

NS_ASSUME_NONNULL_END
