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

typedef void(^FetchVideoBlock)(NSArray<GAVideo*>* _Nullable videos,NSString* _Nullable message,NSError * _Nullable error);

@interface GAVideoDataSource : NSObject
@property(nonatomic,strong)NSMutableArray<GAVideo*> *videoList;

- (void)reloadData;
- (void)loadNextPathWithCompletion:(FetchVideoBlock)completion;

@end

NS_ASSUME_NONNULL_END
