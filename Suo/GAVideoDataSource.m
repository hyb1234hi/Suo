//
//  GAVideoDataSource.m
//  Suo
//
//  Created by ysw on 2019/7/30.
//  Copyright © 2019 怪兽 🐙. All rights reserved.
//

#import "GAVideoDataSource.h"

@interface GAVideoDataSource ()
@property(nonatomic,assign)NSInteger page;
@end

@implementation GAVideoDataSource

- (void)reloadData{
    [self.videoList removeAllObjects];
    
    self.page = 0;
    
    [self fetchVideoWithPage:self.page completion:^(NSArray<GAVideo *> * _Nullable videos, NSString * _Nullable message, NSError * _Nullable error) {
        
    }];
}

- (void)loadNextPathWithCompletion:(FetchVideoBlock)completion{
    self.page += 1;
    [self fetchVideoWithPage:self.page completion:^(NSArray<GAVideo *> * _Nullable videos, NSString * _Nullable message, NSError * _Nullable error) {
        
    }];
}

- (void)fetchVideoWithPage:(NSInteger)page completion:(FetchVideoBlock)completion{
    
}
@end
