//
//  CK_tuPianViewController.m
//  EQD
//
//  Created by 梁新帅 on 2018/8/11.
//  Copyright © 2018年 FitBoy. All rights reserved.
//

#import "CK_tuPianViewController.h"
#import "PhotoModel.h"
#import <UIImageView+WebCache.h>
#import <CTAssetsPickerController/CTAssetsPickerController.h>
#import "FBTextImgModel.h"
#import <RongIMKit/RongIMKit.h>
#import "CK_pictruesCollectionViewCell.h"
#import "FBImgShowViewController.h"
#import "FBTextFieldViewController.h"
@interface CK_tuPianViewController ()<UICollectionViewDelegate,UICollectionViewDataSource,CTAssetsPickerControllerDelegate,FBTextFieldViewControllerDelegate>
{
    UICollectionView *CollectionV;
    NSMutableArray  *arr_model;
    NSString *page;
    NSMutableArray *arr_images;
    UserModel *user;
}

@end

@implementation CK_tuPianViewController
-(void)viewWillAppear:(BOOL)animated{
    [super viewWillAppear:animated];
   
}
-(void)loadRequestData{
    [WebRequest Lectures_Get_LectureMenu_PhotoWithmenuId:self.Id_wenjiann page:@"0" And:^(NSDictionary *dic) {
        [CollectionV.mj_footer endRefreshing];
        [CollectionV.mj_header endRefreshing];
        if ([dic[Y_STATUS] integerValue]==200) {
            NSDictionary *tdic = dic[Y_ITEMS];
            page = tdic[@"page"];
            NSArray *tarr = tdic[@"rows"];
            [arr_model removeAllObjects];
            for (int i=0; i<tarr.count; i++) {
                PhotoModel *model = [PhotoModel mj_objectWithKeyValues:tarr[i]];
                [arr_model addObject:model];
            }
            [CollectionV reloadData];
        }
    }];
}
-(void)loadMoreData{
    [WebRequest Lectures_Get_LectureMenu_PhotoWithmenuId:self.Id_wenjiann page:page And:^(NSDictionary *dic) {
        [CollectionV.mj_footer endRefreshing];
        [CollectionV.mj_header endRefreshing];
        if ([dic[Y_STATUS] integerValue]==200) {
            NSDictionary *tdic = dic[Y_ITEMS];
            NSArray *tarr = tdic[@"rows"];
            if (tarr.count ==0) {
                [CollectionV.mj_footer endRefreshingWithNoMoreData];
            }else
            {
                page = tdic[@"page"];
            for (int i=0; i<tarr.count; i++) {
                PhotoModel *model = [PhotoModel mj_objectWithKeyValues:tarr[i]];
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
    arr_images = [NSMutableArray arrayWithCapacity:0];
    self.navigationItem.title = self.name_wenjian;
    arr_model = [NSMutableArray arrayWithCapacity:0];
    UICollectionViewFlowLayout  *flowL =[[UICollectionViewFlowLayout alloc]init];
    flowL.itemSize =CGSizeMake((DEVICE_WIDTH-40)/2.0, (DEVICE_WIDTH-40)/2.0+50);
    flowL.sectionInset = UIEdgeInsetsMake(10, 10, 10, 10);
    CollectionV =[[UICollectionView alloc]initWithFrame:CGRectMake(0, DEVICE_TABBAR_Height, DEVICE_WIDTH, DEVICE_HEIGHT-kBottomSafeHeight) collectionViewLayout:flowL];
    CollectionV.delegate=self;
    CollectionV.dataSource=self;
    [self.view addSubview:CollectionV];
    CollectionV.backgroundColor = [UIColor whiteColor];
    CollectionV.mj_header = [MJRefreshNormalHeader headerWithRefreshingTarget:self refreshingAction:@selector(loadRequestData)];
    CollectionV.mj_footer = [MJRefreshAutoNormalFooter footerWithRefreshingTarget:self refreshingAction:@selector(loadMoreData)];
    
    [CollectionV registerClass:[CK_pictruesCollectionViewCell class] forCellWithReuseIdentifier:@"CollectionViewCell"];
    adjustsScrollViewInsets_NO(CollectionV, self);
 [self loadRequestData];
}

#pragma mark - collection 数据源与代理
-(NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section{
    if ([user.Guid isEqualToString:self.userGuid]) {
        return arr_model.count+1;
    }else
    {
        return arr_model.count;
    }
    
}
- ( UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath{
    
    CK_pictruesCollectionViewCell *cell= [collectionView dequeueReusableCellWithReuseIdentifier:@"CollectionViewCell" forIndexPath:indexPath];
    if ([user.Guid isEqualToString:self.userGuid]) {
    if (indexPath.row ==0) {
        cell.IV_image.image = [UIImage imageNamed:@"add_eqd"];
        cell.L_name.text = @"添加图片";
        cell.L_name.font = [UIFont systemFontOfSize:18];
        cell.L_name.textAlignment = NSTextAlignmentCenter;
    }else
    {
        
        PhotoModel  *model =arr_model[indexPath.row-1];
        [cell setModel_mulu2:model];
    }
    }else
    {
        PhotoModel  *model =arr_model[indexPath.row];
        [cell setModel_mulu2:model];
    }
    
    
    return cell;
}
-(void)collectionView:(UICollectionView *)collectionView didSelectItemAtIndexPath:(NSIndexPath *)indexPath{
    NSLog(@"被选中");
    if ([self.userGuid isEqualToString:user.Guid]) {
        
    if(indexPath.row ==0)
    {
        //添加图片
        
        [PHPhotoLibrary requestAuthorization:^(PHAuthorizationStatus status){
            if (status ==PHAuthorizationStatusAuthorized) {
                dispatch_async(dispatch_get_main_queue(), ^{
                    CTAssetsPickerController *picker = [[CTAssetsPickerController alloc] init];
                    picker.delegate = self;
                    if (UI_USER_INTERFACE_IDIOM() == UIUserInterfaceIdiomPhone)
                        picker.modalPresentationStyle = UIModalPresentationOverFullScreen;
                    picker.showsCancelButton=YES;
                    picker.showsNumberOfAssets=YES;
                    picker.showsSelectionIndex=YES;
                    dispatch_async(dispatch_get_main_queue(), ^{
                        [self presentViewController:picker animated:YES completion:nil];
                    });
                    
                });
            }
            else
            {
                MBProgressHUD *hud=[MBProgressHUD showHUDAddedTo:self.view  animated:YES];
                hud.mode = MBProgressHUDModeText;
                hud.label.text =@"您拒绝访问相册";
                dispatch_time_t popTime = dispatch_time(DISPATCH_TIME_NOW, 1 * NSEC_PER_SEC);
                dispatch_after(popTime, dispatch_get_main_queue(), ^(void){
                    [MBProgressHUD hideHUDForView:self.view  animated:YES];
                });
            }
        }];
    }else
    {
        
        PhotoModel  *model = arr_model[indexPath.row-1];
        //查看图片
        UIAlertController  *alert = [UIAlertController alertControllerWithTitle:@"操作" message:nil preferredStyle:UIAlertControllerStyleActionSheet];
        [alert addAction:[UIAlertAction actionWithTitle:@"查看图片" style:UIAlertActionStyleDefault handler:^(UIAlertAction * _Nonnull action) {
            FBImgShowViewController  *Svc = [[FBImgShowViewController alloc]init];
            NSMutableArray *tarr = [NSMutableArray arrayWithCapacity:0];
            for (int i=0; i<arr_model.count; i++) {
                PhotoModel *tmodel = arr_model[i];
                [tarr addObject:tmodel.imageUrl];
            }
            Svc.imgstrs =tarr;
            Svc.selected = indexPath.row-1;
            [self.navigationController pushViewController:Svc animated:NO];
        }]];
        [alert addAction:[UIAlertAction actionWithTitle:@"修改名字" style:UIAlertActionStyleDefault handler:^(UIAlertAction * _Nonnull action) {
            FBTextFieldViewController *TFvc =[[FBTextFieldViewController alloc]init];
            TFvc.delegate =self;
            TFvc.indexPath =indexPath;
            TFvc.content =model.imageName;
            TFvc.contentTitle =@"修改名字";
            [self.navigationController pushViewController:TFvc animated:NO];
        }]];
        [alert addAction:[UIAlertAction actionWithTitle:@"删除" style:UIAlertActionStyleDestructive handler:^(UIAlertAction * _Nonnull action) {
            
            UIAlertController  *alert2 = [UIAlertController alertControllerWithTitle:@"确认删除？" message:nil preferredStyle:UIAlertControllerStyleActionSheet];
            [alert2 addAction:[UIAlertAction actionWithTitle:@"删除" style:UIAlertActionStyleDestructive handler:^(UIAlertAction * _Nonnull action) {
                
                [WebRequest Lectures_Delete_Lecture_PhotoWithuserGuid:user.Guid lecturePhotoId:model.Id menuId:model.menuId And:^(NSDictionary *dic) {
                    MBFadeAlertView *alert = [[MBFadeAlertView alloc]init];
                    if ([dic[Y_STATUS] integerValue]==200) {
                        [alert showAlertWith:@"删除成功"];
                        [arr_model removeObject:model];
                        [CollectionV reloadData];
                    }else
                    {
                        [alert showAlertWith:@"服务器错误，请重试"];
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
    }else
    {
        FBImgShowViewController  *Svc = [[FBImgShowViewController alloc]init];
        NSMutableArray *tarr = [NSMutableArray arrayWithCapacity:0];
        for (int i=0; i<arr_model.count; i++) {
            PhotoModel *tmodel = arr_model[i];
            [tarr addObject:tmodel.imageUrl];
        }
        Svc.imgstrs =tarr;
        Svc.selected = indexPath.row-1;
        [self.navigationController pushViewController:Svc animated:NO];
    }
}
-(void)collectionView:(UICollectionView *)collectionView moveItemAtIndexPath:(NSIndexPath *)sourceIndexPath toIndexPath:(NSIndexPath *)destinationIndexPath{
    
}
#pragma  mark - 修改名字
-(void)content:(NSString *)content WithindexPath:(NSIndexPath *)indexPath
{
    PhotoModel  *model = arr_model[indexPath.row-1];
    
    [WebRequest Lectures_Update_LecturePhotoWithuserGuid:user.Guid lecturePhotoId:model.Id lecturePhotoTitle:content And:^(NSDictionary *dic) {
        MBFadeAlertView *alert = [[MBFadeAlertView alloc]init];
        
        if ([dic[Y_STATUS] integerValue]==200) {
            [alert showAlertWith:@"修改成功"];
            model.imageName = content;
            [arr_model replaceObjectAtIndex:indexPath.row-1 withObject:model];
            [CollectionV reloadData];
        }else
        {
            [alert showAlertWith:@"修改失败，请重试"];
        }
    }];
}
#pragma  mark - 相册的协议代理
- (void)assetsPickerController:(CTAssetsPickerController *)picker didFinishPickingAssets:(NSArray<PHAsset*> *)assets
{
    [self dismissViewControllerAnimated:NO completion:nil];
    if (assets.count>9) {
        MBProgressHUD *hud=[MBProgressHUD showHUDAddedTo:self.view  animated:YES];
        hud.mode = MBProgressHUDModeText;
        hud.label.text =@"最多只能选择9张";
        dispatch_time_t popTime = dispatch_time(DISPATCH_TIME_NOW, 1 * NSEC_PER_SEC);
        dispatch_after(popTime, dispatch_get_main_queue(), ^(void){
            [MBProgressHUD hideHUDForView:self.view  animated:YES];
        });
    }
    else
    {
        [arr_images removeAllObjects];
      /*  FBTextImgModel *model = [[FBTextImgModel alloc]init];
        model.image = model.image = [RCKitUtility imageNamed:@"actionbar_camera_icon" ofBundle:@"RongCloud.bundle"];
        model.type=@"1";
        [arr_images addObject:model];*/
        for (PHAsset *set in assets) {
            FBTextImgModel  *model = [[FBTextImgModel alloc]initWithasset:set type:@"2"];
            [arr_images insertObject:model atIndex:0];
        }
        NSMutableArray *tarr = [NSMutableArray arrayWithCapacity:0];
        for (int i=0; i<arr_images.count; i++) {
            FBTextImgModel *model = arr_images[i];
            [tarr addObject:model.image];
        }
        [WebRequest  Lectures_Add_LecturePhotoWithuserGuid:user.Guid menuId:self.Id_wenjiann imgArr:tarr And:^(NSDictionary *dic) {
            MBFadeAlertView *alert = [[MBFadeAlertView alloc]init];
            if ([dic[Y_STATUS] integerValue]==200) {
                [alert showAlertWith:@"添加成功"];
                [self loadRequestData];
            }else
            {
                [alert showAlertWith:@"服务器错误，请重试！"];
            }
        }];
    }
}
- (void)assetsPickerControllerDidCancel:(CTAssetsPickerController *)picker
{
    
}

@end
