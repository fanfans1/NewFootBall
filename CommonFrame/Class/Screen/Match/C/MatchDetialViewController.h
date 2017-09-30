//
//  MatchDetialViewController.h
//  CommonFrame
//
//  Created by Guang shen on 2017/9/29.
//  Copyright © 2017年 fanfan. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <WebKit/WebKit.h>

@interface MatchDetialViewController : UIViewController<WKNavigationDelegate>

@property (nonatomic, retain) WKWebView* webView;
@property (nonatomic, retain)NSString *url;

@end
