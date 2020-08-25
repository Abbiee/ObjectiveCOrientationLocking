//
//  EmbedViewController.m
//  WKWebViewObjC
//
//  Created by Abbie on 11/08/20.
//  Copyright © 2020 Abbie. All rights reserved.
//

#import "EmbedViewController.h"
#import <WebKit/WebKit.h>

@interface EmbedViewController ()<WKNavigationDelegate,WKUIDelegate>{
    WKWebView *_webLoader;
}

@end

@implementation EmbedViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    WKPreferences *preferences = [[WKPreferences alloc] init];
    WKWebViewConfiguration *configuration = [[WKWebViewConfiguration alloc] init];
    configuration.preferences = preferences;
    _webLoader = [[WKWebView alloc] initWithFrame:CGRectMake(0, 55, self.view.frame.size.width, self.view.frame.size.height)configuration:configuration];
    [_webLoader setAutoresizingMask:UIViewAutoresizingFlexibleHeight | UIViewAutoresizingFlexibleWidth];
    NSString *htmlString = [NSString stringWithFormat:@"<html><head><meta name = \"viewport\" content = \"initial-scale = 1.0, user-scalable = yes, width = 320\"/></head><body style=\"background:#00;margin-top:0px;margin-left:5px\"><div><object width=\"320\" height=\"480\"><param name=\"movie\" value=\"https://www.youtube.com/embed/rCFstE7xE88\"></param><param name=\"wmode\" value=\"transparent\"></param><embed src=\"https://www.youtube.com/embed/rCFstE7xE88\"type=\"application/x-shockwave-flash\" wmode=\"transparent\" width=\"320\" height=\"480\"></embed></object></div></body></html>"];

    [_webLoader loadHTMLString:htmlString baseURL:nil];
    [self.view addSubview:_webLoader];
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
