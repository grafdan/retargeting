//
//  WebViewController.h
//  Retargeting
//
//  Created by Daniel Graf on 17.02.13.
//  Copyright (c) 2013 Daniel Graf. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "LibraryViewController.h"

@protocol WebViewDelegateProtocol;

@interface WebViewController : UIViewController <UIWebViewDelegate>
@property (nonatomic,weak) NSObject <WebViewDelegateProtocol> * delegate;
@property (nonatomic,strong) NSString *filename;
@property (nonatomic,strong) UIWebView *webView;
- (void) setFilename:(NSString *)aFilename;
@end
