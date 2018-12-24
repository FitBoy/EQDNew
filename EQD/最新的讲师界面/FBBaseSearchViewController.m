//
//  FBBaseSearchViewController.m
//  EQD
//
//  Created by 梁新帅 on 2018/12/13.
//  Copyright © 2018 FitBoy. All rights reserved.
//

#import "FBBaseSearchViewController.h"
@interface FBBaseSearchViewController ()<UICollectionViewDelegate,UICollectionViewDataSource,UISearchBarDelegate,UICollectionViewDelegateFlowLayout>
{
    UICollectionView *CollectionV;
}

@end

/*
 [
 {
 @"name":@"名字"
 @"width":@"宽度"
 },
 {
 
 }
 
 ]
 
 */
@implementation FBBaseSearchViewController

- (void)viewDidLoad {
    [super viewDidLoad];

    UISearchBar * searchBar =[[UISearchBar alloc]initWithFrame:CGRectMake(40, kStatusBarHeight, DEVICE_WIDTH, 40)];
    [self.view addSubview:searchBar];
    searchBar.searchBarStyle = UISearchBarStyleMinimal;
    searchBar.delegate=self;
    searchBar.placeholder=@"搜索";
    
   //  navigator_btn_back 返回按钮的名字
    UIImageView *IV_back = [[UIImageView alloc]initWithFrame:CGRectMake(5, kStatusBarHeight+5, 30, 30)];
    UITapGestureRecognizer *tap = [[UITapGestureRecognizer alloc]initWithTarget:self action:@selector(backClick)];
    self.view.backgroundColor = [[UIColor darkGrayColor] colorWithAlphaComponent:0.4];
    [IV_back addGestureRecognizer:tap];
    [self.view addSubview:IV_back];
    
    UICollectionViewFlowLayout  *flowL =[[UICollectionViewFlowLayout alloc]init];
    flowL.itemSize =CGSizeMake(50, 50);
    flowL.sectionInset = UIEdgeInsetsMake(5, 10, 5, 10);
    CollectionV =[[UICollectionView alloc]initWithFrame:self.view.frame collectionViewLayout:flowL];
    CollectionV.delegate=self;
    CollectionV.dataSource=self;
    [self.view addSubview:CollectionV];
    
    [CollectionV registerClass:[UICollectionViewCell class] forCellWithReuseIdentifier:@"CollectionViewCell"];
    
    
}


-(CGSize)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout *)collectionViewLayout sizeForItemAtIndexPath:(NSIndexPath *)indexPath
{
    return CGSizeMake(30, 30);
    
}
#pragma mark - collection 数据源与代理

-(NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section{
    return 0;
}
- ( UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath{
    
    UICollectionViewCell *cell= [collectionView dequeueReusableCellWithReuseIdentifier:@"CollectionViewCell" forIndexPath:indexPath];
    
    
    return cell;
}
-(void)collectionView:(UICollectionView *)collectionView didSelectItemAtIndexPath:(NSIndexPath *)indexPath{
    NSLog(@"被选中");
}
-(void)collectionView:(UICollectionView *)collectionView moveItemAtIndexPath:(NSIndexPath *)sourceIndexPath toIndexPath:(NSIndexPath *)destinationIndexPath{
    
}

-(void)backClick
{
    [self dismissViewControllerAnimated:NO completion:nil];
    
}


-(void)searchBarSearchButtonClicked:(UISearchBar *)searchBar
{
    if(searchBar.text.length==0)
    {
        MBFadeAlertView *alert = [[MBFadeAlertView alloc]init];
        [alert showAlertWith:@"请输入搜索内容"];
    }else
    {
       if([self.delegate_search respondsToSelector:@selector(getSearchKey:)])
       {
           [self.delegate_search getSearchKey:searchBar.text];
           [self dismissViewControllerAnimated:NO completion:nil];
       }
    }
}



@end
