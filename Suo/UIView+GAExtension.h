//
//  UIView+GAExtension.h
//  Suo
//
//  Created by 怪兽 🐙 on 2019/7/26.
//  Copyright © 2019 怪兽 🐙. All rights reserved.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@interface UIView (GAExtension)


/**
 设置遮罩 调用前需要设置正确的size

 @param corner 圆角大小
 @param rectCorner 设置边角
 */
- (void)setupMaskWithCorner:(CGFloat)corner rectCorner:(UIRectCorner)rectCorner;

@end

NS_ASSUME_NONNULL_END
