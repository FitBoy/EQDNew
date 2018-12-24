//
//  FB_PXLeiBieChooseViewController.m
//  EQD
//
//  Created by 梁新帅 on 2018/1/5.
//  Copyright © 2018年 FitBoy. All rights reserved.
//

#import "FB_PXLeiBieChooseViewController.h"
#import "FBNameLabelCollectionViewCell.h"
#import "FBAddressModel.h"
#import <Masonry.h>
@interface FB_PXLeiBieChooseViewController ()<UICollectionViewDataSource,UICollectionViewDelegateFlowLayout>
{
    UICollectionView *CollectionV;
    NSMutableArray *arr_model;
    NSMutableArray *arr_model_choose;
}

@end

@implementation FB_PXLeiBieChooseViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    arr_model_choose = [NSMutableArray arrayWithArray:self.arr_chosemodel];
    self.navigationItem.title=@"讲师/课程/培训分类";
    arr_model = [NSMutableArray arrayWithCapacity:0];
    [WebRequest  Option_AreasAndWithtype:45 And:^(NSArray *arr) {
        for (int i=0; i<arr.count; i++) {
            FBAddressModel  *model =[FBAddressModel mj_objectWithKeyValues:arr[i]];
            for (int i=0; i<model.sub.count; i++) {
                for (int j=0; j<self.arr_chosemodel.count; j++) {
                    FBAddressModel  *model1 = model.sub[i];
                    FBAddressModel *model2 =self.arr_chosemodel[j];
                    if ([model1.name isEqualToString:model2.name]) {
                        model1.isChoose = YES;
                    break;
                    }
                }
               
            }
            [arr_model addObject:model];
        }
        [CollectionV reloadData];
    }];
    UICollectionViewFlowLayout  *flowL =[[UICollectionViewFlowLayout alloc]init];
//    flowL.itemSize =CGSizeMake(50, 50);
    flowL.sectionInset = UIEdgeInsetsMake(5, 10, 5, 10);
    flowL.minimumLineSpacing=7;
    flowL.minimumInteritemSpacing=7;
    flowL.headerReferenceSize = CGSizeMake(DEVICE_WIDTH, 30);
    CollectionV =[[UICollectionView alloc]initWithFrame:CGRectMake(15, DEVICE_TABBAR_Height, DEVICE_WIDTH-30, DEVICE_HEIGHT-DEVICE_TABBAR_Height-kBottomSafeHeight) collectionViewLayout:flowL];
    adjustsScrollViewInsets_NO(CollectionV, self);
    CollectionV.delegate=self;
    CollectionV.dataSource=self;
    [self.view addSubview:CollectionV];
    CollectionV.backgroundColor = [UIColor whiteColor];
    [CollectionV registerClass:[FBNameLabelCollectionViewCell class] forCellWithReuseIdentifier:@"CollectionViewCell"];
     [CollectionV registerClass:[FBNameLabelCollectionViewCell class] forSupplementaryViewOfKind:UICollectionElementKindSectionHeader withReuseIdentifier:@"CollectionReusableView"];
    
    UIBarButtonItem *right = [[UIBarButtonItem alloc]initWithTitle:@"确定" style:UIBarButtonItemStylePlain target:self action:@selector(quedingClick)];
    [self.navigationItem setRightBarButtonItem:right];
    UIBarButtonItem *left = [[UIBarButtonItem alloc]initWithTitle:@"返回" style:UIBarButtonItemStylePlain target:self action:@selector(backClick)];
    [self.navigationItem setLeftBarButtonItem:left];
}
-(void)backClick
{
//    if ([self.delegate respondsToSelector:@selector(getTecherLeiBieModel:)]) {
//        [self.delegate getTecherLeiBieModel:arr_model_choose];
//    }
    [self.navigationController popViewControllerAnimated:NO];
}
-(void)quedingClick
{
    if ([self.delegate respondsToSelector:@selector(getTecherLeiBieModel:)]) {
        [self.delegate getTecherLeiBieModel:arr_model_choose];
    }
    [self.navigationController popViewControllerAnimated:NO];
}
#pragma mark - collection 数据源与代理
-(NSInteger)numberOfSectionsInCollectionView:(UICollectionView *)collectionView
{
    return arr_model.count;
}
-(UICollectionReusableView*)collectionView:(UICollectionView *)collectionView viewForSupplementaryElementOfKind:(NSString *)kind atIndexPath:(NSIndexPath *)indexPath
{
    UICollectionReusableView *reusableview = nil;
    
    if (kind == UICollectionElementKindSectionHeader){
        
        UICollectionReusableView *headerView = [collectionView dequeueReusableSupplementaryViewOfKind:UICollectionElementKindSectionHeader withReuseIdentifier:@"CollectionReusableView" forIndexPath:indexPath];
        
        headerView.backgroundColor = EQDCOLOR;
        
        //把想添加的控件放在session区头重用的cell里,并且回来赋值,防止重用(重点!!!!!)
        
        UILabel *ttLabel = (UILabel *)[headerView viewWithTag:111];
        if(!ttLabel)
        {
            ttLabel = [[UILabel alloc]initWithFrame:CGRectMake(15, 5, DEVICE_WIDTH-30, 20)];
            ttLabel.tag =111;
            ttLabel.font =[UIFont systemFontOfSize:16];
            [headerView addSubview:ttLabel];
        }
        
        FBAddressModel  *model =arr_model[indexPath.section];
        ttLabel.text =model.name;
        
        reusableview = headerView;
        
    }
    return reusableview;
    
    
}
-(NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section{
    FBAddressModel *model = arr_model[section];
    return model.sub.count;
}
- ( UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath{
    
    FBNameLabelCollectionViewCell *cell= [collectionView dequeueReusableCellWithReuseIdentifier:@"CollectionViewCell" forIndexPath:indexPath];
    FBAddressModel *model = arr_model[indexPath.section];
    FBAddressModel  *model2 =model.sub[indexPath.row];
    cell.L_name.text = model2.name;
    [cell.L_name mas_remakeConstraints:^(MASConstraintMaker *make) {
        make.size.mas_equalTo(CGSizeMake(model2.cellHeight, 30));
        make.centerY.mas_equalTo(cell.mas_centerY);
        make.centerX.mas_equalTo(cell.mas_centerX);
    }];
    
   
    if (model2.isChoose==NO) {
        cell.L_name.backgroundColor  =[UIColor whiteColor];
    }else
    {
        cell.L_name.backgroundColor = [UIColor greenColor];
    }
    
    return cell;
}
-(void)collectionView:(UICollectionView *)collectionView didSelectItemAtIndexPath:(NSIndexPath *)indexPath{
    FBAddressModel  *model = arr_model[indexPath.section];
    FBAddressModel *model2 =model.sub[indexPath.row];
    
    if (model2.isChoose==NO && arr_model_choose.count >4) {
        MBProgressHUD *hud=[MBProgressHUD showHUDAddedTo:self.view  animated:YES];
        hud.mode = MBProgressHUDModeText;
        hud.label.text =@"最多选择5种类别";
        dispatch_time_t popTime = dispatch_time(DISPATCH_TIME_NOW, 1 * NSEC_PER_SEC);
        dispatch_after(popTime, dispatch_get_main_queue(), ^(void){
            [MBProgressHUD hideHUDForView:self.view  animated:YES];
        });
    }else
    {
    
    model2.isChoose = !model2.isChoose;
        if (model2.isChoose==NO) {
            for (int i=0; i<arr_model_choose.count; i++) {
                FBAddressModel *tmodel =arr_model_choose[i];
                if ([tmodel.name isEqualToString:model2.name]) {
                    [arr_model_choose removeObject:tmodel];
                    break;
                }
            }
        }else
        {
            [arr_model_choose addObject:model2];
        }
    [CollectionV reloadItemsAtIndexPaths:@[indexPath]];
    }
}
-(CGSize)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout *)collectionViewLayout sizeForItemAtIndexPath:(NSIndexPath *)indexPath
{
    FBAddressModel *model = arr_model[indexPath.section];
    FBAddressModel  *model2 =model.sub[indexPath.row];
    CGSize size = [model2.name boundingRectWithSize:CGSizeMake(DEVICE_WIDTH-30, 30) options:NSStringDrawingUsesLineFragmentOrigin attributes:@{NSFontAttributeName:[UIFont systemFontOfSize:16]} context:nil].size;
    model2.cellHeight = size.width+20;
    return CGSizeMake(size.width+20, 30);
}

@end
