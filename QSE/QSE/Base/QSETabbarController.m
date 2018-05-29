//
//  QSETabbarController.m
//  QSE
//
//  Created by zhouyuxi on 2018/5/28.
//  Copyright © 2018年 zhouyuxi. All rights reserved.
//

#import "QSETabbarController.h"
#import "QSEBaseController.h"
#import "QSENavigationController.h"
#import "QSEHomeController.h"
#import "QSENoticeController.h"
#import "QSEMeController.h"

@implementation QSETabbarController

-(void)viewDidLoad
{
   [super viewDidLoad];
    UITabBar.appearance.backgroundColor = [UIColor whiteColor];
    //设置 tabbarItem 未选中状态下的文字颜色(不被系统默认渲染,显示文字自定义颜色)
    [[UITabBarItem appearance]setTitleTextAttributes:[NSDictionary dictionaryWithObjectsAndKeys:[UIColor grayColor],NSForegroundColorAttributeName,[UIFont fontWithName:@"Helvetica"size:12.0f],NSFontAttributeName,nil]forState:UIControlStateNormal];
    
    //设置 tabbarItem 选中状态下的文字颜色(不被系统默认渲染,显示文字自定义颜色)
    [[UITabBarItem appearance]setTitleTextAttributes:[NSDictionary dictionaryWithObjectsAndKeys:[UIColor blackColor],NSForegroundColorAttributeName,[UIFont fontWithName:@"Helvetica"size:12.0f],NSFontAttributeName,nil]forState:UIControlStateSelected];
    
    [self setupChildControllers];
}

- (void)setupChildControllers
{
    QSEHomeController *home = [[QSEHomeController alloc] init];
    [self addChildViewControllers:home title:@"首页" imageName:@"home"];
    
    QSENoticeController *notice = [[QSENoticeController alloc] init];
    [self addChildViewControllers:notice title:@"通知" imageName:@"notice"];
    
    QSEMeController *me = [[QSEMeController alloc] init];
    [self addChildViewControllers:me title:@"我" imageName:@"me"];
}

- (void)addChildViewControllers:(QSEBaseController *)controller title:(NSString *)title imageName:(NSString *)imageName{
    controller.title = title;
    controller.tabBarItem.image = [UIImage imageNamed:imageName];
    NSString *selectImageName = [NSString stringWithFormat:@"%@_selected",imageName];
    controller.tabBarItem.selectedImage = [[UIImage imageNamed:selectImageName] imageWithRenderingMode:UIImageRenderingModeAlwaysOriginal];
    QSENavigationController *nav = [[QSENavigationController alloc] initWithRootViewController:controller];
    [self addChildViewController:nav];
}


@end
