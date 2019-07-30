//
//  GAVideoDataSource.h
//  Suo
//
//  Created by ysw on 2019/7/30.
//  Copyright © 2019 怪兽 🐙. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "GAVideo.h"

NS_ASSUME_NONNULL_BEGIN

typedef void(^FetchVideoBlock)(NSArray<GAVideo*>*videos,NSString*message,NSError *error);

@interface GAVideoDataSource : NSObject
@property(nonatomic,strong)NSMutableArray<GAVideo*> *videoList;



@end

NS_ASSUME_NONNULL_END
