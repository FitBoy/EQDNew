//
//  EQDS_PhotoDetailViewController.m
//  EQD
//
//  Created by 梁新帅 on 2018/3/5.
//  Copyright © 2018年 FitBoy. All rights reserved.
//

#import "EQDS_PhotoDetailViewController.h"
#import "PhotoModel.h"
#import "EQD_photoCollectionViewCell.h"
#import <UIImageView+WebCache.h>
#import "FBindexpathLongPressGestureRecognizer.h"
#import "FBShowimg_moreViewController.h"
#import <CTAssetsPickerController/CTAssetsPickerController.h>
#import "FBTextImgModel.h"
@interface EQDS_PhotoDetailViewController ()<UICollectionViewDelegate,UICollectionViewDataSource,CTAssetsPickerControllerDelegate>
{
    UICollectionView *CollectionV;
    NSString *page;
    NSMutableArray *arr_model;
    UserModel *user;
    NSMutableArray *arr_imgs;
    
}

@end

@implementation EQDS_PhotoDetailViewController
-(void)assetsPickerControllerDidCancel:(CTAssetsPickerController *)picker
{
    [self dismissViewControllerAnimated:NO completion:nil];
}
-(void)assetsPickerController:(CTAssetsPickerController *)picker didFinishPickingAssets:(NSArray<PHAsset *> *)assets
{
    [self dismissViewControllerAnimated:NO completion:nil];
    
        for (PHAsset *set in assets) {
            FBTextImgModel  *model = [[FBTextImgModel alloc]initWithasset:set type:@"2"];
            [arr_imgs addObject:model];
        }
    ///上传图片
    NSMutableArray *tarr = [NSMutableArray arrayWithCapacity:0];
    for (int i=0; i<arr_imgs.count; i++) {
        FBTextImgModel *model =arr_imgs[i];
        [tarr addObject:model.image];
    }
    
    MBProgressHUD *hud = [MBProgressHUD showHUDAddedTo:self.view animated:YES];
    hud.mode = MBProgressHUDModeAnnularDeterminate;
    hud.label.text = @"正在上传";
    [WebRequest Lectures_Add_LecturePhotoWithuserGuid:user.Guid menuId:self.menuId imgArr:tarr And:^(NSDictionary *dic) {
        hud.label.text =dic[Y_MSG];
        dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(0.7 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
            [hud hideAnimated:NO];
            [self loadData];
        });
    }];
    
    
}
-(void)loadOtherData{
    [WebRequest Lectures_Get_LectureMenu_PhotoWithmenuId:self.menuId page:page And:^(NSDictionary *dic) {
        [CollectionV.mj_footer endRefreshing];
        if ([dic[Y_STATUS] integerValue]==200) {
            NSDictionary *tdic = dic[Y_ITEMS];
            NSArray *tarr = tdic[@"rows"];
            if (tarr.count==0) {
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
- (void)viewDidLoad {
    [super viewDidLoad];
    arr_imgs = [NSMutableArray arrayWithCapacity:0];
    page =@"0";
    user = [WebRequest GetUserInfo];
    arr_model = [NSMutableArray arrayWithCapacity:0];
    self.navigationItem.title =self.name_photo;
    float  width = (DEVICE_WIDTH-45)/4.0;
    UICollectionViewFlowLayout  *flowL =[[UICollectionViewFlowLayout alloc]init];
    flowL.itemSize =CGSizeMake(width, width);
    flowL.sectionInset = UIEdgeInsetsMake(5, 5, 5, 5);
    flowL.minimumLineSpacing=1;
    flowL.minimumInteritemSpacing=1;
    CollectionV =[[UICollectionView alloc]initWithFrame:CGRectMake(0, DEVICE_TABBAR_Height, DEVICE_WIDTH, DEVICE_HEIGHT-DEVICE_TABBAR_Height-kBottomSafeHeight) collectionViewLayout:flowL];
    CollectionV.delegate=self;
    CollectionV.dataSource=self;
    [self.view addSubview:CollectionV];
    [CollectionV registerClass:[EQD_photoCollectionViewCell class] forCellWithReuseIdentifier:@"CollectionViewCell"];
    CollectionV.backgroundColor = [UIColor whiteColor];
    CollectionV.mj_footer = [MJRefreshAutoNormalFooter footerWithRefreshingTarget:self refreshingAction:@selector(loadOtherData)];
    [self loadData];
    UIBarButtonItem *right = [[UIBarButtonItem alloc]initWithImage:[[UIImage imageNamed:@"add_eqd2"] imageWithRenderingMode:UIImageRenderingModeAlwaysOriginal] style:UIBarButtonItemStylePlain target:self action:@selector(tianjiaCLick)];
    [self.navigationItem setRightBarButtonItem:right];
}
-(void)loadData{
    [WebRequest Lectures_Get_LectureMenu_PhotoWithmenuId:self.menuId page:@"0" And:^(NSDictionary *dic) {
        [CollectionV.mj_footer endRefreshing];
        if ([dic[Y_STATUS] integerValue]==200) {
            NSDictionary *tdic = dic[Y_ITEMS];
            NSArray *tarr = tdic[@"rows"];
            page = tdic[@"page"];
            [arr_model removeAllObjects];
            for (int i=0; i<tarr.count; i++) {
                PhotoModel *model = [PhotoModel mj_objectWithKeyValues:tarr[i]];
                [arr_model addObject:model];
            }
            [CollectionV reloadData];
        }
    }];
}
#pragma  mark - 添加照片
-(void)tianjiaCLick
{
    [PHPhotoLibrary requestAuthorization:^(PHAuthorizationStatus status){
        if (status ==PHAuthorizationStatusAuthorized) {
            dispatch_async(dispatch_get_main_queue(), ^{
                CTAssetsPickerController *picker = [[CTAssetsPickerController alloc] init];
                picker.delegate = self;
                if (UI_USER_INTERFACE_IDIOM() == UIUserInterfaceIdiomPhone)
                    picker.modalPresentationStyle = UIModalPresentationOverFullScreen;
                NSMutableArray *tarr = [NSMutableArray arrayWithCapacity:0];
                for (int i=0; i<arr_imgs.count; i++) {
                    FBTextImgModel *model =arr_imgs[i];
                    [tarr addObject:model.asset];
                }
                picker.selectedAssets=tarr;
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
}
#pragma mark - collection 数据源与代理
-(NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section{
    return arr_model.count;
}
- ( UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath{
    
    EQD_photoCollectionViewCell *cell= [collectionView dequeueReusableCellWithReuseIdentifier:@"CollectionViewCell" forIndexPath:indexPath];
    PhotoModel *model =arr_model[indexPath.row];
    [cell.IV_img sd_setImageWithURL:[NSURL URLWithString:model.imageUrl]];
    FBindexpathLongPressGestureRecognizer  *longPress = [[FBindexpathLongPressGestureRecognizer alloc]initWithTarget:self action:@selector(longPressClick:)];
    longPress.indexPath = indexPath;
    [cell addGestureRecognizer:longPress];
    return cell;
}
-(void)collectionView:(UICollectionView *)collectionView didSelectItemAtIndexPath:(NSIndexPath *)indexPath{
    NSLog(@"被选中");
    NSMutableArray *tarr = [NSMutableArray arrayWithCapacity:0];
    for (int i=0; i<arr_model.count; i++) {
        PhotoModel *model =arr_model[i];
        [tarr addObject:model.imageUrl];
    }
    FBShowimg_moreViewController  *Svc = [[FBShowimg_moreViewController alloc]init];
    Svc.arr_imgs = tarr;
    Svc.index = indexPath.row;
    [self.navigationController pushViewController:Svc animated:NO];
   
}
#pragma  mark - 长按操作
-(void)longPressClick:(FBindexpathLongPressGestureRecognizer*)longPress{
     PhotoModel *model =arr_model[longPress.indexPath.row];
    if (![user.Guid isEqualToString:model.creater]) {
        
    }else
    {
    UIAlertController  *alert = [[UIAlertController alloc]init];
    NSArray *tarr = @[@"修改照片名字",@"设为相册封面"];
    for (int i=0; i<tarr.count; i++) {
        [alert addAction:[UIAlertAction actionWithTitle:tarr[i] style:UIAlertActionStyleDefault handler:^(UIAlertAction * _Nonnull action) {
            if(i==0)
            {
                //修改照片名字
                UIAlertController *alert2 =[UIAlertController alertControllerWithTitle:@"修改照片名字" message:[NSString stringWithFormat:@"原名字:%@",model.imageName] preferredStyle:UIAlertControllerStyleAlert];
                [alert2 addTextFieldWithConfigurationHandler:^(UITextField * _Nonnull textField) {
                    textField.placeholder = @"请输入新名字";
                }];
                [alert2 addAction:[UIAlertAction actionWithTitle:@"取消" style:UIAlertActionStyleDefault handler:^(UIAlertAction * _Nonnull action) {
                    
                }]];
                [alert2 addAction:[UIAlertAction actionWithTitle:@"确定" style:UIAlertActionStyleDefault handler:^(UIAlertAction * _Nonnull action) {
                    MBProgressHUD *hud = [MBProgressHUD showHUDAddedTo:self.view animated:YES];
                    hud.mode = MBProgressHUDModeAnnularDeterminate;
                    hud.label.text = @"正在修改";
                    [WebRequest Lectures_Update_LecturePhotoWithuserGuid:user.Guid lecturePhotoId:model.Id lecturePhotoTitle:alert2.textFields[0].text And:^(NSDictionary *dic) {
                        hud.label.text = dic[Y_MSG];
                        dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(0.7 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
                            [hud hideAnimated:NO];
                        });
                    }];
                    
                }]];
                dispatch_async(dispatch_get_main_queue(), ^{
                    [self presentViewController:alert2 animated:NO completion:nil];
                });
                
                
                
            }else
            {
               //设为相册封面
                MBProgressHUD *hud = [MBProgressHUD showHUDAddedTo:self.view animated:YES];
                hud.mode = MBProgressHUDModeAnnularDeterminate;
                hud.label.text = @"正在设置";
                [WebRequest Lectures_Set_HomeImageWithuserGuid:user.Guid imageId:model.Id menuId:self.menuId And:^(NSDictionary *dic) {
                    hud.label.text =dic[Y_MSG];
                    dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(0.7 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
                          [hud hideAnimated:NO];
                    });
                  

                }];
            }
        }]];
    }
    [alert addAction:[UIAlertAction actionWithTitle:@"删除" style:UIAlertActionStyleDestructive handler:^(UIAlertAction * _Nonnull action) {
        
        UIAlertController *alert2 =[UIAlertController alertControllerWithTitle:@"您确认删除该照片吗" message:nil preferredStyle:UIAlertControllerStyleActionSheet];
        [alert2 addAction:[UIAlertAction actionWithTitle:@"删除" style:UIAlertActionStyleDestructive handler:^(UIAlertAction * _Nonnull action) {
            MBProgressHUD *hud = [MBProgressHUD showHUDAddedTo:self.view animated:YES];
            hud.mode = MBProgressHUDModeAnnularDeterminate;
            hud.label.text = @"正在删除";
            [WebRequest Lectures_Delete_Lecture_PhotoWithuserGuid:user.Guid lecturePhotoId:model.Id menuId:self.menuId And:^(NSDictionary *dic) {
                hud.label.text =dic[Y_MSG];
                dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(0.7 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
                    [hud hideAnimated:NO];
                    if ([dic[Y_STATUS] integerValue]==200) {
                        [arr_model removeObject:model];
                        [CollectionV reloadData];
                    }
                });
            }];
        }]];
        [alert2 addAction:[UIAlertAction actionWithTitle:@"取消" style:UIAlertActionStyleCancel handler:^(UIAlertAction * _Nonnull action) {
            
        }]];
        dispatch_async(dispatch_get_main_queue(), ^{
            [self presentViewController:alert2 animated:NO completion:nil];
        });
        
       
    }]];
    
    
    [alert addAction:[UIAlertAction actionWithTitle:@"取消" style:UIAlertActionStyleCancel handler:^(UIAlertAction * _Nonnull action) {
        
    }]];
        dispatch_async(dispatch_get_main_queue(), ^{
            [self presentViewController:alert animated:NO completion:nil];
        });
    }
}




@end
