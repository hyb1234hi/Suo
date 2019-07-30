//
//  GAVideoCell.h
//  Suo
//
//  Created by 怪兽 🐙 on 2019/7/26.
//  Copyright © 2019 怪兽 🐙. All rights reserved.
//

#import "GABaseCollectionViewCell.h"

NS_ASSUME_NONNULL_BEGIN


@class GAVideoCell;

@protocol GAVideoCellDelegate <NSObject>

- (void)cellDidClickAvatar:(GAVideoCell*)cell;

@end

@interface GAVideoCell : GABaseCollectionViewCell
@property(nonatomic,weak)id<GAVideoCellDelegate> delegate;
@end

NS_ASSUME_NONNULL_END
