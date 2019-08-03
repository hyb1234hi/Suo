//
//  NSObject+GAExtension.h
//  Suo
//
//  Created by ysw on 2019/8/3.
//  Copyright © 2019 怪兽 🐙. All rights reserved.
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

@interface NSObject (GAExtension)


- (void)rootVCPresentViewController:(UIViewController*)vc animated:(BOOL)animate completion:(void(^__nullable)(void))completion;
@end

NS_ASSUME_NONNULL_END
