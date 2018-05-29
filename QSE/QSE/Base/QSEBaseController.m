//
//  QSEBaseController.m
//  QSE
//
//  Created by zhouyuxi on 2018/5/28.
//  Copyright © 2018年 zhouyuxi. All rights reserved.
//

#import "QSEBaseController.h"
#import "IQKeyboardManager.h"

@interface QSEBaseController ()<UITableViewDelegate, UITableViewDataSource,UICollectionViewDataSource, UICollectionViewDelegate,UICollectionViewDelegateFlowLayout>
@property(nonatomic,strong)UITableView *tableView;
@property(nonatomic,strong)UICollectionView *myCollectionView;

@end

@implementation QSEBaseController

- (void)viewDidLoad {
    [super viewDidLoad];
    [self IQKeyboardManagerSetting];
    [UIApplication.sharedApplication setStatusBarStyle:UIStatusBarStyleLightContent];
}

-(void)viewDidAppear:(BOOL)animated
{
    [self IQKeyboardManagerSetting];
}

-(void)viewDidDisappear:(BOOL)animated
{
    [super viewDidDisappear:animated];

}
- (void)IQKeyboardManagerSetting
{
    [IQKeyboardManager sharedManager].enableAutoToolbar = YES;
    [IQKeyboardManager sharedManager].shouldShowToolbarPlaceholder=YES;
    [IQKeyboardManager sharedManager].toolbarDoneBarButtonItemText = @"完成";
    // 修改字体颜色
    [IQKeyboardManager sharedManager].shouldToolbarUsesTextFieldTintColor = NO;
    [IQKeyboardManager sharedManager].toolbarTintColor = [UIColor blackColor];
}

#pragma TableView

- (void)setupTableView
{
    self.tableView = [[UITableView alloc]initWithFrame:self.view.bounds style:UITableViewStylePlain];
    [self.view addSubview:self.tableView];
    self.tableView.dataSource = self;
    self.tableView.delegate = self;
    
    UIView *footerView = [[UIView alloc] init];
    footerView.backgroundColor = [UIColor clearColor];
    self.tableView.tableFooterView = footerView;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    
    return 0;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return [[UITableViewCell alloc] init];
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return 44;
}

#pragma CollectionView

- (void)setupCollectionView{
    UICollectionViewFlowLayout *layout = [[UICollectionViewFlowLayout alloc] init];
    self.myCollectionView = [[UICollectionView alloc]initWithFrame:CGRectMake(0, 0, kDeviceWidth, KDeviceHeight-64) collectionViewLayout:layout];
    layout.scrollDirection = UICollectionViewScrollDirectionVertical;
    self.myCollectionView.backgroundColor = [UIColor whiteColor];
    self.myCollectionView.dataSource = self;
    self.myCollectionView.delegate = self;
    [self.view addSubview:self.myCollectionView];
}

- (void)registCollectionCell{
    
    [self.myCollectionView registerClass:[UICollectionViewCell class] forCellWithReuseIdentifier:@"collectionCell"];
}

- (NSInteger)numberOfSectionsInCollectionView:(UICollectionView *)collectionView
{
    
    return 1;
}


-(NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section
{
    return 0;
    
}

-(UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath
{
    UICollectionViewCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:@"collectionCell" forIndexPath:indexPath];
    return cell;
}

-(UIEdgeInsets)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout *)collectionViewLayout insetForSectionAtIndex:(NSInteger)section
{
    
     return UIEdgeInsetsMake(0, 0, 0, 0);//分别为上、左、下、右
}

- (CGFloat)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout *)collectionViewLayout minimumLineSpacingForSectionAtIndex:(NSInteger)section
{
    
    return 0;
}

-(CGFloat)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout *)collectionViewLayout minimumInteritemSpacingForSectionAtIndex:(NSInteger)section
{
    
    return 0;
}



////设置状态栏颜色
//- (void)setStatusBarBackgroundColor:(UIColor *)color {
//    UIView *statusBar = [[[UIApplication sharedApplication] valueForKey:@"statusBarWindow"] valueForKey:@"statusBar"];
//    if ([statusBar respondsToSelector:@selector(setBackgroundColor:)]) {
//        statusBar.backgroundColor = color;
//    }
//}

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
