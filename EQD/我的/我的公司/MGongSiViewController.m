//
//  MGongSiViewController.m
//  YiQiDian
//
//  Created by 梁新帅 on 2017/3/16.
//  Copyright © 2017年 FitBoy. All rights reserved.
//

#import "MGongSiViewController.h"
#import "WebRequest.h"
#import "GSRegisterViewController.h"
#import "GSYaoQingViewController.h"
#import "FBTwo_noimg12TableViewCell.h"
#import "FBOne_img2TableViewCell.h"
#import <UIImageView+AFNetworking.h>
#import "FBTextFieldViewController.h"
#import "HeTong_listPersonViewController.h"
#import "LianLuoBook_OtherViewController.h"
#import "RedTip_LabelTableViewCell.h"
@interface MGongSiViewController ()<UITableViewDelegate,UITableViewDataSource,FBTextFieldViewControllerDelegate,UINavigationControllerDelegate, UIImagePickerControllerDelegate>
{
    UITableView *tableV;
    NSMutableArray *arr_gongsi;
    UserModel *user ;
    ComModel *comM;
    NSMutableArray *arr_cominfo;
    NSMutableArray *arr_cominfocontent;
    NSInteger flag;
    NSMutableArray *arr_code;
}

@end

@implementation MGongSiViewController
-(void)viewWillAppear:(BOOL)animated{
    [super viewWillAppear:animated];
    [self loadRequestData];
    [self message_recieved];
}
-(void)message_recieved
{
    [WebRequest  userashx_GetCount_MsgCodeWithuserGuid:user.Guid And:^(NSDictionary *dic) {
        if ([dic[Y_STATUS] integerValue]==200) {
            NSArray *tarr =dic[Y_ITEMS];
            arr_code = [NSMutableArray arrayWithArray:@[@"0",@"0",@"0"]];
            NSInteger temp =0;
            for (int i=0; i<tarr.count; i++) {
                NSDictionary *dic2 =tarr[i];
                if ([dic2[@"code"] integerValue]==150) {
                    //入职邀请
                    [arr_code  replaceObjectAtIndex:temp withObject:[NSString stringWithFormat:@"%ld",[arr_code[temp] integerValue] +[dic2[@"count"] integerValue]]];
                  
                        
                   
                }else if ([dic2[@"code"] integerValue]==160)
                {
                    //合同签订
                    [arr_code  replaceObjectAtIndex:temp+1 withObject:[NSString stringWithFormat:@"%ld",[arr_code[temp+1] integerValue] +[dic2[@"count"] integerValue]]];
                }else if ([dic2[@"code"] integerValue]==230)
                {//外企联络书
                    [arr_code  replaceObjectAtIndex:temp+2 withObject:[NSString stringWithFormat:@"%ld",[arr_code[temp+2] integerValue] +[dic2[@"count"] integerValue]]];
                }else
                {
                }
            }
            
            dispatch_async(dispatch_get_main_queue(), ^{
                [tableV reloadData];
            });
        }
    }];
}
-(void)loadRequestData{
            [WebRequest Com_regiInfoWithcomId:user.companyId And:^(NSDictionary *dic) {
            NSNumber *number =dic[Y_STATUS];
            if ([number integerValue]==200) {
                NSDictionary *dic2 = dic[Y_ITEMS];
                comM = [ComModel mj_objectWithKeyValues:dic2];
                [self initconifo];
                [tableV reloadSections:[NSIndexSet indexSetWithIndex:1] withRowAnimation:UITableViewRowAnimationNone];
            }
        }];

   
}

-(void)initconifo{
   arr_cominfo = [NSMutableArray arrayWithArray:@[@"企业全称",@"企业简称",@"企业logo",@"企业类型",@"所属行业",@"企业地址",@"企业邮箱"]];
    arr_cominfocontent = [NSMutableArray arrayWithArray:@[comM.name,comM.simpleName,comM.logo,comM.type,comM.hangye,comM.address,comM.email]];
    flag = [comM.creater isEqualToString:user.Guid]?1:0;
    
}
- (void)viewDidLoad {
    [super viewDidLoad];
    flag=0;
    user =[WebRequest GetUserInfo];
    self.navigationItem.title = @"我的企业";
  /*  if([user.isAdmin integerValue]>0)
    {
    arr_gongsi = [NSMutableArray arrayWithArray:@[@"注册企业",@"入职邀请",@"合同签订",@"外企联络书"]];
    }else
    {
     
    }*/
     arr_gongsi = [NSMutableArray arrayWithArray:@[@"入职邀请",@"合同签订",@"外企联络书"]];
    tableV = [[UITableView alloc]initWithFrame:CGRectMake(0, 0, DEVICE_WIDTH, DEVICE_HEIGHT) style:UITableViewStyleGrouped];
    tableV.delegate=self;
    tableV.dataSource=self;
    [self.view addSubview:tableV];
    tableV.rowHeight=60;
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(message_recieved) name:Z_FB_message_received object:nil];
    
}

#pragma  mark - 表的数据源
-(CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section
{
    return 25;
}
-(NSString*)tableView:(UITableView *)tableView titleForHeaderInSection:(NSInteger)section
{
    if (section==0) {
        return nil;
    }
    else
    {
        return @"企业信息";
    }
}
-(NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return 2;
}
-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    if (section==0) {
        return arr_gongsi.count;

    }
    else
    {
        return arr_cominfo.count;
    }
    }
-(UITableViewCell*)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    if (indexPath.section==0) {
        static NSString *cellId=@"cellID";
        RedTip_LabelTableViewCell *cell =[tableView dequeueReusableCellWithIdentifier:cellId];
        if (!cell) {
            cell = [[RedTip_LabelTableViewCell alloc]initWithStyle:UITableViewCellStyleDefault reuseIdentifier:cellId];
            cell.accessoryType=UITableViewCellAccessoryDisclosureIndicator;
            cell.textLabel.font = [UIFont systemFontOfSize:17];
        }
        cell.textLabel.text = arr_gongsi[indexPath.row];
        if ([arr_code[indexPath.row] integerValue]>0) {
            cell.L_RedTip.hidden=NO;
            cell.L_RedTip.text =arr_code[indexPath.row];
        }
return cell;
    }
    else
    {
        
        if (indexPath.row==2) {
            FBOne_img2TableViewCell *cell = [[FBOne_img2TableViewCell alloc]initWithStyle:UITableViewCellStyleDefault reuseIdentifier:nil];
            cell.accessoryType = UITableViewCellAccessoryDisclosureIndicator;
            cell.selectionStyle=UITableViewCellSelectionStyleNone;
            cell.L_left0.text =arr_cominfo[indexPath.row];
            [cell.IV_img setImageWithURL:[NSURL URLWithString:arr_cominfocontent[indexPath.row]] placeholderImage:[UIImage imageNamed:@"eqd"]];
            if (flag==1) {
                cell.accessoryType = UITableViewCellAccessoryDisclosureIndicator;
            }
            return cell;
        }
        else
        {
        static NSString *cellid2 =@"cellid2";
        FBTwo_noimg12TableViewCell  *cell = [tableView dequeueReusableCellWithIdentifier:cellid2];
        if (!cell) {
            cell = [[FBTwo_noimg12TableViewCell alloc]initWithStyle:UITableViewCellStyleDefault reuseIdentifier:cellid2];
            cell.accessoryType = UITableViewCellAccessoryNone;
            cell.selectionStyle=UITableViewCellSelectionStyleNone;
        }
            if (indexPath.row==1 && flag==1) {
               cell.accessoryType = UITableViewCellAccessoryDisclosureIndicator;
            }
        cell.L_left0.text =arr_cominfo[indexPath.row];
        cell.L_right0.text =arr_cominfocontent[indexPath.row];
            return cell;
        }
        
        
    }
   
    
    
}

#pragma  mark - 表的协议代理
-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    if (indexPath.section==0) {
    if ([user.authen integerValue]==0) {
        MBProgressHUD *hud=[MBProgressHUD showHUDAddedTo:self.view  animated:YES];
        hud.mode = MBProgressHUDModeText;
        hud.label.text =@"您未实名认证，请先实名认证";
        dispatch_time_t popTime = dispatch_time(DISPATCH_TIME_NOW, 1 * NSEC_PER_SEC);
        dispatch_after(popTime, dispatch_get_main_queue(), ^(void){
            [MBProgressHUD hideHUDForView:self.view  animated:YES];
        });
    }
    else
    {
//        NSInteger  temp = [user.isAdmin integerValue]>0?0:2;
    switch (indexPath.row+1) {
        case 0:
        {
            if ([user.authen integerValue]==1) {
                //企业注册
                if ([user.companyId integerValue]==0) {
                    GSRegisterViewController *Rvc =[[GSRegisterViewController alloc]init];
                    Rvc.phonenumber = user.Guid;
                    [self.navigationController pushViewController:Rvc animated:NO];
                }
                else
                {
                    MBProgressHUD *hud=[MBProgressHUD showHUDAddedTo:self.view  animated:YES];
                    hud.mode = MBProgressHUDModeText;
                    hud.label.text =@"您已经在公司，不能再注册";
                    dispatch_time_t popTime = dispatch_time(DISPATCH_TIME_NOW, 1 * NSEC_PER_SEC);
                    dispatch_after(popTime, dispatch_get_main_queue(), ^(void){
                        [MBProgressHUD hideHUDForView:self.view  animated:YES];
                    });
                }
            }
            else
            {
                MBProgressHUD *hud=[MBProgressHUD showHUDAddedTo:self.view  animated:YES];
                hud.mode = MBProgressHUDModeText;
                hud.label.text =@"企业注册必须实名认证";
                dispatch_time_t popTime = dispatch_time(DISPATCH_TIME_NOW, 1 * NSEC_PER_SEC);
                dispatch_after(popTime, dispatch_get_main_queue(), ^(void){
                    [MBProgressHUD hideHUDForView:self.view  animated:YES];
                });
            }
            
        }
            break;
     
        case 1:
        {
            //入驻邀请
            GSYaoQingViewController *YQvc =[[GSYaoQingViewController alloc]init];
            [self.navigationController pushViewController:YQvc animated:NO];
        }
            break;
        case 2:
        {
            //合同签订
            HeTong_listPersonViewController *Pvc =[[HeTong_listPersonViewController alloc]init];
            [self.navigationController pushViewController:Pvc animated:NO];
            
        }
            break;
            case 3:
        {
            //联络书
            LianLuoBook_OtherViewController *Ovc =[[LianLuoBook_OtherViewController alloc]init];
            [self.navigationController pushViewController:Ovc animated:NO];
            
        }
            break;
        default:
            break;
    }
        
    }
        
    }
    
    else
    {
        if (indexPath.row==1 &&flag==1) {
            //修改简称
            FBTextFieldViewController *TFvc =[[FBTextFieldViewController alloc]init];
            TFvc.contentTitle=@"修改简称";
            TFvc.content =arr_cominfocontent[indexPath.row];
            TFvc.delegate=self;
            TFvc.indexPath=indexPath;
            [self.navigationController pushViewController:TFvc animated:NO];
            
        }
        else if (indexPath.row==2 && flag==1)
        {
            //修改企业头像
            UIAlertController *alert = [[UIAlertController alloc]init];
            UIImagePickerController *picker =[[UIImagePickerController alloc]init];
            picker.delegate =self;
            picker.allowsEditing=YES;
            [alert addAction:[UIAlertAction actionWithTitle:@"相册" style:UIAlertActionStyleDefault handler:^(UIAlertAction * _Nonnull action) {
                if ([UIImagePickerController isSourceTypeAvailable:UIImagePickerControllerSourceTypePhotoLibrary]) {
                    [UIImagePickerController availableMediaTypesForSourceType:UIImagePickerControllerSourceTypePhotoLibrary];
                    dispatch_async(dispatch_get_main_queue(), ^{
                        [self presentViewController:picker animated:NO completion:nil];
                    });
                }
                else
                {
                    MBProgressHUD *hud=[MBProgressHUD showHUDAddedTo:self.view  animated:YES];
                    hud.mode = MBProgressHUDModeText;
                    hud.label.text =@"请前往设置->隐私->照片 修改权限";
                    dispatch_time_t popTime = dispatch_time(DISPATCH_TIME_NOW, 1 * NSEC_PER_SEC);
                    dispatch_after(popTime, dispatch_get_main_queue(), ^(void){
                        [MBProgressHUD hideHUDForView:self.view  animated:YES];
                    });
                }
            }]];
            [alert addAction:[UIAlertAction actionWithTitle:@"相机" style:UIAlertActionStyleDefault handler:^(UIAlertAction * _Nonnull action) {
                if ([UIImagePickerController isSourceTypeAvailable:UIImagePickerControllerSourceTypeCamera]) {
                    [UIImagePickerController availableMediaTypesForSourceType:UIImagePickerControllerSourceTypeCamera];
                    dispatch_async(dispatch_get_main_queue(), ^{
                        [self presentViewController:alert animated:NO completion:nil];
                    });
                }
                else
                {
                    MBProgressHUD *hud=[MBProgressHUD showHUDAddedTo:self.view  animated:YES];
                    hud.mode = MBProgressHUDModeText;
                    hud.label.text =@"请前往设置->隐私->相机 修改权限";
                    dispatch_time_t popTime = dispatch_time(DISPATCH_TIME_NOW, 1 * NSEC_PER_SEC);
                    dispatch_after(popTime, dispatch_get_main_queue(), ^(void){
                        [MBProgressHUD hideHUDForView:self.view  animated:YES];
                    });
                }
            }]];
            [alert addAction:[UIAlertAction actionWithTitle:@"取消" style:UIAlertActionStyleCancel handler:^(UIAlertAction * _Nonnull action) {
                
            }]];
            dispatch_async(dispatch_get_main_queue(), ^{
                [self presentViewController:alert animated:NO completion:nil];
            });

        }
        else
        {
            
        }
    }
}

-(void)imagePickerController:(UIImagePickerController *)picker didFinishPickingMediaWithInfo:(NSDictionary<NSString *,id> *)info
{
    UIImage *image =[info objectForKey:UIImagePickerControllerEditedImage];
    [self dismissViewControllerAnimated:NO completion:^{
        
        MBProgressHUD *hud = [MBProgressHUD showHUDAddedTo:self.view animated:YES];
        hud.mode = MBProgressHUDModeAnnularDeterminate;
        hud.label.text = @"正在修改";
        [WebRequest  Com_alterLogoWithuserGuid:user.Guid comId:user.companyId img:image And:^(NSDictionary *dic) {
            hud.label.text = dic[Y_MSG];
            dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(1 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
                [hud hideAnimated:NO];
                [self loadRequestData];
            });
        }];
    }];
    
}
#pragma mark -自定义的协议代理
-(void)content:(NSString *)content WithindexPath:(NSIndexPath *)indexPath
{
    MBProgressHUD *hud = [MBProgressHUD showHUDAddedTo:self.view animated:YES];
    hud.mode = MBProgressHUDModeAnnularDeterminate;
    hud.label.text = @"正在修改";
    [WebRequest Com_alterSimpleNameWithuserGuid:user.Guid comId:user.companyId simpleName:content And:^(NSDictionary *dic) {
        hud.label.text=dic[Y_MSG];
        dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(0.5 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
            [hud hideAnimated:NO];
            [self loadRequestData];
        });
    }];
    
}

@end
