//
//  CLAccessoryWebView.h
//  Rundavoo
//
//  Created by  on 1/21/14.
//
//

#import <Cordova/CDVPlugin.h>

@interface CLAccessoryWebView : CDVPlugin{
    UIWebView *accesoryWebview;
}
- (void)open:(CDVInvokedUrlCommand*)command;
- (void)close:(CDVInvokedUrlCommand*)command;
@end
