//
//  GALiveWatchCell.h
//  Suo
//
//  Created by 怪兽 🐙 on 2019/7/27.
//  Copyright © 2019 怪兽 🐙. All rights reserved.
//

#import "GABaseCollectionViewCell.h"

NS_ASSUME_NONNULL_BEGIN

@class GALiveWatchCell;

@protocol GALiveWatchCellDelegate <NSObject>

- (void)clickUserWithCell:(GALiveWatchCell*)cell;

@end

@interface GALiveWatchCell : GABaseCollectionViewCell
@property(nonatomic,weak)id<GALiveWatchCellDelegate> delegate;
@end

NS_ASSUME_NONNULL_END
