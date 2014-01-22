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
   float height    = [[command argumentAtIndex:3] floatValue];
    CGRect frame = self.webView.frame;
    frame.origin = CGPointMake(xPosition, yPosition);
    if(height > 0) frame.size.height = height;
    if(accesoryWebview != nil) [accesoryWebview removeFromSuperview];
    
    accesoryWebview = [[UIWebView alloc] initWithFrame:frame];
    [accesoryWebview setDelegate:self];
    
    NSMutableURLRequest *request = [NSMutableURLRequest requestWithURL:[NSURL
                                                                        
                                                                        URLWithString:url]
                                    
                                                           cachePolicy:NSURLRequestUseProtocolCachePolicy
                                    
                                                       timeoutInterval:60.0];
    
    originalUrlString = [[NSString alloc] initWithString:url];
    [accesoryWebview loadRequest:request];
    
    [self.webView addSubview:accesoryWebview];
}
- (void)close:(CDVInvokedUrlCommand*)command{
    
    if(accesoryWebview !=nil) [accesoryWebview removeFromSuperview];
}

#pragma mark - UIWebViewDelegate methods

- (BOOL) webView:(UIWebView *)inWeb shouldStartLoadWithRequest:(NSURLRequest *)inRequest navigationType:(UIWebViewNavigationType)inType {
   
    if ( inType == UIWebViewNavigationTypeLinkClicked ) {
        [[UIApplication sharedApplication] openURL:[inRequest URL]];
        return NO;
    }
    
    NSURL* requestedURL = [inRequest URL];
    
    if(requestedURL != nil){
        NSString* requestedURLString = [requestedURL absoluteString];
        BOOL isEqual = [requestedURLString isEqualToString:originalUrlString];
        BOOL containsOriginal = [requestedURLString rangeOfString:originalUrlString].location != NSNotFound;
        BOOL containsRequested = [originalUrlString rangeOfString:requestedURLString].location != NSNotFound;
        BOOL decision = isEqual || containsOriginal || containsRequested;
        if(!decision){
            [[UIApplication sharedApplication] openURL:requestedURL];
            return NO;
        }
    }

    
    return YES;
}
@end
