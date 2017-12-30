//
//  FB_ShareEQDViewController.m
//  EQD
//
//  Created by 梁新帅 on 2017/12/30.
//  Copyright © 2017年 FitBoy. All rights reserved.
//
/*
 LYvc.providesPresentationContextTransitionStyle = YES;
 LYvc.definesPresentationContext = YES;
 LYvc.modalPresentationStyle = UIModalPresentationOverCurrentContext;
 */
#define DEVICE_HEIGHT  [UIScreen mainScreen].bounds.size.height
#define DEVICE_WIDTH   [UIScreen mainScreen].bounds.size.width
#import "FB_ShareEQDViewController.h"
#import "FB_shareEQDCollectionViewCell.h"
#import <MJExtension.h>
@interface FB_ShareEQDViewController ()<UICollectionViewDelegate,UICollectionViewDataSource>
{
    UICollectionView *CollectionV;
    NSMutableArray  *arr_model;
    NSArray  *arr_json;
}

@end

@implementation FB_ShareEQDViewController
-(void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
    [arr_model removeAllObjects];
    for(int i=0;i<arr_json.count;i++)
    {
        NSDictionary *tdic = arr_json[i];
        FB_ShareModel *model =[FB_ShareModel mj_objectWithKeyValues:tdic];
        [arr_model addObject:model];
    }
    [CollectionV reloadData];
}
- (void)viewDidLoad {
    [super viewDidLoad];
    if (self.EQD_ShareType == EQD_ShareTypeText) {
        arr_json = @[
                     @{
                         @"img":@"share_friend",
                         @"biaoji":@"10",
                         @"name":@"发送给好友"
                         },
                     @{
                         @"img":@"share_eqd",
                         @"biaoji":@"11",
                         @"name":@"工作圈"
                         },
                     @{
                         @"img":@"share_shoucang",
                         @"biaoji":@"13",
                         @"name":@"我的收藏"
                         },
                     @{
                         @"img":@"wechat",
                         @"biaoji":@"20",
                         @"name":@"微信"
                         },
                     @{
                         @"img":@"wechat_fav",
                         @"biaoji":@"21",
                         @"name":@"微信收藏"
                         },
                     @{
                         @"img":@"wechat_moment",
                         @"biaoji":@"22",
                         @"name":@"朋友圈"
                         },
                     @{
                         @"img":@"qq",
                         @"biaoji":@"30",
                         @"name":@"QQ"
                         },
                     @{
                         @"img":@"qzone",
                         @"biaoji":@"31",
                         @"name":@"qq空间"
                         },
                     @{
                         @"img":@"weibo",
                         @"biaoji":@"40",
                         @"name":@"新浪微博"
                         },
                     ];
    }else if (self.EQD_ShareType ==EQD_ShareTypeImage)
    {
        arr_json = @[
                     @{
                         @"img":@"share_friend",
                         @"biaoji":@"10",
                         @"name":@"发送给好友"
                         },
                     @{
                         @"img":@"share_eqd",
                         @"biaoji":@"11",
                         @"name":@"工作圈"
                         },
                     @{
                         @"img":@"share_shoucang",
                         @"biaoji":@"13",
                         @"name":@"我的收藏"
                         },
                     @{
                         @"img":@"wechat",
                         @"biaoji":@"20",
                         @"name":@"微信"
                         },
                     @{
                         @"img":@"wechat_fav",
                         @"biaoji":@"21",
                         @"name":@"微信收藏"
                         },
                     @{
                         @"img":@"wechat_moment",
                         @"biaoji":@"22",
                         @"name":@"朋友圈"
                         },
                     @{
                         @"img":@"qq",
                         @"biaoji":@"30",
                         @"name":@"QQ"
                         },
                     @{
                         @"img":@"qzone",
                         @"biaoji":@"31",
                         @"name":@"qq空间"
                         },
                     @{
                         @"img":@"weibo",
                         @"biaoji":@"40",
                         @"name":@"新浪微博"
                         },
                     ];
    }else if (self.EQD_ShareType ==EQD_ShareTypeLink)
    {
        arr_json = @[
                     @{
                         @"img":@"share_friend",
                         @"biaoji":@"10",
                         @"name":@"发送给好友"
                         },
                     @{
                         @"img":@"share_eqd",
                         @"biaoji":@"11",
                         @"name":@"工作圈"
                         },
                     
                     @{
                         @"img":@"share_shoucang",
                         @"biaoji":@"13",
                         @"name":@"我的收藏"
                         },
                     @{
                         @"img":@"share_safari",
                         @"biaoji":@"16",
                         @"name":@"用safari打开"
                         },
                     @{
                         @"img":@"wechat",
                         @"biaoji":@"20",
                         @"name":@"微信"
                         },
                     @{
                         @"img":@"wechat_fav",
                         @"biaoji":@"21",
                         @"name":@"微信收藏"
                         },
                     @{
                         @"img":@"wechat_moment",
                         @"biaoji":@"22",
                         @"name":@"朋友圈"
                         },
                     @{
                         @"img":@"qq",
                         @"biaoji":@"30",
                         @"name":@"QQ"
                         },
                     @{
                         @"img":@"qzone",
                         @"biaoji":@"31",
                         @"name":@"qq空间"
                         },
                     @{
                         @"img":@"weibo",
                         @"biaoji":@"40",
                         @"name":@"新浪微博"
                         },
                     ];
    }else if (self.EQD_ShareType ==EQD_ShareTypeFile)
    {
        arr_json = @[
                     @{
                         @"img":@"share_friend",
                         @"biaoji":@"10",
                         @"name":@"发送给好友"
                         },
                     
                     @{
                         @"img":@"wechat",
                         @"biaoji":@"20",
                         @"name":@"微信"
                         },
                     @{
                         @"img":@"wechat_fav",
                         @"biaoji":@"21",
                         @"name":@"微信收藏"
                         }
                     ];
    }else if (self.EQD_ShareType == EQD_ShareTypeVideo)
    {
        arr_json = @[
                     
                     @{
                         @"img":@"wechat",
                         @"biaoji":@"20",
                         @"name":@"微信"
                         },
                     @{
                         @"img":@"wechat_fav",
                         @"biaoji":@"21",
                         @"name":@"微信收藏"
                         },
                     @{
                         @"img":@"wechat_moment",
                         @"biaoji":@"22",
                         @"name":@"朋友圈"
                         },
                     @{
                         @"img":@"qq",
                         @"biaoji":@"30",
                         @"name":@"QQ"
                         },
                     @{
                         @"img":@"qzone",
                         @"biaoji":@"31",
                         @"name":@"qq空间"
                         }
                     ];
    }else
    {
        arr_json = nil;
    }
    float  width_cell = (DEVICE_WIDTH - 50)/4.0;
    arr_model =[NSMutableArray arrayWithCapacity:0];
    UICollectionViewFlowLayout  *flowL =[[UICollectionViewFlowLayout alloc]init];
    flowL.itemSize =CGSizeMake(width_cell, width_cell+30);
    flowL.sectionInset = UIEdgeInsetsMake(5, 10, 5, 10);
    flowL.minimumLineSpacing=5;
    flowL.minimumInteritemSpacing=5;
//    flowL.headerReferenceSize = CGSizeMake(DEVICE_WIDTH, 40);
    CollectionV =[[UICollectionView alloc]initWithFrame:CGRectMake(0, DEVICE_HEIGHT-(width_cell+40)*(arr_json.count/4+1), DEVICE_WIDTH, (width_cell+40)*(arr_json.count/4+1)) collectionViewLayout:flowL];
    CollectionV.delegate=self;
    CollectionV.dataSource=self;
    [self.view addSubview:CollectionV];
    self.view.backgroundColor = [[UIColor darkGrayColor] colorWithAlphaComponent:0.4];
    [CollectionV registerClass:[FB_shareEQDCollectionViewCell class] forCellWithReuseIdentifier:@"CollectionViewCell"];
    CollectionV.backgroundColor = [UIColor whiteColor];
   


}
-(void)touchesBegan:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event
{
    [self dismissViewControllerAnimated:NO completion:nil];
}
#pragma mark - collection 数据源与代理
-(NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section{
    return arr_model.count;
}
- ( UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath{
    
    FB_shareEQDCollectionViewCell *cell= [collectionView dequeueReusableCellWithReuseIdentifier:@"CollectionViewCell" forIndexPath:indexPath];
    FB_ShareModel *model =arr_model[indexPath.row];
    [cell setModel:model];
    
    return cell;
}
-(void)collectionView:(UICollectionView *)collectionView didSelectItemAtIndexPath:(NSIndexPath *)indexPath{
    [self dismissViewControllerAnimated:NO completion:nil];
    FB_ShareModel *model =arr_model[indexPath.row];
    switch ([model.biaoji integerValue]) {
        case 10:
            {
                //发送到朋友
            }
            break;
        case 11:
        {
            //工作圈
        }
            break;
        case 13:
        {
            //我的收藏
        }
            break;
        case 15:
        {
            //复制链接
        }
            break;
        case 16:
        {
            //用safari打开
        }
            break;
        case 20:
        {
            //微信
        }
            break;
        case 21:
        {
            //微信收藏
        }
            break;
        case 22:
        {
            //朋友圈
        }
            break;
        case 30:
        {
            //QQ
        }
            break;
        case 31:
        {
            //qq空间
        }
            break;
        default:
            break;
    }
    
}
-(void)collectionView:(UICollectionView *)collectionView moveItemAtIndexPath:(NSIndexPath *)sourceIndexPath toIndexPath:(NSIndexPath *)destinationIndexPath{
    
}




@end
