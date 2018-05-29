//
//  QSCAccountTool.m
//  qingsongchou
//
//  Created by Chai on 15/9/15.
//  Copyright (c) 2015年 Chai. All rights reserved.
//
#define kFile [NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES)[0] stringByAppendingPathComponent:@"account.data"]

#import "QSCAccountTool.h"
#import "AppDelegate.h"
#import "JPUSHService.h"
#import "QSCUMengTool.h"
//#import "QSCMsgController.h"


@implementation QSCAccountTool
single_implementation(QSCAccountTool)

- (id)init
{
    if (self = [super init]) {
        _account = [NSKeyedUnarchiver unarchiveObjectWithFile:kFile];
    }
    return self;
}

- (void)saveAccount:(QSCAccount *)account
{
    _account = account;
    [NSKeyedArchiver archiveRootObject:account toFile:kFile];
}

/**
 *  是否登录
 */
- (BOOL)isLogin
{
    if (QSCLoginAccountTool.account) {
        return YES;
    }else{
        return NO;
    }
}

/**
 *  退出app账户操作
 */
- (void)logoutQSCAccount
{
    [self unbindAccount];
    [self removeAgent];
    
    [[QSCAccountTool sharedQSCAccountTool] saveAccount:nil];
    //获取归档路路径,清空沙盒
    NSArray *pathArray = NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES);
    NSString *shahePath = [pathArray objectAtIndex:0];
    NSError *error;
    NSFileManager *defaultManager = [NSFileManager defaultManager];
    NSArray *tmplist = [[NSFileManager defaultManager] contentsOfDirectoryAtPath:shahePath error:nil];
    for (NSString *filename in tmplist) {
        MYLog(@"沙盒文件-----%@",filename);
        if([filename rangeOfString:@"storePdf"].location !=NSNotFound || [filename rangeOfString:@"account.data"].location !=NSNotFound){
            NSString *fullpath = [shahePath stringByAppendingPathComponent:filename];
            if ([defaultManager isDeletableFileAtPath:fullpath]) {
                [defaultManager removeItemAtPath:fullpath error:&error];
            }
        }
    }
    MYLog(@"退出登录");
    
    [[QSCUMengTool sharedQSCUMengTool] outAccountCount];//退出友盟账号统计

}

-(void)unbindAccount
{
    QSCAccount *account = [QSCAccountTool sharedQSCAccountTool].account;
    if (account.user.phone.length > 0) {
    [JPUSHService setAlias:@"" callbackSelector:@selector(tagsAliasCallback:tags:alias:) object:self];
    }
}

- (void)tagsAliasCallback:(int)iResCode
                     tags:(NSSet *)tags
                    alias:(NSString *)alias {
    MYLog(@"rescode: %d, \ntags: %@, \nalias: %@\n", iResCode, tags , alias);
}



- (void)removeAgent
{
    UIWebView *webView = [[UIWebView alloc] initWithFrame:CGRectZero];
    NSString *oldAgent = [webView stringByEvaluatingJavaScriptFromString:@"navigator.userAgent"];
    if ([oldAgent rangeOfString:@"qshz_custom"].length > 0 ) {
        oldAgent = [oldAgent substringToIndex:[oldAgent rangeOfString:@"qshz_custom"].location];
    }
    NSDictionary *dictionnary = [[NSDictionary alloc] initWithObjectsAndKeys:oldAgent, @"UserAgent", nil];
    [[NSUserDefaults standardUserDefaults] registerDefaults:dictionnary];
}


/*
 * 获取本地 标签文件目录
 */
+ (NSString *)getLocalCategoryFilePath{
    NSArray *loacalPaths = NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES);
    NSString *categoryFilePath = [loacalPaths objectAtIndex:0];
    NSString *savedFileName = [NSString stringWithFormat:@"localSelectedcategory.plist"];
    NSString *localCategoryFilePath = [categoryFilePath stringByAppendingPathComponent:savedFileName];
    return localCategoryFilePath;
}

/*
 * 获取本地 用户 发起｜支持｜关注 文件目录
 */
+ (NSString *)getLocalUserProjectNumFilePath{
    NSArray *loacalPaths = NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES);
    NSString *projectNumFilePath = [loacalPaths objectAtIndex:0];
    NSString *savedFileName = [NSString stringWithFormat:@"UserId-%@sLocalProjectNumFile.plist",[QSCAccountTool sharedQSCAccountTool].account.user.user_id];
    NSString *localProjectNumFilePath = [projectNumFilePath stringByAppendingPathComponent:savedFileName];
    return localProjectNumFilePath;
}

@end








