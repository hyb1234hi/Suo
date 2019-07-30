//
//  GAVideoPlayCell.h
//  Suo
//
//  Created by 怪兽 🐙 on 2019/7/26.
//  Copyright © 2019 怪兽 🐙. All rights reserved.
//

#import "GABaseCollectionViewCell.h"

NS_ASSUME_NONNULL_BEGIN

@class GAVideoPlayCell;

@protocol GAVideoPlayCellDelegate <NSObject>

- (void)cellDidClickUser:(GAVideoPlayCell*)cell;

@end

@interface GAVideoPlayCell : GABaseCollectionViewCell
@property(nonatomic,weak)id<GAVideoPlayCellDelegate> delegate;
@end

NS_ASSUME_NONNULL_END
