//
//  QSCWirteUserInfoWebView.h
//  qingsongchou
//
//  Created by zhangzhenwei on 2017/7/9.
//  Copyright © 2017年 Chai. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface QSCWirteUserInfoWebView : UIView

singleton_interface(QSCWirteUserInfoWebView)


@property (weak, nonatomic) IBOutlet UIWebView *myWebView;
@property (nonatomic, copy) NSString *webUrl;

-(void)loadUrl:(NSString *)url;


@end
