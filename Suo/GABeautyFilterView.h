//
//  GABeautyFilterView.h
//  Suo
//
//  Created by ysw on 2019/8/9.
//  Copyright © 2019 怪兽 🐙. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "GABeautyFilterParams.h"
#import <AlivcLivePusher/AlivcLivePusher.h>

NS_ASSUME_NONNULL_BEGIN

@class GABeautyFilterView;

typedef NS_ENUM(NSUInteger, BFViewState) {
    BFViewStateBeauty,
    BFViewStateFilter,
};

@protocol GABeautyFilterViewDelegate <NSObject>

- (void)beautyFilterParamsValueChange:(GABeautyFilterParams*)params;

@end


@interface GABeautyFilterView : UIView

@property(nonatomic,weak)id<GABeautyFilterViewDelegate> delegate;

@property(nonatomic,strong)GABeautyFilterParams *params;    //!<默认参数,修改后 内部持久化数据
@property(nonatomic,strong)AlivcLivePusher *pusher;         //!<修改画质


/**
 切换选中状态

 @param state 视图状态
 */
- (void)selectedState:(BFViewState)state;
@end

NS_ASSUME_NONNULL_END
