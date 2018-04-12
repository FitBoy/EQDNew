//
//  LTrueNameViewController.m
//  EQD
//
//  Created by 梁新帅 on 2017/3/29.
//  Copyright © 2017年 FitBoy. All rights reserved.
//

#import "LTrueNameViewController.h"
#import "LTrueTableViewCell.h"
#import "FBTextFieldViewController.h"
#import <RongIMKit/RongIMKit.h>
#import "FBImgViewController.h"
#import "TrueBrthdayViewController.h"
#import "FBOptionViewController.h"
#import "FBAddressViewController.h"
#import "GSRegisterViewController.h"
@interface LTrueNameViewController ()<UITableViewDelegate,UITableViewDataSource,UINavigationControllerDelegate, UIImagePickerControllerDelegate,FBTextFieldViewControllerDelegate,FBImgViewControllerDelegate,TrueBrthdayViewControllerDelegate,FBOptionViewControllerDelegate,FBAddressViewControllerDelegate, UIImagePickerControllerDelegate>
{
    UITableView *tableV;
    NSMutableArray *arr_names;
    NSMutableArray *arr_contents;
    NSMutableArray *arr_one_names;
    NSMutableArray *arr_one_contents;
    NSMutableArray *arr_images;
    NSMutableArray *arr_tishi;
    NSInteger flag;
    UserModel *user;
    UIImagePickerController *picker;
}

@end

@implementation LTrueNameViewController
-(void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
    self.navigationController.navigationBarHidden=NO;
}
- (void)viewDidLoad {
    [super viewDidLoad];
    self.navigationItem.title=@"个人实名认证";
    user = [WebRequest GetUserInfo];
    arr_images =[NSMutableArray arrayWithArray:@[@"身份证正面照",@"身份证反面照",@"手持身份证"]];
    //@"1.此证件照必须是红或白或蓝底，否则将会验证失败。\n2.此证件照只可修改一次，请认真对待\n3.此照片仅用于易企点认证使用，不做其他身上也用途",
    arr_tishi = [NSMutableArray arrayWithArray:@[@"1.身份证正面照片必须是真实的 。\n2.此照片仅用于易企点认证使用，不做其他身上也用途",@"1.身份证反面面照片必须是真实的 \n2.此照片仅用于易企点认证使用，不做其他身上也用途",@"1.必须是本人与本人的身份证件。\n2.此照片仅用于易企点认证使用，不做其他身上也用途",@"易企点",@"易企点",@"希望公司给你祝福的日期",@"此邮箱用于用户换手机或者手机丢失的个人操作，也便于我们邮箱联系你"]];
    arr_one_names = [NSMutableArray arrayWithArray:@[@"身份证正面照",@"身份证反面照",@"本人手持身份证照",@"籍贯",@"户口性质",@"生日祝福日期",@"邮箱(可选)"]];
    
    arr_one_contents = [NSMutableArray arrayWithArray:@[@"未选择",@"未选择",@"未选择",@"请选择",@"请选择",@"请选择",@"请输入"]];
    
    arr_names = [NSMutableArray arrayWithArray:@[@"真实姓名",@"身份证号",@"性别",@"出生日期",@"民族",@"户籍地址"]];
    arr_contents = [NSMutableArray arrayWithArray:@[@"从身份证信息读取",@"从身份证信息读取",@"从身份证信息读取",@"从身份证信息读取",@"从身份证信息读取",@"从身份证信息读取",@"从身份证信息读取"]];
    
    tableV = [[UITableView alloc]initWithFrame:CGRectMake(0, 0, DEVICE_WIDTH, DEVICE_HEIGHT) style:UITableViewStyleGrouped];
    tableV.delegate=self;
    tableV.dataSource=self;
    [self.view addSubview:tableV];
    UIBarButtonItem *right = [[UIBarButtonItem alloc]initWithTitle:@"实名认证" style:UIBarButtonItemStylePlain target:self action:@selector(quedingClick)];
    [self.navigationItem setRightBarButtonItem:right];
    UIBarButtonItem *left = [[UIBarButtonItem alloc]initWithTitle:@"返回" style:UIBarButtonItemStylePlain target:self action:@selector(editCancelClick)];
    [self.navigationItem setLeftBarButtonItem:left];
    flag = 0;
     picker =[[UIImagePickerController alloc]init];
    picker.delegate=self;
    picker.allowsEditing =YES;
    if ([UIImagePickerController isSourceTypeAvailable:UIImagePickerControllerSourceTypeCamera]) {
      picker.sourceType = UIImagePickerControllerSourceTypeCamera;
    }
    
    
}

-(void)quedingClick
{
    
    NSInteger flag1 = 0;
    NSString *str = arr_contents[0];
        if ([str isEqualToString:@"从身份证信息读取"] ) {
            flag1=1;
        }
    if (flag1 ==0) {
        
        MBProgressHUD *hud = [MBProgressHUD showHUDAddedTo:self.view animated:YES];
        hud.mode = MBProgressHUDModeAnnularDeterminate;
        hud.label.text = @"正在认证";
        NSInteger temp=0;
        if ([arr_contents[2] isEqualToString:@"女"]) {
            temp=1;
        }
        self.navigationItem.rightBarButtonItem.enabled =NO;
        [WebRequest Com_InsertStaffInfoWithuserGuid:user.Guid name:arr_contents[0] imagearr:arr_images idnum:arr_contents[1] sex:[NSString stringWithFormat:@"%ld",(long)temp] age:[self ageWithDateOfBirth:arr_contents[3]] date:arr_contents[3] rdate:arr_one_contents[5] pnative:arr_one_contents[3] nation:arr_contents[4] mail:arr_one_contents[6] housetype:arr_one_contents[4] houseadress:arr_contents[5]  ptel:user.uname And:^(NSDictionary *dic) {
          self.navigationItem.rightBarButtonItem.enabled =YES;
           
            NSNumber *number = dic[@"status"];
            NSString *msg =dic[@"msg"];
            if ([number integerValue]==200) {
                
                [WebRequest updateUserinfoWithKey:@"authen" value:@"1"];
                [WebRequest user_enterWithu1:user.uname u2:[USERDEFAULTS objectForKey:Y_MIMA] And:^(NSDictionary *dic) {
                    NSDictionary *items =dic[Y_ITEMS];
                    [USERDEFAULTS setObject:items forKey:Y_USERINFO];
                    [USERDEFAULTS synchronize];
                    
                }];
                
                hud.label.text =msg;
                dispatch_time_t popTime = dispatch_time(DISPATCH_TIME_NOW, 1 * NSEC_PER_SEC);
                dispatch_after(popTime, dispatch_get_main_queue(), ^(void){
                    [hud hideAnimated:NO];
                });
                dispatch_async(dispatch_get_main_queue(), ^{
                    if (self.isFirst==0) {
                        [self.navigationController popViewControllerAnimated:NO];
                    }
                    else if(self.isFirst==1)
                    {
                        UIAlertController *alert = [[UIAlertController alloc]init];
                       
                        [alert addAction:[UIAlertAction actionWithTitle:@"注册企业" style:UIAlertActionStyleDefault handler:^(UIAlertAction * _Nonnull action) {
                            GSRegisterViewController *Rvc =[[GSRegisterViewController alloc]init];
                            [self.navigationController pushViewController:Rvc animated:NO];
                            
                        }]];
                        [alert addAction:[UIAlertAction actionWithTitle:@"现在进入" style:UIAlertActionStyleDefault handler:^(UIAlertAction * _Nonnull action) {
                            [self mainJiemian];
                        }]];
                        
                        [self presentViewController:alert animated:NO completion:nil];
                    }
                    else
                    {
                        //入驻企业需要的实名认证
                       /* RZWanShanViewController *WSvc =[[RZWanShanViewController alloc]init];
                        [self.navigationController pushViewController:WSvc animated:NO];*/
                        
                    }
                });
               
                
            }
            else
            {
                hud.label.text =msg;
                dispatch_time_t popTime = dispatch_time(DISPATCH_TIME_NOW, 1 * NSEC_PER_SEC);
                dispatch_after(popTime, dispatch_get_main_queue(), ^(void){
                    [hud hideAnimated:NO];
                });
            }

        }];
        }
    
    else
    {
        MBProgressHUD *hud=[MBProgressHUD showHUDAddedTo:self.view.window animated:YES];
        hud.mode = MBProgressHUDModeText;
        hud.label.text =@"信息不完整请检查";
        dispatch_time_t popTime = dispatch_time(DISPATCH_TIME_NOW, 1 * NSEC_PER_SEC);
        dispatch_after(popTime, dispatch_get_main_queue(), ^(void){
            [MBProgressHUD hideHUDForView:self.view.window animated:YES];
        });
    }
}

#pragma  mark - 表的数据源
-(NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return 2;
}
-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    if (section ==0) {
        return arr_one_names.count;
    }
    return arr_names.count;
}
-(UITableViewCell*)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    static NSString *cellId=@"cellID";
    UITableViewCell *cell =[tableView dequeueReusableCellWithIdentifier:cellId];
    if (!cell) {
        cell = [[UITableViewCell alloc]initWithStyle:UITableViewCellStyleValue1 reuseIdentifier:cellId];
        cell.accessoryType = UITableViewCellAccessoryNone;
    }
    
    if (indexPath.section==0) {
        cell.textLabel.text =arr_one_names[indexPath.row];
        cell.detailTextLabel.text =arr_one_contents[indexPath.row];
    }
    else
    {
        cell.textLabel.text =arr_names[indexPath.row];
        cell.detailTextLabel.text =arr_contents[indexPath.row];
    }
    return cell;
    
}


-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return 60;
}
#pragma  mark - 表的协议代理
-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    
    if (indexPath.section==0) {
       /* if (indexPath.row==0) {
            FBImgViewController *imagvc =[[FBImgViewController alloc]init];
            imagvc.indexPath=indexPath;
            imagvc.flag =indexPath.row;
            imagvc.delegate =self;
            imagvc.contentTitle =arr_one_names[indexPath.row];
            imagvc.content =arr_tishi[indexPath.row];
            [self.navigationController pushViewController:imagvc animated:NO];
            
        }
        else*/
        if(indexPath.row<3 )
        {
            if ([UIImagePickerController isSourceTypeAvailable:UIImagePickerControllerSourceTypeCamera]) {
                flag = indexPath.row;
                [self presentViewController:picker animated:NO completion:nil];
            }
            else
            {
                MBProgressHUD *hud=[MBProgressHUD showHUDAddedTo:self.view.window animated:YES];
                hud.mode = MBProgressHUDModeText;
                hud.label.text =@"无法获得相机";
                dispatch_time_t popTime = dispatch_time(DISPATCH_TIME_NOW, 2 * NSEC_PER_SEC);
                dispatch_after(popTime, dispatch_get_main_queue(), ^(void){
                    [MBProgressHUD hideHUDForView:self.view.window animated:YES];
                });
            }
        }
        else if(indexPath.row==3)
        {
            //户籍
            FBAddressViewController *Avc =[[FBAddressViewController alloc]init];
            Avc.indexPath =indexPath;
            Avc.delegate =self;
            [self.navigationController pushViewController:Avc animated:NO];
            
        }
        else if(indexPath.row==4)
        {
            //户口性质
            FBOptionViewController *Ovc =[[FBOptionViewController alloc]init];
            Ovc.indexPath=indexPath;
            Ovc.delegate =self;
            Ovc.contentTitle=arr_one_names[indexPath.row];
            Ovc.option=20;
            [self.navigationController pushViewController:Ovc animated:NO];
            
        }
       else if (indexPath.row==5) {
            //生日祝福日期
           TrueBrthdayViewController *Bvc =[[TrueBrthdayViewController alloc]init];
           Bvc.delegate =self;
           Bvc.indexpath= indexPath;
//           Bvc.content =arr_one_contents[indexPath.row];
           [self.navigationController pushViewController:Bvc animated:NO];
           
        }
        else
        {
           //邮箱
            FBTextFieldViewController *TFvc =[[FBTextFieldViewController alloc]init];
            TFvc.delegate =self;
            TFvc.indexPath=indexPath;
            TFvc.contentTitle = arr_one_names[indexPath.row];
            TFvc.content =arr_one_contents[indexPath.row];
            TFvc.contentTishi =arr_tishi[indexPath.row];
            [self.navigationController pushViewController:TFvc animated:NO];
            
        }
    }
    
    
    
    
    
}

-(void)imagePickerController:(UIImagePickerController *)picker didFinishPickingMediaWithInfo:(NSDictionary<NSString *,id> *)info
{
    UIImage *image = [info objectForKey:UIImagePickerControllerEditedImage];
    [self dismissViewControllerAnimated:NO completion:^{
       
    }];
    if (flag ==0) {
        MBProgressHUD *hud = [MBProgressHUD showHUDAddedTo:self.view animated:YES];
        hud.mode = MBProgressHUDModeAnnularDeterminate;
        hud.label.text = @"正在处理身份信息";
        [WebRequest GetuserinfoWithimg:image And:^(NSDictionary *dic) {
            NSArray *arr_card = dic[@"cards"];
            
            if (arr_card.count) {
                NSDictionary *dic1 = arr_card[0];
                
                [arr_contents replaceObjectAtIndex:0 withObject:dic1[@"name"]];
                [arr_contents replaceObjectAtIndex:1 withObject:dic1[@"id_card_number"]];
                [arr_contents replaceObjectAtIndex:2 withObject:dic1[@"gender"]];
                [arr_contents replaceObjectAtIndex:3 withObject:dic1[@"birthday"]];
                [arr_contents replaceObjectAtIndex:4 withObject:dic1[@"race"]];
                [arr_contents replaceObjectAtIndex:5 withObject:dic1[@"address"]];
                hud.label.text =@"读取信息成功";
                [tableV reloadData];
            }
            else
            {
                hud.label.text =@"读取信息失败，请重新拍照";
                
            }
            dispatch_async(dispatch_get_main_queue(), ^{
                [hud hideAnimated:NO];
            });
        }];
    }
        
    [arr_one_contents replaceObjectAtIndex:flag withObject:@"已选择"];
    [arr_images replaceObjectAtIndex:flag withObject:image];
    [tableV reloadData];
    
}
#pragma mark - 自定义协议代理
-(void)content:(NSString *)content WithindexPath:(NSIndexPath *)indexPath
{
    [arr_one_contents replaceObjectAtIndex:indexPath.row withObject:content];
    [tableV reloadData];
    
}
-(void)img:(UIImage *)img flag:(NSInteger)flag indexPath:(NSIndexPath *)indexPath
{
    [arr_one_contents replaceObjectAtIndex:flag withObject:@"已选择"];
    [arr_images replaceObjectAtIndex:flag withObject:img];
    dispatch_async(dispatch_get_main_queue(), ^{
       [tableV reloadData];
    });
}
-(void)birthDayWithcontent:(NSString *)content indexPath:(NSIndexPath *)indexpath
{
    [arr_one_contents replaceObjectAtIndex:indexpath.row withObject:content];
    [tableV reloadData];
}
-(void)option:(NSString *)option indexPath:(NSIndexPath *)indexPath
{
    [arr_one_contents replaceObjectAtIndex:indexPath.row withObject:option];
    [tableV reloadData];
}
-(void)address:(NSString *)address Withindexpath:(NSIndexPath *)indexPath arr_address:(NSArray *)arr_address
{
    [arr_one_contents replaceObjectAtIndex:indexPath.row withObject:address];
    [tableV reloadData];
}
@end
