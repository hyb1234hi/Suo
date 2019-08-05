//
//  GACommentFooterView.h
//  Suo
//
//  Created by gajz on 2019/8/3.
//  Copyright © 2019 怪兽 🐙. All rights reserved.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@class GACommentFooterView;
@protocol GACommentFooterViewDelegate <NSObject>

- (void)commentFooterViewWithSection:(NSInteger)section withSelection:(BOOL)isSelected;

@end

@interface GACommentFooterView : UITableViewHeaderFooterView

/**delegate**/
@property (nonatomic, weak)id<GACommentFooterViewDelegate> delegate;
/**button**/
@property (nonatomic, strong)UIButton *returnButton;

@property (nonatomic, assign)NSInteger index; // section

@property (nonatomic, assign)BOOL isSelected; // 按钮是否被点击

@end

NS_ASSUME_NONNULL_END
