//
//  SC_teamAddViewController.m
//  EQD
//
//  Created by 梁新帅 on 2018/6/23.
//  Copyright © 2018年 FitBoy. All rights reserved.
//

#import "SC_teamAddViewController.h"
#import "FBTextFieldViewController.h"
#import "FBTextVViewController.h"
#import "FBImgeOnlyTableViewCell.h"
#import "FBLabel_YYAddTableViewCell.h"
#import <Masonry.h>
#import <UIImageView+WebCache.h>
@interface SC_teamAddViewController ()<UITableViewDelegate,UITableViewDataSource,UINavigationControllerDelegate, UIImagePickerControllerDelegate,FBTextVViewControllerDelegate,FBTextFieldViewControllerDelegate>
{
    UITableView *tableV;
    NSArray *arr_names;
    NSMutableArray *arr_contents;
    UserModel *user;
    UIImagePickerController *picker;
    NSMutableArray *arr_height;
    UIImage *image_one;
}

@end

@implementation SC_teamAddViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.navigationItem.title = @"团队成员";
    user = [WebRequest GetUserInfo];
    arr_names = @[@"头像",@"姓名",@"职务",@"简介"];
    
    if(_model_list)
    {
        arr_contents = [NSMutableArray arrayWithArray:@[@"已选择",_model_list.userName,_model_list.Post,_model_list.Msg]];
        CGSize size = [_model_list.Msg boundingRectWithSize:CGSizeMake(DEVICE_WIDTH-30, MAXFLOAT) options:NSStringDrawingUsesLineFragmentOrigin attributes:@{NSFontAttributeName:[UIFont systemFontOfSize:17]} context:nil].size;
        
        arr_height = [NSMutableArray arrayWithArray:@[[NSString stringWithFormat:@"%f",(DEVICE_WIDTH-30)/2.0],@"60",@"60",[NSString stringWithFormat:@"%f",size.height +20]]];
    }else
    {
    arr_contents = [NSMutableArray arrayWithArray:@[@"请选择",@"请输入",@"请输入",@"请输入"]];
        arr_height = [NSMutableArray arrayWithArray:@[@"60",@"60",@"60",@"60"]];
    }
    picker = [[UIImagePickerController alloc]init];
    picker.delegate =self;
    picker.allowsEditing =YES;
    
    
    tableV = [[UITableView alloc]initWithFrame:CGRectMake(0, DEVICE_TABBAR_Height, DEVICE_WIDTH, DEVICE_HEIGHT-DEVICE_TABBAR_Height-kBottomSafeHeight) style:UITableViewStylePlain];
    adjustsScrollViewInsets_NO(tableV, self);
    tableV.delegate=self;
    tableV.dataSource=self;
    [self.view addSubview:tableV];
    tableV.rowHeight=60;
    NSString *tTitle = self.model_list==nil?@"提交":@"修改";
    
    UIBarButtonItem *right = [[UIBarButtonItem alloc]initWithTitle:tTitle style:UIBarButtonItemStylePlain target:self action:@selector(tijiaoCLick)];
    [self.navigationItem setRightBarButtonItem:right];
    
    if (self.model_list) {
        NSData *data = [NSData dataWithContentsOfURL:[NSURL URLWithString:self.model_list.HeadImage]];
        image_one = [[UIImage alloc]initWithData:data];
    }else
    {
        image_one =nil;
    }
}
-(void)tijiaoCLick
{
    if(self.temp ==1)
    {
        
        if(self.model_list)
        {
            MBProgressHUD *hud = [MBProgressHUD showHUDAddedTo:self.view animated:YES];
            hud.mode = MBProgressHUDModeAnnularDeterminate;
            hud.label.text = @"正在修改";
            [WebRequest ComSpace_ComSpaceGoodStaff_Update_ComSpaceGoodStaffWithuserGuid:user.Guid companyId:user.companyId userName:arr_contents[1] PostMsg:arr_contents[2] Msg:arr_contents[3] goodStaffId:self.model_list.Id And:^(NSDictionary *dic) {
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
        
        NSInteger temp =0;
        for (int i=0; i<arr_contents.count; i++) {
            if ([arr_contents[i] isEqualToString:@"请输入"] || [arr_contents[i] isEqualToString:@"请选择"]){
                temp =1;
                break;
            }
            
            if (temp ==0) {
                MBProgressHUD *hud = [MBProgressHUD showHUDAddedTo:self.view animated:YES];
                hud.mode = MBProgressHUDModeAnnularDeterminate;
                hud.label.text = @"正在提交";
                [WebRequest ComSpace_ComSpaceGoodStaff_Add_ComSpaceGoodStaffWithuserGuid:user.Guid companyId:user.companyId userName:arr_contents[1] PostMsg:arr_contents[2] Msg:arr_contents[3] image:image_one And:^(NSDictionary *dic) {
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
    }else
    {
  
    NSInteger temp =0;
    for (int i=0; i<arr_contents.count; i++) {
        if ([arr_contents[i] isEqualToString:@"请输入"] || [arr_contents[i] isEqualToString:@"请选择"]){
            temp =1;
            break;
        }
    
    if (temp ==0) {
        if (self.model_list) {
            MBProgressHUD *hud = [MBProgressHUD showHUDAddedTo:self.view animated:YES];
            hud.mode = MBProgressHUDModeAnnularDeterminate;
            hud.label.text = @"正在修改";
            [WebRequest ComSpace_ComSpaceTeam_Update_ComSpaceTeamWithuserGuid:user.Guid companyId:user.companyId userName:arr_contents[1] PostMsg:arr_contents[2] Msg:arr_contents[3] teamId:self.model_list.Id And:^(NSDictionary *dic) {
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
        MBProgressHUD *hud = [MBProgressHUD showHUDAddedTo:self.view animated:YES];
        hud.mode = MBProgressHUDModeAnnularDeterminate;
        hud.label.text = @"正在提交";
    [WebRequest ComSpace_ComSpaceTeam_Add_ComSpaceTeamWithuserGuid:user.Guid companyId:user.companyId userName:arr_contents[1] PostMsg:arr_contents[2] Msg:arr_contents[3] image:image_one And:^(NSDictionary *dic) {
        hud.label.text = dic[Y_MSG];
        dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(0.6 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
            [hud hideAnimated:NO];
            if ([dic[Y_STATUS] integerValue]==200) {
                [self.navigationController popViewControllerAnimated:NO];
            }
        });
    }];
        }
        
     }else
     {
         
     }
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
    if([arr_contents[indexPath.row] isEqualToString:@"请选择"] || [arr_contents[indexPath.row] isEqualToString:@"请输入"])
    {
    static NSString *cellId=@"cellID";
    UITableViewCell *cell =[tableView dequeueReusableCellWithIdentifier:cellId];
    if (!cell) {
        cell = [[UITableViewCell alloc]initWithStyle:UITableViewCellStyleValue1 reuseIdentifier:cellId];
        cell.accessoryType = UITableViewCellAccessoryDisclosureIndicator;
        cell.textLabel.font = [UIFont systemFontOfSize:18];
    }
        cell.textLabel.text =arr_names[indexPath.row];
        cell.detailTextLabel.text =arr_contents[indexPath.row];
        return cell;
    }else
    {
        if (indexPath.row ==0) {
            FBImgeOnlyTableViewCell  *cell = [[FBImgeOnlyTableViewCell alloc]init];
           
            cell.IV_img.image = image_one;
            
            [arr_height replaceObjectAtIndex:0 withObject:[NSString stringWithFormat:@"%f",(DEVICE_WIDTH-30)/2.0]];
            return cell;
        }else if (indexPath.row ==1 || indexPath.row ==2)
        {
           
            
            static NSString *cellId=@"cellID1";
            UITableViewCell *cell =[tableView dequeueReusableCellWithIdentifier:cellId];
            if (!cell) {
                cell = [[UITableViewCell alloc]initWithStyle:UITableViewCellStyleValue1 reuseIdentifier:cellId];
                cell.accessoryType = UITableViewCellAccessoryDisclosureIndicator;
                cell.textLabel.font = [UIFont systemFontOfSize:18];
            }
            cell.textLabel.text =arr_names[indexPath.row];
            cell.detailTextLabel.text =arr_contents[indexPath.row];
            return cell;
        }else if (indexPath.row ==3)
        {
            FBLabel_YYAddTableViewCell *cell = [[FBLabel_YYAddTableViewCell alloc]init];
            NSMutableAttributedString *contents = [[NSMutableAttributedString alloc]initWithString:arr_contents[3] attributes:@{NSFontAttributeName:[UIFont systemFontOfSize:17]}];
            contents.yy_lineSpacing =6;
            cell.YL_content.attributedText = contents;
            CGSize size = [contents boundingRectWithSize:CGSizeMake(DEVICE_WIDTH-30, MAXFLOAT) options:NSStringDrawingUsesLineFragmentOrigin context:nil].size;
            [arr_height replaceObjectAtIndex:3 withObject:[NSString stringWithFormat:@"%f",size.height+20]];
            [cell.YL_content mas_remakeConstraints:^(MASConstraintMaker *make) {
                make.left.mas_equalTo(cell.mas_left).mas_offset(15);
                make.right.mas_equalTo(cell.mas_right).mas_offset(-15);
                make.height.mas_equalTo(size.height+10);
                make.centerY.mas_equalTo(cell.mas_centerY);
            }];
            
            return cell;
        }else
        {
            return nil;
        }
        
    }
        
}

#pragma  mark - 表的协议代理
-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    if (indexPath.row ==0) {
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
    }else if (indexPath.row ==1 || indexPath.row ==2)
    {
        FBTextFieldViewController *TFvc =[[FBTextFieldViewController alloc]init];
        TFvc.delegate =self;
        TFvc.indexPath =indexPath;
        TFvc.content =arr_contents[indexPath.row];
        TFvc.contentTitle =arr_names[indexPath.row];
        [self.navigationController pushViewController:TFvc animated:NO];
    }else if (indexPath.row ==3)
    {
        FBTextVViewController *TVvc =[[FBTextVViewController alloc]init];
        TVvc.indexpath =indexPath;
        TVvc.delegate =self;
        TVvc.contentTitle=arr_names[indexPath.row];
        TVvc.content =arr_contents[indexPath.row];
        [self.navigationController pushViewController:TVvc animated:NO];
    }else
    {
        
    }
}

#pragma  mark - 相册
-(void)imagePickerController:(UIImagePickerController *)picker didFinishPickingMediaWithInfo:(NSDictionary<NSString *,id> *)info
{
    image_one = [info objectForKey:UIImagePickerControllerEditedImage];
    [self dismissViewControllerAnimated:NO completion:nil];
    
    if (self.model_list) {
        
        
        MBProgressHUD *hud = [MBProgressHUD showHUDAddedTo:self.view animated:YES];
        hud.mode = MBProgressHUDModeAnnularDeterminate;
        hud.label.text = @"正在修改";
        if (self.temp ==1) {
            [WebRequest ComSpace_ComSpaceGoodStaff_Update_ComSpaceGoodStaffImgWithuserGuid:user.Guid companyId:user.companyId image:image_one goodStaffId:self.model_list.Id And:^(NSDictionary *dic) {
                hud.label.text = dic[Y_MSG];
                dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(0.6 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
                    [hud hideAnimated:NO];
                    if ([dic[Y_STATUS] integerValue]==200) {
                        [arr_contents replaceObjectAtIndex:0 withObject:@"已选择"];
                        [arr_height  replaceObjectAtIndex:0 withObject:[NSString stringWithFormat:@"%f",(DEVICE_WIDTH-30)/2.0]];
                        [tableV reloadRowsAtIndexPaths:@[[NSIndexPath indexPathForRow:0 inSection:0]] withRowAnimation:UITableViewRowAnimationNone];
                    }
                });
            }];
        }else
        {
        [WebRequest ComSpace_ComSpaceTeam_Update_ComSpaceTeamImageWithuserGuid:user.Guid companyId:user.companyId image:image_one teamId:self.model_list.Id And:^(NSDictionary *dic) {
            hud.label.text = dic[Y_MSG];
            dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(0.6 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
                [hud hideAnimated:NO];
                if ([dic[Y_STATUS] integerValue]==200) {
                    [arr_contents replaceObjectAtIndex:0 withObject:@"已选择"];
                    [arr_height  replaceObjectAtIndex:0 withObject:[NSString stringWithFormat:@"%f",(DEVICE_WIDTH-30)/2.0]];
                    [tableV reloadRowsAtIndexPaths:@[[NSIndexPath indexPathForRow:0 inSection:0]] withRowAnimation:UITableViewRowAnimationNone];
                }
            });
        }];
        }
    }else
    {
    [arr_contents replaceObjectAtIndex:0 withObject:@"已选择"];
    [arr_height  replaceObjectAtIndex:0 withObject:[NSString stringWithFormat:@"%f",(DEVICE_WIDTH-30)/2.0]];
    [tableV reloadRowsAtIndexPaths:@[[NSIndexPath indexPathForRow:0 inSection:0]] withRowAnimation:UITableViewRowAnimationNone];
    }
}
#pragma  mark - 单行
-(void)content:(NSString *)content WithindexPath:(NSIndexPath *)indexPath
{
    [arr_contents  replaceObjectAtIndex:indexPath.row withObject:content];
    [tableV reloadRowsAtIndexPaths:@[indexPath] withRowAnimation:UITableViewRowAnimationNone];
}
#pragma  mark - 多行
-(void)textVtext:(NSString *)text indexPath:(NSIndexPath *)indexPath
{
    [arr_contents replaceObjectAtIndex:indexPath.row withObject:text];
    [tableV reloadRowsAtIndexPaths:@[indexPath] withRowAnimation:UITableViewRowAnimationNone];
}





@end
