//
//  SC_needAddViewController.m
//  EQD
//
//  Created by 梁新帅 on 2018/7/10.
//  Copyright © 2018年 FitBoy. All rights reserved.
//

#import "SC_needAddViewController.h"
#import "FBTextFieldViewController.h"
#import "FBTextVViewController.h"
#import "FBAddressViewController.h"
#import "FB_twoTongShi2ViewController.h"
#import "FBHangYeViewController.h"
#import "DatePicer_AlertView.h"
#import "SC_needModel.h"
#import "FBone_SwitchTableViewCell.h"
#import "MM_zhiBiaoAddViewController.h"
#import "FBOneImg_yyLabelTableViewCell.h"
#import <Masonry.h>
#import "SC_productModel.h"
#import <UIImageView+WebCache.h>
@interface SC_needAddViewController ()<UITableViewDelegate,UITableViewDataSource,FBTextVViewControllerDelegate,FBTextFieldViewControllerDelegate,FBAddressViewControllerDelegate,FB_twoTongShi2ViewControllerDelegate,FBHangYeViewControllerDelegate,MM_zhiBiaoAddViewControllerDelegate>
{
    UITableView *tableV;
    UserModel *user;
    NSArray *arr_names;
    NSMutableArray *arr_contents;
    DatePicer_AlertView *date_alert;
    SC_needModel *model_detail;
    
    NSMutableArray *arr_zhibiao;
    NSMutableArray *arr_product;
}

@end

@implementation SC_needAddViewController

#pragma  mark - 单行的文字输入
-(void)content:(NSString *)content WithindexPath:(NSIndexPath *)indexPath
{
    [arr_contents replaceObjectAtIndex:indexPath.row withObject:content];
    [tableV reloadRowsAtIndexPaths:@[indexPath] withRowAnimation:UITableViewRowAnimationNone];
    if(self.temp ==1)
    {
    NSString *para=nil;
    if (indexPath.row==0) {
        para =[NSString stringWithFormat:@"DemandName='%@'",content];
    }else if (indexPath.row ==3)
    {
        para =[NSString stringWithFormat:@"DemandPrice='%@'",content];

    }else if (indexPath.row==4)
    {
        para =[NSString stringWithFormat:@"DemandNum='%@'",content];

    }else if (indexPath.row ==7)
    {        para =[NSString stringWithFormat:@"ContactWay='%@'",content];

        
    }else
    {
        return;
    }
    
    [WebRequest ComSpace_ComSpaceDemand_Update_ComSpaceDemandWithuserGuid:user.Guid companyId:user.companyId demandId:model_detail.Id para:para And:^(NSDictionary *dic) {
        if ([dic[Y_STATUS]integerValue]==200) {
            MBFadeAlertView *alert = [[MBFadeAlertView alloc]init];
            [alert showAlertWith:@"修改成功"];
        }else
        {
            MBFadeAlertView *alert = [[MBFadeAlertView alloc]init];
            [alert showAlertWith:@"修改失败，请重试"];
        }
    }];
    }
}
#pragma  mark - 多行的文字
-(void)textVtext:(NSString *)text indexPath:(NSIndexPath *)indexPath
{
    [arr_contents replaceObjectAtIndex:indexPath.row withObject:text];
    [tableV reloadRowsAtIndexPaths:@[indexPath] withRowAnimation:UITableViewRowAnimationNone];
    if (self.temp ==1) {
    NSString *para = [NSString stringWithFormat:@"DemandDescribe='%@'",text];
    [WebRequest ComSpace_ComSpaceDemand_Update_ComSpaceDemandWithuserGuid:user.Guid companyId:user.companyId demandId:model_detail.Id para:para And:^(NSDictionary *dic) {
        if ([dic[Y_STATUS]integerValue]==200) {
            MBFadeAlertView *alert = [[MBFadeAlertView alloc]init];
            [alert showAlertWith:@"修改成功"];
        }else
        {
            MBFadeAlertView *alert = [[MBFadeAlertView alloc]init];
            [alert showAlertWith:@"修改失败，请重试"];
        }
    }];
    }
}
-(void)hangye:(NSString *)hangye Withindexpath:(NSIndexPath *)indexpath
{
    NSArray *tarr = [hangye componentsSeparatedByString:@"-"];
    [arr_contents replaceObjectAtIndex:indexpath.row withObject:tarr[0]];
    [tableV reloadRowsAtIndexPaths:@[indexpath] withRowAnimation:UITableViewRowAnimationNone];
    if (self.temp ==1) {
    NSString *para = [NSString stringWithFormat:@"DemandType='%@'",tarr[0]];
    [WebRequest ComSpace_ComSpaceDemand_Update_ComSpaceDemandWithuserGuid:user.Guid companyId:user.companyId demandId:model_detail.Id para:para And:^(NSDictionary *dic) {
        if ([dic[Y_STATUS]integerValue]==200) {
            MBFadeAlertView *alert = [[MBFadeAlertView alloc]init];
            [alert showAlertWith:@"修改成功"];
        }else
        {
            MBFadeAlertView *alert = [[MBFadeAlertView alloc]init];
            [alert showAlertWith:@"修改失败，请重试"];
        }
    }];
    }
}
-(void)address:(NSString *)address Withindexpath:(NSIndexPath *)indexPath arr_address:(NSArray *)arr_address
{
    NSArray *tarr = [address componentsSeparatedByString:@"-"];
    [arr_contents replaceObjectAtIndex:indexPath.row withObject:tarr[0]];
    [tableV reloadRowsAtIndexPaths:@[indexPath] withRowAnimation:UITableViewRowAnimationNone];
    if (self.temp ==1) {
    NSString *para = [NSString stringWithFormat:@"DemandAddress='%@'",tarr[0]];
    [WebRequest ComSpace_ComSpaceDemand_Update_ComSpaceDemandWithuserGuid:user.Guid companyId:user.companyId demandId:model_detail.Id para:para And:^(NSDictionary *dic) {
        if ([dic[Y_STATUS]integerValue]==200) {
            MBFadeAlertView *alert = [[MBFadeAlertView alloc]init];
            [alert showAlertWith:@"修改成功"];
        }else
        {
            MBFadeAlertView *alert = [[MBFadeAlertView alloc]init];
            [alert showAlertWith:@"修改失败，请重试"];
        }
    }];
    }
}

- (BOOL)prefersHomeIndicatorAutoHidden{
    return NO;
}
-(void)leftClick
{
    [date_alert removeFromSuperview];
}
-(void)rightClick
{
     NSDateFormatter *formatter =[[NSDateFormatter alloc]init];
    [formatter setDateFormat:@"yyyy-MM-dd"];
    NSString *date_str = [formatter stringFromDate:date_alert.picker.date];
    [arr_contents replaceObjectAtIndex:9 withObject:date_str];
    [tableV reloadRowsAtIndexPaths:@[[NSIndexPath indexPathForRow:9 inSection:0]] withRowAnimation:UITableViewRowAnimationNone];
    [date_alert removeFromSuperview];
    if (self.temp ==1) {
    NSString *para = [NSString stringWithFormat:@"EndTime='%@'",date_str];
    [WebRequest ComSpace_ComSpaceDemand_Update_ComSpaceDemandWithuserGuid:user.Guid companyId:user.companyId demandId:model_detail.Id para:para And:^(NSDictionary *dic) {
        if ([dic[Y_STATUS]integerValue]==200) {
            MBFadeAlertView *alert = [[MBFadeAlertView alloc]init];
            [alert showAlertWith:@"修改成功"];
        }else
        {
            MBFadeAlertView *alert = [[MBFadeAlertView alloc]init];
            [alert showAlertWith:@"修改失败，请重试"];
        }
    }];
    }
}
- (void)viewDidLoad {
    [super viewDidLoad];
    arr_zhibiao = [NSMutableArray arrayWithCapacity:0];
    arr_product = [NSMutableArray arrayWithCapacity:0];
    date_alert =[[DatePicer_AlertView alloc]initWithFrame:self.view.frame];
    NSDateFormatter *formatter =[[NSDateFormatter alloc]init];
    [formatter setDateFormat:@"yyyy-MM-dd"];
    NSString *date_str = [formatter stringFromDate:[NSDate date]];
    [date_alert setDate3:date_str];
    date_alert.picker.datePickerMode =UIDatePickerModeDate;
    [date_alert.two_btn setleftname:@"取消" rightname:@"确定"];
    [date_alert.two_btn.B_left addTarget:self action:@selector(leftClick) forControlEvents:UIControlEventTouchUpInside];
    [date_alert.two_btn.B_right addTarget:self action:@selector(rightClick) forControlEvents:UIControlEventTouchUpInside];
   
    user = [WebRequest GetUserInfo];
   
   
    if (self.temp ==1) {
        self.navigationItem.title = @"需求详情";
         arr_names = @[@"需求名称",@"需求类别",@"国标代码",@"需求描述",@"需求预算（元）",@"需求量",@"发布地区",@"联系人",@"联系方式",@"截止日期",@"特性指标"];
        [WebRequest ComSpace_ComSpaceOther_Get_ComSpaceDemandByIdWithDemandID:self.Id And:^(NSDictionary *dic) {
            if ([dic[Y_STATUS] integerValue]==200) {
                model_detail = [SC_needModel mj_objectWithKeyValues:dic[Y_ITEMS]];
                arr_contents = [NSMutableArray arrayWithArray:@[model_detail.ProductName,model_detail.ProductType,model_detail.GuoBiaoCode,model_detail.ProductDesc,model_detail.DemandPrice,model_detail.DemandNum,model_detail.DemandAddress,model_detail.Contacts,model_detail.ContactWay,model_detail.EndTime,@"添加指标"]];
                arr_zhibiao = [NSMutableArray arrayWithArray:model_detail.indexList];
                
                [tableV reloadData];
            }
            
        }];
    }else
    {
        
        self.navigationItem.title = @"发布需求";
        arr_names = @[@"需求名称",@"需求类别",@"国标代码",@"需求描述",@"需求预算（元）",@"需求量",@"发布地区",@"联系人",@"联系方式",@"截止日期",@"特性指标"];
       arr_contents = [NSMutableArray arrayWithArray:@[@"请输入",@"请选择",@"请输入",@"请输入",@"请输入",@"请输入",@"请选择",user.username, user.uname,@"请输入",@"添加"]];
        UIBarButtonItem *right = [[UIBarButtonItem alloc]initWithTitle:@"提交" style:UIBarButtonItemStylePlain target:self action:@selector(tijiaoClick)];
        [self.navigationItem setRightBarButtonItem:right];
    }
    
    tableV = [[UITableView alloc]initWithFrame:CGRectMake(0, DEVICE_TABBAR_Height, DEVICE_WIDTH, DEVICE_HEIGHT-DEVICE_TABBAR_Height-kBottomSafeHeight) style:UITableViewStyleGrouped];
    adjustsScrollViewInsets_NO(tableV, self);
    tableV.delegate=self;
    tableV.dataSource=self;
    [self.view addSubview:tableV];
    tableV.rowHeight=60;
   
    
}
-(CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section
{
    if (section ==0) {
        return 1;
    }else
    {
        return 20;
    }
}
-(NSString*)tableView:(UITableView *)tableView titleForHeaderInSection:(NSInteger)section
{
   if (section ==1)
    {
        return @"特性指标";
    }else if (section ==2)
    {
        return @"根据需求匹配的产品";
    }else
    {
        return nil;
    }
        
}
-(void)tijiaoClick{
    
    NSInteger temp =0;
    for (int i=0; i<arr_contents.count; i++) {
        if ([arr_contents[i] isEqualToString:@"请输入"] || [arr_contents[i] isEqualToString:@"请选择"]) {
            temp =1;
            break;
        }
    }
    
    NSMutableArray *tarr = [NSMutableArray arrayWithCapacity:0];
    for (int i=0; i<arr_zhibiao.count; i++) {
        SC_productModel  *model = arr_zhibiao[i];
        NSDictionary *tdic =@{
                              @"indexTypeKey":model.GuoBiaoCode,
                              @"indexTypeValue":model.ProductMsg,
                              @"indexImage":model.productImage
                              };
        [tarr addObject:tdic];
    }
    NSString *tstr = nil;
    if (tarr.count ==0) {
        tstr =@" ";
    }else
    {
        NSData *tdata = [NSJSONSerialization dataWithJSONObject:tarr options:NSJSONWritingPrettyPrinted error:nil];
        tstr = [[NSString alloc]initWithData:tdata encoding:NSUTF8StringEncoding];
    }
    
    
    if (temp ==0) {
        MBProgressHUD *hud = [MBProgressHUD showHUDAddedTo:self.view animated:YES];
        hud.mode = MBProgressHUDModeAnnularDeterminate;
        hud.label.text = @"正在提交";
       
        [WebRequest ComSpace_ComSpaceOther_Add_ComSpaceDemandWithuserGuid:user.Guid companyId:user.companyId productName:arr_contents[0] GuoBiaoCode:arr_contents[2] productType:arr_contents[1] productDesc:arr_contents[3] indexJson:tstr demandNum:arr_contents[5] demandPrice:arr_contents[4] demandAddress:arr_contents[6] contacts:arr_contents[7] contactWay:arr_contents[8] endTime:arr_contents[9] And:^(NSDictionary *dic) {
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
        MBFadeAlertView *alert = [[MBFadeAlertView alloc]init];
        [alert showAlertWith:@"参数不完整"];
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
        return  arr_contents.count;
    }else if (section ==1)
    {
        return arr_zhibiao.count;
    }else if(section ==2)
    {
        return arr_product.count;
    }else
    {
        return 0;
    }
    
}
-(UITableViewCell*)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    if (indexPath.section ==0) {
    /*if (indexPath.row == 10) {
        static NSString *cellId=@"cellID";
        FBone_SwitchTableViewCell *cell =[tableView dequeueReusableCellWithIdentifier:cellId];
        if (!cell) {
            cell = [[FBone_SwitchTableViewCell alloc]initWithStyle:UITableViewCellStyleValue1 reuseIdentifier:cellId];
            cell.accessoryType = UITableViewCellAccessoryNone;
            
        }
        
        cell.L_left0.text =arr_names[indexPath.row];
        [cell.S_kaiguan addTarget:self action:@selector(kaiClick:) forControlEvents:UIControlEventValueChanged];
        [cell.S_kaiguan setOn:[arr_contents[indexPath.row] integerValue]==1?YES:NO];
        return cell;
    }else */
        if (indexPath.row ==10)
    {
        //特性指标
        
        static NSString *cellId=@"cellID11";
        UITableViewCell *cell =[tableView dequeueReusableCellWithIdentifier:cellId];
        if (!cell) {
            cell = [[UITableViewCell alloc]initWithStyle:UITableViewCellStyleValue1 reuseIdentifier:cellId];
            cell.accessoryType = UITableViewCellAccessoryDisclosureIndicator;
            cell.textLabel.font = [UIFont systemFontOfSize:18];
            
        }
        cell.textLabel.text = arr_names[indexPath.row];
        cell.detailTextLabel.text = arr_contents[indexPath.row];
        
        return cell;
    }
    else
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
    }
    }else if (indexPath.section ==1)
    {
        if (self.temp ==1) {
            static NSString *cellId=@"cellID102";
            FBOneImg_yyLabelTableViewCell *cell =[tableView dequeueReusableCellWithIdentifier:cellId];
            if (!cell) {
                cell = [[FBOneImg_yyLabelTableViewCell alloc]initWithStyle:UITableViewCellStyleValue1 reuseIdentifier:cellId];
                cell.accessoryType = UITableViewCellAccessoryNone;
                cell.textLabel.font = [UIFont systemFontOfSize:18];
                
            }
            SC_maiMaiModel *model  =arr_zhibiao[indexPath.row];
            [cell.IV_img sd_setImageWithURL:[NSURL URLWithString:model.IndexImage] placeholderImage:[UIImage imageNamed:@"imageerror"]];
            NSMutableAttributedString *name = [[NSMutableAttributedString alloc]initWithString:[NSString stringWithFormat:@"指标：%@\n指标值：%@",model.IndexTypeKey,model.IndexTypeValue] attributes:@{NSFontAttributeName:[UIFont systemFontOfSize:15],NSForegroundColorAttributeName:[UIColor grayColor]}];
            cell.yyL_context.attributedText = name;
            [cell.yyL_context mas_makeConstraints:^(MASConstraintMaker *make) {
                make.height.mas_equalTo(100);
                make.left.mas_equalTo(cell.IV_img.mas_right).mas_offset(5);
                make.right.mas_equalTo(cell.mas_right).mas_offset(-15);
                make.centerY.mas_equalTo(cell.mas_centerY);
            }];
            
            return cell;
        }else
        {
        ///特性指标的列表
        static NSString *cellId=@"cellID101";
        FBOneImg_yyLabelTableViewCell *cell =[tableView dequeueReusableCellWithIdentifier:cellId];
        if (!cell) {
            cell = [[FBOneImg_yyLabelTableViewCell alloc]initWithStyle:UITableViewCellStyleValue1 reuseIdentifier:cellId];
            cell.accessoryType = UITableViewCellAccessoryNone;
            cell.textLabel.font = [UIFont systemFontOfSize:18];
            
        }
        SC_productModel *model  =arr_zhibiao[indexPath.row];
        [cell.IV_img sd_setImageWithURL:[NSURL URLWithString:model.productImage] placeholderImage:[UIImage imageNamed:@"imageerror"]];
        NSMutableAttributedString *name = [[NSMutableAttributedString alloc]initWithString:[NSString stringWithFormat:@"指标：%@\n指标值：%@",model.GuoBiaoCode,model.ProductMsg] attributes:@{NSFontAttributeName:[UIFont systemFontOfSize:15],NSForegroundColorAttributeName:[UIColor grayColor]}];
        cell.yyL_context.attributedText = name;
        [cell.yyL_context mas_makeConstraints:^(MASConstraintMaker *make) {
            make.height.mas_equalTo(100);
            make.left.mas_equalTo(cell.IV_img.mas_right).mas_offset(5);
            make.right.mas_equalTo(cell.mas_right).mas_offset(-15);
            make.centerY.mas_equalTo(cell.mas_centerY);
        }];
        
        return cell;
        }
    }else if(indexPath.section ==2)
    {
        return nil;
    }else
    {
        return nil;
    }
        
}

#pragma  mark - 设置是否公开
-(void)kaiClick:(UISwitch*)S_kai
{
    
    if (self.temp ==1) {
    NSString *status = S_kai.isOn ==NO?@"0":@"1";
    [WebRequest ComSpace_ComSpaceDemand_Set_ComSpaceDemandShowWithuserGuid:user.Guid companyId:user.companyId demandId:model_detail.Id showStatus:status And:^(NSDictionary *dic) {
        if ([dic[Y_STATUS] integerValue]==200) {
            
        }else
        {
            MBFadeAlertView *alert= [[MBFadeAlertView alloc]init];
            [alert showAlertWith:@"服务器错误，请重试！"];
            [S_kai setOn:!S_kai.isOn];
        }
    }];
    }else
    {
        
    }
   
}

#pragma  mark - 表的协议代理
-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    if (indexPath.row ==0|| indexPath.row==2|| indexPath.row==8 || indexPath.row==5 || indexPath.row ==4 || indexPath.row ==7) {
        FBTextFieldViewController *TFvc =[[FBTextFieldViewController alloc]init];
        TFvc.delegate =self;
        TFvc.indexPath =indexPath;
        TFvc.content =arr_contents[indexPath.row];
        TFvc.contentTitle =arr_names[indexPath.row];
        dispatch_async(dispatch_get_main_queue(), ^{
            [self.navigationController pushViewController:TFvc animated:NO];
        });
        
    }else if (indexPath.row ==1)
    {
        FBHangYeViewController *Ovc =[[FBHangYeViewController alloc]init];
        Ovc.indexPath =indexPath;
        Ovc.delegate =self;
        [self.navigationController pushViewController:Ovc animated:NO];
    }else if (indexPath.row==3)
    {
        FBTextVViewController *TVvc =[[FBTextVViewController alloc]init];
        TVvc.indexpath =indexPath;
        TVvc.delegate =self;
        TVvc.contentTitle=arr_names[indexPath.row];
        TVvc.content =arr_contents[indexPath.row];
        [self.navigationController pushViewController:TVvc animated:NO];
    }else if (indexPath.row ==6)
    {
        FBAddressViewController  *addressVc = [[FBAddressViewController alloc]init];
        addressVc.delegate =self;
        addressVc.indexPath =indexPath;
        addressVc.isXiangXi =NO;
        [self.navigationController pushViewController:addressVc animated:NO];
    }else if (indexPath.row ==7)
    {
        //联系人
        FB_twoTongShi2ViewController *TSvc = [[FB_twoTongShi2ViewController alloc]init];
        TSvc.delegate_tongshiDan =self;
        TSvc.indexPath =indexPath;
        [self.navigationController pushViewController:TSvc animated:NO];
    }else if (indexPath.row ==9)
    {
        //截止日期
        [self.view addSubview:date_alert];
    }else if (indexPath.row ==10)
    {
        MM_zhiBiaoAddViewController *ZBvc =[[MM_zhiBiaoAddViewController alloc]init];
        ZBvc.delegate_zhibiao = self;
        [self.navigationController pushViewController:ZBvc animated:NO];
    }
    else
    {
        
    }
}
-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    if (indexPath.section ==0 || indexPath.section ==1) {
        return 60;
    }else
    {
        return 110;
    }
}

#pragma  mark - 指标
-(void)getZhibiao:(NSString *)zhibiao valueZhibiao:(NSString *)valuezhibiao imageUrl:(NSString *)imageUrl
{
    SC_productModel *model = [[SC_productModel alloc]init];
    model.productImage =[NSString stringWithFormat:@"%@%@",HTTP_PATH,imageUrl];
    model.GuoBiaoCode = zhibiao;
    model.ProductMsg = valuezhibiao;
    [arr_zhibiao addObject:model];
    [tableV reloadSections:[NSIndexSet indexSetWithIndex:1] withRowAnimation:UITableViewRowAnimationNone];
}
-(void)getComUserModel:(Com_UserModel *)model_com indexpath:(NSIndexPath *)indexPath
{
    [arr_contents replaceObjectAtIndex:indexPath.row withObject:model_com.username];
    [tableV reloadRowsAtIndexPaths:@[indexPath] withRowAnimation:UITableViewRowAnimationNone];
    NSString *para = [NSString stringWithFormat:@"Contacts='%@'",model_com.username];
    [WebRequest ComSpace_ComSpaceDemand_Update_ComSpaceDemandWithuserGuid:user.Guid companyId:user.companyId demandId:model_detail.Id para:para And:^(NSDictionary *dic) {
        if ([dic[Y_STATUS]integerValue]==200) {
            MBFadeAlertView *alert = [[MBFadeAlertView alloc]init];
            [alert showAlertWith:@"修改成功"];
        }else
        {
            MBFadeAlertView *alert = [[MBFadeAlertView alloc]init];
            [alert showAlertWith:@"修改失败，请重试"];
        }
    }];
}


@end
