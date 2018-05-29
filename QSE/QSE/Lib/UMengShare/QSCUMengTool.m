//
//  QSCUMengTool.m
//  qingsongchou
//
//  Created by lifuzhou on 16/5/25.
//  Copyright © 2016年 Chai. All rights reserved.
//

#import "QSCUMengTool.h"
#import <UMMobClick/MobClick.h>
@implementation QSCUMengTool
single_implementation(QSCUMengTool)


- (void)UMConfigInit
{
    UMConfigInstance.appKey = UMengKey;
    UMConfigInstance.channelId = @""; //发送渠道
    UMConfigInstance.eSType = E_UM_NORMAL; // 仅适用于游戏场景
    UMConfigInstance.ePolicy = BATCH; //发送策略的设置BATCH = 1,/启动发送 SEND_INTERVAL = 6,
    
    [MobClick startWithConfigure:UMConfigInstance];

    NSString *version = [[[NSBundle mainBundle] infoDictionary] objectForKey:@"CFBundleShortVersionString"];
    [MobClick setAppVersion:version];//设置应用程序的版本标识
    
#if DEBUG
    // 打开友盟sdk调试，注意Release发布时需要注释掉此行,减少io消耗
    [MobClick setLogEnabled:YES];
#endif
    return;
}

//启动页面时统计
- (void)beginLogPageView:(__unsafe_unretained Class)pageView {
    [MobClick beginLogPageView:NSStringFromClass(pageView)];
    MYLog(@">>>>>启动类名%@",NSStringFromClass(pageView));
    return;
}
//离开页面时统计
- (void)endLogPageView:(__unsafe_unretained Class)pageView {
    [MobClick endLogPageView:NSStringFromClass(pageView)];
    MYLog(@">>>>>结束类名%@",NSStringFromClass(pageView));

    return;
}

//账号登录时统计
- (void)loginAccountCountForId:(NSString *)userid plateform:(NSString *)provider
{
    if ([provider isEqualToString:@""]) {
        
        [MobClick profileSignInWithPUID:userid];

    }else
    {
        [MobClick profileSignInWithPUID:userid provider:provider];

    }
}

//账号登出时需调用此接口，调用之后不再发送账号相关内容
- (void)outAccountCount
{
    [MobClick profileSignOff];
}
@end
