//
//  GALiveTopCell.h
//  Suo
//
//  Created by ysw on 2019/8/8.
//  Copyright © 2019 怪兽 🐙. All rights reserved.
//

#import "GABaseCollectionViewCell.h"

NS_ASSUME_NONNULL_BEGIN

@class GALiveTopCell;

@protocol GALiveTopCellDelegate <NSObject>

- (void)liveTopCellDidSelected:(GALiveTopCell*)cell;

@end
@interface GALiveTopCell : GABaseCollectionViewCell
@property(nonatomic,weak)id<GALiveTopCellDelegate> delegate;
@end

NS_ASSUME_NONNULL_END
