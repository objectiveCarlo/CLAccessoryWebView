//
//  CLAccessoryWebView.m
//  Rundavoo
//
//  Created by  on 1/21/14.
//
//

#import "CLAccessoryWebView.h"

@implementation CLAccessoryWebView
- (void)open:(CDVInvokedUrlCommand*)command{
    NSString* url = [command argumentAtIndex:0];
   float xPosition = [[command argumentAtIndex:1] floatValue];
   float yPosition = [[command argumentAtIndex:2] floatValue];
    
    CGRect frame = self.webView.frame;
    frame.origin = CGPointMake(xPosition, yPosition);
    
    if(accesoryWebview != nil) [accesoryWebview removeFromSuperview];
    
    accesoryWebview = [[UIWebView alloc] initWithFrame:frame];

    
    NSMutableURLRequest *request = [NSMutableURLRequest requestWithURL:[NSURL
                                                                        
                                                                        URLWithString:url]
                                    
                                                           cachePolicy:NSURLRequestUseProtocolCachePolicy
                                    
                                                       timeoutInterval:60.0];
    
    [accesoryWebview loadRequest:request];
    
    [self.webView addSubview:accesoryWebview];
}
- (void)close:(CDVInvokedUrlCommand*)command{
    
    if(accesoryWebview !=nil) [accesoryWebview removeFromSuperview];
}
@end
