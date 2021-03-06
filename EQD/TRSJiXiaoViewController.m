//
//  TRSJiXiaoViewController.m
//  EQD
//
//  Created by 梁新帅 on 2017/6/12.
//  Copyright © 2017年 FitBoy. All rights reserved.
//

#import "TRSJiXiaoViewController.h"

@interface TRSJiXiaoViewController ()<UICollectionViewDelegate,UICollectionViewDataSource>
{
    UICollectionView *CollectionV;
    NSMutableArray *arr_model;
}

@end

@implementation TRSJiXiaoViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.navigationItem.title =@"企业看板";
    adjustsScrollViewInsets_NO(CollectionV, self);
    UICollectionViewFlowLayout  *flowL =[[UICollectionViewFlowLayout alloc]init];
    flowL.itemSize =CGSizeMake(DEVICE_WIDTH/2.0-20, (DEVICE_WIDTH/2.0-20)/2.0);
    flowL.minimumLineSpacing = 10;
    flowL.minimumInteritemSpacing=10;
    CollectionV =[[UICollectionView alloc]initWithFrame:CGRectMake(15, 64, DEVICE_WIDTH-30, DEVICE_HEIGHT-64) collectionViewLayout:flowL];
    CollectionV.delegate=self;
    CollectionV.dataSource=self;
    [self.view addSubview:CollectionV];
    
    [CollectionV registerClass:[UICollectionViewCell class] forCellWithReuseIdentifier:@"CollectionViewCell"];
}
#pragma mark - collection 数据源与代理
-(NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section{
    return 10;
}
- ( UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath{
    
    UICollectionViewCell *cell= [collectionView dequeueReusableCellWithReuseIdentifier:@"CollectionViewCell" forIndexPath:indexPath];
    cell.backgroundColor = [UIColor redColor];
    
    return cell;
}
-(void)collectionView:(UICollectionView *)collectionView didSelectItemAtIndexPath:(NSIndexPath *)indexPath{
    NSLog(@"被选中");
}


@end
