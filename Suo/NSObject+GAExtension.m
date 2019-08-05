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
    UIViewController *root = [[UIApplication sharedApplication].delegate.window rootViewController];
    
    while (root.parentViewController) {
        root = root.parentViewController;
    }
    
    [root setDefinesPresentationContext:YES];
    [root presentViewController:vc animated:animate completion:completion];
}
@end
