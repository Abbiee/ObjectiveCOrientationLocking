//
//  KonyWebViewController.m
//  WKWebViewObjC
//
//  Created by Abbie on 07/07/20.
//  Copyright © 2020 Abbie. All rights reserved.
//

#import "KonyWebViewController.h"
#import <WebKit/WebKit.h>
#import "AppDelegate.h"

@interface KonyWebViewController ()<WKNavigationDelegate,WKUIDelegate>{
    WKWebView *_konyWebLoader;
    BOOL allowLoad;
    UIActivityIndicatorView *activityView;
}
@end

@implementation KonyWebViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    allowLoad = YES;
    [self restrictRotation:YES];
    WKPreferences *preferences = [[WKPreferences alloc] init];
    WKWebViewConfiguration *configuration = [[WKWebViewConfiguration alloc] init];
    configuration.preferences = preferences;
    UINavigationBar *myNav = [[UINavigationBar alloc]initWithFrame:CGRectMake(0, [UIApplication sharedApplication].statusBarFrame.size.height, self.view.frame.size.width, 50)];
     [myNav setAutoresizingMask: UIViewAutoresizingFlexibleWidth];
     [UINavigationBar appearance].barTintColor = [UIColor colorWithRed: 0.40 green: 0.16 blue: 0.51 alpha: 1.00];
    [[UINavigationBar appearance] setTitleTextAttributes:
    [NSDictionary dictionaryWithObjectsAndKeys:
        [UIColor whiteColor], NSForegroundColorAttributeName,
           [UIFont fontWithName:@"ArialMT" size:16.0], NSFontAttributeName,nil]];
     [self.view addSubview:myNav];
    UIImage *image = [[UIImage imageNamed:@"WhiteArrow"] imageWithRenderingMode:UIImageRenderingModeAlwaysOriginal];
//     UIBarButtonItem *cancelItem = [[UIBarButtonItem alloc] initWithTitle:@"< Back"
//                                                                    style:UIBarButtonItemStylePlain
//                                                                   target:self
//                                                                   action:@selector(back:)];
    
    UIBarButtonItem *cancelItem = [[UIBarButtonItem alloc] initWithImage: image
     style:UIBarButtonItemStylePlain
    target:self
    action:@selector(back:)];

     UINavigationItem *navigItem = [[UINavigationItem alloc] initWithTitle:_titleName];
     //navigItem.rightBarButtonItem = doneItem;
     navigItem.leftBarButtonItem = cancelItem;
     myNav.items = [NSArray arrayWithObjects: navigItem,nil];

     [UIBarButtonItem appearance].tintColor = [UIColor whiteColor];
    _konyWebLoader = [[WKWebView alloc] initWithFrame:CGRectMake(0, [UIApplication sharedApplication].statusBarFrame.size.height + 50, self.view.frame.size.width, self.view.frame.size.height - ([UIApplication sharedApplication].statusBarFrame.size.height + 70))configuration:configuration];
   // [_konyWebLoader setAutoresizingMask:UIViewAutoresizingFlexibleHeight | UIViewAutoresizingFlexibleWidth];
    _konyWebLoader.navigationDelegate = self;
    NSURL *url = [NSURL URLWithString: self.productURL];
    NSURLRequest *urlReq = [NSURLRequest requestWithURL:url];
    NSLog(@"Product URL%@", _productURL);
    NSLog(@"TItle%@", _titleName);
    [_konyWebLoader loadRequest:urlReq];
    [self.view addSubview:_konyWebLoader];
}

- (void)webView:(WKWebView *)webView didStartProvisionalNavigation:(WKNavigation *)navigation {
    activityView = [[UIActivityIndicatorView alloc]
        initWithActivityIndicatorStyle:UIActivityIndicatorViewStyleGray];

    activityView.center=self.view.center;
    [activityView startAnimating];
    [self.view addSubview:activityView];
    
}
- (void)webView:(WKWebView *)webView didFinishNavigation:(WKNavigation *)navigation {
//[MBProgressHUD hideAllProgressHUDsForView:self.view animated:YES];
  NSLog(@"Delegate called");
  [activityView stopAnimating];
  allowLoad = NO;}

- (void)webView:(WKWebView *)webView decidePolicyForNavigationAction:(WKNavigationAction *)navigationAction decisionHandler:(void (^)(WKNavigationActionPolicy))decisionHandler {
if (allowLoad == YES) {
    decisionHandler(WKNavigationActionPolicyAllow);
} else {
    NSLog(@"allowLoad NO");
    decisionHandler(WKNavigationActionPolicyCancel);
}}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (void)back:(UIBarButtonItem *)sender {
    NSLog(@"Executing backButtonClicked...");
    [self restrictRotation:NO];
    [self dismissViewControllerAnimated:YES completion:nil];
}

-(void) restrictRotation:(BOOL) restriction
{
    AppDelegate* appDelegate = (AppDelegate*)[UIApplication sharedApplication].delegate;
    appDelegate.restrictRotation = restriction;
}

// Source For Orientation Lock : https://stackoverflow.com/questions/31794317/how-can-i-lock-orientation-for-a-specific-view-an-objective-c-iphone-app-in-ios
@end
