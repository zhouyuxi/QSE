//
//  QSCNetworkTipManager.m
//  qingsongchou
//
//  Created by qsc on 16/8/30.
//  Copyright © 2016年 Chai. All rights reserved.
//

#define kBackgroundViewHeight 40
#define kTipLabelHeight 20
#define kTipLabelWidth 250

#import "QSCNetworkTipManager.h"
#import "UIColor+Extension.h"
#import "Reachability.h"
#import "QSCNewworkTipView.h"

@interface QSCNetworkTipManager ()
{
    QSCNewworkTipView *_tipView; //提示语view
}
@end

@implementation QSCNetworkTipManager

singleton_implementation(QSCNetworkTipManager)

//检查当前网络
- (QSCNewworkTipView *)checkCurrentNetworkInView:(UIView *)view {

    //检查网络
    Reachability *reach=[Reachability reachabilityWithHostName:QSCIsExistNetwork];
    if (reach.currentReachabilityStatus == NotReachable){ //没有网络
        //展示提示框
        return [self showInView:view];
    }
    
    return nil;
}

- (QSCNewworkTipView *)showInView:(UIView *)view {
    
    if (!_tipView) {
        
        _tipView = [[QSCNewworkTipView alloc] initWithFrame:CGRectMake(0, 0, kDeviceWidth, kBackgroundViewHeight)];
        [view addSubview:_tipView];
        [view bringSubviewToFront:_tipView];
    }
    //开始动画
    [self startAnimation];
    
    return _tipView;
}

- (void)startAnimation {

    _tipView.alpha = 0.f;
    [UIView animateWithDuration:0.3 animations:^{
        
        _tipView.alpha = 1.f;
        
    } completion:^(BOOL finished) {
        //消失
        [self diss];
    }];
}

- (void)diss {

    dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(3.f * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
        
        [UIView animateWithDuration:0.3 animations:^{
            
            _tipView.alpha = 0.f;
            _tipView = nil;
            [_tipView removeFromSuperview];
        }];
    });
}
@end
