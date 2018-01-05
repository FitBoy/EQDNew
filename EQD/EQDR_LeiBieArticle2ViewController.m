//
//  EQDR_LeiBieArticle2ViewController.m
//  EQD
//
//  Created by 梁新帅 on 2017/12/31.
//  Copyright © 2017年 FitBoy. All rights reserved.
//

#import "EQDR_LeiBieArticle2ViewController.h"
#import "WebRequest.h"
#import "FBNameLabelCollectionViewCell.h"
#import "OptionModel.h"
#import <Masonry.h>
@interface EQDR_LeiBieArticle2ViewController ()<UICollectionViewDataSource,UICollectionViewDelegateFlowLayout>
{
    UICollectionView *CollectionV;
    NSMutableArray *arr_model;
    NSMutableArray *arr_chooseModel;
}

@end

@implementation EQDR_LeiBieArticle2ViewController
-(void)viewWillAppear:(BOOL)animated{
    [super viewWillAppear:animated];
    [self loadRequestData];
}
-(void)loadRequestData{

    [WebRequest Option_AreasAndWithtype:44 And:^(NSArray *arr) {
        for (int i=0; i<arr.count; i++) {
            OptionModel  *model = [OptionModel mj_objectWithKeyValues:arr[i]];
              model.isChoose = NO;
            for (int i=0; i<self.arr_chooses.count; i++) {
                OptionModel  *model2 = self.arr_chooses[i];
                if ([model.name  isEqualToString:model2.name]) {
                    model.isChoose =YES;
                break;
                }else
                {
                    model.isChoose=NO;
                }
            }
          
            [arr_model addObject:model];
        }
        [CollectionV reloadData];
    }];
}
- (void)viewDidLoad {
    [super viewDidLoad];
    self.navigationItem.title =@"文章分类";
    arr_chooseModel = [NSMutableArray arrayWithArray:_arr_chooses];
    arr_model = [NSMutableArray arrayWithCapacity:0];
    UICollectionViewFlowLayout  *flowL =[[UICollectionViewFlowLayout alloc]init];
//    flowL.itemSize =CGSizeMake(50, 50);
//    flowL.sectionInset = UIEdgeInsetsMake(5, 10, 5, 10);
    flowL.minimumLineSpacing =10;
    flowL.minimumInteritemSpacing=10;
    CollectionV =[[UICollectionView alloc]initWithFrame:CGRectMake(15, DEVICE_TABBAR_Height+10, DEVICE_WIDTH-30, DEVICE_HEIGHT-DEVICE_TABBAR_Height-10) collectionViewLayout:flowL];
    adjustsScrollViewInsets_NO(CollectionV, self);
    CollectionV.delegate=self;
    CollectionV.dataSource=self;
    [self.view addSubview:CollectionV];
    CollectionV.backgroundColor = [UIColor whiteColor];
    [CollectionV registerClass:[FBNameLabelCollectionViewCell class] forCellWithReuseIdentifier:@"CollectionViewCell"];
    UIBarButtonItem *right = [[UIBarButtonItem alloc]initWithTitle:@"确定" style:UIBarButtonItemStylePlain target:self action:@selector(quedingClick)];
    [self.navigationItem setRightBarButtonItem:right];
}
-(void)quedingClick
{
    if ([self.delegate respondsToSelector:@selector(getArticleWithModel:)]) {
        [self.delegate getArticleWithModel:arr_chooseModel];
        [self.navigationController popViewControllerAnimated:NO];
    }
}
#pragma mark - collection 数据源与代理
-(NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section{
    return arr_model.count;
}
- ( UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath{
    
    FBNameLabelCollectionViewCell *cell= [collectionView dequeueReusableCellWithReuseIdentifier:@"CollectionViewCell" forIndexPath:indexPath];
    OptionModel  *model =arr_model[indexPath.row];
    
    
    if (model.isChoose==NO) {
       cell.backgroundColor = [UIColor grayColor];
    }else
    {
         cell.backgroundColor = EQDCOLOR;
    }
   
    cell.L_name.text = model.name;
    [cell.L_name mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerY.mas_equalTo(cell.mas_centerY);
        make.height.mas_equalTo(30);
        make.centerX.mas_equalTo(cell.mas_centerX);
        make.width.mas_equalTo(model.cellHeight+20);
    }];

    
    
    return cell;
}
-(void)collectionView:(UICollectionView *)collectionView didSelectItemAtIndexPath:(NSIndexPath *)indexPath{
 OptionModel  *model = arr_model[indexPath.row];
    if (model.isChoose==NO && arr_chooseModel.count>2) {
        MBProgressHUD *hud=[MBProgressHUD showHUDAddedTo:self.view  animated:YES];
        hud.mode = MBProgressHUDModeText;
        hud.label.text =@"最多选择3种类别";
        dispatch_time_t popTime = dispatch_time(DISPATCH_TIME_NOW, 1 * NSEC_PER_SEC);
        dispatch_after(popTime, dispatch_get_main_queue(), ^(void){
            [MBProgressHUD hideHUDForView:self.view  animated:YES];
        });
    }else
    {
        model.isChoose =!model.isChoose;
        [CollectionV reloadItemsAtIndexPaths:@[indexPath]];
        if (model.isChoose==YES) {
            [arr_chooseModel  addObject:model];
        }else
        {
            [arr_chooseModel removeObject:model];
        }
    }
   
   
    
}

-(CGSize)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout *)collectionViewLayout sizeForItemAtIndexPath:(NSIndexPath *)indexPath
{
    OptionModel  *model = arr_model[indexPath.row];
    CGSize  size = [model.name boundingRectWithSize:CGSizeMake(DEVICE_WIDTH-30, 30) options:NSStringDrawingUsesLineFragmentOrigin attributes:@{NSFontAttributeName:[UIFont systemFontOfSize:16]} context:nil].size;
    model.cellHeight = size.width;
    
    return CGSizeMake(size.width+20, 30);
}


@end
