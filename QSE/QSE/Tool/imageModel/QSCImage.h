//
//  QSCImage.h
//  qingsongchou
//
//  Created by zhouyuxi on 16/3/17.
//  Copyright © 2016年 Chai. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "MWPhoto.h"
#import "MWPhotoBrowser.h"

@interface QSCImage : NSObject

typedef NS_ENUM(NSInteger, QSCisUp)
{
    QSCDefault = 0, //图片未上传
    QSCUpSuccess, //图片上传成功
    QSCUpFail, //图片上传失败
    QSCAddIMG, //图片未选择
    
    QSCAddTips, //提示图片
};

@property (nonatomic, copy) NSString *image; // url
@property (nonatomic, copy) NSString *thumb; // url
@property (nonatomic, strong) UIImage *imageV;
@property (nonatomic,copy) NSString *imageName;
//@property (nonatomic,copy) NSString  *imageUrl;
@property (nonatomic,strong) MWPhoto *photo;
@property (nonatomic,strong) NSIndexPath *indexPath;
@property (nonatomic,strong) NSMutableArray *imageArray;
@property (nonatomic,copy) NSString  *title;
@property (nonatomic,assign) QSCisUp isUpType;

//@property (nonatomic, copy) NSString *videoLocalPath;//提交前本地地址
//@property (nonatomic, copy) NSString *videoThumbLocalPath;//提交前本地图片地址
//@property (nonatomic, copy) NSString *videoRemoteUrl;//提交后远端地址
//@property (nonatomic, copy) NSString *videoThumbRemoteUrl;//提交后远端地址
@end
