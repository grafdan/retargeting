//
//  WebViewController.m
//  Retargeting
//
//  Created by Daniel Graf on 17.02.13.
//  Copyright (c) 2013 Daniel Graf. All rights reserved.
//
//    This file is part of Refooormat.
//
//    Refooormat is free software: you can redistribute it and/or modify
//    it under the terms of the GNU General Public License as published by
//    the Free Software Foundation, either version 3 of the License, or
//    (at your option) any later version.
//
//    Refooormat is distributed in the hope that it will be useful,
//    but WITHOUT ANY WARRANTY; without even the implied warranty of
//    MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
//    GNU General Public License for more details.
//
//    You should have received a copy of the GNU General Public License
//    along with Refooormat.  If not, see <http://www.gnu.org/licenses/>.

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
