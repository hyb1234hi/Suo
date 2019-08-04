//
//  GAAuthorListCommonView.h
//  Suo
//
//  Created by gajz on 2019/8/4.
//  Copyright © 2019 怪兽 🐙. All rights reserved.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@class GAAuthorListCommonView;

@protocol GAAuthorListCommonViewDelegate <NSObject>

- (void)authorListCommonViewClickWithIndex:(NSInteger)index;

@end

@interface GAAuthorListCommonView : UIView

@property (nonatomic, weak)id<GAAuthorListCommonViewDelegate> delegate;
@property (nonatomic, assign)NSInteger index; // 标记
@property (nonatomic, strong)NSArray *dataSource; // 列表数据

@end

NS_ASSUME_NONNULL_END
