//
//  QSCAlertManager.h
//  qingsongchou
//
//  Created by qsc on 16/8/29.
//  Copyright © 2016年 Chai. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface ProgressHUD : NSObject

singleton_interface(ProgressHUD)

+ (void)showError:(NSString *)errorMsg Interaction:(BOOL)interaction;
+ (void)showSuccess:(NSString *)successMsg Interaction:(BOOL)interaction;
+ (void)showSuccess:(NSString *)msg;
+ (void)showError:(NSString *)msg;
- (void)dissHUD;
@end

