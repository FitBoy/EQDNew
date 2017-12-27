//
//  SPDetailViewController.m
//  EQD
//
//  Created by 梁新帅 on 2017/7/25.
//  Copyright © 2017年 FitBoy. All rights reserved.
//

#import "SPDetailViewController.h"
#import "FBTwo_noimg12TableViewCell.h"
#import "FBFour_noimgTableViewCell.h"
#import "FBImgView.h"
#import "FBindexTapGestureRecognizer.h"
#import "FBImgShowViewController.h"
@interface SPDetailViewController ()<UITableViewDelegate,UITableViewDataSource>
{
    UITableView *tableV;
    NSMutableArray *arr_names;
    NSMutableArray *arr_contents;
    UserModel *user;
    NSArray *tarr2;
}

@end

@implementation SPDetailViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    user =[WebRequest GetUserInfo];
    self.navigationItem.title =@"个人详情";
    NSString *tstr = @"女";
    if ([self.model.usex integerValue]==0) {
        tstr =@"男";
    }

    NSArray *tarr = [self.model.udate componentsSeparatedByString:@"T"];
    NSString *udate = tarr[0];
    arr_names = [NSMutableArray arrayWithArray:@[@"出生年月",@"身份证号",@"手机号",@"户籍地址",@"户口类型",@"政治面貌",@"学历",@"职业资格"]];
    arr_contents = [NSMutableArray arrayWithArray:@[udate,self.model.uidnum,self.model.userPhone,self.model.uhouseadress,self.model.uhousetype,self.model.upoliticstate,self.model.uedu,self.model.umajor]];
    tableV = [[UITableView alloc]initWithFrame:CGRectMake(0, 0, DEVICE_WIDTH, DEVICE_HEIGHT) style:UITableViewStylePlain];
    tableV.delegate=self;
    tableV.dataSource=self;
    [self.view addSubview:tableV];
    tableV.rowHeight=50;
    tarr2 =@[self.model.uidumfrontphoto,self.model.uidumbackphoto,self.model.uwithidumphoto,self.model.uiphoto];
    
    FBImgView *imgV =[[FBImgView alloc]initWithImgurls:tarr2];
    tableV.tableHeaderView =imgV;
    imgV.frame =CGRectMake(0, 0, DEVICE_WIDTH, imgV.height+10);
    for (int i=0; i<imgV.arr_imgVarr.count; i++) {
        UIImageView *imgV1 =imgV.arr_imgVarr[i];
        imgV1.userInteractionEnabled=YES;
        FBindexTapGestureRecognizer *tap = [[FBindexTapGestureRecognizer alloc]initWithTarget:self action:@selector(tapClick:)];
        tap.index = i;
        tap.numberOfTapsRequired=1;
        tap.numberOfTouchesRequired=1;
        [imgV1 addGestureRecognizer:tap];
        
    }
}
-(void)tapClick:(FBindexTapGestureRecognizer*)tap
{
    FBImgShowViewController *Svc =[[FBImgShowViewController alloc]init];
    Svc.selected =tap.index;
    Svc.imgstrs =tarr2;
    [self.navigationController pushViewController:Svc animated:NO];
    
}
#pragma  mark - 表的数据源
-(NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return self.isDetail==0?3:2;
}
-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    if (section==0||section==2) {
        return 1;
    }
    else
    {
        return arr_names.count;
    }
    
}
-(UITableViewCell*)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    if (indexPath.section==0) {
        NSString *tstr = @"女";
        if ([self.model.usex integerValue]==0) {
            tstr =@"男";
        }
        FBFour_noimgTableViewCell *cell = [[FBFour_noimgTableViewCell alloc]init];
        cell.L_left0.text =[NSString stringWithFormat:@"%@【%@】",self.model.uname,tstr];
        cell.L_left1.text = [NSString stringWithFormat:@"%@【%@】",self.model.umarry,self.model.unation];
        cell.L_right0.text =self.model.departName;
        cell.L_right1.text = self.model.postName;
        return cell;
    }
    else if(indexPath.section==1)
    {
        static NSString *cellid1 =@"cellid1";
    FBTwo_noimg12TableViewCell *cell =[tableView dequeueReusableCellWithIdentifier:cellid1];
        if(!cell)
        {
            cell =[[FBTwo_noimg12TableViewCell alloc]initWithStyle:UITableViewCellStyleDefault reuseIdentifier:cellid1];
            cell.accessoryType = UITableViewCellAccessoryNone;
        }
        cell.L_left0.text =arr_names[indexPath.row];
        cell.L_right0.text =arr_contents[indexPath.row];
        return cell;
    }
    
    
    else
    {
        UITableViewCell *cell =[[UITableViewCell alloc]init];
        cell.textLabel.font =[UIFont systemFontOfSize:17];
        cell.textLabel.textAlignment = NSTextAlignmentCenter;
        cell.textLabel.text=@"同意";
        return cell;
    }
    
}
-(CGFloat)tableView:(UITableView *)tableView heightForFooterInSection:(NSInteger)section
{
    return 9;
}
-(BOOL)tableView:(UITableView *)tableView canEditRowAtIndexPath:(NSIndexPath *)indexPath
{
    return YES;
}

-(UITableViewCellEditingStyle)tableView:(UITableView *)tableView editingStyleForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return UITableViewCellEditingStyleDelete;
    
}
-(void)tableView:(UITableView *)tableView commitEditingStyle:(UITableViewCellEditingStyle)editingStyle forRowAtIndexPath:(NSIndexPath *)indexPath
{
    
    if (editingStyle == UITableViewCellEditingStyleDelete) {
        //拒绝邀请
        MBProgressHUD *hud = [MBProgressHUD showHUDAddedTo:self.view animated:YES];
        hud.mode = MBProgressHUDModeAnnularDeterminate;
        hud.label.text = @"正在驳回";
        [WebRequest User_InvertRefuseWithuserGuid:user.Guid entryId:self.model.entryId userPhone:user.uname And:^(NSDictionary *dic) {
            hud.label.text =dic[Y_MSG];
            dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(0.5 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
                [hud hideAnimated:NO];
                [self.navigationController popViewControllerAnimated:NO];
            });
        }];
        
    }
}

-(NSString*)tableView:(UITableView *)tableView titleForDeleteConfirmationButtonForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return @"驳回重填";
}


#pragma  mark - 表的协议代理
-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    if (indexPath.section==2) {
        //同意入职
        MBProgressHUD *hud = [MBProgressHUD showHUDAddedTo:self.view animated:YES];
        hud.mode = MBProgressHUDModeAnnularDeterminate;
        hud.label.text = @"正在同意";
        [WebRequest User_InvertAgreeWithuserGuid:user.Guid entryId:self.model.entryId userPhone:self.model.userPhone And:^(NSDictionary *dic) {
            hud.label.text =dic[Y_MSG];
            dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(0.5 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
                [hud hideAnimated:NO];
                [self.navigationController popViewControllerAnimated:NO];
            });
        }];
        
    }
}



@end
