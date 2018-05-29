//
//  QSCCover.h
//  qingsongchou
//
//  Created by zhouyuxi on 16/1/18.
//  Copyright © 2016年 Chai. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "MWPhoto.h"

@interface QSCCover : NSObject
/*! 默人|不设置｜ nil 为图片，@"live"为 视频跳转链接图片 */
@property (nonatomic, copy) NSString *imageType;
/*! 图片为视频链接时，视频地址 */
@property (nonatomic, copy) NSString *videoUrl;
/*! 图片为视频链接时，项目uuid */
@property (nonatomic, strong) NSString *videoProjectUuid;
/*! 图片为视频链接时，项目templateId */
@property (nonatomic, strong) NSString *videoProjectTemplateId;
/*! 图片为视频链接时，项目templateId */
@property (nonatomic, strong) NSString *videoProjectCategoryId;



@property (nonatomic, copy) NSString *image;
@property (nonatomic, copy) NSString *thumb;
@property (nonatomic, strong) MWPhoto *mwPhoto;
@property (nonatomic, strong) UIImage *cacheImage;



@property (nonatomic, copy) NSString *title;



@end
