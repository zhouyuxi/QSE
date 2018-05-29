//
//  QSCHttpTool.m
//  qingsongchou
//
//  Created by Chai on 15/9/9.
//  Copyright (c) 2015年 Chai. All rights reserved.
//
#define kHeadAccept @"application/json"

#define kQSCAccessToken [NSString stringWithFormat:@"%@/auth/refresh_token",kQSCCommonBaseUrl]

//#define kQSCepAccessToken [NSString stringWithFormat:@"%@/auth/refresh_token",KQSCEnterpriseBaseUrl]

#import "QSEHttpTool.h"
#import <AFNetworking/AFNetworking.h>
#import <MBProgressHUD/MBProgressHUD.h>
#import "QSCAccount.h"
#import "NSDate+Extension.h"
#import "AppDelegate.h"
#import "UIImage+Extension.h"
#import <AliyunOSSiOS/OSSService.h>
#import "QSCImage.h"
#import <AdSupport/AdSupport.h>
#import "QSCAccountTool.h"
#import "QSCAccount.h"
#import "QSCTipHUDManager.h"
#import "QSCNetworkTipManager.h"
#import "QSCWirteUserInfoWebView.h"

#ifdef DEBUG
#define QSCRequestTimeOut 60.0f
#else
#define QSCRequestTimeOut 20.0f
#endif
@interface QSEHttpTool ()
{
    NSString *_accessKeyId;
    NSString *_accessKeySecret;
}

@end

@implementation QSEHttpTool

+ (void)get:(NSString *)url parameters:(NSDictionary *)parameters httpToolSuccess:(QSCSuccess)httpToolSuccess failure:(QSCFailure)failure
{
    AFHTTPSessionManager *manager  = nil;
    
    manager = [self getAFHTTPRequestOperationManager];
    [manager GET:url parameters:parameters progress:nil success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
        if (httpToolSuccess) {
            [self successWithResponseObject:responseObject httpToolSuccess:httpToolSuccess failure:failure];
        }
    } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
        if (failure) {
            failure(error);
            [self failureOperation:task error:error];
        }
    }];
}

+ (void)get:(NSString *)url parameters:(NSDictionary *)parameters isShowHUD:(BOOL)showHUD httpToolSuccess:(QSCSuccess)httpToolSuccess failure:(QSCFailure)failure
{
    //再次加载标示
    if (showHUD) {
        [[QSCTipHUDManager sharedQSCTipHUDManager] showHUD];
    }
    AFHTTPSessionManager *manager  = nil;
    manager = [self getAFHTTPRequestOperationManager];
    [manager GET:url parameters:parameters progress:nil success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
        
        [[QSCTipHUDManager sharedQSCTipHUDManager] hideHUD];
        
        if (httpToolSuccess) {
            [self successWithResponseObject:responseObject httpToolSuccess:httpToolSuccess failure:failure];
        }
        
    } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
        
        [[QSCTipHUDManager sharedQSCTipHUDManager] hideHUD];
        
        if (failure) {
            failure(error);
            [self failureOperation:task error:error];
        }
    }];
}


+ (void)post:(NSString *)url parameters:(id )parameters httpToolSuccess:(QSCSuccess)httpToolSuccess failure:(QSCFailure)failure
{
    
    AFHTTPSessionManager *manager  = nil;
    manager = [self getAFHTTPRequestOperationManager];
    [manager POST:url parameters:parameters progress:nil success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
        if (httpToolSuccess) {
            [self successWithResponseObject:responseObject httpToolSuccess:httpToolSuccess failure:failure];
        }
    } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
        if (failure) {
            failure(error);
            [self failureOperation:task error:error];
        }
    }];
}


+ (void)post:(NSString *)url parameters:(id )parameters isShowHUD:(BOOL)showHUD httpToolSuccess:(QSCSuccess)httpToolSuccess failure:(QSCFailure)failure
{
    if (showHUD) {
        [[QSCTipHUDManager sharedQSCTipHUDManager] showHUD];
    }
    
    AFHTTPSessionManager *manager  = nil;
    manager = [self getAFHTTPRequestOperationManager];
    [manager POST:url parameters:parameters progress:nil success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
        
        [[QSCTipHUDManager sharedQSCTipHUDManager] hideHUD];
        
        if (httpToolSuccess) {
            [self successWithResponseObject:responseObject httpToolSuccess:httpToolSuccess failure:failure];
        }
    } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
        
        [[QSCTipHUDManager sharedQSCTipHUDManager] hideHUD];
        
        if (failure) {
            failure(error);
            [self failureOperation:task error:error];
        }
    }];
}


+ (void)deleted:(NSString *)url parameters:(id )parameters isShowHUD:(BOOL)showHUD httpToolSuccess:(QSCSuccess)httpToolSuccess failure:(QSCFailure)failure
{
    if (showHUD) {
        [[QSCTipHUDManager sharedQSCTipHUDManager] showHUD];
    }
    
    AFHTTPSessionManager *manager  = nil;
    manager = [self getAFHTTPRequestOperationManager];
    [manager DELETE:url parameters:parameters success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
        
        [[QSCTipHUDManager sharedQSCTipHUDManager] hideHUD];
        if (httpToolSuccess) {
            [self successWithResponseObject:responseObject httpToolSuccess:httpToolSuccess failure:failure];
        }
        
    } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
        
        [[QSCTipHUDManager sharedQSCTipHUDManager] hideHUD];
        
        if (failure) {
            failure(error);
            [self failureOperation:task error:error];
        }
    }];
    
}


+ (void)put:(NSString *)url parameters:(id )parameters isShowHUD:(BOOL)showHUD httpToolSuccess:(QSCSuccess)httpToolSuccess failure:(QSCFailure)failure
{
    if (showHUD) {
        [[QSCTipHUDManager sharedQSCTipHUDManager] showHUD];
    }
    
    AFHTTPSessionManager *manager  = nil;
    manager = [self getAFHTTPRequestOperationManager];
    [manager PUT:url parameters:parameters success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
        
        [[QSCTipHUDManager sharedQSCTipHUDManager] hideHUD];
        
        if (httpToolSuccess) {
            [self successWithResponseObject:responseObject httpToolSuccess:httpToolSuccess failure:failure];
        }
    } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
        
        [[QSCTipHUDManager sharedQSCTipHUDManager] hideHUD];
        
        if (failure) {
            failure(error);
            [self failureOperation:task error:error];
        }
    }];
}


+(void)patch:(NSString *)url parameters:(id)parameters isShowHUD:(BOOL)showHUD httpToolSuccess:(QSCSuccess)httpToolSuccess failure:(QSCFailure)failure
{
    if (showHUD) {
        [[QSCTipHUDManager sharedQSCTipHUDManager] showHUD];
    }
    
    AFHTTPSessionManager *manager  = nil;
    manager = [self getAFHTTPRequestOperationManager];
    [manager PATCH:url parameters:parameters success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
        
        [[QSCTipHUDManager sharedQSCTipHUDManager] hideHUD];
        
        if (httpToolSuccess) {
            [self successWithResponseObject:responseObject httpToolSuccess:httpToolSuccess failure:failure];
        }
    } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
        
        [[QSCTipHUDManager sharedQSCTipHUDManager] hideHUD];
        
        if (failure) {
            failure(error);
            [self failureOperation:task error:error];
        }
    }];
}

#pragma mark - Token
+ (void)postToken:(NSString *)url parameters:(id )parameters httpToolSuccess:(QSCSuccess)httpToolSuccess failure:(QSCFailure)failure
{
    NSURLSessionConfiguration* config = [NSURLSessionConfiguration defaultSessionConfiguration];
    config.timeoutIntervalForRequest = QSCRequestTimeOut;
    AFHTTPSessionManager *manager = [[AFHTTPSessionManager alloc]initWithSessionConfiguration:config];
    manager.responseSerializer = [AFJSONResponseSerializer serializer];
    manager.requestSerializer=[AFJSONRequestSerializer serializer];
    manager.responseSerializer.acceptableContentTypes = [NSSet setWithObjects:@"application/json",@"text/json",@"text/plain",@"text/javascript",@"text/html", nil];
    [manager.requestSerializer setValue:kHeadAccept forHTTPHeaderField:@"Accept"];
    manager.requestSerializer.timeoutInterval = QSCRequestTimeOut;
    QSCAccount *account = [QSCAccountTool sharedQSCAccountTool].account;
    NSString *authorization = [NSString stringWithFormat:@"Bearer %@",account.access_token] ;
    NSString *idfa= [[[ASIdentifierManager sharedManager] advertisingIdentifier] UUIDString];
    [manager.requestSerializer setValue:authorization  forHTTPHeaderField:@"Authorization"];
    NSString *prltform = [NSString stringWithFormat:kHeadVersion,[[UIDevice currentDevice] systemVersion]];
    [manager.requestSerializer setValue:prltform  forHTTPHeaderField:@"Platform"];
    [manager.requestSerializer setValue:idfa  forHTTPHeaderField:@"DeviceId"];
    [manager POST:url parameters:parameters progress:nil success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
        if (httpToolSuccess) {
            httpToolSuccess(responseObject);
            [[QSCTipHUDManager sharedQSCTipHUDManager] hideHUD];
        }
    } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
        if (failure) {
            failure(error);
            
            [[QSCTipHUDManager sharedQSCTipHUDManager] hideHUD];
            NSHTTPURLResponse *httpResponse = (NSHTTPURLResponse *)task.response;
            NSInteger codes = httpResponse.statusCode;
            
            if (codes == 422 || codes == 403 || codes == 404) {
                NSData *data = error.userInfo[@"com.alamofire.serialization.response.error.data"];
                if (data.length >0) {
                    NSDictionary *json = [NSJSONSerialization JSONObjectWithData:data options:NSJSONReadingMutableLeaves error:nil];
                    NSString *str = json[@"error"];
                    [ProgressHUD showError:str];
                }
            }
            else if(codes == 400 || codes == 401)
            {
                MYLog(@"大token");
                [[QSCAccountTool sharedQSCAccountTool] logoutQSCAccount];
                
                QSETabbarController *tabbar = [[QSETabbarController alloc]init];
                [[UIApplication sharedApplication].delegate window].rootViewController = tabbar;
            }
            else
            {
                [ProgressHUD showError:QSCErrorText];
            }
        }
        
    }];
}

+ (AFHTTPSessionManager *)getAFHTTPRequestOperationManager
{
    dispatch_async(dispatch_get_main_queue(), ^{
        [[QSCNetworkTipManager sharedQSCNetworkTipManager] checkCurrentNetworkInView:[UIApplication sharedApplication].keyWindow];
    });
    MYLog(@"1.getAFHTTPRequestOperationManager");
    [self getToken];
    NSURLSessionConfiguration* config = [NSURLSessionConfiguration defaultSessionConfiguration];
    config.timeoutIntervalForRequest = QSCRequestTimeOut;
    AFHTTPSessionManager *manager = [[AFHTTPSessionManager alloc]initWithSessionConfiguration:config];
    
    manager.responseSerializer = [AFJSONResponseSerializer serializer];
    manager.requestSerializer=[AFJSONRequestSerializer serializer];
    manager.responseSerializer.acceptableContentTypes = [NSSet setWithObjects:@"application/json",@"text/json",@"text/plain",@"text/javascript",@"text/html",nil];
    [manager.requestSerializer setValue:kHeadAccept forHTTPHeaderField:@"Accept"];
    manager.requestSerializer.timeoutInterval = QSCRequestTimeOut;
    QSCAccount *acc = [[QSCAccountTool sharedQSCAccountTool]account];
    if (acc.access_token.length) {
        //        acc.access_token = [QSCAccessTokenManager sharedQSCAccessTokenManager].currentToken.access_token;
        //        acc.expires_in = [QSCAccessTokenManager sharedQSCAccessTokenManager].currentToken.expires_in;
        //        acc.srv_create_time =  [QSCAccessTokenManager sharedQSCAccessTokenManager].currentToken.srv_create_time;
        //        acc.currentGetTime = [QSCAccessTokenManager sharedQSCAccessTokenManager].currentToken.currentGetTime;
        [[QSCAccountTool sharedQSCAccountTool]saveAccount:acc];
    }
    MYLog(@"%@",acc.access_token);
    NSString *idfa= [[[ASIdentifierManager sharedManager] advertisingIdentifier] UUIDString];
    [manager.requestSerializer setValue:acc.access_token  forHTTPHeaderField:@"QSC-TOKEN"];
    NSString *prltform = [NSString stringWithFormat:kHeadVersion,[[UIDevice currentDevice] systemVersion]];
    [manager.requestSerializer setValue:prltform  forHTTPHeaderField:@"Platform"];
    [manager.requestSerializer setValue:idfa  forHTTPHeaderField:@"DeviceId"];  // 添加idfa标示
    MYLog(@"请求头-----%@",manager.requestSerializer.HTTPRequestHeaders);
    
    return manager;
}


+ (void)progressHUDWithError:(NSError *)error
{
    NSString *errorStr = error.localizedDescription;
    [ProgressHUD showError:errorStr];
}
+ (void)failureOperation:(NSURLSessionDataTask *)task error:(NSError *)error
{
    [[QSCTipHUDManager sharedQSCTipHUDManager] hideHUD];
    
    [ProgressHUD showError:[self requestErrorControllWithErrorCode:error.code]];
    
}


+ (void)getToken{
    
}


//{
//
//    //passport
//    QSCAccessTokenFailureType failureType = [[QSCAccessTokenManager sharedQSCAccessTokenManager] checkTheAccessTokenIsFailure];;
//    if (failureType == QSCAccessTokenFailureTypeRefreshTokenInvalid || failureType == QSCAccessTokenFailureTypeNone || failureType == QSCAccessTokenFailureTypeNo) {
//
//        //清除本地用户数据
//        [QSCLoginAccountTool saveAccount:nil];
//
//        //清除本地token数据
//        [[QSCAccessTokenManager sharedQSCAccessTokenManager] clearTheAccessTokenData];
//
//
//    }
//    else if (failureType == QSCAccessTokenFailureTypeAccessTokenInvalid) { //刷新token
//
//        //刷新token
//        [[QSCAccessTokenManager sharedQSCAccessTokenManager] refreshTheAccessTokenWithFailureBlock:^{
//
//            //清除本地用户数据
//            [QSCLoginAccountTool saveAccount:nil];
//
//            //清除本地token数据
//            [[QSCAccessTokenManager sharedQSCAccessTokenManager] clearTheAccessTokenData];
//
//            //弹出登录界面去重新登录
//            BOOL showThird = NO;
//            NSString *is_review = [QSCParametersInitTool sharedQSCParametersInitTool].parameters.version.is_review;
//
//            if ([is_review isEqualToString:@"Y"]) {
//                showThird = YES;
//            }
//
//            [QSCCommonTool CommonGoLogin];
//
//        }sucessBlock:^{
//            QSCAccount *acc = [[QSCAccountTool sharedQSCAccountTool]account];
//            if (acc) {
//                acc.access_token = [QSCAccessTokenManager sharedQSCAccessTokenManager].currentToken.access_token;
//                acc.expires_in = [QSCAccessTokenManager sharedQSCAccessTokenManager].currentToken.expires_in;
//                acc.srv_create_time =  [QSCAccessTokenManager sharedQSCAccessTokenManager].currentToken.srv_create_time;
//                acc.currentGetTime = [QSCAccessTokenManager sharedQSCAccessTokenManager].currentToken.currentGetTime;
//                [[QSCAccountTool sharedQSCAccountTool]saveAccount:acc];
//            }
//            dispatch_async(dispatch_get_main_queue(), ^{
//                //写入webview 用户信息数据
//                QSCWirteUserInfoWebView *myview =  [[[NSBundle mainBundle] loadNibNamed:@"QSCWirteUserInfoWebView" owner:nil options:nil] lastObject];
//                [myview loadUrl:kWriteLocalStorageUrl1];
//                QSCWirteUserInfoWebView *myview2 =  [[[NSBundle mainBundle] loadNibNamed:@"QSCWirteUserInfoWebView" owner:nil options:nil] lastObject];
//                [myview2 loadUrl:kWriteLocalStorageUrl2];
//                QSCWirteUserInfoWebView *myview3 =  [[[NSBundle mainBundle] loadNibNamed:@"QSCWirteUserInfoWebView" owner:nil options:nil] lastObject];
//                [myview3 loadUrl:kWriteLocalStorageUrl3];
//                QSCWirteUserInfoWebView *myview4 =  [[[NSBundle mainBundle] loadNibNamed:@"QSCWirteUserInfoWebView" owner:nil options:nil] lastObject];
//                [myview4 loadUrl:kWriteLocalStorageUrl4];
//            });
//
//
//        }];
//
//    }
//
//
//
//}


+ (void)uploadImagePath:(NSString *)path params:(NSDictionary *)params kHeadimgName:(NSString *)headimgName image:(UIImage *)image success:(ImageHttpSuccessBlock)success failure:(ImageHttpFailureBlock)failure
{
    NSData *data = UIImageJPEGRepresentation(image, 0.7);// 压缩
    // 在网络开发中，上传文件时，是文件不允许被覆盖，文件重名
    // 要解决此问题，
    // 可以在上传时使用当前的系统时间作为文件名
    NSDateFormatter *formatter = [[NSDateFormatter alloc] init];
    // 设置时间格式
    formatter.dateFormat = @"yyyyMMddHHmmss";
    NSString *str = [formatter stringFromDate:[NSDate date]];
    NSString *fileName = [NSString stringWithFormat:@"%@.png", str];
    
    
    // 1.获得请求管理者
    //    AFHTTPRequestOperationManager *mgr = [AFHTTPRequestOperationManager manager];
    AFHTTPSessionManager *mgr = [self getAFHTTPRequestOperationManager];
    
    //    //申明请求的数据是HTTP类型
    //    mgr.requestSerializer = [AFHTTPRequestSerializer serializer];
    //    //申明返回的结果是json类型
    //    mgr.responseSerializer = [AFHTTPResponseSerializer serializer];
    //    mgr.requestSerializer.timeoutInterval = 30;
    //    mgr.responseSerializer.acceptableContentTypes = [NSSet setWithObjects:@"application/json",@"text/json",@"text/plain",@"text/html",@"text/javascript",nil];
    
    [mgr POST:path parameters:params constructingBodyWithBlock:^(id<AFMultipartFormData>  _Nonnull formData) {
        [formData appendPartWithFileData:data name:@"file" fileName:fileName mimeType:@"image/png"];
    } progress:nil success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
        
        //        [QSCHudView sharedQSCHudView].hidden = YES;
        //        [[QSCHudView sharedQSCHudView] disMissHUD];
        [[QSCTipHUDManager sharedQSCTipHUDManager] hideHUD];
        
        success(responseObject);
        
    } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
        if (failure) {
            
            failure(error);
            [self failureOperation:task error:error];
        }
    }];
}

+ (void)uploadImagePath:(NSString *)path params:(NSDictionary *)params kHeadimgName:(NSString *)headimgName image:(UIImage *)image progress:(ImageUploadProgress)progress success:(ImageHttpSuccessBlock)success failure:(ImageHttpFailureBlock)failure
{
    
    NSData *data = UIImageJPEGRepresentation(image, 0.7);// 压缩
    MYLog(@"%f", (CGFloat)data.length / 1024/1024);
    NSDateFormatter *formatter = [[NSDateFormatter alloc] init];
    formatter.dateFormat = @"yyyyMMddHHmmss";
    NSString *str = [formatter stringFromDate:[NSDate date]];
    NSString *fileName = [NSString stringWithFormat:@"%@.png", str];
    MYLog(@"%@",fileName);
    
    AFHTTPSessionManager *mgr = [self getAFHTTPRequestOperationManager];
    
    [mgr POST:path parameters:params constructingBodyWithBlock:^(id<AFMultipartFormData>  _Nonnull formData) {
        [formData appendPartWithFileData:data name:@"file" fileName:fileName mimeType:@"image/png"];
    } progress:^(NSProgress * _Nonnull uploadProgress) {
        
        MYLog(@"uploadProgress.totalUnitCount  %lld  ,uploadProgress.completedUnitCount  %lld ",uploadProgress.totalUnitCount,uploadProgress.completedUnitCount);
        
        progress(uploadProgress.completedUnitCount,uploadProgress.totalUnitCount,uploadProgress.completedUnitCount);
        MYLog(@"%@",uploadProgress);
    } success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
        
        //        [QSCHudView sharedQSCHudView].hidden = YES;
        //        [[QSCHudView sharedQSCHudView] disMissHUD];
        [[QSCTipHUDManager sharedQSCTipHUDManager] hideHUD];
        
        success(responseObject);
    } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
        if (failure) {
            failure(error);
            [self failureOperation:task error:error];
        }
    }];
    
}

+ (void)AlUploadImagePath:(NSString *)path params:(NSDictionary *)params image:(QSCImage *)imageModel progress:(ALImageUploadProgress)progress success:(ImageHttpSuccessBlock)success failure:(ImageHttpFailureBlock)failure withIndex:(int)index  uuid:(NSString *)uuid
{
    
    UIImage *image = imageModel.imageV;
    //    imageModel.imageV;
    
    //    if (image.size.width > image.size.height && image.size.width > 710)
    CGFloat rect =  710.0 /image.size.width;
    CGFloat hight = image.size.height * rect;
    CGSize size = CGSizeMake(710, hight);
    
    CGFloat rectLong =  710.0 /image.size.height;
    CGFloat widthLong = image.size.width * rectLong;
    CGSize sizeLong = CGSizeMake(widthLong, 710);
    
    
    QSEHttpTool *httpHool = [[QSEHttpTool alloc] init];
    [httpHool initOSSClient];
    
    UIImage *putImage;
    if (image.size.width > 710 && (image.size.width >= image.size.height)) { // 宽图
        UIImage *SevenImage = [image imageByScalingToSize:size];
        MYLog(@"%@  -- %@",NSStringFromCGSize(image.size), NSStringFromCGSize(SevenImage.size));
        putImage = SevenImage;
    }else if((image.size.height >= image.size.width) && image.size.height > 710){ // 长图
        UIImage *SevenImage = [image imageByScalingToSize:sizeLong];
        MYLog(@"%@  -- %@",NSStringFromCGSize(image.size), NSStringFromCGSize(SevenImage.size));
        putImage = SevenImage;
    }else{
        putImage = image;
    }
    
    MYLog(@"%@",NSStringFromCGSize(putImage.size));
    
    NSData *data = UIImageJPEGRepresentation(putImage, 0.7);// 压缩
    MYLog(@"%f", (CGFloat)data.length / 1024/1024);
    
    NSDateFormatter *formatter = [[NSDateFormatter alloc] init];
    formatter.dateFormat = @"yyyyMMddHHmmss";
    NSString *str = [formatter stringFromDate:[NSDate date]];
    NSString *fileName;
    
    QSCAccount *account = [QSCAccountTool sharedQSCAccountTool].account;
    if (!uuid) {
        uuid = account.user.uuid;
    }
    
    int anyNum = (arc4random() % 100000) + 100000;
    if (imageModel.imageName) {
        NSArray *array = [imageModel.imageName componentsSeparatedByString:@"."];
        NSString *name = array[0];
        fileName = [NSString stringWithFormat:@"%@%@%d%@%d.png",str,name,index,uuid,anyNum];
    }else{
        fileName = [NSString stringWithFormat:@"%@%@%d.png",str,uuid,anyNum];
    }
    imageModel.imageName = fileName;
    OSSPutObjectRequest * put = [OSSPutObjectRequest new];
    
    // 必填字段
    //    put.bucketName = @"qschou";
    put.bucketName = @"qschou";
    
    NSString *yearStr = [str substringToIndex:4];
    MYLog(@"%@",yearStr);
    NSString *monthStr = [str substringWithRange:NSMakeRange(4, 2)];
    MYLog(@"%@",monthStr);
    NSString *dayStr = [str substringWithRange:NSMakeRange(6, 2)];
    MYLog(@"%@",dayStr);
    put.objectKey = [NSString stringWithFormat:@"temp/%@/%@/%@/%@",yearStr,monthStr,dayStr,fileName];
    MYLog(@"%@",put.objectKey);
    
    //put.uploadingFileURL = [NSURL fileURLWithPath:@"<filepath>"];
    put.uploadingData = data; // 直接上传NSData
    put.contentMd5 = [OSSUtil base64Md5ForData:data]; // 如果是二进制数据进行md5校验
    
    
    if (progress) {
        put.uploadProgress = progress;
    }
    
    OSSTask * putTask = [httpHool.aliclient putObject:put];
    if (httpHool.aliclient.credentialProvider) {
        [putTask continueWithBlock:^id(OSSTask *task) {
            if (!task.error) {
                MYLog(@"upload object success!");
                OSSTask *imageTask = [httpHool.aliclient presignPublicURLWithBucketName:put.bucketName withObjectKey:put.objectKey];
                MYLog(@"%@",imageTask.result); // 图片url
                //                NSString *newPath = [imageTask.result stringByReplacingOccurrencesOfString:@"http://qschou.oss-cn-hangzhou.aliyuncs.com" withString:qschouPath];
                success(imageTask.result);
                
            } else {
                MYLog(@"upload object failed, error: %@" , task.error);
                failure(task.error);
            }
            return nil;
        }];
    }
}

//+ (void)uploadVideoToCOSWithImageModel:(QSCImage *)imageModel paramDict:(NSMutableDictionary *)paramDict progress:(ALImageUploadProgress)progress success:(ImageHttpSuccessBlock)success failure:(ImageHttpFailureBlock)failure{
//    
//    //图片处理
//    UIImage *image = imageModel.image;
//    CGFloat rect =  710.0 /image.size.width;
//    CGFloat hight = image.size.height * rect;
//    CGSize size = CGSizeMake(710, hight);
//    
//    CGFloat rectLong =  710.0 /image.size.height;
//    CGFloat widthLong = image.size.width * rectLong;
//    CGSize sizeLong = CGSizeMake(widthLong, 710);
//    
//    UIImage *putImage;
//    if (image.size.width > 710 && (image.size.width >= image.size.height)) { // 宽图
//        UIImage *SevenImage = [image imageByScalingToSize:size];
//        MYLog(@"%@  -- %@",NSStringFromCGSize(image.size), NSStringFromCGSize(SevenImage.size));
//        putImage = SevenImage;
//    }else if((image.size.height >= image.size.width) && image.size.height > 710){ // 长图
//        UIImage *SevenImage = [image imageByScalingToSize:sizeLong];
//        MYLog(@"%@  -- %@",NSStringFromCGSize(image.size), NSStringFromCGSize(SevenImage.size));
//        putImage = SevenImage;
//    }else{
//        putImage = image;
//    }
//    NSData *imageData = UIImageJPEGRepresentation(putImage, 0.7);// 压缩
//    MYLog(@"%f", (CGFloat)imageData.length / 1024/1024);
//    
//    //参数设置
//    NSDateFormatter *formatter = [[NSDateFormatter alloc] init];
//    formatter.dateFormat = @"yyyyMMddHHmmss";
//    NSDateFormatter *formatter1 = [[NSDateFormatter alloc] init];
//    formatter1.dateFormat = @"yyyy/MM/dd/";
//    NSString *timeStamp = [formatter stringFromDate:[NSDate date]];
//    NSString *timeStampDay = [formatter1 stringFromDate:[NSDate date]];
//    NSString *uuid = [QSCAccountTool sharedQSCAccountTool].account.user.uuid;
//    NSString *index;
//    NSString *appid;
//    NSString *bucketName;
//    NSString *sign;
//    NSString *regionStr;
//    if([paramDict.allKeys containsObject:@"index"]){
//        index = [paramDict valueForKey:@"index"];
//    }
//    if([paramDict.allKeys containsObject:@"appId"]){
//        appid = [paramDict valueForKey:@"appId"];
//    }
//    if([paramDict.allKeys containsObject:@"SecurityToken"]){
//        sign = [paramDict valueForKey:@"SecurityToken"];
//    }
//    if([paramDict.allKeys containsObject:@"bucket"]){
//        bucketName = [paramDict valueForKey:@"bucket"];
//    }
//    if([paramDict.allKeys containsObject:@"regionStr"]){
//        regionStr = [paramDict valueForKey:@"regionStr"];
//    }
//    
//    NSString *imageFileName;
//    NSString *videoFilename;
//    NSString *fileDirect;
//    int anyNum = (arc4random() % 100000) + 100000;
//    if (imageModel.imageName) {
//        NSArray *array = [imageModel.imageName componentsSeparatedByString:@"."];
//        NSString *name = array[0];
//        imageFileName = [NSString stringWithFormat:@"%@%@%@%@%d.png",timeStamp,name,index,uuid,anyNum];
//        videoFilename = [NSString stringWithFormat:@"%@%@%@%@%d.mp4",timeStamp,name,index,uuid,anyNum];
//        fileDirect = [NSString stringWithFormat:@"temp/%@",timeStampDay];
//    }else{
//        imageFileName = [NSString stringWithFormat:@"%@%@%d.png",timeStamp,uuid,anyNum];
//        videoFilename = [NSString stringWithFormat:@"%@%@%d.mp4",timeStamp,uuid,anyNum];
//        fileDirect = [NSString stringWithFormat:@"temp/%@",timeStampDay];
//    }
//    
//    imageModel.imageName = imageFileName;
//    NSMutableDictionary *successDict = [[NSMutableDictionary alloc]init];
//    
//    
//    COSClient *imgClient = [[COSClient alloc] initWithAppId:appid withRegion:regionStr];
//    
//    COSObjectPutTask *imageUploadTask = [COSObjectPutTask new];
//    imageUploadTask.filePath = imageModel.videoThumbLocalPath;
//    imageUploadTask.fileName = imageFileName;
//    imageUploadTask.bucket = bucketName;
//    imageUploadTask.directory = fileDirect;
//    imageUploadTask.insertOnly = YES;
//    imageUploadTask.sign = sign;
//
//    imgClient.completionHandler = ^(COSTaskRsp *resp, NSDictionary *context){
//        //sucess
//        COSObjectUploadTaskRsp *fileResp = (COSObjectUploadTaskRsp *)resp;
//        if(fileResp.retCode == 0) {
//            [successDict setValue:fileResp.sourceURL forKey:@"imgUrl"];
//            if([successDict.allKeys containsObject:@"videoUrl"]){
//                success(successDict);
//            }
//        }else {
//            failure(nil);
//            return;
//        }
//
//    };
//    [imgClient putObject:imageUploadTask];
//    
//    //上传视频
//    COSObjectPutTask *videoUploadTask = [COSObjectPutTask new];
//    videoUploadTask.filePath = imageModel.videoLocalPath;
//    videoUploadTask.fileName = videoFilename;
//    videoUploadTask.bucket = bucketName;
//    videoUploadTask.directory = fileDirect;
//    videoUploadTask.insertOnly = YES;
//    videoUploadTask.sign = sign;
//    
//    COSClient *videoClient = [[COSClient alloc] initWithAppId:appid withRegion:regionStr];
//    videoClient.completionHandler = ^(COSTaskRsp *resp, NSDictionary *context){
//        //sucess
//        COSObjectUploadTaskRsp *fileResp = (COSObjectUploadTaskRsp *)resp;
//        if(fileResp.retCode == 0) {
//            [successDict setValue:fileResp.sourceURL forKey:@"videoUrl"];
//            if([successDict.allKeys containsObject:@"imgUrl"]){
//                success(successDict);
//            }
//        }else {
//            failure(nil);
//            return;
//        }
//    };
//    
//    if (progress){
//        videoClient.progressHandler = progress;
//    }
//    [videoClient putObject:videoUploadTask];
//    
//}



+ (void)shareUploadImagePath:(NSString *)path params:(NSDictionary *)params image:(QSCImage *)imageModel progress:(ALImageUploadProgress)progress success:(ImageHttpSuccessBlock)success failure:(ImageHttpFailureBlock)failure withIndex:(int)index
{
    
    UIImage *image = imageModel.imageV;
    CGFloat defaultWidth = 710.0;
    
    CGFloat width =  defaultWidth /image.size.width;
    CGFloat hight = image.size.height * width;
    CGSize  size = CGSizeMake(defaultWidth, hight);
    
    CGFloat rectLong =  defaultWidth /image.size.height;
    CGFloat widthLong = image.size.width * rectLong;
    CGSize sizeLong = CGSizeMake(widthLong, defaultWidth);
    
    
    QSEHttpTool *httpHool = [[QSEHttpTool alloc] init];
    [httpHool initOSSClient];
    
    UIImage *putImage;
    if (image.size.width > defaultWidth && (image.size.width >= image.size.height)) { // 宽图
        UIImage *SevenImage = [image imageByScalingToSize:size];
        MYLog(@"%@  -- %@",NSStringFromCGSize(image.size), NSStringFromCGSize(SevenImage.size));
        putImage = SevenImage;
    }else if((image.size.height >= image.size.width) && image.size.height > 710){ // 长图
        UIImage *SevenImage = [image imageByScalingToSize:sizeLong];
        MYLog(@"%@  -- %@",NSStringFromCGSize(image.size), NSStringFromCGSize(SevenImage.size));
        putImage = SevenImage;
    }else{
        putImage = image;
    }
    
    MYLog(@"%@",NSStringFromCGSize(putImage.size));
    
    NSData *data = UIImageJPEGRepresentation(putImage, 0.7);// 压缩
    MYLog(@"%f", (CGFloat)data.length / 1024/1024);
    
    NSDateFormatter *formatter = [[NSDateFormatter alloc] init];
    formatter.dateFormat = @"yyyyMMddHHmmss";
    NSString *str = [formatter stringFromDate:[NSDate date]];
    
    NSString *fileName;
    if (imageModel.imageName) {
        NSArray *array = [imageModel.imageName componentsSeparatedByString:@"."];
        NSString *name = array[0];
        fileName = [NSString stringWithFormat:@"%@%@%d.png",str,name,index];
        
    }else{
        fileName = [NSString stringWithFormat:@"%@.png",str];
        
    }
    imageModel.imageName = fileName;
    OSSPutObjectRequest * put = [OSSPutObjectRequest new];
    
    // 必填字段
    //    put.bucketName = @"qschou";
    put.bucketName = @"qschou";
    
    NSString *yearStr = [str substringToIndex:4];
    MYLog(@"%@",yearStr);
    NSString *monthStr = [str substringWithRange:NSMakeRange(4, 2)];
    MYLog(@"%@",monthStr);
    NSString *dayStr = [str substringWithRange:NSMakeRange(6, 2)];
    MYLog(@"%@",dayStr);
    put.objectKey = [NSString stringWithFormat:@"temp/%@/%@/%@/%@",yearStr,monthStr,dayStr,fileName];
    MYLog(@"%@",put.objectKey);
    
    //put.uploadingFileURL = [NSURL fileURLWithPath:@"<filepath>"];
    put.uploadingData = data; // 直接上传NSData
    
    // 可选字段，可不设置
    //    put.uploadProgress = ^(int64_t bytesSent, int64_t totalByteSent, int64_t totalBytesExpectedToSend) {
    //        // 当前上传段长度、当前已经上传总长度、一共需要上传的总长度
    //        NSLog(@"%lld, %lld, %lld", bytesSent, totalByteSent, totalBytesExpectedToSend);
    //    };
    
    if (progress) {
        put.uploadProgress = progress;
    }
    
    
    // 以下可选字段的含义参考： https://docs.aliyun.com/#/pub/oss/api-reference/object&PutObject
    // put.contentType = @"";
    // put.contentMd5 = @"";
    // put.contentEncoding = @"";
    // put.contentDisposition = @"";
    // put.objectMeta = [NSMutableDictionary dictionaryWithObjectsAndKeys:@"value1", @"x-oss-meta-name1", nil]; // 可以在上传时设置元信息或者其他HTTP头部
    
    OSSTask * putTask = [httpHool.aliclient putObject:put];
    //    NSString *qschouPath = @"http://images.qschou.com";
    if (httpHool.aliclient.credentialProvider) {
        [putTask continueWithBlock:^id(OSSTask *task) {
            if (!task.error) {
                MYLog(@"upload object success!");
                OSSTask *imageTask = [httpHool.aliclient presignPublicURLWithBucketName:put.bucketName withObjectKey:put.objectKey];
                MYLog(@"%@",imageTask.result); // 图片url
                //                NSString *newPath = [imageTask.result stringByReplacingOccurrencesOfString:@"http://qschou.oss-cn-hangzhou.aliyuncs.com" withString:qschouPath];
                success(imageTask.result);
                
            } else {
                MYLog(@"upload object failed, error: %@" , task.error);
                failure(task.error);
            }
            return nil;
        }];
    }
}




//签权
- (void)initOSSClient {
    
    [QSEHttpTool getToken];
    NSString *imageUrl = [NSString stringWithFormat:@"%@/upload/token",kQSCBaseUrlPath];
    
    
    QSCAccount *account  = [QSCAccountTool sharedQSCAccountTool].account;
    id<OSSCredentialProvider> credential = [[OSSFederationCredentialProvider alloc] initWithFederationTokenGetter:^OSSFederationToken * {
        NSURL * url = [NSURL URLWithString:imageUrl];
        NSMutableURLRequest * request = [NSMutableURLRequest requestWithURL:url];
        [request setHTTPMethod:@"GET"];
        [request addValue:kHeadAccept forHTTPHeaderField:@"Accept"];
        NSString *prltform = [NSString stringWithFormat:kHeadVersion,[[UIDevice currentDevice] systemVersion]];
        [request addValue:prltform forHTTPHeaderField:@"Platform"];
        NSString *authorization = [NSString stringWithFormat:@"Bearer %@",account.access_token] ;
        [request addValue:authorization  forHTTPHeaderField:@"Authorization"];
        OSSTaskCompletionSource * tcs = [OSSTaskCompletionSource taskCompletionSource];
        NSURLSession * session = [NSURLSession sharedSession];
        NSURLSessionTask * sessionTask = [session dataTaskWithRequest:request
                                                    completionHandler:^(NSData *data, NSURLResponse *response, NSError *error) {
                                                        if (error) {
                                                            [tcs setError:error];
                                                            
                                                            return;
                                                        }
                                                        [tcs setResult:data];
                                                    }];
        [sessionTask resume];
        [tcs.task waitUntilFinished];
        
        MYLog(@"%@",tcs.task);
        if (tcs.task.error) {
            MYLog(@"get token error: %@", tcs.task.error);
            return nil;
        } else {
            NSDictionary * object = [NSJSONSerialization JSONObjectWithData:tcs.task.result
                                                                    options:kNilOptions
                                     
                                                                      error:nil] [@"data"];
            
            MYLog(@"%@",object);
            if(!QSENotNilAndNull(object))
            {
                return nil;
            }
            OSSFederationToken * token = [OSSFederationToken new];
            MYLog(@"%@",token);
            NSDictionary *dict = [object objectForKey:@"Credentials"];
            token.tAccessKey = [dict objectForKey:@"AccessKeyId"];
            token.tSecretKey = [dict objectForKey:@"AccessKeySecret"];
            token.tToken = [dict objectForKey:@"SecurityToken"];
            token.expirationTimeInGMTFormat = [dict objectForKey:@"Expiration"];
            MYLog(@"get token: %@", token);
            return token;
        }
    }];
    
    OSSClientConfiguration * conf = [OSSClientConfiguration new];
    conf.maxRetryCount = 2;
    conf.timeoutIntervalForRequest = 30;
    conf.timeoutIntervalForResource = 24 * 60 * 60;
    
    self.aliclient = [[OSSClient alloc] initWithEndpoint:kQSCENDPOINT credentialProvider:credential clientConfiguration:conf];
    
}

//补助方法=========>
+(NSString *)requestErrorControllWithErrorCode:(long)errorCode{
    NSString *failMsg = QSCErrorText;
    switch(errorCode){
        case -1001:{
            failMsg = @"网速不给力";
            break;
        }
        case -1002:
        case -1003:
        case -1006:
        case -1007:{
            failMsg = @"链接不到服务器";
            break;
        }
        case -1005:
            failMsg = @"网络失去连接";
            break;
        case -1004:
        case -1009:
            failMsg = @"没有可用网络";
            break;
        case -1200:
            failMsg = @"网络请求失败";
            break;
        case -1201:
        case -1202:
        case -1203:
        case -1204:
            failMsg = @"非法请求操作";
            break;
        case -1205:
        case -1206:
            failMsg = @"安全链接失败";
            break;
        default:
            failMsg = QSCErrorText;
            break;
    }
    return failMsg;
}




+ (void)successWithResponseObject:(id)responseObject httpToolSuccess:(QSCSuccess)httpToolSuccess failure:(QSCFailure)failure{
    
}
//{
//
//    if (![responseObject isKindOfClass:[NSNull class]]) {
//
//        NSInteger codeNum = [responseObject[@"meta"][@"code"] integerValue];
////        codeNum = 9999;
//        if (codeNum ==0) {
//            httpToolSuccess(responseObject);
//        }else if (codeNum == 10||codeNum == 11)
//        {
//            MYLog(@"换token_______code");
//            QSCAccount *account = [QSCAccountTool sharedQSCAccountTool].account;
//            if (account.access_token.length) {
//
//                //刷新token
//                [[QSCAccessTokenManager sharedQSCAccessTokenManager] refreshTheAccessTokenWithFailureBlock:^{
//
//                    //清除本地用户数据
//                    [QSCLoginAccountTool saveAccount:nil];
//
//                    //清除本地token数据
//                    [[QSCAccessTokenManager sharedQSCAccessTokenManager] clearTheAccessTokenData];
//
//                    //弹出登录界面去重新登录
//                    BOOL showThird = NO;
//                    NSString *is_review = [QSCParametersInitTool sharedQSCParametersInitTool].parameters.version.is_review;
//
//                    if ([is_review isEqualToString:@"Y"]) {
//                        showThird = YES;
//                    }
//
//                    [QSCCommonTool CommonGoLogin];
//
//                }sucessBlock:^{
//                    QSCAccount *acc = [[QSCAccountTool sharedQSCAccountTool]account];
//                    if (acc) {
//                        acc.access_token = [QSCAccessTokenManager sharedQSCAccessTokenManager].currentToken.access_token;
//                        acc.expires_in = [QSCAccessTokenManager sharedQSCAccessTokenManager].currentToken.expires_in;
//                        acc.srv_create_time =  [QSCAccessTokenManager sharedQSCAccessTokenManager].currentToken.srv_create_time;
//                        acc.currentGetTime = [QSCAccessTokenManager sharedQSCAccessTokenManager].currentToken.currentGetTime;
//                        [[QSCAccountTool sharedQSCAccountTool]saveAccount:acc];
//                    }
//
//                     dispatch_async(dispatch_get_main_queue(), ^{
//                    //写入webview 用户信息数据
//                    QSCWirteUserInfoWebView *myview =  [[[NSBundle mainBundle] loadNibNamed:@"QSCWirteUserInfoWebView" owner:nil options:nil] lastObject];
//                    [myview loadUrl:kWriteLocalStorageUrl1];
//                    QSCWirteUserInfoWebView *myview2 =  [[[NSBundle mainBundle] loadNibNamed:@"QSCWirteUserInfoWebView" owner:nil options:nil] lastObject];
//                    [myview2 loadUrl:kWriteLocalStorageUrl2];
//                    QSCWirteUserInfoWebView *myview3 =  [[[NSBundle mainBundle] loadNibNamed:@"QSCWirteUserInfoWebView" owner:nil options:nil] lastObject];
//                    [myview3 loadUrl:kWriteLocalStorageUrl3];
//                     QSCWirteUserInfoWebView *myview4 =  [[[NSBundle mainBundle] loadNibNamed:@"QSCWirteUserInfoWebView" owner:nil options:nil] lastObject];
//                     [myview4 loadUrl:kWriteLocalStorageUrl4];
//                     });
//
//                }];
//
//                 if (failure)failure (nil);
//
//            }else{
//                [QSCCommonTool CommonGoLogin];
//                if (failure)failure (nil);
//            }
//
//        }else if (codeNum == 12)
//        {
//            //弹出绑定界面
//
//
//            QSCLoginModuleManager *loginManager = [QSCLoginModuleManager sharedQSCLoginModuleManager];
//            loginManager.currentPlatomStr = [NSString stringWithFormat:@"qsc_ios/%@",APPVERSION];
//            loginManager.hiddenBingdingLeftBtn = YES;
//            [loginManager showTheBandingVCWithQSCAppType:QSCAppTypeHelpEachOther];
//            httpToolSuccess(@{@"code":@"12"});
//
//        }
//        else if ( codeNum >= 1 && codeNum <= 1000000)
//        {
//
//            if (codeNum == 100040){ // 重复实名认证
//                httpToolSuccess(responseObject);
//            }else{
//                MYLog(@"错误提示  10000 ---  99999 %@",responseObject);
//                [self showError:responseObject];
//                if (failure) {
//                    failure (nil);
//                }
//            }
//
//        } else
//        {
//            MYLog(@"大于1000000  不提示内容");
//            if (failure) {
//
//                failure (nil);
//            }
//        }
//
//    }
//}

+ (void)showError:(id )responseObject
{
    MYLog(@"msg --- %@   error---%@",responseObject [@"msg"],responseObject[@"error"]);
    
    if ([responseObject [@"meta"][@"message"] isKindOfClass:[NSString class]] || [responseObject[@"meta"][@"msg"] isKindOfClass:[NSString class]]) {
        NSString *msg = responseObject [@"meta"][@"message"];
        NSString *msg2 = responseObject [@"meta"][@"msg"];
        
        if (msg.length) {
            [ProgressHUD showError:msg];
        }else if (msg2.length) {
            [ProgressHUD showError:msg2];
        }else{
            [ProgressHUD showError:@"系统维护中..."];
        }
    }
    else
        [ProgressHUD showError:@"系统维护中..."];
}


@end
