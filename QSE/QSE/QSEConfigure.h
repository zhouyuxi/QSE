//
//  QSEConfigure.h
//  QSE
//
//  Created by zhouyuxi on 2018/5/29.
//  Copyright © 2018年 zhouyuxi. All rights reserved.
//

#ifndef QSEConfigure_h
#define QSEConfigure_h


#endif /* QSEConfigure_h */

// Platform
#define kHeadVersion  [NSString stringWithFormat:@"huzhu_ios/%@/%%@/v1",[[[NSBundle mainBundle] infoDictionary] objectForKey:@"CFBundleShortVersionString"]]
#define kH5HeadVersion [NSString stringWithFormat:@"huzhu_ios/%@/v1",[[[NSBundle mainBundle] infoDictionary] objectForKey:@"CFBundleShortVersionString"]]
#define kQSCENDPOINT   @"http://oss-cn-hangzhou.aliyuncs.com" // 阿里图片上传

#ifdef DEBUG /*! 线下环境APPKey */
static  NSString * const UMengKey = @"58a51416677baa6b8d0014e1";
#else  /*! 线上环境APPKey */
static  NSString * const UMengKey = @"58a51416677baa6b8d0014e1";
#endif




#ifdef DEBUG /*! 线下环境URL */
#define kQSCBaseUrlPath             @"http://api.qschou.com/v6"
#else  /*! 线上环境URL */
#define kQSCBaseUrlPath             @"http://api.qschou.com/v6"
#endif
