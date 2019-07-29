//
//  GACityWideCollectionCell.h
//  Suo
//
//  Created by 怪兽 🐙 on 2019/7/26.
//  Copyright © 2019 怪兽 🐙. All rights reserved.
//

#import "GABaseCollectionViewCell.h"

NS_ASSUME_NONNULL_BEGIN


@class GACityWideCollectionCell;

@protocol GACityWideCollectionCellDelegate <NSObject>

- (void)deleteItem:(GACityWideCollectionCell*)cell;

@end

@interface GACityWideCollectionCell : GABaseCollectionViewCell
@property(nonatomic,weak)id<GACityWideCollectionCellDelegate> delegate;

@end

NS_ASSUME_NONNULL_END
