//
//  CK_picturesPersonViewController.m
//  EQD
//
//  Created by 梁新帅 on 2018/8/11.
//  Copyright © 2018年 FitBoy. All rights reserved.
//

#import "CK_picturesPersonViewController.h"
#import "PhotoModel.h"
#import "CK_pictruesCollectionViewCell.h"
#import "FBTextFieldViewController.h"
#import "CK_tuPianViewController.h"
#import "FBindexpathLongPressGestureRecognizer.h"
@interface CK_picturesPersonViewController ()<UICollectionViewDelegate,UICollectionViewDataSource,FBTextFieldViewControllerDelegate>
{
    UICollectionView *CollectionV;
    NSMutableArray *arr_model;
    NSString *page;
    UserModel *user;
    //是否是修改名字
    NSInteger temp;
}

@end

@implementation CK_picturesPersonViewController
-(void)viewWillAppear:(BOOL)animated{
    [super viewWillAppear:animated];
   
}
-(void)loadRequestData{
    [WebRequest Lectures_Get_LecturePhoto_MenuWithlectureGuid:self.userGuid page:@"0" And:^(NSDictionary *dic) {
        [CollectionV.mj_header endRefreshing];
        [CollectionV.mj_footer endRefreshing];
        if ([dic[Y_STATUS] integerValue]==200) {
            NSDictionary *Tdic =dic[Y_ITEMS];
            page =Tdic[@"page"];
            NSArray *tarr = Tdic[@"rows"];
            [arr_model removeAllObjects];
            
            
            for (int i=0; i<tarr.count; i++) {
                PhotoModel  *model = [PhotoModel mj_objectWithKeyValues:tarr[i]];
                [arr_model addObject:model];
            }
            [CollectionV reloadData];
        }
    }];
}
-(void)loadMoreData{
    [WebRequest Lectures_Get_LecturePhoto_MenuWithlectureGuid:self.userGuid page:page And:^(NSDictionary *dic) {
        [CollectionV.mj_header endRefreshing];
        [CollectionV.mj_footer endRefreshing];
        if ([dic[Y_STATUS] integerValue]==200) {
            NSDictionary *Tdic =dic[Y_ITEMS];
           
            NSArray *tarr = Tdic[@"rows"];
            if (tarr.count==0) {
                [CollectionV.mj_footer endRefreshingWithNoMoreData];
            }else
            {
             page =Tdic[@"page"];
            for (int i=0; i<tarr.count; i++) {
                PhotoModel  *model = [PhotoModel mj_objectWithKeyValues:tarr[i]];
                [arr_model addObject:model];
            }
            [CollectionV reloadData];
            }
        }
    }];
}
- (BOOL)prefersHomeIndicatorAutoHidden{
    return NO;
}
- (void)viewDidLoad {
    [super viewDidLoad];
    user = [WebRequest GetUserInfo];
    arr_model = [NSMutableArray arrayWithCapacity:0];
    self.navigationItem.title = [NSString stringWithFormat:@"%@的相册",self.userName];
    UICollectionViewFlowLayout  *flowL =[[UICollectionViewFlowLayout alloc]init];
    flowL.itemSize =CGSizeMake((DEVICE_WIDTH-40)/2.0, (DEVICE_WIDTH-40)/2.0 + 50);
    flowL.sectionInset = UIEdgeInsetsMake(10, 10, 10, 10);
    CollectionV =[[UICollectionView alloc]initWithFrame:CGRectMake(0, DEVICE_TABBAR_Height, DEVICE_WIDTH, DEVICE_HEIGHT-kBottomSafeHeight) collectionViewLayout:flowL];
    CollectionV.backgroundColor = [UIColor whiteColor];
    CollectionV.delegate=self;
    CollectionV.dataSource=self;
    [self.view addSubview:CollectionV];
    CollectionV.mj_header = [MJRefreshNormalHeader headerWithRefreshingTarget:self refreshingAction:@selector(loadRequestData)];
    CollectionV.mj_footer =[MJRefreshAutoNormalFooter footerWithRefreshingTarget:self refreshingAction:@selector(loadMoreData)];
    adjustsScrollViewInsets_NO(CollectionV, self);
    [CollectionV registerClass:[CK_pictruesCollectionViewCell class] forCellWithReuseIdentifier:@"CollectionViewCell"];
    
 UIBarButtonItem *right =[[UIBarButtonItem alloc]initWithImage:[UIImage imageNamed:@"add_eqd2"] style:UIBarButtonItemStylePlain target:self action:@selector(addClick)];
    
//    [self.navigationItem setRightBarButtonItem:right];
     [self loadRequestData];
    temp =0;
}
-(void)addClick
{
    UIAlertController  *alert = [[UIAlertController alloc]init];
    [alert addAction:[UIAlertAction actionWithTitle:@"上传照片" style:UIAlertActionStyleDefault handler:^(UIAlertAction * _Nonnull action) {
        
    }]];
    [alert addAction:[UIAlertAction actionWithTitle:@"新建相册" style:UIAlertActionStyleDefault handler:^(UIAlertAction * _Nonnull action) {
        FBTextFieldViewController *TFvc =[[FBTextFieldViewController alloc]init];
        TFvc.delegate =self;
        TFvc.indexPath =[NSIndexPath indexPathForRow:0 inSection:0];
        TFvc.content =@"请输入";
        TFvc.contentTitle =@"相册名字";
        [self.navigationController pushViewController:TFvc animated:NO];
    }]];
    [alert addAction:[UIAlertAction actionWithTitle:@"取消" style:UIAlertActionStyleCancel handler:^(UIAlertAction * _Nonnull action) {
        
    }]];
    [self presentViewController:alert animated:NO completion:nil];
    
}
#pragma mark - collection 数据源与代理
-(NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section{
    if([user.Guid isEqualToString:self.userGuid])
    {
    return arr_model.count +1;
    }else
    {
        return arr_model.count;
    }
}
- ( UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath{
    
    CK_pictruesCollectionViewCell *cell= [collectionView dequeueReusableCellWithReuseIdentifier:@"CollectionViewCell" forIndexPath:indexPath];
    
    if ([user.Guid isEqualToString:self.userGuid]) {
        
    if (indexPath.row ==0 ) {
        cell.IV_image.image = [UIImage imageNamed:@"add_eqd"];
        cell.L_name.text = @"新建相册";
        cell.L_name.font = [UIFont systemFontOfSize:18];
        cell.L_name.textAlignment = NSTextAlignmentCenter;
    }else
    {
    
    PhotoModel  *model =arr_model[indexPath.row-1];
    [cell setModel_mulu:model];
      
        FBindexpathLongPressGestureRecognizer  *longPress = [[FBindexpathLongPressGestureRecognizer alloc]initWithTarget:self action:@selector(longpressClick:)];
        longPress.indexPath = indexPath;
        [cell addGestureRecognizer:longPress];
        
        
    }}
    else
    {
        PhotoModel  *model =arr_model[indexPath.row];
        [cell setModel_mulu:model];
    }
    
    return cell;
}

-(void)longpressClick:(FBindexpathLongPressGestureRecognizer*)longPress
{
    PhotoModel  *model = arr_model[longPress.indexPath.row-1];
    UIAlertController  *alert = [[UIAlertController alloc]init];
    [alert addAction:[UIAlertAction actionWithTitle:@"修改名字" style:UIAlertActionStyleDefault handler:^(UIAlertAction * _Nonnull action) {
        FBTextFieldViewController *TFvc =[[FBTextFieldViewController alloc]init];
        TFvc.delegate =self;
        TFvc.indexPath =longPress.indexPath;
        TFvc.content =model.title;
        TFvc.contentTitle =@"修改名字";
        temp =1;
        [self.navigationController pushViewController:TFvc animated:NO];
        
    }]];
  /*  [alert addAction:[UIAlertAction actionWithTitle:@"修改封面图" style:UIAlertActionStyleDefault handler:^(UIAlertAction * _Nonnull action) {
        
    }]];*/
    [alert addAction:[UIAlertAction actionWithTitle:@"删除" style:UIAlertActionStyleDestructive handler:^(UIAlertAction * _Nonnull action) {
        UIAlertController  *alert2 = [UIAlertController alertControllerWithTitle:@"删除之后，文件下的图片也会被删除，请确认" message:nil preferredStyle:UIAlertControllerStyleActionSheet];
        [alert2 addAction:[UIAlertAction actionWithTitle:@"删除" style:UIAlertActionStyleDestructive handler:^(UIAlertAction * _Nonnull action) {
            [WebRequest Lectures_Delete_Lecture_ImageMenuWithuserGuid:user.Guid menuId:model.menuId And:^(NSDictionary *dic) {
                MBFadeAlertView  *alert3 = [[MBFadeAlertView alloc]init];
                if ([dic[Y_STATUS] integerValue]==200) {
                    [alert3 showAlertWith:@"删除成功"];
                    [arr_model removeObject:model];
                    [CollectionV reloadData];
                }else
                {
                    [alert3 showAlertWith:@"服务器错误，请重试"];
                }
            }];
            
        }]];
        [alert2 addAction:[UIAlertAction actionWithTitle:@"取消" style:UIAlertActionStyleCancel handler:^(UIAlertAction * _Nonnull action) {
            
        }]];
        [self presentViewController:alert2 animated:NO completion:nil];
        
        
    }]];
    [alert addAction:[UIAlertAction actionWithTitle:@"取消" style:UIAlertActionStyleCancel handler:^(UIAlertAction * _Nonnull action) {
        
    }]];
    [self presentViewController:alert animated:NO completion:nil];
}
-(void)collectionView:(UICollectionView *)collectionView didSelectItemAtIndexPath:(NSIndexPath *)indexPath{
    NSLog(@"被选中");
    if ([user.Guid isEqualToString:self.userGuid]) {
    if (indexPath.row ==0) {
        FBTextFieldViewController *TFvc =[[FBTextFieldViewController alloc]init];
        TFvc.delegate =self;
        TFvc.indexPath =indexPath;
        TFvc.content =@"请输入";
        TFvc.contentTitle =@"相册名字";
        temp=0;
        [self.navigationController pushViewController:TFvc animated:NO];
    }else
    {
        PhotoModel  *model  =arr_model[indexPath.row -1];
        CK_tuPianViewController *TPvc =[[CK_tuPianViewController alloc]init];
        TPvc.name_wenjian = model.title;
        TPvc.Id_wenjiann = model.Id;
        TPvc.userGuid = self.userGuid;
        [self.navigationController pushViewController:TPvc animated:NO];
    }
    }else
    {
        PhotoModel  *model  =arr_model[indexPath.row];
        CK_tuPianViewController *TPvc =[[CK_tuPianViewController alloc]init];
        TPvc.userGuid = self.userGuid;
        TPvc.name_wenjian = model.title;
        TPvc.Id_wenjiann = model.Id;
        [self.navigationController pushViewController:TPvc animated:NO];
    }
}
-(void)collectionView:(UICollectionView *)collectionView moveItemAtIndexPath:(NSIndexPath *)sourceIndexPath toIndexPath:(NSIndexPath *)destinationIndexPath{
    
}

#pragma  mark -  相册名字
-(void)content:(NSString *)content WithindexPath:(NSIndexPath *)indexPath
{
    
    if (temp ==0) {
    [WebRequest Lectures_Add_LecturePhoto_MenuWithuserGuid:user.Guid title:content And:^(NSDictionary *dic) {
        MBFadeAlertView  *alert = [[MBFadeAlertView alloc]init];
        if ([dic[Y_STATUS] integerValue]==200) {
            PhotoModel *model = [PhotoModel mj_objectWithKeyValues:dic[Y_ITEMS]];
            [arr_model insertObject:model atIndex:0];
            [CollectionV reloadData];
            [alert showAlertWith:@"创建成功"];
        }else
        {
            [alert showAlertWith:@"服务器错误，请重试"];
        }
    }];
    }else if(temp==1)
    {
        
        PhotoModel  *model = arr_model[indexPath.row -1];
        [WebRequest Lectures_Update_LecturePhotoWithuserGuid:user.Guid lecturePhotoId:model.Id lecturePhotoTitle:content And:^(NSDictionary *dic) {
            MBFadeAlertView  *alert = [[MBFadeAlertView alloc]init];
            if ([dic[Y_STATUS] integerValue]==200) {
                [alert showAlertWith:@"修改成功"];
                model.title = content;
                [arr_model replaceObjectAtIndex:indexPath.row-1 withObject:model];
            }else
            {
                [alert showAlertWith:@"服务器错误，请重试"];
            }
        }];
    }else
    {
        
    }
}

@end
