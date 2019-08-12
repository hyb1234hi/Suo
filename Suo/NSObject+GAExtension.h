//
//  NSObject+GAExtension.h
//  Suo
//
//  Created by ysw on 2019/8/3.
//  Copyright © 2019 怪兽 🐙. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <MBProgressHUD.h>

NS_ASSUME_NONNULL_BEGIN

@interface NSObject (GAExtension)
@property(nonatomic,readonly,copy)NSString *loginKey;

- (MBProgressHUD*)showHUDToView:(UIView* __nullable)view message:(NSString*)msg;

- (void)rootVCPresentViewController:(UIViewController*)vc animated:(BOOL)animate completion:(void(^__nullable)(void))completion;


/**
 生成指定颜色图片

 @param size 图片大小
 @param color 颜色
 @return image
 */
- (UIImage*)imageForSize:(CGSize)size color:(UIColor*)color;
@end

NS_ASSUME_NONNULL_END
