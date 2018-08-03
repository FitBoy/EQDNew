//
//  SC_ZuZhiAddViewController.m
//  EQD
//
//  Created by 梁新帅 on 2018/6/22.
//  Copyright © 2018年 FitBoy. All rights reserved.
//

#import "SC_ZuZhiAddViewController.h"
#import "FB_OnlyForLiuYanViewController.h"
#import "FBTextVViewController.h"
#import "FBTextFieldViewController.h"
#import "FBImgeOnlyTableViewCell.h"
#import "FBLabel_YYAddTableViewCell.h"
#import <Masonry.h>
#import <UIImageView+WebCache.h>
@interface SC_ZuZhiAddViewController ()<UITableViewDelegate,UITableViewDataSource,FB_OnlyForLiuYanViewControllerDlegate,FBTextVViewControllerDelegate,FBTextFieldViewControllerDelegate,UINavigationControllerDelegate, UIImagePickerControllerDelegate>
{
    UITableView *tableV;
    NSArray *arr_names;
    NSMutableArray *arr_contents;
    UIImage *img_one;
    NSString *img_url;
    NSMutableArray *arr_height;
    
    UIImagePickerController *picker;
    UserModel *user;
}

@end

@implementation SC_ZuZhiAddViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    user = [WebRequest GetUserInfo];
    self.navigationItem.title = @"添加组织机构图";
    arr_names = @[@"组织机构图",@"说明",@"排序号"];
    if (self.model_) {
        arr_contents = [NSMutableArray arrayWithArray:@[@"已选择",self.model_.describe,self.model_.sort]];
        img_one =nil;
        img_url = self.model_.ImageUrl;
    }else
    {
    arr_contents = [NSMutableArray arrayWithArray:@[@"请选择",@"请输入",@"请输入"]];
     img_one =nil;
        img_url =nil;
    }
    arr_height =[NSMutableArray arrayWithArray:@[@"60",@"60",@"60"]] ;
    tableV = [[UITableView alloc]initWithFrame:CGRectMake(0, DEVICE_TABBAR_Height, DEVICE_WIDTH, DEVICE_HEIGHT-DEVICE_TABBAR_Height-kBottomSafeHeight) style:UITableViewStylePlain];
    adjustsScrollViewInsets_NO(tableV, self);
    tableV.delegate=self;
    tableV.dataSource=self;
    [self.view addSubview:tableV];
    tableV.rowHeight=60;
   

    picker = [[UIImagePickerController alloc]init];
    picker.allowsEditing =YES;
    picker.delegate = self;
    NSString *RightTitle = nil;
    if (self.model_) {
        RightTitle = @"修改";
    }else
    {
        RightTitle = @"提交";
    }
    
    UIBarButtonItem *right = [[UIBarButtonItem alloc]initWithTitle:RightTitle style:UIBarButtonItemStylePlain target:self action:@selector(tijiaoCLick)];
    [self.navigationItem setRightBarButtonItem:right];
    
}
-(void)tijiaoCLick
{
    if (self.model_) {
        MBProgressHUD *hud = [MBProgressHUD showHUDAddedTo:self.view animated:YES];
        hud.mode = MBProgressHUDModeAnnularDeterminate;
        hud.label.text = @"正在修改";
        [WebRequest ComSpace_ComSpaceOrganization_Update_ComSpaceOrganizationWithuserGuid:user.Guid companyId:user.companyId describe:self.model_.describe sort:self.model_.sort imageId:self.model_.Id And:^(NSDictionary *dic) {
            hud.label.text =dic[Y_MSG];
            dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(0.6 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
                [hud hideAnimated:NO];
                if ([dic[Y_STATUS] integerValue]==200) {
                    [self.navigationController popViewControllerAnimated:NO];
                }
            });
        }];
    }else
    {
    NSInteger temp=0;
    for (int i=0; i<arr_contents.count; i++) {
        if ([arr_contents[i] isEqualToString:@"请输入"] || [arr_contents[i] isEqualToString:@"请选择"]) {
            temp =1;
            break;
        }
    }
    if (temp ==0) {
        MBProgressHUD *hud = [MBProgressHUD showHUDAddedTo:self.view animated:YES];
        hud.mode = MBProgressHUDModeAnnularDeterminate;
        hud.label.text = @"正在提交";
        [WebRequest ComSpace_ComSpaceOrganization_Add_ComSpaceOrganizationWithuserGuid:user.Guid companyId:user.companyId describe:arr_contents[1] image:img_one sort:arr_contents[2] And:^(NSDictionary *dic) {
            hud.label.text = dic[Y_MSG];
            dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(0.6 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
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
        hud.label.text =@"参数不完整";
        dispatch_time_t popTime = dispatch_time(DISPATCH_TIME_NOW, 1 * NSEC_PER_SEC);
        dispatch_after(popTime, dispatch_get_main_queue(), ^(void){
            [MBProgressHUD hideHUDForView:self.view  animated:YES];
        });
    }
    }
}
#pragma  mark - 表的数据源
-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return [arr_height[indexPath.row] integerValue];
}
-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return arr_contents.count;
}
-(UITableViewCell*)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    if ([arr_contents[indexPath.row] isEqualToString:@"请输入"] || [arr_contents[indexPath.row] isEqualToString:@"请选择"]) {
        static NSString *cellId=@"cellID";
        UITableViewCell *cell =[tableView dequeueReusableCellWithIdentifier:cellId];
        if (!cell) {
            cell = [[UITableViewCell alloc]initWithStyle:UITableViewCellStyleValue1 reuseIdentifier:cellId];
            cell.accessoryType = UITableViewCellAccessoryDisclosureIndicator;
            cell.textLabel.font = [UIFont systemFontOfSize:18];
        }
        cell.textLabel.text = arr_names[indexPath.row];
        cell.detailTextLabel.text = arr_contents[indexPath.row];
        return cell;
    }else
    {
        if (indexPath.row ==0) {
            FBImgeOnlyTableViewCell *cell = [[FBImgeOnlyTableViewCell alloc]init];
            if(_model_)
            {
                [cell.IV_img sd_setImageWithURL:[NSURL URLWithString:_model_.ImageUrl] placeholderImage:[UIImage imageNamed:@"imageerro"] options:(SDWebImageProgressiveDownload)];
            }else
            {
            cell.IV_img.image = img_one;
            }
            [arr_height replaceObjectAtIndex:0 withObject:[NSString stringWithFormat:@"%.2f",(DEVICE_WIDTH-30)/2.0+10]];
            return cell;
        }else if (indexPath.row ==1)
        {
            NSMutableAttributedString *contents = [[NSMutableAttributedString alloc]initWithString:arr_contents[1] attributes:@{NSFontAttributeName:[UIFont systemFontOfSize:17]}];
            CGSize size = [contents boundingRectWithSize:CGSizeMake(DEVICE_WIDTH-30, MAXFLOAT) options:NSStringDrawingUsesLineFragmentOrigin context:nil].size;
            
            FBLabel_YYAddTableViewCell *cell = [[FBLabel_YYAddTableViewCell alloc]init];
            cell.YL_content.attributedText = contents;
            [arr_height replaceObjectAtIndex:1 withObject:[NSString stringWithFormat:@"%.2f",size.height+20]];
            [cell.YL_content mas_remakeConstraints:^(MASConstraintMaker *make) {
                make.height.mas_equalTo(size.height+5);
                make.left.mas_equalTo(cell.mas_left).mas_offset(15);
                make.right.mas_equalTo(cell.mas_right).mas_offset(-15);
                make.centerY.mas_equalTo(cell.mas_centerY);
            }];
            return cell;
            
        }else if (indexPath.row ==2)
        {
            UITableViewCell  *cell = [[UITableViewCell alloc]init];
            cell.textLabel.text = [NSString stringWithFormat:@"排序号：%@",arr_contents[2]];
            return cell;
        }else
        {
            return nil;
        }
    }
   
}

-(void)imagePickerController:(UIImagePickerController *)picker didFinishPickingMediaWithInfo:(NSDictionary<NSString *,id> *)info
{
    img_one  = [info objectForKey:UIImagePickerControllerEditedImage];
    [arr_contents replaceObjectAtIndex:0 withObject:@"已选择"];
    [tableV reloadRowsAtIndexPaths:@[[NSIndexPath indexPathForRow:0 inSection:0]] withRowAnimation:UITableViewRowAnimationNone];
    [self dismissViewControllerAnimated:NO completion:nil];
}

#pragma  mark - 表的协议代理
-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    if (indexPath.row ==0) {
      
        if(self.model_)
        {
            MBProgressHUD *hud=[MBProgressHUD showHUDAddedTo:self.view  animated:YES];
            hud.mode = MBProgressHUDModeText;
            hud.label.text =@"组织机构图不允许修改，可以删除";
            dispatch_time_t popTime = dispatch_time(DISPATCH_TIME_NOW, 1 * NSEC_PER_SEC);
            dispatch_after(popTime, dispatch_get_main_queue(), ^(void){
                [MBProgressHUD hideHUDForView:self.view  animated:YES];
            });
        }else
        {
        
        UIAlertController *alert = [[UIAlertController alloc]init];
        [alert addAction:[UIAlertAction actionWithTitle:@"相册" style:UIAlertActionStyleDefault handler:^(UIAlertAction * _Nonnull action) {
            if ([UIImagePickerController availableMediaTypesForSourceType:UIImagePickerControllerSourceTypePhotoLibrary]) {
                picker.sourceType = UIImagePickerControllerSourceTypePhotoLibrary;
                [self presentViewController:picker animated:NO completion:nil];
            }else
            {
                MBProgressHUD *hud=[MBProgressHUD showHUDAddedTo:self.view  animated:YES];
                hud.mode = MBProgressHUDModeText;
                hud.label.text =@"您拒绝了相册的访问";
                dispatch_time_t popTime = dispatch_time(DISPATCH_TIME_NOW, 1 * NSEC_PER_SEC);
                dispatch_after(popTime, dispatch_get_main_queue(), ^(void){
                    [MBProgressHUD hideHUDForView:self.view  animated:YES];
                });
            }
        }]];
        [alert addAction:[UIAlertAction actionWithTitle:@"相机" style:UIAlertActionStyleDefault handler:^(UIAlertAction * _Nonnull action) {
            
            if([UIImagePickerController availableMediaTypesForSourceType:UIImagePickerControllerSourceTypeCamera])
            {
                picker.sourceType =UIImagePickerControllerSourceTypeCamera;
                [self presentViewController:picker animated:NO completion:nil];
                
            }else
            {
                MBProgressHUD *hud=[MBProgressHUD showHUDAddedTo:self.view  animated:YES];
                hud.mode = MBProgressHUDModeText;
                hud.label.text =@"您拒绝了相机的访问";
                dispatch_time_t popTime = dispatch_time(DISPATCH_TIME_NOW, 1 * NSEC_PER_SEC);
                dispatch_after(popTime, dispatch_get_main_queue(), ^(void){
                    [MBProgressHUD hideHUDForView:self.view  animated:YES];
                });
            }
            
        }]];
        [alert addAction:[UIAlertAction actionWithTitle:@"取消" style:UIAlertActionStyleCancel handler:^(UIAlertAction * _Nonnull action) {
            
        }]];
        [self presentViewController:alert animated:NO completion:nil];
        }
    }else if (indexPath.row == 1)
    {
        FBTextVViewController *TVvc =[[FBTextVViewController alloc]init];
        TVvc.indexpath =indexPath;
        TVvc.delegate =self;
        TVvc.contentTitle=arr_names[indexPath.row];
        TVvc.content =arr_contents[indexPath.row];
        [self.navigationController pushViewController:TVvc animated:NO];
    }else if (indexPath.row ==2)
    {
        FBTextFieldViewController *TFvc =[[FBTextFieldViewController alloc]init];
        TFvc.delegate =self;
        TFvc.indexPath =indexPath;
        TFvc.keyBoardType = UIKeyboardTypeNumberPad;
        TFvc.content =arr_contents[indexPath.row];
        TFvc.contentTitle =arr_names[indexPath.row];
        [self.navigationController pushViewController:TFvc animated:NO];
    }else
    {
        
    }
}

#pragma  mark - 单行
-(void)content:(NSString *)content WithindexPath:(NSIndexPath *)indexPath
{
    [arr_contents replaceObjectAtIndex:indexPath.row withObject:content];
    [tableV reloadRowsAtIndexPaths:@[indexPath] withRowAnimation:UITableViewRowAnimationNone];
}
#pragma  mark - 多行
-(void)textVtext:(NSString *)text indexPath:(NSIndexPath *)indexPath
{
    [arr_contents replaceObjectAtIndex:indexPath.row withObject:text];
    [tableV reloadRowsAtIndexPaths:@[indexPath] withRowAnimation:UITableViewRowAnimationNone];
}


@end
