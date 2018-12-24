//
//  FBTextvImgViewController.m
//  EQD
//
//  Created by 梁新帅 on 2017/5/19.
//  Copyright © 2017年 FitBoy. All rights reserved.
//

#import "FBTextvImgViewController.h"
#import "FBImageVCollectionViewCell.h"
#import <CTAssetsPickerController/CTAssetsPickerController.h>
#import <RongIMKit/RongIMKit.h>
#import "FBImageShowViewController.h"
#import "FBindexpathLongPressGestureRecognizer.h"
#import "UITextView+Tool.h"
@interface FBTextvImgViewController ()<UITextViewDelegate,UICollectionViewDelegate,UICollectionViewDataSource,CTAssetsPickerControllerDelegate,FBImageShowViewControllerDelegate,UINavigationControllerDelegate, UIImagePickerControllerDelegate,UITextViewDelegate>
{
    UITextView *textV;
    UICollectionView *CollectionV;
    NSInteger width;
    NSMutableArray *arr_images;
    NSInteger *flag;
}

@end

@implementation FBTextvImgViewController

-(void)viewWillAppear:(BOOL)animated
{
    [self.view endEditing:YES];
    
}
- (void)viewDidLoad {
    [super viewDidLoad];
    flag =0;
    self.navigationItem.title = self.contentTitle;
    arr_images =[NSMutableArray arrayWithCapacity:0];
    FBTextImgModel *model = [[FBTextImgModel alloc]init];
//    model.image = [RCKitUtility imageNamed:@"actionbar_camera_icon" ofBundle:@"RongCloud.bundle"];
    model.image = [UIImage imageNamed:@"eqd_picture_icon.png"];
    model.type=@"1";
    [arr_images addObject:model];
    self.automaticallyAdjustsScrollViewInsets =NO;
    textV=[[UITextView alloc]initWithFrame:CGRectMake(15, 70-64+DEVICE_TABBAR_Height, DEVICE_WIDTH-30, 120)];
    textV.font =[UIFont systemFontOfSize:17];
    [self.view addSubview:textV];
    textV.delegate =self;
    textV.scrollEnabled=YES;
    textV.text = nil;
    [textV setTextFieldInputAccessoryView];
    [textV becomeFirstResponder];
    width = (DEVICE_WIDTH-60)/3;
    UICollectionViewFlowLayout  *flowL =[[UICollectionViewFlowLayout alloc]init];
    flowL.itemSize =CGSizeMake(width, width);
    flowL.minimumLineSpacing=15;
    flowL.minimumInteritemSpacing=15;

    textV.delegate =self;
    textV.returnKeyType=UIReturnKeyDefault;
    
    
    CollectionV =[[UICollectionView alloc]initWithFrame:CGRectMake(15, 200-64+DEVICE_TABBAR_Height, DEVICE_WIDTH-30, DEVICE_HEIGHT-200+64-DEVICE_TABBAR_Height) collectionViewLayout:flowL];
    adjustsScrollViewInsets_NO(CollectionV, self);
    CollectionV.delegate=self;
    CollectionV.dataSource=self;
    [self.view addSubview:CollectionV];
    CollectionV.layer.backgroundColor = [UIColor whiteColor].CGColor;
    [CollectionV registerClass:[FBImageVCollectionViewCell class] forCellWithReuseIdentifier:@"CollectionViewCell"];
    
    UIBarButtonItem *right = [[UIBarButtonItem alloc]initWithTitle:@"确定" style:UIBarButtonItemStylePlain target:self action:@selector(quedingClick)];
    [self.navigationItem setRightBarButtonItem:right];
    
}

-(void)quedingClick
{
    NSMutableArray *tarr=[NSMutableArray arrayWithCapacity:0];
    for (int i=0; i<arr_images.count-1; i++) {
        FBTextImgModel *model =arr_images[i];
        [tarr addObject:model.image];
    }
    //确定
    if (textV.text.length==0) {
      textV.text=@" ";
    }
   
    if ([self.delegate respondsToSelector:@selector(text:imgArr:indexPath:)]) {
        [self.delegate text:textV.text imgArr:tarr indexPath:self.indexPath];
    }
    [self.navigationController popViewControllerAnimated:NO];
    
    
}
#pragma mark - textV的 协议代理
-(BOOL)textViewShouldBeginEditing:(UITextView *)textView
{
    if ([textView.text isEqualToString:@"说点什么吧……"]) {
        textView.text = nil;
    }
    return YES;
}

#pragma mark - collection 数据源与代理
-(NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section{
    return arr_images.count;
}
- ( UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath{
    
    FBImageVCollectionViewCell *cell= [collectionView dequeueReusableCellWithReuseIdentifier:@"CollectionViewCell" forIndexPath:indexPath];
    if (indexPath.row<arr_images.count-1) {
        FBindexpathLongPressGestureRecognizer *longpress = [[FBindexpathLongPressGestureRecognizer alloc]initWithTarget:self action:@selector(longpressClick:)];
        longpress.indexPath =indexPath;
        [cell addGestureRecognizer:longpress];
    }
    
    
    FBTextImgModel *model =arr_images[indexPath.row];
    [cell setModel:model];
    
    
    
    return cell;
}
-(void)longpressClick:(FBindexpathLongPressGestureRecognizer*)longpress
{
    UIAlertController *alert =[[UIAlertController alloc]init];
    [alert addAction:[UIAlertAction actionWithTitle:@"删除" style:UIAlertActionStyleDefault handler:^(UIAlertAction * _Nonnull action) {
        [arr_images removeObjectAtIndex:longpress.indexPath.row];
        [CollectionV reloadData];
    }]];
    [alert addAction:[UIAlertAction actionWithTitle:@"取消" style:UIAlertActionStyleCancel handler:^(UIAlertAction * _Nonnull action) {
        
    }]];
    dispatch_async(dispatch_get_main_queue(), ^{
        [self presentViewController:alert animated:NO completion:nil];
    });
    
}
-(void)collectionView:(UICollectionView *)collectionView didSelectItemAtIndexPath:(NSIndexPath *)indexPath{
    FBTextImgModel *model =arr_images[indexPath.row];
    if ([model.type integerValue]==1) {
        //添加图片按钮
        
        [PHPhotoLibrary requestAuthorization:^(PHAuthorizationStatus status){
            if (status ==PHAuthorizationStatusAuthorized) {
                dispatch_async(dispatch_get_main_queue(), ^{
                    CTAssetsPickerController *picker = [[CTAssetsPickerController alloc] init];
                    picker.delegate = self;
                    if (UI_USER_INTERFACE_IDIOM() == UIUserInterfaceIdiomPhone)
                        picker.modalPresentationStyle = UIModalPresentationOverFullScreen;
                    NSMutableArray *tarr = [NSMutableArray arrayWithCapacity:0];
                    for (int i=0; i<arr_images.count-1; i++) {
                        FBTextImgModel *model =arr_images[i];
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
        
      /*  UIAlertController *alert =[[UIAlertController alloc]init];
        [alert addAction:[UIAlertAction actionWithTitle:@"从手机相册选择" style:UIAlertActionStyleDefault handler:^(UIAlertAction * _Nonnull action) {
            
            
                    
            

        }]];
        [alert addAction:[UIAlertAction actionWithTitle:@"拍照" style:UIAlertActionStyleDefault handler:^(UIAlertAction * _Nonnull action) {
        
            if ([UIImagePickerController isSourceTypeAvailable:UIImagePickerControllerSourceTypeCamera]) {
                UIImagePickerController *picker = [[UIImagePickerController alloc]init];
                picker.sourceType = UIImagePickerControllerSourceTypeCamera;
                picker.allowsEditing =YES;
                picker.delegate =self;
                dispatch_async(dispatch_get_main_queue(), ^{
                    [self.navigationController presentViewController:picker animated:NO completion:nil];
                });
            }
            
            
        }]];
        [alert addAction:[UIAlertAction actionWithTitle:@"取消" style:UIAlertActionStyleCancel handler:^(UIAlertAction * _Nonnull action) {
            
        }]];
        
       [self presentViewController:alert animated:NO completion:nil];*/
        
        
    
        
        
    }
    else
    {
       //放大并展示图片
        [self.view endEditing:YES];
        FBImageShowViewController *ISvc =[[FBImageShowViewController alloc]init];
        ISvc.indexPath =indexPath;
        ISvc.delegate=self;
        ISvc.modelArr =[NSMutableArray arrayWithArray:arr_images];
        [self.navigationController pushViewController:ISvc animated:NO];
        
        
    }
}
#pragma imagePickerDelegate
-(void)imagePickerController:(UIImagePickerController *)picker didFinishPickingMediaWithInfo:(NSDictionary<NSString *,id> *)info
{
    
    UIImage *image = [info objectForKey:UIImagePickerControllerEditedImage];
    MBProgressHUD *hud = [MBProgressHUD showHUDAddedTo:self.view animated:YES];
    hud.mode = MBProgressHUDModeAnnularDeterminate;
    hud.label.text = @"正在处理";
    [[PHPhotoLibrary sharedPhotoLibrary] performChanges:^{
        [PHAssetChangeRequest creationRequestForAssetFromImage:image];
    } completionHandler:^(BOOL success, NSError * _Nullable error) {
        if(success ==YES)
        {
            flag +=1;
            dispatch_async(dispatch_get_main_queue(), ^{
                [hud hideAnimated:NO];
                FBTextImgModel *model= [[FBTextImgModel alloc]init];
                model.image =image;
                model.type=@"2";
                [arr_images insertObject:model atIndex:0];
                [CollectionV reloadData];
            });
        }
    }];
    [self dismissViewControllerAnimated:NO completion:nil];
}


#pragma mark - 多选图片的delegate
- (void)assetsPickerController:(CTAssetsPickerController *)picker didFinishPickingAssets:(NSArray *)assets
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
    FBTextImgModel *model = [[FBTextImgModel alloc]init];
    model.image = model.image = [RCKitUtility imageNamed:@"actionbar_camera_icon" ofBundle:@"RongCloud.bundle"];
    model.type=@"1";
    [arr_images addObject:model];
    for (PHAsset *set in assets) {
        FBTextImgModel  *model = [[FBTextImgModel alloc]initWithasset:set type:@"2"];
        [arr_images insertObject:model atIndex:0];
    }
    [CollectionV reloadData];
    }
}

#pragma mark - 删除在别的地方
-(void)modelArr:(NSArray<FBTextImgModel *> *)arr WithSelected:(NSInteger)selected
{
    [arr_images removeAllObjects];
    arr_images = [NSMutableArray arrayWithArray:arr];
    [CollectionV reloadData];
    
}



@end
