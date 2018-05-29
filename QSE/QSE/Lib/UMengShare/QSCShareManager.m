//
//  QSCShareManager.m
//  qingsongchou
//
//  Created by Chai on 16/3/15.
//  Copyright © 2016年 Chai. All rights reserved.
//

#import "QSCShareManager.h"
#import <ShareSDK/ShareSDK.h>
#import "QSCCover.h"
#import <ShareSDK3/WXApi.h>
#import <TencentOpenAPI/QQApiInterface.h>
#import "UIImage+Extension.h"
#import "AFNetworkReachabilityManager.h"
#import "Reachability.h"
#import "WeiboSDK.h"
#import "QSCTipHUDManager.h"

@interface QSCShareManager ()
@end
@implementation QSCShareManager
//lj
+ (void)shareProductParamsByText:(NSString *)text
                          images:(NSArray *)images
                             url:(NSURL *)url
                           title:(NSString *)title
                            type:(NSInteger)type
                         proUuid:(NSString *)uuid
                         shareTo:(int)shareTo

{

    MYLog(@"分享text%@,images%@,url=%@,title=%@,uuid=%@",text,images,url,title,uuid);
    
    if(text.length == 0 && title.length ==0 && images.count == 0)
    {
        [ProgressHUD showError:@"分享内容不能为空" Interaction:YES];
        return;
    }
    
    if(title.length > 40)
    {
        title = [title substringToIndex:40];
    }
    if (text.length > 40) {
        text = [text substringToIndex:40];
    }
    
    Reachability *reachability = [Reachability reachabilityForInternetConnection];
    
    NetworkStatus internetStatus = [reachability currentReachabilityStatus];
    if (internetStatus == NotReachable) {
        return [ProgressHUD showError:@"请检查网络" Interaction:YES];
    }
    
  
    
    NSString *myUrl = @"http://www.qschou.com";
    NSURL *theUrl;
    if (url) {
        theUrl = url;
    }else{
        theUrl = [NSURL URLWithString:myUrl];
    }
    
    MYLog(@"%@",theUrl);
    NSMutableDictionary *shareParams = [NSMutableDictionary dictionary];
    NSMutableArray *imageArray = [NSMutableArray array];
    
    MYLog(@"%@",images);
    for (id model in images) {
        if ([model isKindOfClass:[QSCCover class]]) {
            
            QSCCover *cover = (QSCCover *)model;
            
            [imageArray addObject:cover.thumb];
            
        }else if([model isKindOfClass:[NSString class]]){
            
            [imageArray addObject:model];
        }
    }
    
    
    if (imageArray.count == 0) {
        [imageArray addObject:@"http://static.qingsongchou.com/img/grey.png"];
    }
    
    if(type ==  SSDKPlatformTypeSinaWeibo)
    {
        NSString *temp = text.length ? text :title;
        text = [[temp stringByAppendingString:@"--轻松互助"] stringByAppendingString:theUrl.absoluteString] ;
        //        title = [title stringByAppendingString:theUrl.absoluteString];
    }
    
    [[QSCTipHUDManager sharedQSCTipHUDManager] showHUD];
    MYLog(@"imageArray   %@",imageArray);
    
    [self downloadImage:imageArray shareType:type success:^(NSArray * shareArrImage) {
        MYLog(@"shareArrImage   %@",shareArrImage);
        //  test      NSData *data = UIImageJPEGRepresentation(shareArrImage[0], 1.0) ;
        //        MYLog(@"___size___%ld",data.length);
        dispatch_async(dispatch_get_main_queue(), ^{
            
            [[QSCTipHUDManager sharedQSCTipHUDManager] hideHUD];
        });
        
        [shareParams SSDKEnableUseClientShare];  //使用客户端分享
        
        [shareParams SSDKSetupShareParamsByText:text
                                         images:shareArrImage
                                            url:theUrl
                                          title:[title stringByAppendingString:@"--轻松互助"]
                                           type:SSDKContentTypeAuto];
        MYLog(@"分享参数%@",shareParams);
        [ShareSDK share:type
             parameters:shareParams
         onStateChanged:^(SSDKResponseState state, NSDictionary *userData, SSDKContentEntity *contentEntity, NSError *error) {
             MYLog(@"分享回调信息%lu",(unsigned long)state);
             switch (state) {
                 case SSDKResponseStateSuccess:
                 {

//                     [QSCNotificationCenter postNotificationName:QSCRefreshShareCountNum object:nil];
//                     [self shareViewTapRetainCountAddProjectId:uuid shareTo:shareTo];//分享计数统计


                     if (type ==  SSDKPlatformTypeSinaWeibo  && ![WeiboSDK isWeiboAppInstalled]){
                         UIAlertView *alertView = [[UIAlertView alloc] initWithTitle:@"分享成功"
                                                                             message:nil
                                                                            delegate:nil
                                                                   cancelButtonTitle:@"确定"
                                                                   otherButtonTitles:nil];
                         [alertView show];
                     }
                     break;
                 }
                 case SSDKResponseStateFail:
                 {
                     
                     if (![QQApiInterface isQQInstalled] || ![WXApi isWXAppInstalled] ){
                         UIAlertView *alertView = [[UIAlertView alloc] initWithTitle:@"分享失败"
                                                                             message:nil
                                                                            delegate:nil
                                                                   cancelButtonTitle:@"确定"
                                                                   otherButtonTitles:nil];
                         [alertView show];
                         
                     }else{
                         MYLog(@"fail -%@",error);
                         UIAlertView *alertView = [[UIAlertView alloc] initWithTitle:@"分享失败"
                                                                             message:nil
                                                                            delegate:nil
                                                                   cancelButtonTitle:@"确定"
                                                                   otherButtonTitles:nil];
                         [alertView show];
                         
                     }
                     
                     break;
                 }
                 case SSDKResponseStateCancel:
                 {
                     
                     break;
                 }
                     
                     
                 default:
                     break;
             }
             
             //增加分享通知
//             [QSCNotificationCenter postNotificationName:@"DIDCLICKSHARE" object:nil];
             
         }];
        
    }];
}

+ (void)shareImageProductParamsByText:(NSString *)text
                          images:(NSArray *)images
                             url:(NSURL *)url
                           title:(NSString *)title
                            type:(NSInteger)type
                         proUuid:(NSString *)uuid
                         shareTo:(int)shareTo

{
    
    MYLog(@"分享text%@,images%@,url=%@,title=%@,uuid=%@",text,images,url,title,uuid);
    
    if(text.length == 0 && title.length ==0 && images.count == 0)
    {
        [ProgressHUD showError:@"分享内容不能为空" Interaction:YES];
        return;
    }
    
    if(title.length > 40)
    {
        title = [title substringToIndex:40];
    }
    if (text.length > 40) {
        text = [text substringToIndex:40];
    }
    
    Reachability *reachability = [Reachability reachabilityForInternetConnection];
    
    NetworkStatus internetStatus = [reachability currentReachabilityStatus];
    if (internetStatus == NotReachable) {
        return [ProgressHUD showError:@"请检查网络" Interaction:YES];
    }
    
    
    
    NSString *myUrl = @"http://www.qschou.com";
    NSURL *theUrl;
    if (url) {
        theUrl = url;
    }else{
        theUrl = [NSURL URLWithString:myUrl];
    }
    
    MYLog(@"%@",theUrl);
    NSMutableDictionary *shareParams = [NSMutableDictionary dictionary];
    NSMutableArray *imageArray = [NSMutableArray array];
    
    if(type ==  SSDKPlatformTypeSinaWeibo)
    {
        NSString *temp = text.length ? text :title;
        text = [[temp stringByAppendingString:@"--轻松互助"] stringByAppendingString:theUrl.absoluteString] ;
        //        title = [title stringByAppendingString:theUrl.absoluteString];
    }
    
    [[QSCTipHUDManager sharedQSCTipHUDManager] showHUD];
    MYLog(@"imageArray   %@",imageArray);
    
        dispatch_async(dispatch_get_main_queue(), ^{
            
            [[QSCTipHUDManager sharedQSCTipHUDManager] hideHUD];
        });
        
        [shareParams SSDKEnableUseClientShare];  //使用客户端分享
        
        [shareParams SSDKSetupShareParamsByText:nil
                                         images:images
                                            url:nil
                                          title:nil
                                           type:SSDKContentTypeImage];
        MYLog(@"分享参数%@",shareParams);
        [ShareSDK share:type
             parameters:shareParams
         onStateChanged:^(SSDKResponseState state, NSDictionary *userData, SSDKContentEntity *contentEntity, NSError *error) {
             MYLog(@"分享回调信息%lu",(unsigned long)state);
             switch (state) {
                 case SSDKResponseStateSuccess:
                 {
                     
                     if (type ==  SSDKPlatformTypeSinaWeibo  && ![WeiboSDK isWeiboAppInstalled]){
                         UIAlertView *alertView = [[UIAlertView alloc] initWithTitle:@"分享成功"
                                                                             message:nil
                                                                            delegate:nil
                                                                   cancelButtonTitle:@"确定"
                                                                   otherButtonTitles:nil];
                         [alertView show];
                     }
                     break;
                 }
                 case SSDKResponseStateFail:
                 {
                     
                     if (![QQApiInterface isQQInstalled] || ![WXApi isWXAppInstalled] ){
                         UIAlertView *alertView = [[UIAlertView alloc] initWithTitle:@"分享失败"
                                                                             message:@"未安装"
                                                                            delegate:nil
                                                                   cancelButtonTitle:@"确定"
                                                                   otherButtonTitles:nil];
                         [alertView show];
                         
                     }else{
                         MYLog(@"fail -%@",error);
                         UIAlertView *alertView = [[UIAlertView alloc] initWithTitle:@"分享失败"
                                                                             message:nil
                                                                            delegate:nil
                                                                   cancelButtonTitle:@"确定"
                                                                   otherButtonTitles:nil];
                         [alertView show];
                         
                     }
                     
                     break;
                 }
                 case SSDKResponseStateCancel:
                 {
                     
                     break;
                 }
                     
                     
                 default:
                     break;
             }
         }];
}


// lj
+ (void)downloadImage:(NSArray *)imageArray  shareType:(int)type success:(QSCSuccess )success
{
    dispatch_group_t group =  dispatch_group_create();
    dispatch_queue_t queue =  dispatch_queue_create("downloadImage", DISPATCH_QUEUE_CONCURRENT);
    NSInteger count = [imageArray count];
    __weak typeof(self) weakSelf = self;
    NSMutableArray *zipImageArr = [NSMutableArray arrayWithCapacity:count];
    
    
    for (NSInteger i = 0 ; i< count; i ++) {
        NSString *imageUrl = imageArray[i];
        dispatch_group_async(group, queue, ^{
            UIImage *zipImage = [weakSelf zipImageWithUrl:imageUrl];
            if (type != SSDKPlatformTypeSinaWeibo) {    //除新郎微博外  图片处理
                zipImage = [zipImage  transformtoSize:CGSizeMake(80, 80)];
            }
            if (zipImage) {
                [zipImageArr addObject:zipImage];
            }
            
        });
    }
    dispatch_group_notify(group, queue, ^{
        
        success (zipImageArr);
    });
    
}


// lj
+ (UIImage *)zipImageWithUrl:(NSString *)imageUrl
{
    NSData * imageData = [[NSData alloc]initWithContentsOfURL:[NSURL URLWithString:imageUrl]];
    CGFloat maxFileSize = 32*1024;
    CGFloat compression = 0.9f;
    CGFloat maxCompression = 0.1f;
    UIImage *image = [UIImage imageWithData:imageData];
    NSData *compressedData = UIImageJPEGRepresentation(image, compression);
    while ([compressedData length] > maxFileSize && compression > maxCompression) {
        compression -= 0.1;
        compressedData = UIImageJPEGRepresentation(image, compression);
        MYLog(@"compressedData Size ______%ld ___%@",compressedData.length,[NSThread currentThread]);
    }
    
    UIImage *compressedImage = [UIImage imageWithData:compressedData];
    return compressedImage;
}


- (UIImage *)imageCompressForWidth:(UIImage *)sourceImage targetWidth:(CGFloat)defineWidth
{
    CGSize imageSize = sourceImage.size;
    CGFloat width = imageSize.width;
    CGFloat height = imageSize.height;
    CGFloat targetWidth = defineWidth;
    CGFloat targetHeight = (targetWidth / width) * height;
    UIGraphicsBeginImageContext(CGSizeMake(targetWidth, targetHeight));
    [sourceImage drawInRect:CGRectMake(0,0,targetWidth, targetHeight)];
    UIImage* newImage = UIGraphicsGetImageFromCurrentImageContext();
    UIGraphicsEndImageContext();
    return newImage;
}




@end
