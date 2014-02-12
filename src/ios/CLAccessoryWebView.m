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
    
    float minusHeight = frame.size.height - yPosition;
    
    if(height > minusHeight){
        frame.size.height = minusHeight;
    }else{
        frame.size.height = height;
    }
    if(accesoryWebview != nil) [accesoryWebview removeFromSuperview];
    
    accesoryWebview = [[UIWebView alloc] initWithFrame:frame];
    [accesoryWebview setDelegate:self];
    
    NSMutableURLRequest *request = [NSMutableURLRequest requestWithURL:[NSURL
                                                                        
                                                                        URLWithString:url]
                                    
                                                           cachePolicy:NSURLRequestUseProtocolCachePolicy
                                    
                                                       timeoutInterval:60.0];
    
    originalUrlString = [[NSString alloc] initWithString:url];
    
    
    [self.webView addSubview:accesoryWebview];
    if(activityView == nil){
        activityView=[[UIActivityIndicatorView alloc]     initWithActivityIndicatorStyle:UIActivityIndicatorViewStyleGray];
        activityView.autoresizingMask = UIViewAutoresizingFlexibleLeftMargin | UIViewAutoresizingFlexibleWidth | UIViewAutoresizingFlexibleRightMargin | UIViewAutoresizingFlexibleTopMargin | UIViewAutoresizingFlexibleHeight | UIViewAutoresizingFlexibleBottomMargin;
         [self.webView addSubview:activityView];
    }
    activityView.center=self.webView.center;
    
    [activityView startAnimating];
    
    [accesoryWebview loadRequest:request];
}
- (void)close:(CDVInvokedUrlCommand*)command{
    
    if(accesoryWebview !=nil) [accesoryWebview removeFromSuperview];
    if(activityView == nil) [activityView stopAnimating];
}

#pragma mark - UIWebViewDelegate methods

- (BOOL) webView:(UIWebView *)inWeb shouldStartLoadWithRequest:(NSURLRequest *)inRequest navigationType:(UIWebViewNavigationType)inType {
   
    if ( inType == UIWebViewNavigationTypeLinkClicked ) {
        [[UIApplication sharedApplication] openURL:[inRequest URL]];
        return NO;
    }
    

    
    return YES;
}
- (void) webViewDidStartLoad:(UIWebView *)webView{
    if(activityView != nil && !activityView.isAnimating) [activityView startAnimating];
}
- (void) webViewDidFinishLoad:(UIWebView *)webView{
      if(activityView != nil && activityView.isAnimating) [activityView stopAnimating];
}
@end
