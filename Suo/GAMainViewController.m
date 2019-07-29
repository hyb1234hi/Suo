//
//  GAMainViewController.m
//  Suo
//
//  Created by 怪兽 🐙 on 2019/7/26.
//  Copyright © 2019 怪兽 🐙. All rights reserved.
//

#import "GAMainViewController.h"
#import "GALiveMainViewController.h"

#import <WebKit/WebKit.h>


@interface GAMainViewController ()<WKNavigationDelegate,WKScriptMessageHandler,WKUIDelegate>
@property(nonatomic,strong) WKWebView *webView;
@end

@implementation GAMainViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    
    [self setTitle:@""];
    [self.view setBackgroundColor:ColorWhite];
    
    WKWebViewConfiguration *config = [[WKWebViewConfiguration alloc] init];
    [config.userContentController addScriptMessageHandler:self name:@""];

    
    _webView = [[WKWebView alloc] initWithFrame:self.view.bounds configuration:config];
    [_webView setNavigationDelegate:self];
    [_webView setUIDelegate:self];
    
    NSURL *url = [NSURL URLWithString:@"http://www.suo.com"];
    
    NSURLRequest *request = [NSURLRequest requestWithURL:url cachePolicy:NSURLRequestReloadIgnoringCacheData timeoutInterval:30];
    [_webView loadRequest:request];
    
    
    [_webView evaluateJavaScript:@"" completionHandler:^(id _Nullable obj, NSError * _Nullable error) {
        
    }];
    
    
        //缓存
    NSSet *dataSet = [WKWebsiteDataStore allWebsiteDataTypes];
    NSDate *date = [NSDate dateWithTimeIntervalSince1970:0];
    [[WKWebsiteDataStore defaultDataStore] removeDataOfTypes:dataSet modifiedSince:date completionHandler:^{
            //清除完成
    }];
    
    [self.view addSubview:_webView];
    [self.navigationController setNavigationBarHidden:YES animated:YES];
    
    
    
    UIViewController *vc = GALiveMainViewController.new;
    [self.navigationController pushViewController:vc animated:YES];
}


- (void)viewDidLayoutSubviews{
    [super viewDidLayoutSubviews];
    
    [self.webView mas_remakeConstraints:^(MASConstraintMaker *make) {
        if (@available(iOS 11.0, *)) {
            make.edges.mas_equalTo(self.view).insets(self.view.safeAreaInsets);
        } else {
                // Fallback on earlier versions
            make.edges.mas_equalTo(self.view).insets(self.view.layoutMargins);
            
        }
    }];
}

- (void)webView:(WKWebView *)webView didStartProvisionalNavigation:(WKNavigation *)navigation{
    
   // NSLog(@"did start url = %@",webView.URL.absoluteString);
    NSString *url = webView.URL.absoluteString;
    if ([url isEqualToString:@"http://www.suo.com/mobile/html/pointspro_list.html"]) {
        UIViewController *vc = GALiveMainViewController.new;
        [self.navigationController pushViewController:vc animated:YES];
    }
}

- (void)webView:(WKWebView *)webView didFinishNavigation:(WKNavigation *)navigation{
    NSLog(@"finish -- %@",webView.URL);
}



- (void)userContentController:(WKUserContentController *)userContentController didReceiveScriptMessage:(WKScriptMessage *)message{
    NSLog(@"message --%@",message);
}
@end
