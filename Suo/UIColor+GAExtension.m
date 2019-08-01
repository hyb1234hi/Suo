//
//  UIColor+GAExtension.m
//  Suo
//
//  Created by ysw on 2019/7/31.
//  Copyright © 2019 怪兽 🐙. All rights reserved.
//

#import "UIColor+GAExtension.h"

@implementation UIColor (GAExtension)

- (UIColor*)withHue:(CGFloat )hue{
    CGFloat saturation = 1;
    CGFloat brightness = 1;
    CGFloat alpha = 1;
    
    [self getHue:nil saturation:&saturation brightness:&brightness alpha:&alpha];
    return [UIColor colorWithHue:hue saturation:saturation brightness:brightness alpha:alpha];
}
- (UIColor*)withSaturation:(CGFloat)saturation{
    CGFloat hue = 1,brightness = 1,alpha = 1;
    [self getHue:&hue saturation:nil brightness:&brightness alpha:&alpha];
    return [[UIColor alloc] initWithHue:hue saturation:saturation brightness:brightness alpha:alpha];
}
- (UIColor*)withBrightness:(CGFloat)brightness {
    CGFloat hue = 1, saturation = 1, alpha = 1;
    [self getHue:&hue saturation:&saturation brightness:nil alpha:&alpha];
    
    return [[UIColor alloc] initWithHue:hue saturation:saturation brightness:brightness alpha:alpha];
}

- (UIColor*)withAlpha:(CGFloat)alpha{
    CGFloat hue = 1, saturation = 1, brightness = 1;
    [self getHue:&hue saturation:&saturation brightness:&brightness alpha:nil];
    return [[UIColor alloc] initWithHue:hue saturation:saturation brightness:brightness alpha:alpha];
}

- (UIColor*)highlight:(CGFloat)highlight{
    CGFloat red = 1 , green = 1, blue = 1, alpha = 1;
    [self getRed:&red green:&green blue:&blue alpha:&alpha];
    
    CGFloat(^value)(CGFloat) = ^(CGFloat color){
        return color * (1-highlight) + highlight;
    };
    
    UIColor *color = [UIColor colorWithRed:value(red)
                                     green:value(green)
                                      blue:value(blue)
                                     alpha:value(alpha)];
    return color;
}

- (UIColor*)shadow:(CGFloat)shadow {
    CGFloat red = 1, green = 1, blue = 1, alpha = 1;
    [self getRed:&red green:&green blue:&blue alpha:&alpha];
    
    CGFloat(^value)(CGFloat) = ^(CGFloat color){
        return color * (1-shadow);
    };
    
    return [[UIColor alloc] initWithRed:value(red)
                                  green:value(green)
                                   blue:value(blue)
                                  alpha:value(alpha)+shadow];
}

@end
