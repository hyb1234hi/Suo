//
//  GAMainViewController.m
//  Suo
//
//  Created by 怪兽 🐙 on 2019/7/26.
//  Copyright © 2019 怪兽 🐙. All rights reserved.
//

#import "GAMainViewController.h"
#import "GALiveMainViewController.h"
#import "GALiveTabBarViewController.h"

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
    [config.userContentController addScriptMessageHandler:self name:@"onClickButton"];  //注册方法
    [config.userContentController addScriptMessageHandler:self name:@"jsCallOC"];

    
    _webView = [[WKWebView alloc] initWithFrame:self.view.bounds configuration:config];
    [_webView setNavigationDelegate:self];
    [_webView setUIDelegate:self];

    
    NSLog(@"cookie -------- %@",[[NSHTTPCookieStorage sharedHTTPCookieStorage] cookies]);
    
    
    NSURL *url = [NSURL URLWithString:@"http://www.suo.com/mobile/index0.html"];
    
    NSURLRequest *request = [NSURLRequest requestWithURL:url cachePolicy:NSURLRequestReloadIgnoringCacheData timeoutInterval:30];
    [_webView loadRequest:request];
    
    [_webView evaluateJavaScript:@"" completionHandler:^(id _Nullable obj, NSError * _Nullable error) {
        
    }];
    
    
    
//        //缓存
//    NSSet *dataSet = [WKWebsiteDataStore allWebsiteDataTypes];
//    NSDate *date = [NSDate dateWithTimeIntervalSince1970:0];
//    [[WKWebsiteDataStore defaultDataStore] removeDataOfTypes:dataSet modifiedSince:date completionHandler:^{
//            //清除完成
//    }];
    
    [self.view addSubview:_webView];
    [self.navigationController setNavigationBarHidden:YES animated:YES];
    
    [self pushToLive];
    
    UIButton *button = [[UIButton alloc] initWithFrame:CGRectMake(0, 0, 80, 35)];
    [button setTitle:@"直播中心" forState:UIControlStateNormal];
    [button addTarget:self action:@selector(pushToLive) forControlEvents:UIControlEventTouchUpInside];
    [button setTitleColor:UIColor.blueColor forState:UIControlStateNormal];
    [self.view addSubview:button];
    [button mas_remakeConstraints:^(MASConstraintMaker *make) {
        make.center.mas_equalTo(self.view);
    }];
}


- (void)pushToLive{
    GALiveTabBarViewController *vc = GALiveTabBarViewController.new; //GALiveMainViewController.new;
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
        [self pushToLive];
    }
}

- (void)webView:(WKWebView *)webView decidePolicyForNavigationResponse:(WKNavigationResponse *)navigationResponse decisionHandler:(void (^)(WKNavigationResponsePolicy))decisionHandler{
    
    if ([navigationResponse.response.URL.absoluteString isEqualToString:@"http://www.suo.com/mobile/html/pointspro_list.html"]) {
        decisionHandler(WKNavigationResponsePolicyCancel);
        return;
    }
    
    if (@available(iOS 12.0, *)) {
        WKHTTPCookieStore *cookieStore = webView.configuration.websiteDataStore.httpCookieStore;
        [cookieStore getAllCookies:^(NSArray* cookies) {
           // NSLog(@"cookies  --- %@",cookies);
            for (NSHTTPCookie *cookie in cookies) {
                //NSLog(@"cookie pt -- %@",cookie.properties);
                
                //共享用户 key username cookies
                if ([[cookie.properties valueForKey:NSHTTPCookieName] isEqualToString:@"key"]) {
                    [[NSHTTPCookieStorage sharedHTTPCookieStorage] setCookie:cookie];
                    //NSLog(@"cookie == %@",cookie);
                }
                if ([[cookie.properties valueForKey:NSHTTPCookieName] isEqualToString:@"username"]) {
                    [[NSHTTPCookieStorage sharedHTTPCookieStorage] setCookie:cookie];
                }
            }
        }];
    }else {
        NSHTTPURLResponse *response = (NSHTTPURLResponse *)navigationResponse.response;
        NSArray *cookies =[NSHTTPCookie cookiesWithResponseHeaderFields:[response allHeaderFields] forURL:response.URL];
        //NSLog(@"------------------------cookies -- %@",cookies);
    }
    
    decisionHandler(WKNavigationResponsePolicyAllow);
}

- (void)webView:(WKWebView *)webView didFinishNavigation:(WKNavigation *)navigation{
    NSLog(@"finish -- %@",webView.URL);
}

- (void)jsCallOC:(NSDictionary*)dict{
    NSLog(@">>>");
}

- (void)userContentController:(WKUserContentController *)userContentController
      didReceiveScriptMessage:(WKScriptMessage *)message{
    NSLog(@"JS message --%@",message);
    NSLog(@" name == %@",message.name);
    NSLog(@" body --%@",message.body);
}
@end
