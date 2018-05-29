//
//  QSEHomeController.m
//  QSE
//
//  Created by zhouyuxi on 2018/5/28.
//  Copyright © 2018年 zhouyuxi. All rights reserved.
//

#import "QSEHomeController.h"
#import "QSENoticeController.h"

@interface QSEHomeController ()

@end

@implementation QSEHomeController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.view.backgroundColor = [UIColor redColor];
    
    UIButton *btn = [UIButton buttonWithType:UIButtonTypeCustom];
    btn.frame = CGRectMake(0, 0, 100, 100);
    btn.backgroundColor = [UIColor yellowColor];
    [self.view addSubview:btn];
    [btn addTarget:self action:@selector(pushNext:) forControlEvents:UIControlEventTouchUpInside];
}

- (void)pushNext:(UIButton *)btn
{
    QSENoticeController *notice = [[QSENoticeController alloc] init];
    [self.navigationController pushViewController:notice animated:YES];
    
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
