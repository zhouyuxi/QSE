//
//  QSCUser.h
//  qingsongchou
//
//  Created by Chai on 15/9/22.
//  Copyright (c) 2015年 Chai. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface QSCUser : NSObject

@property (nonatomic, copy) NSString *avatar;

@property (nonatomic, copy) NSString *phone;

@property (nonatomic, copy) NSString *avatar_thumb;

@property (nonatomic, copy) NSString *nickname;

@property (nonatomic, copy) NSString *uuid;

@property (nonatomic, copy) NSString *url;

@property (nonatomic, copy) NSString *user_id;

@property (nonatomic, copy) NSString *alias;// 用于推送别名

/**
 *  好评率
 */
@property (nonatomic, copy) NSString *rate_avg;

//电话
@property (nonatomic, copy) NSString *mobile;



@end
