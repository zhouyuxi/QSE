//
//  QSENavigationController.m
//  QSE
//
//  Created by zhouyuxi on 2018/5/28.
//  Copyright © 2018年 zhouyuxi. All rights reserved.
//

#import "QSENavigationController.h"
#import "QSEBaseController.h"


@interface QSENavigationController ()

@end

@implementation QSENavigationController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.navigationBar.backgroundColor= [UIColor whiteColor];
    self.navigationBar.tintColor = [UIColor blackColor];
    UIImage *image = [UIImage createImageWithColor:[UIColor whiteColor]];
;
    [self.navigationBar setBackgroundImage:image forBarMetrics:UIBarMetricsDefault];
}

- (void)pushViewController:(UIViewController *)viewController animated:(BOOL)animated{
    if (self.childViewControllers.count > 0) {
        viewController.hidesBottomBarWhenPushed = YES;
        
        if ([viewController isKindOfClass:[QSEBaseController class]]) {
            viewController.navigationItem.leftBarButtonItem = [[UIBarButtonItem alloc]  initWithImage:[UIImage imageNamed:@"nav_back"] style:UIBarButtonItemStylePlain target:self action:@selector(popToParent)];
        }
    }
    
    [super pushViewController:viewController animated:YES];
}


-(void)popToParent
{
    [self popViewControllerAnimated:YES];
    
    
}
- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
