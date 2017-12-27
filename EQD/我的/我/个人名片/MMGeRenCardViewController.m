//
//  MMGeRenCardViewController.m
//  YiQiDian
//
//  Created by 梁新帅 on 2017/3/16.
//  Copyright © 2017年 FitBoy. All rights reserved.
//

#import "MMGeRenCardViewController.h"
#import "WebRequest.h"
#import "FBMyErWeiMaViewController.h"
#import "FBConversationViewControllerViewController.h"
#import "Com_UserModel.h"
#import "FBOne_img2TableViewCell.h"
#import <UIImageView+AFNetworking.h>
#import "FBTwo_noimg12TableViewCell.h"
#import "FBTextFieldViewController.h"
#import "FBAddressTwoViewController.h"
#import "FBTextVViewController.h"
#import "SJieBangPhoneViewController.h"
#import <RongIMKit/RongIMKit.h>
@interface MMGeRenCardViewController ()<UITableViewDelegate,UITableViewDataSource,UINavigationControllerDelegate, UIImagePickerControllerDelegate,FBTextFieldViewControllerDelegate,FBAddressTwoViewControllerDelegate,FBTextVViewControllerDelegate>
{
    UITableView *tableV;
    
    NSMutableArray *arr_names;
    NSMutableArray *arr_contents;
    
    NSMutableArray *arr_names1;
    NSMutableArray *arr_names2;
    NSMutableArray *arr_names3;
    NSMutableArray *arr_big;
    UserModel *user;
    Com_UserModel *model ;
    
}

@end

@implementation MMGeRenCardViewController
-(void)viewWillAppear:(BOOL)animated{
    [super viewWillAppear:animated];
    [self loadRequestData];
}
-(void)loadRequestData{
    [WebRequest Com_User_BusinessCardWithuserGuid:user.Guid And:^(NSDictionary *dic) {
        NSNumber *number = dic[Y_STATUS];
        if ([number integerValue]==200) {
            NSDictionary *dic1=dic[Y_ITEMS];
            model = [Com_UserModel mj_objectWithKeyValues:dic1];
            if (model.location.length<2) {
                NSArray  *tarr = [USERDEFAULTS objectForKey:Y_AMAP_cityProvince];
                NSString *address = [USERDEFAULTS objectForKey:Y_AMAP_address];
                if (address!=nil) {
                    [WebRequest  Update_loginLocationWithuserGuid:user.Guid loginLocation:address province:tarr[0] city:tarr[1] And:^(NSDictionary *dic) {
                        
                    }];
                }
               
            }
            NSMutableDictionary *dic2 =[NSMutableDictionary dictionaryWithDictionary:[USERDEFAULTS objectForKey:Y_USERINFO]];
            [dic2 setObject:model.upname forKey:@"upname"];
            [dic2 setObject:model.photo forKey:@"iphoto"];
            [dic2 setObject:model.Signature forKey:@"Signature"];
            [USERDEFAULTS setObject:dic2 forKey:Y_USERINFO];
            [USERDEFAULTS synchronize];
            dispatch_async(dispatch_get_main_queue(), ^{
                RCUserInfo *info = [[RCUserInfo alloc]initWithUserId:model.userGuid name:model.upname portrait:model.photo];
                [[RCIM sharedRCIM] refreshUserInfoCache:info withUserId:model.userGuid];
                [tableV reloadData];
            });
        }
        else
        {
            MBProgressHUD *hud=[MBProgressHUD showHUDAddedTo:self.view  animated:YES];
            hud.mode = MBProgressHUDModeText;
            hud.label.text =@"服务器错误";
            dispatch_time_t popTime = dispatch_time(DISPATCH_TIME_NOW, 1 * NSEC_PER_SEC);
            dispatch_after(popTime, dispatch_get_main_queue(), ^(void){
                [MBProgressHUD hideHUDForView:self.view  animated:YES];
            });
        }
    }];
}



- (void)viewDidLoad {
    [super viewDidLoad];
    user = [WebRequest GetUserInfo];
    self.title = @"个人资料";
    arr_names = [NSMutableArray arrayWithArray:@[@"头像",@"昵称",@"易企点号",@"二维码"]];
    
    arr_names1 = [NSMutableArray arrayWithArray:@[@"手机号",@"地区"]];
    arr_names2 = [NSMutableArray arrayWithArray:@[@"公司",@"部门/职务"]];
    arr_names3 = [NSMutableArray arrayWithArray:@[@"个性签名"]];
    arr_big = [NSMutableArray arrayWithCapacity:0];
    [arr_big addObject:arr_names];
    [arr_big addObject:arr_names1];
    [arr_big addObject:arr_names2];
    [arr_big addObject:arr_names3];
    tableV = [[UITableView alloc]initWithFrame:CGRectMake(0, 0, DEVICE_WIDTH, DEVICE_HEIGHT) style:UITableViewStyleGrouped];
    tableV.delegate=self;
    tableV.dataSource=self;
    [self.view addSubview:tableV];
    tableV.rowHeight=50;
    
}

#pragma  mark - 表的数据源
-(NSInteger)numberOfSectionsInTableView:(UITableView *)tableView{
    return arr_big.count;
}
-(CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section
{
    return 15;
}
-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    NSArray *arr = arr_big[section];
    return arr.count;
}
-(UITableViewCell*)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    if (indexPath.section==0) {
        if (indexPath.row==0 || indexPath.row==3) {
            static NSString *cellid13 =@"cellid13";
            FBOne_img2TableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:cellid13];
            if (!cell) {
                cell = [[FBOne_img2TableViewCell alloc]initWithStyle:UITableViewCellStyleDefault reuseIdentifier:cellid13];
                cell.accessoryType = UITableViewCellAccessoryDisclosureIndicator;
            }
            cell.L_left0.text=arr_names[indexPath.row];
            if (indexPath.row==0) {
                [cell.IV_img setImageWithURL:[NSURL URLWithString:model?model.photo:@"0"] placeholderImage:[UIImage imageNamed:@"no_login_head"]];
                
            }
            else
            {
                cell.IV_img.image=[UIImage imageNamed:@"erweimalogo"];
                cell.IV_img.layer.cornerRadius=1;
            }
            
            return cell;
        }
        else
        {
            static NSString *cellid23 = @"cellid23";
            FBTwo_noimg12TableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:cellid23];
            if (!cell) {
                cell = [[FBTwo_noimg12TableViewCell alloc]initWithStyle:UITableViewCellStyleDefault reuseIdentifier:cellid23];
                cell.accessoryType =UITableViewCellAccessoryDisclosureIndicator;
            }
            cell.L_left0.text =arr_names[indexPath.row];
            if (model) {
                cell.L_right0.text = indexPath.row==1?model.upname:model.EQDCode;
            }
            else
            {
                cell.L_right0.text =@"";
            }
            
            return cell;
        }
    }else if (indexPath.section==3)
    {
        static NSString *cellid30 = @"cellid30";
        FBTwo_noimg12TableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:cellid30];
        if (!cell) {
            cell = [[FBTwo_noimg12TableViewCell alloc]initWithStyle:UITableViewCellStyleSubtitle reuseIdentifier:cellid30];
            cell.accessoryType =UITableViewCellAccessoryDisclosureIndicator;
            cell.textLabel.font = [UIFont systemFontOfSize:17];
        }
        cell.L_right0.font =[UIFont systemFontOfSize:13];
        cell.textLabel.text =arr_names3[indexPath.row];
        cell.L_right0.text =model.Signature;
        return cell;
    }
    else
    {
    static NSString *cellid212=@"cellid212";
        FBTwo_noimg12TableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:cellid212];
        if (!cell) {
            cell = [[FBTwo_noimg12TableViewCell alloc]initWithStyle:UITableViewCellStyleDefault reuseIdentifier:cellid212];
            cell.accessoryType=UITableViewCellAccessoryDisclosureIndicator;
        }
        if (indexPath.section==1) {
            cell.L_left0.text =arr_names1[indexPath.row];
            
            if(model)
            {
                NSString *tstr = [model.location isEqualToString:@"0"]?@"":model.location;
                cell.L_right0.text =indexPath.row==0?model.uname:tstr;
            }
            else
            {
                cell.L_right0.text =@"";
            }
            
        }
        else
        {
            cell.accessoryType =UITableViewCellAccessoryNone;
            cell.L_left0.text =arr_names2[indexPath.row];
            if (model) {
                NSString *tcompany = model.company.length>1?model.company:@"";
                
                NSString *tbumen =model.department.length>1?model.department:@"";
                NSString *tzhiwei =model.post.length>1?model.post:@"";
                cell.L_right0.text = indexPath.row==0?tcompany:[NSString stringWithFormat:@"%@/%@",tbumen,tzhiwei];
            }
            else
            {
                cell.L_right0.text=@"";
            }
        }
    return cell;
    }
}




#pragma  mark - 表的协议代理
-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    switch (indexPath.section) {
        case 0:
        {
            if (indexPath.row==0) {
               //头像
                UIImagePickerController *picker =[[UIImagePickerController alloc]init];
                picker.delegate=self;
                picker.allowsEditing=YES;
                UIAlertController *alert = [[UIAlertController alloc]init];
                [alert addAction:[UIAlertAction actionWithTitle:@"相册" style:UIAlertActionStyleDefault handler:^(UIAlertAction * _Nonnull action) {
                   if( [UIImagePickerController isSourceTypeAvailable:UIImagePickerControllerSourceTypePhotoLibrary])
                   {
                       picker.sourceType=UIImagePickerControllerSourceTypePhotoLibrary;
                       [self presentViewController:picker animated:NO completion:nil];
                   }
                    else
                    {
                        MBProgressHUD *hud=[MBProgressHUD showHUDAddedTo:self.view  animated:YES];
                        hud.mode = MBProgressHUDModeText;
                        hud.label.text =@"请前往设置->隐私->照片修改权限";
                        dispatch_time_t popTime = dispatch_time(DISPATCH_TIME_NOW, 1 * NSEC_PER_SEC);
                        dispatch_after(popTime, dispatch_get_main_queue(), ^(void){
                            [MBProgressHUD hideHUDForView:self.view  animated:YES];
                        });
                    }
                }]];
                [alert addAction:[UIAlertAction actionWithTitle:@"相机" style:UIAlertActionStyleDefault handler:^(UIAlertAction * _Nonnull action) {
                    if ([UIImagePickerController isSourceTypeAvailable:UIImagePickerControllerSourceTypeCamera]) {
                        picker.sourceType = UIImagePickerControllerSourceTypeCamera;
                        [self presentViewController:picker animated:NO completion:nil];
                        
                    }
                    else{
                        MBProgressHUD *hud=[MBProgressHUD showHUDAddedTo:self.view  animated:YES];
                        hud.mode = MBProgressHUDModeText;
                        hud.label.text =@"请前往设置->隐私->相机修改权限";
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
            else if(indexPath.row==1)
            {
               //昵称
                FBTextFieldViewController *TFvc =[[FBTextFieldViewController alloc]init];
                TFvc.delegate=self;
                TFvc.indexPath=indexPath;
                TFvc.contentTitle = @"修改昵称";
                TFvc.content = model?model.upname:@"";
                [self.navigationController pushViewController:TFvc animated:NO];
                
            }
            else if(indexPath.row==2)
            {
               //易企点号
                FBTextFieldViewController  *TFvc =[[FBTextFieldViewController alloc]init];
                TFvc.indexPath =indexPath;
                TFvc.delegate =self;
                TFvc.contentTitle =@"修改易企点号";
                TFvc.content = model.EQDCode;
                TFvc.contentTishi =@"1.字母开头，允许5-16字节，允许字母数字下划线\n2.易企点号只能修改一次，不允许修改多次";
                [self.navigationController pushViewController:TFvc animated:NO];
                
            }
            else if (indexPath.row==3)
            {
              //二维码
                FBMyErWeiMaViewController *EWvc = [[FBMyErWeiMaViewController alloc]init];
                [self.navigationController pushViewController:EWvc animated:NO];
            }
            else
            {
                
            }
        }
            break;
            case 1:
        {
            if(indexPath.row==0)
            {
                //手机号
                SJieBangPhoneViewController *Jvc =[[SJieBangPhoneViewController alloc]init];
                [self.navigationController pushViewController:Jvc animated:NO];
            }
            else
            {
               //地区
                FBAddressTwoViewController *ATvc =[[FBAddressTwoViewController alloc]init];
                ATvc.indexPath=indexPath;
                ATvc.delegate=self;
                [self.navigationController pushViewController:ATvc animated:NO];
            }
        }
            break;
            case 2:
        {
            
        }
            break;
            case 3:
        {
            if (indexPath.row==0) {
                //修改个性签名
                FBTextVViewController *TVvc =[[FBTextVViewController alloc]init];
                TVvc.delegate =self;
                TVvc.contentTitle = @"个性签名";
                TVvc.content = model.Signature;
                TVvc.S_maxnum=@"30";
                TVvc.indexpath =indexPath;
                [self.navigationController pushViewController:TVvc animated:NO];
            }
        }
            break;
        default:
            break;
    }
}
#pragma mark - 相机的协议代理
-(void)imagePickerController:(UIImagePickerController *)picker didFinishPickingMediaWithInfo:(NSDictionary<NSString *,id> *)info
{
    UIImage *image = [info objectForKey:UIImagePickerControllerEditedImage];
    [self dismissViewControllerAnimated:NO completion:^{
        [WebRequest User_Update_HeadimageWithuser:user.uname userGuid:user.Guid img:image And:^(NSDictionary *dic) {
                [self loadRequestData];
            
        }];
        
    }];
    
}

-(void)content:(NSString *)content WithindexPath:(NSIndexPath *)indexPath
{
    if(indexPath.row==1)
    {
   [WebRequest userashx_Update_upnameWithuserGuid:user.Guid upname:content And:^(NSDictionary *dic) {
       NSNumber *number =dic[Y_STATUS];
       if ([number integerValue]==200) {
           [arr_contents replaceObjectAtIndex:indexPath.row withObject:content];
           [tableV reloadRowsAtIndexPaths:@[indexPath] withRowAnimation:UITableViewRowAnimationNone];
           [WebRequest updateUserinfoWithKey:@"upname" value:content];
           
           
       }
   }];
    }else
    {
        MBProgressHUD *hud = [MBProgressHUD showHUDAddedTo:self.view animated:YES];
        hud.mode = MBProgressHUDModeAnnularDeterminate;
        hud.label.text = @"正在修改";
        [WebRequest  userashx_Update_EQDCodeWithuserGuid:user.Guid eqdCodeNew:content And:^(NSDictionary *dic) {
            hud.label.text =dic[Y_MSG];
            NSNumber *number =dic[Y_STATUS];
            if ([number integerValue]==200) {
                [arr_contents replaceObjectAtIndex:indexPath.row withObject:content];
                [tableV reloadRowsAtIndexPaths:@[indexPath] withRowAnimation:UITableViewRowAnimationNone];
                [WebRequest updateUserinfoWithKey:@"EQDCode" value:content];
               
            }
            dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(0.7 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
                [hud hideAnimated:NO];
            });
        }];
    }
    
}
-(void)address2:(NSString *)address indexPath:(NSIndexPath *)indexpath arr_address:(NSArray *)arr_address
{
    [WebRequest Update_loginLocationWithuserGuid:user.Guid loginLocation:address province:arr_address[0] city:arr_address[1]  And:^(NSDictionary *dic) {
        if ([dic[Y_STATUS] integerValue]==200) {
            [arr_contents replaceObjectAtIndex:indexpath.row withObject:address];
            [tableV reloadRowsAtIndexPaths:@[indexpath] withRowAnimation:UITableViewRowAnimationNone];
        }
       
    }];
    
}
-(void)textVtext:(NSString *)text indexPath:(NSIndexPath *)indexPath
{
    //修改个性签名
    MBProgressHUD *hud = [MBProgressHUD showHUDAddedTo:self.view animated:YES];
    hud.mode = MBProgressHUDModeAnnularDeterminate;
    hud.label.text = @"正在修改";
    [WebRequest Com_Update_UserSignatureWithuserGuid:user.Guid signature:text And:^(NSDictionary *dic) {
        hud.label.text =dic[Y_MSG];
        if ([dic[Y_STATUS] integerValue]==200) {
            [arr_contents replaceObjectAtIndex:indexPath.row withObject:text];
            [tableV reloadRowsAtIndexPaths:@[indexPath] withRowAnimation:UITableViewRowAnimationNone];
            [WebRequest updateUserinfoWithKey:@"Signature" value:text];
        }
        dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(1 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
            [hud hideAnimated:NO];
        });
    }];
    
}

@end
