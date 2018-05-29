//
//  QSCTipHUDManager.m
//  qingsongchou
//
//  Created by qsc on 16/8/29.
//  Copyright © 2016年 Chai. All rights reserved.
//

#import "QSCTipHUDManager.h"
#import "UIColor+Extension.h"

@interface QSCTipHUDManager ()
{
    UIView *_backCover;
    UIActivityIndicatorView *_indicator;
}
@end

@implementation QSCTipHUDManager

singleton_implementation(QSCTipHUDManager)

- (void)showHUD {
    
    if (_backCover) return;
    if (_indicator) return;
    
    //背景view
    dispatch_async(dispatch_get_main_queue(), ^{
        _backCover = [[UIView alloc] init];
        _backCover.bounds = CGRectMake(0, 0, 90, 50);
        _backCover.center = CGPointMake(kDeviceWidth / 2, KDeviceHeight / 2);
        _backCover.backgroundColor = [UIColor colorWithHexColorString:@"000000" alpha:0.6];
        _backCover.layer.cornerRadius = 6.f;
        [_backCover.layer setMasksToBounds:YES];
        [WINDOW addSubview:_backCover];
        
        //动画
        _indicator = [[UIActivityIndicatorView alloc] initWithActivityIndicatorStyle:UIActivityIndicatorViewStyleWhite];
        _indicator.bounds = CGRectMake(0, 0, 26, 26);
        _indicator.center = CGPointMake(_backCover.bounds.size.width / 2, _backCover.bounds.size.height / 2);
        [_backCover addSubview:_indicator];
        
        //开始动画
        [_indicator startAnimating];
        });
}

- (void)hideHUD {

    if (!_indicator && !_backCover) return;
    
    [_indicator stopAnimating];
    _indicator = nil;
    [_indicator removeFromSuperview];
    
    _backCover.alpha = 0.f;
    _backCover = nil;
    [_backCover removeFromSuperview];
}

@end
