//
//  QSCAccountTool.h
//  qingsongchou
//
//  Created by Chai on 15/9/15.
//  Copyright (c) 2015年 Chai. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "Singleton.h"
#import "QSCAccount.h"

#define QSCLoginAccountTool [QSCAccountTool sharedQSCAccountTool]

@interface QSCAccountTool : NSObject

singleton_interface(QSCAccountTool)

- (void)saveAccount:(QSCAccount *)account;

// 获得当前账号
@property (nonatomic, readonly) QSCAccount * account;


/**
 *  是否登录
 */
- (BOOL)isLogin;

/**
 *  退出app账户操作
 */
- (void)logoutQSCAccount;

/*
 * 获取本地 标签目录
 */
+ (NSString *)getLocalCategoryFilePath;

/*
 * 获取本地 用户 发起｜支持｜关注 文件目录
 */
+ (NSString *)getLocalUserProjectNumFilePath;
@end










