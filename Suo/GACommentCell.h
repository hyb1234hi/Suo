//
//  GACommentCell.h
//  Suo
//
//  Created by 怪兽 🐙 on 2019/7/26.
//  Copyright © 2019 怪兽 🐙. All rights reserved.
//

#import "GABaseTableViewCell.h"

NS_ASSUME_NONNULL_BEGIN

@class GACommentCell;
@protocol GACommentCellDelegate <NSObject>

- (void)commentCellShowMoreWithCell:(GACommentCell *)cell withHeight:(CGFloat)height;

@end

@interface GACommentCell : GABaseTableViewCell

/**delegate**/
@property (nonatomic, weak)id<GACommentCellDelegate> delegate;

@end

NS_ASSUME_NONNULL_END
