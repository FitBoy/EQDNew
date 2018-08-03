//
//  SC_centerAddViewController.m
//  EQD
//
//  Created by 梁新帅 on 2018/6/26.
//  Copyright © 2018年 FitBoy. All rights reserved.
//

#import "SC_centerAddViewController.h"
#import "FBImgeOnlyTableViewCell.h"
#import "FBLabel_YYAddTableViewCell.h"
#import <Masonry.h>
#import "FBTextFieldViewController.h"
#import "FBTextVViewController.h"
@interface SC_centerAddViewController ()<UITableViewDelegate,UITableViewDataSource,UINavigationControllerDelegate, UIImagePickerControllerDelegate,FBTextVViewControllerDelegate,FBTextFieldViewControllerDelegate>
{
    UITableView *tableV;
    NSArray *arr_names;
    NSMutableArray *arr_contents;
    UIImage *image_one;
    NSMutableArray *arr_height;
    UIImagePickerController  *picker;
    UserModel *user;
}

@end

@implementation SC_centerAddViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    user = [WebRequest GetUserInfo];
    self.navigationItem.title = @"核心价值观";
    arr_names = @[@"核心价值观图",@"标题",@"简介"];
    if(self.tmodel)
    {
        arr_contents = [NSMutableArray arrayWithArray:@[@"已选择",_tmodel.title,_tmodel.describe]];
        NSData *data = [NSData dataWithContentsOfURL:[NSURL URLWithString:_tmodel.ImageUrl]];
        image_one = [UIImage imageWithData:data];
        CGSize size = [_tmodel.describe boundingRectWithSize:CGSizeMake(DEVICE_WIDTH-30, MAXFLOAT) options:NSStringDrawingUsesLineFragmentOrigin attributes:@{NSFontAttributeName:[UIFont systemFontOfSize:17]} context:nil].size;
        arr_height = [NSMutableArray arrayWithArray:@[[NSString stringWithFormat:@"%.2f",(DEVICE_WIDTH-30)/2.0],@"60",[NSString stringWithFormat:@"%f",size.height+20]]];
    }else
    {
    arr_contents = [NSMutableArray arrayWithArray:@[@"请选择",@"请输入",@"请输入"]];
    image_one = nil;
    arr_height = [NSMutableArray arrayWithArray:@[@"60",@"60",@"60"]];
    }
    tableV = [[UITableView alloc]initWithFrame:CGRectMake(0, kNavBarHAbove7, DEVICE_WIDTH, DEVICE_HEIGHT-kNavBarHAbove7-kBottomSafeHeight) style:UITableViewStylePlain];
    adjustsScrollViewInsets_NO(tableV, self);
    tableV.delegate=self;
    tableV.dataSource=self;
    [self.view addSubview:tableV];
    tableV.rowHeight=60;
    picker = [[UIImagePickerController alloc]init];
    picker.delegate =self;
    picker.allowsEditing =YES;

    NSString *tTitle = self.tmodel == nil?@"提交":@"修改";
    UIBarButtonItem *right = [[UIBarButtonItem alloc]initWithTitle:tTitle style:UIBarButtonItemStylePlain target:self action:@selector(tijiaoCLick)];
    [self.navigationItem setRightBarButtonItem:right];
}
-(void)tijiaoCLick
{
    if(self.tmodel)
    {
        MBProgressHUD *hud = [MBProgressHUD showHUDAddedTo:self.view animated:YES];
        hud.mode = MBProgressHUDModeAnnularDeterminate;
        hud.label.text = @"正在修改";
        [WebRequest ComSpace_ComSpaceCoreValues_Update_ComSpaceCoreValuesWithuserGuid:user.Guid companyId:user.companyId title:arr_contents[1] Describe:arr_contents[2] coreValuesId:self.tmodel.Id And:^(NSDictionary *dic) {
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
        if ([arr_contents[i] isEqualToString:@"请选择"] || [arr_contents[i] isEqualToString:@"请输入"]) {
            temp =1;
            break;
        }
    }
    
    
    
    
    if (temp ==0) {
        MBProgressHUD *hud = [MBProgressHUD showHUDAddedTo:self.view animated:YES];
        hud.mode = MBProgressHUDModeAnnularDeterminate;
        hud.label.text = @"正在加载";
        
        [WebRequest ComSpace_ComSpaceCoreValues_Add_ComSpaceCoreValuesWithuserGuid:user.Guid companyId:user.companyId title:arr_contents[1] describe:arr_contents[2] image:image_one And:^(NSDictionary *dic) {
            hud.label.text = dic[Y_MSG];
            dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(0.6 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
                [hud hideAnimated:NO];
                if ([dic[Y_STATUS] integerValue] ==200) {
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
        cell.textLabel.text = arr_names[indexPath.row];
        cell.detailTextLabel.text = arr_contents[indexPath.row];
    return cell;
    }else
    {
        
        
        if (indexPath.row == 0) {
            FBImgeOnlyTableViewCell *cell = [[FBImgeOnlyTableViewCell alloc]init];
            cell.IV_img.image = image_one;
            
            [arr_height replaceObjectAtIndex:0 withObject:[NSString stringWithFormat:@"%f",(DEVICE_WIDTH-30)/2.0]];
            return cell;
        }else if (indexPath.row ==1)
        {
            static NSString *cellId=@"cellID1";
            UITableViewCell *cell =[tableView dequeueReusableCellWithIdentifier:cellId];
            if (!cell) {
                cell = [[UITableViewCell alloc]initWithStyle:UITableViewCellStyleValue1 reuseIdentifier:cellId];
                cell.accessoryType = UITableViewCellAccessoryDisclosureIndicator;
                cell.textLabel.font = [UIFont systemFontOfSize:18];
            }
            cell.textLabel.text = arr_names[indexPath.row];
            cell.detailTextLabel.text = arr_contents[indexPath.row];
            return cell;
        }else if (indexPath.row ==2)
        {
            FBLabel_YYAddTableViewCell *cell = [[FBLabel_YYAddTableViewCell alloc]init];
            NSMutableAttributedString *contents = [[NSMutableAttributedString alloc]initWithString:arr_contents[2] attributes:@{NSFontAttributeName:[UIFont systemFontOfSize:17]}];
            contents.yy_lineSpacing =6;
            cell.YL_content.attributedText = contents;
            CGSize size = [contents boundingRectWithSize:CGSizeMake(DEVICE_WIDTH-30, MAXFLOAT) options:NSStringDrawingUsesLineFragmentOrigin context:nil].size;
            [arr_height replaceObjectAtIndex:2 withObject:[NSString stringWithFormat:@"%.2f",size.height+20]];
            [cell.YL_content  mas_remakeConstraints:^(MASConstraintMaker *make) {
                make.height.mas_equalTo(size.height+10);
                make.centerY.mas_equalTo(cell.mas_centerY);
                make.left.mas_equalTo(cell.mas_left).mas_offset(15);
                make.right.mas_equalTo(cell.mas_right).mas_offset(-15);
            }];
            return cell;
            
        }else
        {
            return nil;
        }
    }
}

-(void)imagePickerController:(UIImagePickerController *)picker didFinishPickingMediaWithInfo:(NSDictionary<NSString *,id> *)info
{
    image_one = [info objectForKey:UIImagePickerControllerEditedImage];
    [arr_contents replaceObjectAtIndex:0 withObject:@"已选择"];
    [arr_height replaceObjectAtIndex:0 withObject:[NSString stringWithFormat:@"%f",(DEVICE_WIDTH-30)/2.0]];
    [tableV reloadRowsAtIndexPaths:@[[NSIndexPath indexPathForRow:0 inSection:0]] withRowAnimation:UITableViewRowAnimationNone];
    [self dismissViewControllerAnimated:NO completion:nil];
}

#pragma  mark - 表的协议代理
-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return [arr_height[indexPath.row] integerValue];
}
-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    if (indexPath.row ==0) {
        
        if (self.tmodel) {
            MBProgressHUD *hud=[MBProgressHUD showHUDAddedTo:self.view  animated:YES];
            hud.mode = MBProgressHUDModeText;
            hud.label.text =@"暂不支持图片修改";
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
    }else if (indexPath.row ==1)
    {
        FBTextFieldViewController *TFvc =[[FBTextFieldViewController alloc]init];
        TFvc.delegate =self;
        TFvc.indexPath =indexPath;
        TFvc.content =arr_contents[indexPath.row];
        TFvc.contentTitle =arr_names[indexPath.row];
        [self.navigationController pushViewController:TFvc animated:NO];
    }else if (indexPath.row ==2 )
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
