//
//  MyDangAn1ViewController.m
//  YiQiDian
//
//  Created by 梁新帅 on 2017/3/9.
//  Copyright © 2017年 FitBoy. All rights reserved.
//

#import "MyDangAn1ViewController.h"
#import "WebRequest.h"
#import "GeRenView.h"
#import "FBTextFieldViewController.h"
#import "FBOptionViewController.h"
#import "FBTextVViewController.h"
#import "TrueBrthdayViewController.h"
#import "FBOptionViewController.h"
#import "FBAddressViewController.h"
#import <RongIMKit/RongIMKit.h>
#import <UIButton+AFNetworking.h>
#import "DAEngllishViewController.h"
#import "WorkExprienceViewController.h"
#import "ProjectExprienceViewController.h"

#import "NSString+FBString.h"
@interface MyDangAn1ViewController ()<UITableViewDelegate,UITableViewDataSource,UINavigationControllerDelegate, UIImagePickerControllerDelegate,FBTextFieldViewControllerDelegate,FBOptionViewControllerDelegate,FBTextVViewControllerDelegate,TrueBrthdayViewControllerDelegate,FBOptionViewControllerDelegate,FBAddressViewControllerDelegate,DAEngllishViewControllerDelegate>
{
    UITableView *tableV;
    NSMutableArray *arr_big;
    NSMutableArray *arr_bigcontent;
    NSMutableArray *arr_title;
    GeRenView *GRV;
    UserModel *user;
    NSMutableDictionary *dic2;
    NSInteger flag;
}


@end
@implementation MyDangAn1ViewController
-(void)viewWillAppear:(BOOL)animated{
    [super viewWillAppear:animated];
    self.navigationController.navigationBarHidden=NO;
    [self loadRequestData];
}
-(void)loadRequestData{
    
    [WebRequest User_StaffInfoWithuserGuid:user.Guid password:self.password And:^(NSDictionary *dic) {
        
        NSNumber *number = dic[Y_STATUS];
        if ([number integerValue]==200) {
            dic2 =[NSMutableDictionary dictionaryWithDictionary:dic[Y_ITEMS]];
            flag=1;
            dispatch_async(dispatch_get_main_queue(), ^{
                [GRV.B_headimg setBackgroundImageForState:UIControlStateNormal withURL:[NSURL URLWithString:dic2[@"uiphoto"]] placeholderImage:[UIImage imageNamed:@"no_login_head"]];
                [tableV reloadData];
            });
        }
        else
        {
            MBProgressHUD *hud=[MBProgressHUD showHUDAddedTo:self.view  animated:YES];
            hud.mode = MBProgressHUDModeText;
            hud.label.text =@"未知错误";
            dispatch_time_t popTime = dispatch_time(DISPATCH_TIME_NOW, 1 * NSEC_PER_SEC);
            dispatch_after(popTime, dispatch_get_main_queue(), ^(void){
                [MBProgressHUD hideHUDForView:self.view  animated:YES];
            });
        }
        
        
    }];
    
}
- (void)viewDidLoad {
    [super viewDidLoad];
    user =[WebRequest GetUserInfo];
    flag =0;
    self.navigationItem.title =@"个人档案";
    self.view.layer.backgroundColor =[UIColor whiteColor].CGColor;
    arr_title =[NSMutableArray arrayWithArray:@[@"个人基本信息",@"联系方式",@"学历与技能",@"工作履历"]];
    arr_big =[NSMutableArray arrayWithCapacity:0];
      NSMutableArray *arr_one =[NSMutableArray arrayWithArray:@[@"姓名",@"性别",@"民族",@"出生日期",@"生日",@"户口性质",@"户籍地址",@"现住址",@"婚配",@"生肖",@"身高(cm)",@"体重(kg)",@"血型",@"宗教信仰",@"政治面貌",@"兴趣爱好"]];
    arr_bigcontent =[NSMutableArray arrayWithCapacity:0];
    NSMutableArray *arr_onecontents =[NSMutableArray arrayWithArray:@[@"uname",@"usex",@"unation",@"udate",@"urdate",@"uhousetype",@"uhouseadress",@"upadress",@"umarry",@"uczodia",@"uheigh",@"uweigh",@"ublood",@"ubelief",@"upoliticstate",@"uinterest"]];
    NSMutableArray *arr_twocontents =[NSMutableArray arrayWithArray:@[@"uptel",@"uqq",@"uwchat",@"umail",@"ucontactname",@"uscontactrelat",@"uscontact"]];
    NSMutableArray *arr_threecontents =[NSMutableArray arrayWithArray:@[@"ugrad",@"umajor",@"uedu",@"upskill",@"uforeignclass"]];
    [arr_bigcontent addObject:arr_onecontents];
    [arr_bigcontent addObject:arr_twocontents];
    [arr_bigcontent addObject:arr_threecontents];

    NSMutableArray *arr_two = [NSMutableArray arrayWithArray:@[@"个人电话",@"QQ",@"微信",@"邮箱",@"紧急联系人",@"与紧急联系人的关系",@"紧急联系人电话"]];
    
    
    NSMutableArray *arr_three =[NSMutableArray arrayWithArray:@[@"毕业院校",@"专业",@"文化程度",@"职业资格",@"外语等级"]];
   
    
    NSMutableArray *arr_four =[NSMutableArray arrayWithArray:@[@"工作经历",@"项目经验"]];
    NSMutableArray *arr_fourcontents =[NSMutableArray arrayWithCapacity:0];
    
    [arr_bigcontent addObject:arr_fourcontents];
    
    
    
    [arr_big addObject:arr_one];
    [arr_big addObject:arr_two];
    [arr_big addObject:arr_three];
    [arr_big addObject:arr_four];
    tableV = [[UITableView alloc]initWithFrame:CGRectMake(0, 0, DEVICE_WIDTH, DEVICE_HEIGHT) style:UITableViewStyleGrouped];
    tableV.delegate=self;
    tableV.dataSource=self;
    [self.view addSubview:tableV];
    tableV.rowHeight=60;
   GRV =[[GeRenView alloc]init];
    GRV.frame =CGRectMake(0, 0, DEVICE_WIDTH, 90);
    tableV.tableHeaderView =GRV;
    
   GRV.L_content.text =[NSString stringWithFormat:@"工号:%@",user.jobNumber];
    [GRV.B_headimg addTarget:self action:@selector(zhengjianzhaoClick) forControlEvents:UIControlEventTouchUpInside];
    
    
}
-(void)zhengjianzhaoClick
{
    UIImagePickerController *pickerC =[[UIImagePickerController alloc]init];
    pickerC.allowsEditing=YES;
    pickerC.delegate =self;
    UIAlertController *alert =[[UIAlertController alloc]init];
    [alert addAction:[UIAlertAction actionWithTitle:@"相册" style:UIAlertActionStyleDefault handler:^(UIAlertAction * _Nonnull action) {
        if ([UIImagePickerController isSourceTypeAvailable:UIImagePickerControllerSourceTypePhotoLibrary]) {
            pickerC.sourceType =UIImagePickerControllerSourceTypePhotoLibrary;
            dispatch_async(dispatch_get_main_queue(), ^{
                [self presentViewController:pickerC animated:NO completion:nil];
            });
            
        }
        else
        {
            MBProgressHUD *hud=[MBProgressHUD showHUDAddedTo:self.view.window animated:YES];
            hud.mode = MBProgressHUDModeText;
            hud.label.text =@"拒绝了访问相册";
            dispatch_time_t popTime = dispatch_time(DISPATCH_TIME_NOW, 1 * NSEC_PER_SEC);
            dispatch_after(popTime, dispatch_get_main_queue(), ^(void){
                [MBProgressHUD hideHUDForView:self.view.window animated:YES];
            });
        }
        
    }]];
    [alert addAction:[UIAlertAction actionWithTitle:@"相机" style:UIAlertActionStyleDefault handler:^(UIAlertAction * _Nonnull action) {
        if ([UIImagePickerController isSourceTypeAvailable:UIImagePickerControllerSourceTypeCamera]) {
            pickerC.sourceType =UIImagePickerControllerSourceTypeCamera;
            dispatch_async(dispatch_get_main_queue(), ^{
                [self presentViewController:pickerC animated:NO completion:nil];
            });
            
        }
        else
        {
            MBProgressHUD *hud=[MBProgressHUD showHUDAddedTo:self.view.window animated:YES];
            hud.mode = MBProgressHUDModeText;
            hud.label.text =@"拒绝了访问相机";
            dispatch_time_t popTime = dispatch_time(DISPATCH_TIME_NOW, 1 * NSEC_PER_SEC);
            dispatch_after(popTime, dispatch_get_main_queue(), ^(void){
                [MBProgressHUD hideHUDForView:self.view.window animated:YES];
            });
        }
        
        
    }]];
    [alert addAction:[UIAlertAction actionWithTitle:@"取消" style:UIAlertActionStyleCancel handler:^(UIAlertAction * _Nonnull action) {
        
    }]];
    dispatch_async(dispatch_get_main_queue(), ^{
        [self presentViewController:alert animated:NO completion:nil];
    });
    
}


-(void)imagePickerController:(UIImagePickerController *)picker didFinishPickingMediaWithInfo:(NSDictionary<NSString *,id> *)info
{
    UIImage *image =[info objectForKey:UIImagePickerControllerEditedImage];
    [WebRequest userashx_Update_UserIphotoWithtel:user.uname userGuid:user.Guid image:image And:^(NSDictionary *dic) {
        MBFadeAlertView  *alert = [[MBFadeAlertView alloc]init];
        [alert showAlertWith:dic[Y_MSG]];
        if ([dic[Y_STATUS] integerValue]==200) {
            [GRV.B_headimg setBackgroundImage:image forState:UIControlStateNormal];
        }
    }];
    
    
  
    [self dismissViewControllerAnimated:NO completion:nil];
    
}

#pragma  mark - 表的数据源
-(NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return arr_big.count;
}
-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    NSArray *arr =arr_big[section];
    return arr.count;
}
-(UITableViewCell*)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    if (indexPath.section<3) {
        static NSString *cellId=@"cellID";
        UITableViewCell *cell =[tableView dequeueReusableCellWithIdentifier:cellId];
        if (!cell) {
            cell = [[UITableViewCell alloc]initWithStyle:UITableViewCellStyleValue1 reuseIdentifier:cellId];
            cell.accessoryType = UITableViewCellAccessoryDisclosureIndicator;
            cell.textLabel.font = [UIFont systemFontOfSize:17];
        }
        NSArray *arr =arr_big[indexPath.section];
        if (indexPath.section==0) {
            if (indexPath.row<5 ||indexPath.row==6 ) {
                cell.accessoryType =UITableViewCellAccessoryNone;
                cell.selectionStyle =UITableViewCellSelectionStyleNone;
            }else
            {
                cell.accessoryType =UITableViewCellAccessoryDisclosureIndicator;
                cell.selectionStyle =UITableViewCellSelectionStyleDefault;
            }
        }
        else
        {
            cell.accessoryType = UITableViewCellAccessoryDisclosureIndicator;
        }
        if (flag==1) {
            if(indexPath.section<3)
            {
                NSArray *arr1 =arr_bigcontent[indexPath.section];
                cell.detailTextLabel.text =[NSString stringWithFormat:@"%@",dic2[arr1[indexPath.row]]];
                if (indexPath.section==0 ) {
                    if (indexPath.row==1 ) {
                        //性别
                        if([dic2[arr1[indexPath.row]] integerValue]==0)
                        {
                            cell.detailTextLabel.text = @"男";
                        }
                        else
                        {
                            cell.detailTextLabel.text = @"女";
                        }
                    }else if (indexPath.row==3)
                    {
                        NSString *tstr =dic2[arr1[indexPath.row]] ;
                        cell.detailTextLabel.text =[[tstr formatDateString] componentsSeparatedByString:@" "][0];
                    }
                }
            }
            else
            {
                cell.detailTextLabel.text=nil;
                
            }
        }
        
        cell.textLabel.text =arr[indexPath.row];
        return cell;
    }
   
    else
    {
        //工作履历
        static NSString *cellId=@"cellID1";
        UITableViewCell *cell1 =[tableView dequeueReusableCellWithIdentifier:cellId];
        if (!cell1) {
            cell1 = [[UITableViewCell alloc]initWithStyle:UITableViewCellStyleValue1 reuseIdentifier:cellId];
            cell1.accessoryType = UITableViewCellAccessoryDisclosureIndicator;
        }
            cell1.textLabel.text =arr_big[indexPath.section][indexPath.row];
            cell1.textLabel.font = [UIFont systemFontOfSize:17];
        return cell1;
    }

}



-(UIView*)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section
{
    UILabel *tlabel =[[UILabel alloc]init];
    tlabel.text =arr_title[section];
    tlabel.textColor=[UIColor whiteColor];
    tlabel.font =[UIFont systemFontOfSize:24];
    tlabel.backgroundColor =EQDCOLOR;
    return tlabel;
    
}
-(CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section
{
    return 30;
}
#pragma  mark - 表的协议代理
-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    NSArray *arr =arr_big[indexPath.section];
    NSArray *arr2 =arr_bigcontent[indexPath.section];
    if (indexPath.section==0) {
//        if (indexPath.row==4) {
//            //生日
//            TrueBrthdayViewController *Tvc =[[TrueBrthdayViewController alloc]init];
//            Tvc.delegate =self;
//            Tvc.indexpath =indexPath;
//            Tvc.content = arr[indexPath.row];
//            [self.navigationController pushViewController:Tvc animated:NO];
//            
//        }
        if (indexPath.row==5) {
            //户口性质
            FBOptionViewController *Ovc =[[FBOptionViewController alloc]init];
            Ovc.indexPath=indexPath;
            Ovc.delegate=self;
            Ovc.option=20;
            Ovc.contentTitle =arr[indexPath.row];
            [self.navigationController pushViewController:Ovc animated:NO];
        }

        else if(indexPath.row==7){
            //现住址
            FBAddressViewController *ADvc =[[FBAddressViewController alloc]init];
            ADvc.delegate =self;
            ADvc.indexPath=indexPath;
            ADvc.isXiangXi=YES;
            [self.navigationController pushViewController:ADvc animated:NO];
        }
        else if(indexPath.row==8)
        {
            //婚配
            FBOptionViewController *Ovc =[[FBOptionViewController alloc]init];
            Ovc.indexPath=indexPath;
            Ovc.delegate=self;
            Ovc.option=22;
            Ovc.contentTitle =arr[indexPath.row];
            [self.navigationController pushViewController:Ovc animated:NO];
            
        }
        else if(indexPath.row==9){
            //生肖
            FBOptionViewController *ovc =[[FBOptionViewController alloc]init];
            ovc.indexPath=indexPath;
            ovc.delegate =self;
            ovc.option=21;
            ovc.contentTitle =arr[indexPath.row];
            [self.navigationController pushViewController:ovc animated:NO];
            
        }
        else if(indexPath.row ==10|| indexPath.row ==11)
        {
            
            //身高 体重
            FBTextFieldViewController *TFvc =[[FBTextFieldViewController alloc]init];
            TFvc.delegate =self;
            TFvc.indexPath =indexPath;
            TFvc.content = [NSString stringWithFormat:@"%@",dic2[arr2[indexPath.row]]];
            TFvc.contentTitle =arr[indexPath.row];
            [self.navigationController pushViewController:TFvc animated:NO];
            
        }
        
        else if(indexPath.row==13)
        {
            //宗教信仰
            UIAlertController *alert = [[UIAlertController alloc]init];
           [alert addAction:[UIAlertAction actionWithTitle:@"无" style:UIAlertActionStyleDefault handler:^(UIAlertAction * _Nonnull action) {
               [self xiugaiWithcongtent:action.title indexpath:indexPath];
           }]];
            [alert addAction:[UIAlertAction actionWithTitle:@"基督教" style:UIAlertActionStyleDefault handler:^(UIAlertAction * _Nonnull action) {
                 [self xiugaiWithcongtent:action.title indexpath:indexPath];
            }]];
            [alert addAction:[UIAlertAction actionWithTitle:@"天主教" style:UIAlertActionStyleDefault handler:^(UIAlertAction * _Nonnull action) {
                 [self xiugaiWithcongtent:action.title indexpath:indexPath];
            }]];
            [alert addAction:[UIAlertAction actionWithTitle:@"伊斯兰教" style:UIAlertActionStyleDefault handler:^(UIAlertAction * _Nonnull action) {
                 [self xiugaiWithcongtent:action.title indexpath:indexPath];
            }]];
            [alert addAction:[UIAlertAction actionWithTitle:@"佛教" style:UIAlertActionStyleDefault handler:^(UIAlertAction * _Nonnull action) {
                 [self xiugaiWithcongtent:action.title indexpath:indexPath];
            }]];
            [alert addAction:[UIAlertAction actionWithTitle:@"道教" style:UIAlertActionStyleDefault handler:^(UIAlertAction * _Nonnull action) {
                 [self xiugaiWithcongtent:action.title indexpath:indexPath];
            }]];
            [alert addAction:[UIAlertAction actionWithTitle:@"犹太教" style:UIAlertActionStyleDefault handler:^(UIAlertAction * _Nonnull action) {
                 [self xiugaiWithcongtent:action.title indexpath:indexPath];
            }]];
            [alert addAction:[UIAlertAction actionWithTitle:@"其他" style:UIAlertActionStyleDefault handler:^(UIAlertAction * _Nonnull action) {
                 [self xiugaiWithcongtent:action.title indexpath:indexPath];
            }]];
            dispatch_async(dispatch_get_main_queue(), ^{
                [self presentViewController:alert animated:NO completion:nil];
            });
            
            
        }
        
        else if(indexPath.row==12)
        {
            //血型
            UIAlertController *alert =[[UIAlertController alloc]init];
            NSArray  *tarr = @[@"A型",@"B型",@"AB型",@"O型",@"未知"];
            for (int i=0; i<tarr.count; i++) {
                [alert addAction:[UIAlertAction actionWithTitle:tarr[i] style:UIAlertActionStyleDefault handler:^(UIAlertAction * _Nonnull action) {
                    [self xiugaiWithcongtent:action.title indexpath:indexPath];
                }]];
            }
            dispatch_async(dispatch_get_main_queue(), ^{
                [self presentViewController:alert animated:NO completion:nil];
            });
            
        }
        else if(indexPath.row ==14)
        {
            //政治面貌
            FBOptionViewController *ovc =[[FBOptionViewController alloc]init];
            ovc.indexPath=indexPath;
            ovc.delegate =self;
            ovc.option=15;
            ovc.contentTitle =arr[indexPath.row];
            [self.navigationController pushViewController:ovc animated:NO];
        }
       else if(indexPath.row ==15)
       {
           //兴趣爱好
           FBTextVViewController *Tvc =[[FBTextVViewController alloc]init];
           Tvc.delegate =self;
           Tvc.contentTitle =arr[indexPath.row];
           Tvc.content = dic2[arr2[indexPath.row]];
           Tvc.indexpath =indexPath;
           [self.navigationController pushViewController:Tvc animated:NO];
           
       }
        else
        {
            
        }
    
    }
   
    else if (indexPath.section==1)
    {
        
        if (indexPath.row==5) {
            //与紧急联系人的关系
            UIAlertController *alert = [[UIAlertController alloc]init];
            [alert addAction:[UIAlertAction actionWithTitle:@"父母" style:UIAlertActionStyleDefault handler:^(UIAlertAction * _Nonnull action) {
                [self xiugaiWithcongtent:action.title indexpath:indexPath];
                
            }]];
            [alert addAction:[UIAlertAction actionWithTitle:@"夫妻" style:UIAlertActionStyleDefault handler:^(UIAlertAction * _Nonnull action) {
                 [self xiugaiWithcongtent:action.title indexpath:indexPath];
            }]];
            [alert addAction:[UIAlertAction actionWithTitle:@"子女" style:UIAlertActionStyleDefault handler:^(UIAlertAction * _Nonnull action) {
                 [self xiugaiWithcongtent:action.title indexpath:indexPath];
            }]];
            [alert addAction:[UIAlertAction actionWithTitle:@"兄妹" style:UIAlertActionStyleDefault handler:^(UIAlertAction * _Nonnull action) {
                 [self xiugaiWithcongtent:action.title indexpath:indexPath];
            }]];
            [alert addAction:[UIAlertAction actionWithTitle:@"亲戚" style:UIAlertActionStyleDefault handler:^(UIAlertAction * _Nonnull action) {
                 [self xiugaiWithcongtent:action.title indexpath:indexPath];
            }]];
            dispatch_async(dispatch_get_main_queue(), ^{
                [self presentViewController:alert animated:NO completion:nil];
            });
            
        }
        else
        {
        FBTextFieldViewController *TFvc =[[FBTextFieldViewController alloc]init];
        TFvc.delegate =self;
        TFvc.content =dic2[arr2[indexPath.row]];
        TFvc.contentTitle =arr[indexPath.row];
        TFvc.indexPath =indexPath;
        [self.navigationController pushViewController:TFvc animated:NO];
        }
        
    }
   else if(indexPath.section==2)
   {
       if(indexPath.row==0 || indexPath.row==1)
       {
           //毕业院校 专业
           FBTextFieldViewController *TFvc =[[FBTextFieldViewController alloc]init];
           TFvc.delegate =self;
           TFvc.content =dic2[arr2[indexPath.row]];
           TFvc.contentTitle =arr[indexPath.row];
           TFvc.indexPath =indexPath;
           [self.navigationController pushViewController:TFvc animated:NO];
           
       }
       else if(indexPath.row==2 || indexPath.row ==3)
       {
           //文化程度 职业资格
           FBOptionViewController *Ovc =[[FBOptionViewController alloc]init];
           Ovc.indexPath =indexPath;
           Ovc.delegate =self;
           Ovc.option =indexPath.row==2?10:16;
           Ovc.contentTitle =arr[indexPath.row];
           [self.navigationController pushViewController:Ovc animated:NO];
           
       }
       else
       {
           //外语等级
           DAEngllishViewController *Evc =[[DAEngllishViewController alloc]init];
           Evc.delegate =self;
           Evc.indexPath =indexPath;
           [self.navigationController pushViewController:Evc animated:NO];
           
           
       }
   }
    else
    {
        //工作履历
        if(indexPath.row==0)
        {
            //工作经历
            WorkExprienceViewController *Wvc =[[WorkExprienceViewController alloc]init];
            [self.navigationController pushViewController:Wvc animated:NO];
        }else if (indexPath.row==1)
        {
            //项目经验
            ProjectExprienceViewController *Pvc =[[ProjectExprienceViewController alloc]init];
            [self.navigationController pushViewController:Pvc animated:NO];
        }
     
    }
    
}

#pragma  mark--  自定义的协议代理
-(void)birthDayWithcontent:(NSString *)content indexPath:(NSIndexPath *)indexpath
{
    
    
}
-(void)textVtext:(NSString *)text indexPath:(NSIndexPath *)indexPath
{
    [self xiugaiWithcongtent:text indexpath:indexPath];
    
}
-(void)address:(NSString *)address Withindexpath:(NSIndexPath *)indexPath arr_address:(NSArray *)arr_address
{
    NSArray *tarr =[address componentsSeparatedByString:@"-"];
    [self xiugaiWithcongtent:tarr[0] indexpath:indexPath];
    
}
-(void)content:(NSString *)content WithindexPath:(NSIndexPath *)indexPath
{
   //textFiled
    
    if (indexPath.section==0) {
        if (indexPath.row==10 || indexPath.row==11) {
            if (content.length>1 && content.length<4) {
                    if ([self isPureNumandCharacters:content]) {
                        if(indexPath.row==10)
                        {
                           //身高
                            if ([content integerValue]<300) {
                                [self xiugaiWithcongtent:content indexpath:indexPath];
                            }
                            else
                            {
                                MBProgressHUD *hud=[MBProgressHUD showHUDAddedTo:self.view  animated:YES];
                                hud.mode = MBProgressHUDModeText;
                                hud.label.text =@"请您填写正确的身高";
                                dispatch_time_t popTime = dispatch_time(DISPATCH_TIME_NOW, 1 * NSEC_PER_SEC);
                                dispatch_after(popTime, dispatch_get_main_queue(), ^(void){
                                    [MBProgressHUD hideHUDForView:self.view  animated:YES];
                                });
                            }
                        }
                        else
                        {
                           
                            if([content integerValue] < 300)
                            {
                                 [self xiugaiWithcongtent:content indexpath:indexPath];
                            }
                            else
                            {
                                MBProgressHUD *hud=[MBProgressHUD showHUDAddedTo:self.view  animated:YES];
                                hud.mode = MBProgressHUDModeText;
                                hud.label.text =@"体重不能超过300kg";
                                dispatch_time_t popTime = dispatch_time(DISPATCH_TIME_NOW, 1 * NSEC_PER_SEC);
                                dispatch_after(popTime, dispatch_get_main_queue(), ^(void){
                                    [MBProgressHUD hideHUDForView:self.view  animated:YES];
                                });
                            }
                        }
                        
                    }
                else
                {
                    MBProgressHUD *hud=[MBProgressHUD showHUDAddedTo:self.view  animated:YES];
                    hud.mode = MBProgressHUDModeText;
                    hud.label.text =@"必须是纯数字";
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
                hud.label.text =@"必须是2-3位数";
                dispatch_time_t popTime = dispatch_time(DISPATCH_TIME_NOW, 1 * NSEC_PER_SEC);
                dispatch_after(popTime, dispatch_get_main_queue(), ^(void){
                    [MBProgressHUD hideHUDForView:self.view  animated:YES];
                });
            }
        }
        else
        {
            [self xiugaiWithcongtent:content indexpath:indexPath];
            
        }
    }
    
    
    if (indexPath.section==1) {
        if (indexPath.row==0 || indexPath.row==6) {
            //个人电话
           if( [RCKitUtility validateCellPhoneNumber:content])
           {
              [self xiugaiWithcongtent:content indexpath:indexPath];
           }
            else
            {
                MBProgressHUD *hud=[MBProgressHUD showHUDAddedTo:self.view  animated:YES];
                hud.mode = MBProgressHUDModeText;
                hud.label.text =@"手机号格式不正确";
                dispatch_time_t popTime = dispatch_time(DISPATCH_TIME_NOW, 1 * NSEC_PER_SEC);
                dispatch_after(popTime, dispatch_get_main_queue(), ^(void){
                    [MBProgressHUD hideHUDForView:self.view  animated:YES];
                });
            }
        }
        
        else if(indexPath.row==1)
        {
            //qq
            if ([self  isPureNumandCharacters:content]) {
                if (content.length > 4 && content.length <15) {
                    [self xiugaiWithcongtent:content indexpath:indexPath];
                }
                else
                {
                    MBProgressHUD *hud=[MBProgressHUD showHUDAddedTo:self.view  animated:YES];
                    hud.mode = MBProgressHUDModeText;
                    hud.label.text =@"qq的 位数5--14";
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
                hud.label.text =@"输入的qq不合法";
                dispatch_time_t popTime = dispatch_time(DISPATCH_TIME_NOW, 1 * NSEC_PER_SEC);
                dispatch_after(popTime, dispatch_get_main_queue(), ^(void){
                    [MBProgressHUD hideHUDForView:self.view  animated:YES];
                });
            }
            
        }
        else if(indexPath.row==3)
        {
            //邮箱
            if ( [RCKitUtility  validateEmail:content]) {
                [self xiugaiWithcongtent:content indexpath:indexPath];
            }
            else
            {
                MBProgressHUD *hud=[MBProgressHUD showHUDAddedTo:self.view  animated:YES];
                hud.mode = MBProgressHUDModeText;
                hud.label.text =@"邮箱格式不正确";
                dispatch_time_t popTime = dispatch_time(DISPATCH_TIME_NOW, 1 * NSEC_PER_SEC);
                dispatch_after(popTime, dispatch_get_main_queue(), ^(void){
                    [MBProgressHUD hideHUDForView:self.view  animated:YES];
                });
            }
        }
        else
        {
           [self xiugaiWithcongtent:content indexpath:indexPath];
        }
    }
    else
    {
       [self xiugaiWithcongtent:content indexpath:indexPath];
    }
    
    
    
}

///判断字符串是否是数字
- (BOOL)isPureNumandCharacters:(NSString *)string
{
    string = [string stringByTrimmingCharactersInSet:[NSCharacterSet decimalDigitCharacterSet]];
    if(string.length > 0)
    {
        return NO;
    }
    return YES;
}
-(void)option:(NSString *)option indexPath:(NSIndexPath *)indexPath
{
    [self xiugaiWithcongtent:option indexpath:indexPath];
    
}

-(void)xiugaiWithcongtent:(NSString*)content indexpath:(NSIndexPath*)indexpath{
    NSArray *arr = arr_bigcontent[indexpath.section];
    
    NSString *para = [NSString stringWithFormat:@"%@='%@'",arr[indexpath.row],content];
    
    MBProgressHUD *hud = [MBProgressHUD showHUDAddedTo:self.view animated:YES];
    hud.mode = MBProgressHUDModeAnnularDeterminate;
    hud.label.text = @"正在修改";
    [WebRequest  User_UpdateUserinfoWithuserGuid:user.Guid para:para And:^(NSDictionary *dic) {
        
        NSNumber *number = dic[Y_STATUS];
        if ([number integerValue]==200) {
            [self loadRequestData];
        }
        hud.label.text = dic[Y_MSG];
        dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(0.5 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
            [hud hideAnimated:NO];
        });
    }];

}

-(void)english:(NSString *)english indexPath:(NSIndexPath *)indexpath
{
    [self xiugaiWithcongtent:english indexpath:indexpath];
    
    
}

@end
