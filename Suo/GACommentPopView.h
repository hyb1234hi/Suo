//
//  GACommentPopView.h
//  Suo
//
//  Created by 怪兽 🐙 on 2019/7/26.
//  Copyright © 2019 怪兽 🐙. All rights reserved.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@class BaseItem;

/**内容评论*/
@interface GACommentPopView : UIView
//- (instancetype)initWithItem:(BaseItem*)Item;

- (void)show;
- (void)dismiss;
@end

NS_ASSUME_NONNULL_END
