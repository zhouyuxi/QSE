//
//  QSCNetworkTipManager.h
//  qingsongchou
//
//  Created by qsc on 16/8/30.
//  Copyright © 2016年 Chai. All rights reserved.
// 无网络提示语管理

#import <Foundation/Foundation.h>

@class QSCNewworkTipView;

@interface QSCNetworkTipManager : NSObject

singleton_interface(QSCNetworkTipManager)

//检查当前网络
- (QSCNewworkTipView *)checkCurrentNetworkInView:(UIView *)view;


@end
