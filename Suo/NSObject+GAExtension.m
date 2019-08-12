//
//  NSObject+GAExtension.m
//  Suo
//
//  Created by ysw on 2019/8/3.
//  Copyright © 2019 怪兽 🐙. All rights reserved.
//

#import "NSObject+GAExtension.h"

@implementation NSObject (GAExtension)

- (MBProgressHUD *)showHUDToView:(UIView *)view message:(NSString *)msg{
    if (!view) {
        view = [UIApplication sharedApplication].delegate.window;
    }
    MBProgressHUD *hud = [MBProgressHUD showHUDAddedTo:view animated:YES];
    [hud setMode:MBProgressHUDModeText];
    [hud.label setText:msg];
    [hud hideAnimated:YES afterDelay:1.5];
    return hud;
}

- (void)rootVCPresentViewController:(UIViewController *)vc animated:(BOOL)animate completion:(void (^)(void))completion{
    
    UIViewController *root = [self topViewControllerWithRootViewController:[UIApplication sharedApplication].keyWindow.rootViewController];
    
    
    NSLog(@" root ---- %@",root);
    /*
    [[UIApplication sharedApplication].keyWindow rootViewController];
    while (root.parentViewController) {
        root = root.parentViewController;
    }
    */
    
    [root setDefinesPresentationContext:YES];
    [root presentViewController:vc animated:animate completion:completion];
}

- (UIViewController*)topViewControllerWithRootViewController:(UIViewController*)rootViewController
{
    if ([rootViewController isKindOfClass:[UITabBarController class]]) {
        UITabBarController *tabBarController = (UITabBarController *)rootViewController;
        return [self topViewControllerWithRootViewController:tabBarController.selectedViewController];
    } else if ([rootViewController isKindOfClass:[UINavigationController class]]) {
        UINavigationController* navigationController = (UINavigationController*)rootViewController;
        return [self topViewControllerWithRootViewController:navigationController.visibleViewController];
    } else if (rootViewController.presentedViewController) {
        UIViewController* presentedViewController = rootViewController.presentedViewController;
        return [self topViewControllerWithRootViewController:presentedViewController];
    } else {
        return rootViewController;
    }
}


- (NSString *)loginKey{
    NSString *key = nil;
    NSArray *cookies = [[NSHTTPCookieStorage sharedHTTPCookieStorage] cookies];
    for (NSHTTPCookie *cookie in cookies) {
        if ([[cookie.properties valueForKey:NSHTTPCookieName] isEqualToString:@"key"]) {
            key = [cookie.properties valueForKey:NSHTTPCookieValue];
        }
    }
    return key;
}

- (UIImage *)imageForSize:(CGSize)size color:(UIColor *)color{
    UIGraphicsBeginImageContext(size);
    CGContextRef context = UIGraphicsGetCurrentContext();
    CGContextSetFillColorWithColor(context, color.CGColor);
    CGContextFillRect(context, CGRectMake(0, 0, size.width, size.height));
    UIImage *image = UIGraphicsGetImageFromCurrentImageContext();
    UIGraphicsEndImageContext();
    
    return image;
}
@end
