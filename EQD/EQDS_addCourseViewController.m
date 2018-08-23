//
//  EQDS_addCourseViewController.m
//  EQD
//
//  Created by 梁新帅 on 2018/2/25.
//  Copyright © 2018年 FitBoy. All rights reserved.
//

#import "EQDS_addCourseViewController.h"
#import "FBTextFieldViewController.h"
#import "FBTextVViewController.h"
#import "FBEQDEditer_AllViewController.h"
#import "FB_PXLeiBieChooseViewController.h"
#import <CTAssetsPickerController/CTAssetsPickerController.h>
#import "FBTextImgModel.h"
#import "FBHangYeViewController.h"
@interface EQDS_addCourseViewController ()<UITableViewDelegate,UITableViewDataSource,FBTextVViewControllerDelegate,FBTextFieldViewControllerDelegate,FBEQDEditer_AllViewControllerDlegate,FB_PXLeiBieChooseViewControllerdelegate,CTAssetsPickerControllerDelegate,FBHangYeViewControllerDelegate>
{
    UITableView *tableV;
    NSArray *arr_names;
    NSMutableArray *arr_contents;
    NSArray *arr_leibie;
    NSString *html_;
    NSMutableArray *arr_images;
    UserModel *user;
}

@end

@implementation EQDS_addCourseViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    user = [WebRequest GetUserInfo];
    self.navigationItem.title= @"发布新课程";
    arr_images = [NSMutableArray arrayWithCapacity:0];
    arr_names = @[@"*课程主题",@"*课程类型",@"*授课对象",@"*课程时长/天",@"*课程价格/元",@"*课程目标",@"*课程背景",@"*课程大纲",@"课程图片",@"*授课方法",@"*课程适合的行业"];
    arr_contents = [NSMutableArray arrayWithArray:@[@"请输入",@"请选择",@"请输入",@"请输入",@"请输入",@"请输入",@"请输入",@"请输入",@"请选择",@"请输入",@"请输入"]];
    tableV = [[UITableView alloc]initWithFrame:CGRectMake(0, DEVICE_TABBAR_Height, DEVICE_WIDTH, DEVICE_HEIGHT-DEVICE_TABBAR_Height-kBottomSafeHeight) style:UITableViewStylePlain];
    adjustsScrollViewInsets_NO(tableV, self);
    tableV.delegate=self;
    tableV.dataSource=self;
    [self.view addSubview:tableV];
    tableV.rowHeight=60;
    UIBarButtonItem *right = [[UIBarButtonItem alloc]initWithTitle:@"发布" style:UIBarButtonItemStylePlain target:self action:@selector(fabuCLick)];
    [self.navigationItem setRightBarButtonItem:right];

}
#pragma  mark - 发布课程
-(void)fabuCLick{
    NSInteger temp = 0;
    for (int i=0; i<arr_contents.count-1; i++) {
        if ([arr_contents[i] isEqualToString:@"请输入"] || [arr_contents[i] isEqualToString:@"请选择"]) {
            temp=1;
            break;
        }
    }
    if (temp==0) {
        MBProgressHUD *hud = [MBProgressHUD showHUDAddedTo:self.view animated:YES];
        hud.mode = MBProgressHUDModeAnnularDeterminate;
        hud.label.text = @"正在发布";
        NSMutableArray *tarr = [NSMutableArray arrayWithCapacity:0];
        for (int i=0; i<arr_images.count; i++) {
           FBTextImgModel *model = arr_images[i];
            [tarr addObject:model.image];
        }
        
        [WebRequest  Lectures_course_Add_Lecture_CourseWithuserGuid:user.Guid courseType:arr_contents[1] courseTheme:arr_contents[0] courseTimes:arr_contents[3] courseOutlint:html_ courseObjecter:arr_contents[2] courseMethod:arr_contents[9] coursePrice:arr_contents[4] courseBackground:arr_contents[6] lectureName:user.username courseTarget:arr_contents[5] coursewares:@" " images:tarr courseIndustry:arr_contents[10]  And:^(NSDictionary *dic) {
            hud.label.text = dic[Y_MSG];
            dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(0.7 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
                [hud hideAnimated:NO];
                if ([dic[Y_STATUS] integerValue]==200) {
                    [self.navigationController popViewControllerAnimated:NO];
                }
            });
        }];
        
    }else
    {
        MBProgressHUD *hud=[MBProgressHUD showHUDAddedTo:self.view  animated:YES];
        hud.mode = MBProgressHUDModeText;
        hud.label.text =@"带*为必填项";
        dispatch_time_t popTime = dispatch_time(DISPATCH_TIME_NOW, 1 * NSEC_PER_SEC);
        dispatch_after(popTime, dispatch_get_main_queue(), ^(void){
            [MBProgressHUD hideHUDForView:self.view  animated:YES];
        });
    }
    
}
#pragma  mark - 表的数据源
-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return arr_contents.count;
}
-(UITableViewCell*)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    static NSString *cellId=@"cellID";
    UITableViewCell *cell =[tableView dequeueReusableCellWithIdentifier:cellId];
    if (!cell) {
        cell = [[UITableViewCell alloc]initWithStyle:UITableViewCellStyleValue1 reuseIdentifier:cellId];
        cell.accessoryType = UITableViewCellAccessoryDisclosureIndicator;
        cell.textLabel.font = [UIFont systemFontOfSize:18];
        cell.detailTextLabel.font = [UIFont systemFontOfSize:13];
    }
    cell.textLabel.text =arr_names[indexPath.row];
    cell.detailTextLabel.text = arr_contents[indexPath.row];
    return cell;
}

#pragma  mark - 表的协议代理
-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    if (indexPath.row==0 || indexPath.row==2 || indexPath.row==3 ||indexPath.row==9|| indexPath.row==4) {
        //课程主题
        FBTextFieldViewController *TFvc =[[FBTextFieldViewController alloc]init];
        TFvc.delegate =self;
        TFvc.indexPath =indexPath;
        TFvc.content =arr_contents[indexPath.row];
        TFvc.contentTitle =arr_names[indexPath.row];
        [self.navigationController pushViewController:TFvc animated:NO];
    }else if (indexPath.row ==1)
    {
        //课程类别
        FB_PXLeiBieChooseViewController *Pvc =[[FB_PXLeiBieChooseViewController alloc]init];
        Pvc.delegate =self;
        Pvc.arr_chosemodel =arr_leibie;
        [self.navigationController pushViewController:Pvc animated:NO];
    }else if (indexPath.row==5 || indexPath.row==6)
    {
        FBTextVViewController *TVvc =[[FBTextVViewController alloc]init];
        TVvc.indexpath =indexPath;
        TVvc.delegate =self;
        TVvc.contentTitle=arr_names[indexPath.row];
        TVvc.content =arr_contents[indexPath.row];
        [self.navigationController pushViewController:TVvc animated:NO];
    }else if (indexPath.row==7)
    {
        //课程大纲
        FBEQDEditer_AllViewController  *Avc = [[FBEQDEditer_AllViewController alloc]init];
        Avc.temp =10;
        Avc.editor_htmlText= html_;
        Avc.delegate =self;
        [self.navigationController pushViewController:Avc animated:NO];
    }else if (indexPath.row==8)
    {
        //课程图片
        [PHPhotoLibrary requestAuthorization:^(PHAuthorizationStatus status){
            if (status ==PHAuthorizationStatusAuthorized) {
                dispatch_async(dispatch_get_main_queue(), ^{
                    CTAssetsPickerController *picker = [[CTAssetsPickerController alloc] init];
                    picker.delegate = self;
                    if (UI_USER_INTERFACE_IDIOM() == UIUserInterfaceIdiomPhone)
                        picker.modalPresentationStyle = UIModalPresentationOverFullScreen;
                    NSMutableArray *tarr = [NSMutableArray arrayWithCapacity:0];
                    for (int i=0; i<arr_images.count; i++) {
                        FBTextImgModel *model = arr_images[i];
                       
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
    }else if (indexPath.row ==10)
    {
        FBHangYeViewController  *HYvc = [[FBHangYeViewController alloc]init];
        HYvc.indexPath =indexPath;
        HYvc.delegate = self;
        [self.navigationController pushViewController:HYvc animated:NO];
    }
    else
    {
        
    }
}

#pragma  mark - 行业
-(void)hangye:(NSString *)hangye Withindexpath:(NSIndexPath *)indexpath
{
    NSArray *tarr = [hangye componentsSeparatedByString:@"-"];
    
    [arr_contents replaceObjectAtIndex:indexpath.row withObject:tarr[0]];
    [tableV reloadRowsAtIndexPaths:@[indexpath] withRowAnimation:UITableViewRowAnimationNone];
    
}

//@[@"课程主题",@"课程类型",@"授课对象",@"课程时长/h",@"课程价格/元",@"课程目标",@"课程背景",@"课程大纲",@"课程图片"];
#pragma  mark - 多选相册的协议代理
-(void)assetsPickerController:(CTAssetsPickerController *)picker didFinishPickingAssets:(NSArray<PHAsset *> *)assets
{
    [self dismissViewControllerAnimated:NO completion:nil];
    [arr_images removeAllObjects];
    for (PHAsset *set in assets) {
        FBTextImgModel *model = [[FBTextImgModel alloc]initWithasset:set type:@"2"];
        [arr_images addObject:model];
    }
    [arr_contents replaceObjectAtIndex:8 withObject:@"已选择"];
    [tableV reloadRowsAtIndexPaths:@[[NSIndexPath indexPathForRow:8 inSection:0]] withRowAnimation:UITableViewRowAnimationNone];
}
-(void)assetsPickerControllerDidCancel:(CTAssetsPickerController *)picker
{
    [self dismissViewControllerAnimated:NO completion:nil];
}
#pragma  mark - editor的协议代理
-(void)getEditerTitle:(NSString *)title html:(NSString *)html text:(NSString *)text imgurl:(NSString *)imgurl stringData:(NSData *)data
{
    html_ = html;
    [arr_contents replaceObjectAtIndex:7 withObject:text];
    [tableV reloadRowsAtIndexPaths:@[[NSIndexPath indexPathForRow:7 inSection:0]] withRowAnimation:UITableViewRowAnimationNone];
    
}
#pragma  mark - TVVc 额协议代理
-(void)textVtext:(NSString *)text indexPath:(NSIndexPath *)indexPath
{
    [arr_contents replaceObjectAtIndex:indexPath.row withObject:text];
    [tableV reloadRowsAtIndexPaths:@[indexPath] withRowAnimation:UITableViewRowAnimationNone];
}
#pragma  mark - 类别的协议代理
-(void)getTecherLeiBieModel:(NSArray<FBAddressModel *> *)arr_teachers
{
    arr_leibie =arr_teachers;
    NSMutableString *Tstr = [NSMutableString string];
    for (int i=0; i<arr_teachers.count; i++) {
        FBAddressModel *model =arr_teachers[i];
        if (i==arr_teachers.count-1) {
            [Tstr appendString:model.name];
        }else
        {
            [Tstr appendFormat:@"%@,",model.name];
        }
    }
    [arr_contents replaceObjectAtIndex:1 withObject:Tstr];
    [tableV reloadRowsAtIndexPaths:@[[NSIndexPath indexPathForRow:1 inSection:0]] withRowAnimation:UITableViewRowAnimationNone];
}
#pragma  mark - TFvc 的协议代理

-(void)content:(NSString *)content WithindexPath:(NSIndexPath *)indexPath
{
    [arr_contents replaceObjectAtIndex:indexPath.row withObject:content];
    [tableV reloadRowsAtIndexPaths:@[indexPath] withRowAnimation:UITableViewRowAnimationNone];
}


@end
