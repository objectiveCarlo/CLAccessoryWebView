//
//  CLAccessoryWebView.h
//  Rundavoo
//
//  Created by  on 1/21/14.
//
//

#import <Cordova/CDVPlugin.h>

@interface CLAccessoryWebView : CDVPlugin<UIWebViewDelegate>{
    UIWebView *accesoryWebview;
    NSString *originalUrlString;
    UIActivityIndicatorView *activityView;
}
- (void)open:(CDVInvokedUrlCommand*)command;
- (void)close:(CDVInvokedUrlCommand*)command;
@end
