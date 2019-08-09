//
//  GABeautyFilterView.h
//  Suo
//
//  Created by ysw on 2019/8/9.
//  Copyright © 2019 怪兽 🐙. All rights reserved.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

typedef NS_ENUM(NSUInteger, BFViewState) {
    BFViewStateBeauty,
    BFViewStateFilter,
};

@interface GABeautyFilterView : UIView

/**
 切换选中状态

 @param state 视图状态
 */
- (void)selectedState:(BFViewState)state;
@end

NS_ASSUME_NONNULL_END
