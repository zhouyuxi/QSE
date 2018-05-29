//
//  QSCCover.m
//  qingsongchou
//
//  Created by zhouyuxi on 16/1/18.
//  Copyright © 2016年 Chai. All rights reserved.
//

#import "QSCCover.h"

@implementation QSCCover

/**
 将Go接口返回的 thumbnail 字段映射到thumb

 */
-(void)setThumbnail:(NSString *)thumbnail{
    if(self.thumb == nil ){
        self.thumb = thumbnail;
    }
}
/**
 将Go接口返回的 origin 字段映射到thumb
 
 */
-(void)setOrigin:(NSString *)origin{
    if(self.image == nil ){
        self.image = origin;
    }
}
@end
