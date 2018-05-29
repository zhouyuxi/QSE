//
//  QSCShareManager.h
//  qingsongchou
//
//  Created by Chai on 16/3/15.
//  Copyright © 2016年 Chai. All rights reserved.
//

#import <Foundation/Foundation.h>


@interface QSCShareManager : NSObject

+ (void)shareProductParamsByText:(NSString *)text
                          images:(NSArray *)images
                             url:(NSURL *)url
                           title:(NSString *)title
                            type:(NSInteger)type
                             proUuid:(NSString *)uuid
                         shareTo:(int)shareTo;

+ (void)shareImageProductParamsByText:(NSString *)text
                          images:(NSArray *)images
                             url:(NSURL *)url
                           title:(NSString *)title
                            type:(NSInteger)type
                         proUuid:(NSString *)uuid
                         shareTo:(int)shareTo;


@end
