//
//  UIView+GAExtension.m
//  Suo
//
//  Created by 怪兽 🐙 on 2019/7/26.
//  Copyright © 2019 怪兽 🐙. All rights reserved.
//

#import "UIView+GAExtension.h"

@implementation UIView (GAExtension)

- (void)setupMaskWithCorner:(CGFloat)corner rectCorner:(UIRectCorner)rectCorners{
    UIBezierPath* rounded = [UIBezierPath bezierPathWithRoundedRect:self.bounds byRoundingCorners:rectCorners cornerRadii:CGSizeMake(corner, corner)];
    CAShapeLayer* shape = [[CAShapeLayer alloc] init];
    [shape setPath:rounded.CGPath];
    self.layer.mask = shape;
}

@end
