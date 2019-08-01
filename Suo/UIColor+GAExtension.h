//
//  UIColor+GAExtension.h
//  Suo
//
//  Created by ysw on 2019/7/31.
//  Copyright © 2019 怪兽 🐙. All rights reserved.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@interface UIColor (GAExtension)
- (UIColor*)withHue:(CGFloat )hue;
- (UIColor*)withSaturation:(CGFloat)saturation;
- (UIColor*)withBrightness:(CGFloat)brightness ;
- (UIColor*)withAlpha:(CGFloat)alpha;
- (UIColor*)highlight:(CGFloat)highlight;
- (UIColor*)shadow:(CGFloat)shadow;
@end

NS_ASSUME_NONNULL_END
