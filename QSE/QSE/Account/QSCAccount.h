//
//  QSCAccount.h
//  qingsongchou
//
//  Created by Chai on 15/9/15.
//  Copyright (c) 2015年 Chai. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "QSCUser.h"



@interface QSCAccount : NSObject

// 按新文档声明
@property (nonatomic, copy) NSString *access_token;
@property (nonatomic, copy) NSString *token_type;
@property (nonatomic, copy) NSString *expires_in;
@property (nonatomic, copy) NSString *refresh_token;
@property (nonatomic, assign) int new_user;
@property (nonatomic, strong) QSCUser *user;

@property (nonatomic, copy) NSString *reviewPhone;



// 前文档必须保留的
@property (nonatomic, copy) NSString *timestamps;

//passport 新增

//服务器创建token时的时间戳，
@property (nonatomic, copy) NSString *srv_create_time;
//记录当前请求回来的时间 //可以用来比较两个token的新旧
@property (nonatomic, strong) NSDate *currentGetTime;

//第三方登录才有的字段
//第三方是否绑定手机号标识
@property (nonatomic, copy) NSString *bind_phone_flag;
//头像
@property (nonatomic, copy) NSString *face_url;
//用户昵称
@property (nonatomic, copy) NSString *name;






@end



