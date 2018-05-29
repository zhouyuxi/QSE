//
//  QSCUMengTool.h
//  qingsongchou
//
//  Created by lifuzhou on 16/5/25.
//  Copyright © 2016年 Chai. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface QSCUMengTool : NSObject
single_interface(QSCUMengTool)

- (void)UMConfigInit;//友盟初始化

- (void)beginLogPageView:(__unsafe_unretained Class)pageView; //页面开始统计

- (void)endLogPageView:(__unsafe_unretained Class)pageView; //页面结束统计

//账号登录时统计
- (void)loginAccountCountForId:(NSString *)userid plateform:(NSString *)provider;

//账号登出时需调用此接口，调用之后不再发送账号相关内容
- (void)outAccountCount;


@end
