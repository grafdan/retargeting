//
//  WebViewController.m
//  Retargeting
//
//  Created by Daniel Graf on 17.02.13.
//  Copyright (c) 2013 Daniel Graf. All rights reserved.
//

#import "WebViewController.h"

@interface WebViewController ()
@end

@implementation WebViewController {
    NSString * title;
}
@synthesize filename = _filename;
@synthesize webView = _webView;

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
    }
    return self;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
	// Do any additional setup after loading the view.
    self.view.backgroundColor = [UIColor blueColor];
//    self.navigationItem.title = self.title;
    self.navigationItem.rightBarButtonItem = [[UIBarButtonItem alloc] initWithBarButtonSystemItem:UIBarButtonSystemItemDone target:self.delegate action:@selector(didFinishReadingWebsite:)];

    self.webView = [[UIWebView alloc] init];
    self.webView.delegate = self;
//    self.webView.scalesPageToFit = YES;
    NSString * pagePath = [[NSBundle mainBundle] pathForResource:self.filename ofType:@"html"];
    pagePath = [pagePath stringByAddingPercentEscapesUsingEncoding:NSUTF8StringEncoding];
//    NSString * pageContent = [NSString stringWithContentsOfFile:pagePath
//                                                       encoding:NSUTF8StringEncoding
//                                                          error:nil];
    NSURL * url = [NSURL URLWithString:pagePath];
    NSURLRequest *urlRequest = [NSURLRequest requestWithURL:url];
    [self.webView loadRequest:urlRequest];
    self.view = self.webView;
}
- (void)webViewDidFinishLoad:(UIWebView *)webView{
    NSString *pageTitle=[self.webView stringByEvaluatingJavaScriptFromString:@"document.title"];
    self.title = pageTitle;
}

-(BOOL) webView:(UIWebView *)inWeb shouldStartLoadWithRequest:(NSURLRequest *)inRequest navigationType:(UIWebViewNavigationType)inType {
    NSLog(@"link");
    NSLog(@"URL host: %@",inRequest.URL.host);
    NSLog(@"URL path: %@",inRequest.URL.path);
    NSLog(@"URL scheme: %@",inRequest.URL.scheme);
    // open external links in Safari
    if ( ![inRequest.URL.scheme isEqual: @"file"] ) {
//        NSLog(@"follow link to %@",inRequest.URL.path);
        [[UIApplication sharedApplication] openURL:inRequest.URL];
        return NO;
    }
    
    return YES;
}

- (BOOL)shouldAutorotateToInterfaceOrientation:
(UIInterfaceOrientation)interfaceOrientation
{
    // Return YES for supported orientations
    return YES;
}
- (BOOL)shouldAutorotate {
    return YES;
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
