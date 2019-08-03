//
//  NSObject+GAExtension.m
//  Suo
//
//  Created by ysw on 2019/8/3.
//  Copyright © 2019 怪兽 🐙. All rights reserved.
//

#import "NSObject+GAExtension.h"

@implementation NSObject (GAExtension)


- (void)rootVCPresentViewController:(UIViewController *)vc animated:(BOOL)animate completion:(void (^)(void))completion{
    UIViewController *root = [[UIApplication sharedApplication].keyWindow rootViewController];
    
    while (root.parentViewController) {
        root = root.parentViewController;
    }
    
    [root setDefinesPresentationContext:YES];
    [root presentViewController:vc animated:animate completion:completion];
}
@end
