//
//  QSCTipHUDManager.h
//  qingsongchou
//
//  Created by qsc on 16/8/29.
//  Copyright © 2016年 Chai. All rights reserved.
// 加载提示

#import <Foundation/Foundation.h>

@interface QSCTipHUDManager : NSObject

singleton_interface(QSCTipHUDManager)

- (void)showHUD;
- (void)hideHUD;

@end
