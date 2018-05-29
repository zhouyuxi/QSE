////
////  QSCWirteUserInfoWebView.m
////  qingsongchou
////
////  Created by zhangzhenwei on 2017/7/9.
////  Copyright © 2017年 Chai. All rights reserved.
////
//
//#import "QSCWirteUserInfoWebView.h"
//
//@interface QSCWirteUserInfoWebView()<UIWebViewDelegate>
//
//@end
//
//@implementation QSCWirteUserInfoWebView
//
//
//
//-(void)awakeFromNib{
//    [super awakeFromNib];
//    self.myWebView.delegate = self;
//    self.frame = CGRectZero;
//
//    self.backgroundColor = [UIColor greenColor];
//    self.hidden = YES;
//    [[UIApplication sharedApplication].keyWindow addSubview:self];
//}
//
//
//
//
//-(void)loadUrl:(NSString *)url;
//{
////    url = @"https://m2.qschou.com/my/loveValue";
//    //1加载资源
//    NSString *str = [url stringByAddingPercentEscapesUsingEncoding:NSUTF8StringEncoding];
//    NSMutableURLRequest *mRequest=[NSMutableURLRequest requestWithURL:[NSURL URLWithString:str]];
//    //2加载
//    [self.myWebView loadRequest:mRequest];
//}
//
//
//-(void)webViewDidFinishLoad:(UIWebView *)webView
//{
//    [self.myWebView stringByEvaluatingJavaScriptFromString:@"document.documentElement.style.webkitUserSelect='none';"];
//
//    [self.myWebView stringByEvaluatingJavaScriptFromString:@"document.documentElement.style.webkitTouchCallout='none';"];
//
//    dispatch_async(dispatch_get_main_queue(), ^{
//        QSCAccessTokenManager *tokenManager = [QSCAccessTokenManager sharedQSCAccessTokenManager];
//        if (tokenManager.currentToken.access_token.length > 0) {
//            NSString *userContent = [NSString stringWithFormat:@"\\\"{\\\\\"access_token\\\\\":\\\\\"%@\\\\\",\\\\\"expires_in\\\\\":\\\\\"%@\\\\\",\\\\\"cli_create_time\\\\\":\\\\\"%@\\\\\"}\\\"", tokenManager.currentToken.access_token, tokenManager.currentToken.expires_in, tokenManager.currentToken.srv_create_time];
//            NSString *jsString = [NSString stringWithFormat:@"localStorage.setItem('Qsc-Token', '%@')", userContent];
//            [webView stringByEvaluatingJavaScriptFromString:jsString];
//        }else{
//            NSString *userContent = [NSString stringWithFormat:@"\\\"{\\\\\"access_token\\\\\":\\\\\"%@\\\\\",\\\\\"expires_in\\\\\":\\\\\"%@\\\\\",\\\\\"cli_create_time\\\\\":\\\\\"%@\\\\\"}\\\"", @"", @"", @""];
//            NSString *jsString = [NSString stringWithFormat:@"localStorage.setItem('Qsc-Token', '%@')", userContent];
//            [webView stringByEvaluatingJavaScriptFromString:jsString];
//        }
//    });
//
//    NSString *getString = [NSString stringWithFormat:@"window.localStorage.getItem('Qsc-Token')"];
//    NSString *jsgetString =  [webView stringByEvaluatingJavaScriptFromString:getString];
//
//    MYLog(@"getItem --- %@",jsgetString);
//    [self removeFromSuperview];
//
//}
//
//
//
//- (void)webView:(UIWebView *)webView didFailLoadWithError:(NSError *)error{
//    [self.myWebView stringByEvaluatingJavaScriptFromString:@"document.documentElement.style.webkitUserSelect='none';"];
//
//    [self.myWebView stringByEvaluatingJavaScriptFromString:@"document.documentElement.style.webkitTouchCallout='none';"];
//
//    dispatch_async(dispatch_get_main_queue(), ^{
//        QSCAccessTokenManager *tokenManager = [QSCAccessTokenManager sharedQSCAccessTokenManager];
//        if (tokenManager.currentToken.access_token.length > 0) {
//            NSString *userContent = [NSString stringWithFormat:@"\\\"{\\\\\"access_token\\\\\":\\\\\"%@\\\\\",\\\\\"expires_in\\\\\":\\\\\"%@\\\\\",\\\\\"cli_create_time\\\\\":\\\\\"%@\\\\\"}\\\"", tokenManager.currentToken.access_token, tokenManager.currentToken.expires_in, tokenManager.currentToken.srv_create_time];
//            NSString *jsString = [NSString stringWithFormat:@"localStorage.setItem('Qsc-Token', '%@')", userContent];
//            [webView stringByEvaluatingJavaScriptFromString:jsString];
//        }else{
//            NSString *userContent = [NSString stringWithFormat:@"\\\"{\\\\\"access_token\\\\\":\\\\\"%@\\\\\",\\\\\"expires_in\\\\\":\\\\\"%@\\\\\",\\\\\"cli_create_time\\\\\":\\\\\"%@\\\\\"}\\\"", @"", @"", @""];
//            NSString *jsString = [NSString stringWithFormat:@"localStorage.setItem('Qsc-Token', '%@')", userContent];
//            [webView stringByEvaluatingJavaScriptFromString:jsString];
//        }
//    });
//
//    NSString *getString = [NSString stringWithFormat:@"window.localStorage.getItem('Qsc-Token')"];
//    NSString *jsgetString =  [webView stringByEvaluatingJavaScriptFromString:getString];
//
//    MYLog(@"getItem --- %@",jsgetString);
//    [self removeFromSuperview];
//
//}
//
//#pragma mark  -------目前只判断两种含有重定向的URL ， 其余的在工具类中执行------------
//- (BOOL)webView:(UIWebView *)webView shouldStartLoadWithRequest:(NSURLRequest *)request navigationType:(UIWebViewNavigationType)navigationType
//{
//
//    return YES;
//}
//
//
//
//@end

