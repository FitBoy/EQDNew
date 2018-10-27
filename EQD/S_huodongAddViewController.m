//
//  S_huodongAddViewController.m
//  EQD
//
//  Created by 梁新帅 on 2018/9/29.
//  Copyright © 2018年 FitBoy. All rights reserved.
//

#import "S_huodongAddViewController.h"
#import "FBOne_img2TableViewCell.h"
#import "EQDR_labelTableViewCell.h"
#import "FBLabel_segmentTableViewCell.h"
#import <Masonry.h>
#import "FBTextFieldViewController.h"
#import "DatePicer_AlertView.h"
#import "FBAddressViewController.h"
#import "ActiveClassViewController.h"
#import "ActiveFenLeiViewController.h"
#import "DatePicer_AlertView.h"
#import <UIImageView+WebCache.h>
#import "FBEQDEditer_AllViewController.h"
@interface S_huodongAddViewController ()<FBEQDEditer_AllViewControllerDlegate,ActiveFenLeiViewControllerDelegate,ActiveClassViewControllerDelegate,FBAddressViewControllerDelegate,FBTextFieldViewControllerDelegate,UITableViewDelegate,UITableViewDataSource,UINavigationControllerDelegate, UIImagePickerControllerDelegate>
{
    UITableView *tableV;
    NSMutableArray *arr_model_base;
    NSMutableArray *arr_model_baseT;
    NSMutableArray *arr_model_contents;
      NSMutableArray *arr_model_contentsT;
    NSMutableArray *arr_model_baoming;
    NSMutableArray *arr_model_baomingT;

    NSMutableArray *arr_model_contact;
    NSMutableArray *arr_model_contactT;
    UserModel *user;
    DatePicer_AlertView *date_alert;
    UIImagePickerController *picker;
    
    //再加一个人或者企业
    ///封面图
    UIImage *image_fengmian;
    ///确定选择的是哪一个富文本编辑框
    NSInteger temp;
    ///记录富文本的高度
    NSMutableArray *arr_height_htmlText;
    ///活动的费用
    NSString *active_price;
    NSString *price_name;
    ///参会资格审核不审核
    NSInteger  canHui;
    ///发布人身份
   NSInteger shenfen;
    
    NSArray *arr_taddress;
    ///图片在服务器的路径
    NSString *image_path;
}

@end

@implementation S_huodongAddViewController
-(void)viewWillAppear:(BOOL)animated{
    [super viewWillAppear:animated];
}

- (BOOL)prefersHomeIndicatorAutoHidden{
    return NO;
}
#pragma  mark - 单行的输入
-(void)content:(NSString *)content WithindexPath:(NSIndexPath *)indexPath
{
    if(indexPath.section ==0)
    {
        [arr_model_baseT replaceObjectAtIndex:indexPath.row withObject:content];
        [tableV reloadSections:[NSIndexSet indexSetWithIndex:0] withRowAnimation:UITableViewRowAnimationNone];
    }else if (indexPath.section ==2)
    {
        [arr_model_baomingT replaceObjectAtIndex:indexPath.row withObject:content];
        [tableV reloadSections:[NSIndexSet indexSetWithIndex:2] withRowAnimation:UITableViewRowAnimationNone];
    }else if (indexPath.section==4)
    {
        //联系人信息
        [arr_model_contactT replaceObjectAtIndex:indexPath.row withObject:content];
        [tableV reloadSections:[NSIndexSet indexSetWithIndex:4] withRowAnimation:UITableViewRowAnimationNone];
        
    }else
    {
        
    }
}
#pragma  mark - 地址
-(void)address:(NSString *)address Withindexpath:(NSIndexPath *)indexPath arr_address:(NSArray *)arr_address
{
    NSArray *tarr = [address componentsSeparatedByString:@"-"];
    
    NSString *tstr = [NSString stringWithFormat:@"%@%@",arr_address[0],arr_address[1]];
     NSString *xiangxi= [tarr[0] substringFromIndex:tstr.length];
    NSMutableArray *tarr1 = [NSMutableArray arrayWithCapacity:0];
    for (int i=0; i<arr_address.count; i++) {
        [tarr1 addObject:arr_address[i]];
    }
    [tarr1 addObject:xiangxi];
    
    arr_taddress  =tarr1;
    
    
    [arr_model_baseT replaceObjectAtIndex:indexPath.row withObject:tarr[0]];
    [tableV reloadRowsAtIndexPaths:@[indexPath] withRowAnimation:UITableViewRowAnimationNone];
}
- (void)viewDidLoad {
    [super viewDidLoad];
    image_path = nil;
    arr_taddress = nil;
    temp =0;
    price_name = @"活动费用";
    canHui = 0;
    active_price =@"0";
    self.navigationItem.title = @"添加活动";
    user = [WebRequest GetUserInfo];
    arr_model_baseT = [NSMutableArray arrayWithArray:@[@"请输入",@"请选择",@"请选择",@"请输入",@"请输入",@"请选择",@"请选择",@"请输入",]];
    arr_model_base = [NSMutableArray arrayWithArray:@[@"活动标题",@"活动类型 ",@"活动分类 ",@"活动人数",@"活动规模",@"活动开始时间",@"活动结束时间",@"活动地址"]];
    arr_model_contents = [NSMutableArray arrayWithArray:@[@"活动封面图",@"活动描述",@"活动日程"]];
    arr_model_contentsT = [NSMutableArray arrayWithArray:@[@"请选择",@"请输入",@"请输入"]];
    arr_model_baoming = [NSMutableArray arrayWithArray:@[@"审核参会资格",@"参会对象"]];
    arr_model_baomingT = [NSMutableArray arrayWithArray:@[@"是否审核",@"请输入"]];
    
    arr_model_contact = [NSMutableArray arrayWithArray:@[@"姓名",@"部门",@"职位",@"手机",@"邮箱"]];
    arr_model_contactT = [NSMutableArray arrayWithArray:@[user.username,@"请输入",@"请输入",user.uname,@"请输入"]];
    tableV = [[UITableView alloc]initWithFrame:CGRectMake(0, DEVICE_TABBAR_Height, DEVICE_WIDTH, DEVICE_HEIGHT-DEVICE_TABBAR_Height-kBottomSafeHeight) style:UITableViewStyleGrouped];
    adjustsScrollViewInsets_NO(tableV, self);
    tableV.delegate=self;
    tableV.dataSource=self;
    [self.view addSubview:tableV];
    tableV.rowHeight=60;
    tableV.contentInset = UIEdgeInsetsMake(15, 0, 0, 0);
    
    user = [WebRequest GetUserInfo];
    UIBarButtonItem *right = [[UIBarButtonItem alloc]initWithTitle:@"提交" style:UIBarButtonItemStylePlain target:self action:@selector(tijiaoCLick)];
    [self.navigationItem setRightBarButtonItem:right];
    
    date_alert =[[DatePicer_AlertView alloc]initWithFrame:self.view.frame];
    NSDateFormatter *formatter =[[NSDateFormatter alloc]init];
    [formatter setDateFormat:@"yyyy-MM-dd HH:mm"];
    NSString *date_str = [formatter stringFromDate:[NSDate date]];
    [date_alert setDate:date_str];
    date_alert.picker.datePickerMode =UIDatePickerModeDateAndTime;
    [date_alert.two_btn setleftname:@"取消" rightname:@"确定"];
    [date_alert.two_btn.B_left addTarget:self action:@selector(leftClick) forControlEvents:UIControlEventTouchUpInside];
    [date_alert.two_btn.B_right addTarget:self action:@selector(rightClick) forControlEvents:UIControlEventTouchUpInside];
    picker = [[UIImagePickerController alloc]init];
    picker.delegate = self;
    picker.allowsEditing =YES;
    image_fengmian = nil;
    arr_height_htmlText = [NSMutableArray arrayWithArray:@[@"60",@"60"]];
    if(self.shenfenF < 0)
    {
    shenfen = 0;
    }else
    {
        shenfen = self.shenfenF;
    }
}


-(void)leftClick
{
    [date_alert removeFromSuperview];
}
-(void)rightClick
{
    NSDateFormatter *formatter =[[NSDateFormatter alloc]init];
    [formatter setDateFormat:@"yyyy-MM-dd HH:mm"];
    NSString *date_str = [formatter stringFromDate:date_alert.picker.date];
    
    [arr_model_baseT replaceObjectAtIndex:date_alert.two_btn.B_right.indexpath.row withObject:date_str];
    [tableV reloadRowsAtIndexPaths:@[date_alert.two_btn.B_right.indexpath] withRowAnimation:UITableViewRowAnimationNone];
    
    [date_alert removeFromSuperview];
}
-(void)tijiaoCLick
{
    
    NSInteger ttemp = 0;
    for (int i=0; i<arr_model_baseT.count; i++) {
        if ([arr_model_baseT[i] isEqualToString:@"请输入"] || [arr_model_baseT[i] isEqualToString:@"请选择"] ) {
            ttemp =1;
            break;
        }
    }
    
    for(int i=0;i<arr_model_contentsT.count;i++)
    {
        if ([arr_model_contentsT[i] isEqualToString:@"请输入"] || [arr_model_contentsT[i] isEqualToString:@"请选择"] ) {
            ttemp =1;
            break;
        }
    }
    if ([arr_model_baomingT[1] isEqualToString:@"请输入"]) {
        ttemp =1;
    }
    
    for (int i=0; i<arr_model_contactT.count; i++) {
        if ([arr_model_contactT[i] isEqualToString:@"请输入"] || [arr_model_contactT[i] isEqualToString:@"请选择"] ) {
            ttemp =1;
            break;
        }
    }
    
    if (ttemp ==0) {
        
    NSString *companyId = shenfen ==0?@"0":user.companyId;
    NSString *isChecked = canHui ==0?@"false":@"true";
    NSString *ischarge = [active_price integerValue]==0? @"false":@"true";
        MBProgressHUD *hud = [MBProgressHUD showHUDAddedTo:self.view animated:YES];
        hud.mode = MBProgressHUDModeAnnularDeterminate;
        hud.label.text = @"正在处理";
    [WebRequest Activity_Add_ActivityWithuserGuid:user.Guid companyId:companyId actType:arr_model_baseT[1] actClassify:arr_model_baseT[2] actTitle:arr_model_baseT[0] actNum:arr_model_baseT[3] actScale:arr_model_baseT[4] actStartTime:arr_model_baseT[5] actEndTime:arr_model_baseT[6] actProvince:arr_taddress[0] actCity:arr_taddress[1] actAddress:[NSString stringWithFormat:@"%@%@",arr_taddress[2],arr_taddress[3]] ischeck:isChecked actObject:arr_model_baomingT[1] actImg:image_path actDesc:arr_model_contentsT[1] actSchedule:arr_model_contentsT[2] isCharge:ischarge price:active_price name:arr_model_contactT[0] department:arr_model_contactT[1] post:arr_model_contactT[2] phone:arr_model_contactT[3] email:arr_model_contactT[4] And:^(NSDictionary *dic) {
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
        hud.label.text =@"信息填写不完整";
        dispatch_time_t popTime = dispatch_time(DISPATCH_TIME_NOW, 1 * NSEC_PER_SEC);
        dispatch_after(popTime, dispatch_get_main_queue(), ^(void){
            [MBProgressHUD hideHUDForView:self.view  animated:YES];
        });
    }
    
}

-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    if(indexPath.section ==1&& indexPath.row ==1)
    {
        return [arr_height_htmlText[0] floatValue];
    }else if (indexPath.section ==1&& indexPath.row ==2)
    {
        return [arr_height_htmlText[1] floatValue];
    }else
    {
    return 60;
    }
}
-(NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    
    return self.shenfenF<0? 6:5;
}
-(CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section
{
    return 20;
}
-(NSString*)tableView:(UITableView *)tableView titleForHeaderInSection:(NSInteger)section
{
    NSArray *tarr = @[@"活动基本信息",@"活动内容",@"报名",@"费用",@"联系人信息",@"发布人身份"];
    return tarr[section];
}
#pragma  mark - 表的数据源
-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    switch (section) {
        case 0:
        {
            return arr_model_base.count;
        }
            break;
        case 1:
        {
            return arr_model_contents.count;
        }
            break;
        case 2:
        {
            return arr_model_baoming.count;
        }
            break;
        case 3:
        {
            return 1;
        }
            break;
        case 4:
        {
            return arr_model_contact.count;
        }
            break;
        case 5:
        {
            return 1;
        }
            break;
        default:
            return 0;
            break;
    }
}
-(UITableViewCell*)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    switch (indexPath.section) {
        case 0:
        {
            ///活动基本信息
            static NSString *cellId=@"cellID0";
            UITableViewCell *cell =[tableView dequeueReusableCellWithIdentifier:cellId];
            if (!cell) {
                cell = [[UITableViewCell alloc]initWithStyle:UITableViewCellStyleValue1 reuseIdentifier:cellId];
                cell.accessoryType = UITableViewCellAccessoryDisclosureIndicator;
                cell.textLabel.font = [UIFont systemFontOfSize:18];
            }
            cell.textLabel.text = arr_model_base[indexPath.row];
            cell.detailTextLabel.text = arr_model_baseT[indexPath.row];
            return cell;
        }
            break;
            case 1:
        {
            ///活动内容
            if (indexPath.row ==0) {
                ///封面图
                static NSString *cellId=@"cellID10";
                FBOne_img2TableViewCell *cell =[tableView dequeueReusableCellWithIdentifier:cellId];
                if (!cell) {
                    cell = [[FBOne_img2TableViewCell alloc]initWithStyle:UITableViewCellStyleValue1 reuseIdentifier:cellId];
                    cell.accessoryType = UITableViewCellAccessoryNone;
                    cell.textLabel.font = [UIFont systemFontOfSize:18];
                }else
                {
                    
                }
                cell.L_left0.text = arr_model_contents[indexPath.row];
                if (image_fengmian == nil) {
                    cell.IV_img.image = nil;
                }else
                {
                cell.IV_img.image = image_fengmian;
                }
                return cell;
            }else if (indexPath.row==1 || indexPath.row ==2)
            {
                static NSString *cellId=@"cellID11";
                EQDR_labelTableViewCell *cell =[tableView dequeueReusableCellWithIdentifier:cellId];
                if (!cell) {
                    cell = [[EQDR_labelTableViewCell alloc]initWithStyle:UITableViewCellStyleDefault reuseIdentifier:cellId];
                    cell.accessoryType = UITableViewCellAccessoryNone;
                }else
                {
                    
                }
                if ([arr_model_contentsT[indexPath.row] isEqualToString:@"请输入"]) {
                    cell.YL_label.attributedText = [[NSMutableAttributedString alloc]initWithString:arr_model_contents[indexPath.row] attributes:@{NSFontAttributeName:[UIFont systemFontOfSize:17]}];
                    [cell.YL_label mas_remakeConstraints:^(MASConstraintMaker *make) {
                        make.height.mas_equalTo(60);
                        make.left.mas_equalTo(cell.mas_left).mas_offset(15);
                        make.right.mas_equalTo(cell.mas_right).mas_offset(-15);
                        make.centerY.mas_equalTo(cell.mas_centerY);
                    }];
                }else
                {
                    NSString * htmlString =[NSString stringWithFormat:@"<html><body style = \"font-size:17px\">%@ </body></html>",arr_model_contentsT[indexPath.row]] ;
                    NSAttributedString * attrStr = [[NSAttributedString alloc] initWithData:[htmlString dataUsingEncoding:NSUnicodeStringEncoding] options:@{ NSDocumentTypeDocumentAttribute: NSHTMLTextDocumentType } documentAttributes:nil error:nil];
                    CGSize size = [attrStr boundingRectWithSize:CGSizeMake(DEVICE_WIDTH-30, MAXFLOAT) options:NSStringDrawingUsesLineFragmentOrigin context:nil].size;
                    cell.YL_label.attributedText = attrStr;
                    [arr_height_htmlText replaceObjectAtIndex:indexPath.row-1 withObject:[NSString stringWithFormat:@"%.2f",size.height+15]];
                    
                    [cell.YL_label mas_remakeConstraints:^(MASConstraintMaker *make) {
                        make.height.mas_equalTo(size.height+10);
                        make.left.mas_equalTo(cell.mas_left).mas_offset(15);
                        make.right.mas_equalTo(cell.mas_right).mas_offset(-15);
                        make.centerY.mas_equalTo(cell.mas_centerY);
                    }];
                
                }
                return cell;

            }else
            {
                return nil;
            }
            
        }
            break;
            case 2:
        {
            //报名
            if (indexPath.row ==0) {
                static NSString *cellId=@"cellID20";
                FBLabel_segmentTableViewCell *cell =[tableView dequeueReusableCellWithIdentifier:cellId];
                if (!cell) {
                    cell = [[FBLabel_segmentTableViewCell alloc]initWithStyle:UITableViewCellStyleDefault reuseIdentifier:cellId];
                    cell.accessoryType = UITableViewCellAccessoryNone;
                }else
                {
                }
                cell.L_name.text = arr_model_baoming[indexPath.row];
                cell.SC_choose.indexPath = indexPath;
                [cell.SC_choose setSelectedSegmentIndex:canHui];
                [cell.SC_choose  setTitle:@"不审" forSegmentAtIndex:0];
                [cell.SC_choose  setTitle:@"审核" forSegmentAtIndex:1];
                [cell.SC_choose addTarget:self action:@selector(baomingCLick:) forControlEvents:UIControlEventValueChanged];
                
                return cell;
            }else if (indexPath.row ==1)
            {
                //活动对象
                static NSString *cellId=@"cellID21";
                UITableViewCell *cell =[tableView dequeueReusableCellWithIdentifier:cellId];
                if (!cell) {
                    cell = [[UITableViewCell alloc]initWithStyle:UITableViewCellStyleValue1 reuseIdentifier:cellId];
                    cell.accessoryType = UITableViewCellAccessoryDisclosureIndicator;
                }else
                {
                    
                }
                cell.textLabel.text = arr_model_baoming[indexPath.row];
                cell.detailTextLabel.text = arr_model_baomingT[indexPath.row];
                return cell;
            }else
            {
                return nil;
            }
        }
            break;
            case 3:
        {
            //费用
            static NSString *cellId=@"cellID3";
            FBLabel_segmentTableViewCell *cell =[tableView dequeueReusableCellWithIdentifier:cellId];
            if (!cell) {
                cell = [[FBLabel_segmentTableViewCell alloc]initWithStyle:UITableViewCellStyleDefault reuseIdentifier:cellId];
                cell.accessoryType = UITableViewCellAccessoryNone;
                cell.textLabel.font = [UIFont systemFontOfSize:18];
            }
            cell.L_name.text = price_name;
            cell.SC_choose.indexPath = indexPath;
            [cell.SC_choose setSelectedSegmentIndex:[active_price integerValue] ==0? 0:1];
            [cell.SC_choose  setTitle:@"免费" forSegmentAtIndex:0];
            [cell.SC_choose  setTitle:@"收费" forSegmentAtIndex:1];
            [cell.SC_choose addTarget:self action:@selector(feiyongCLIck:) forControlEvents:UIControlEventValueChanged];
            return cell;
            
        }
            break;
            case 4:
        {
            //联系人信息
            static NSString *cellId=@"cellID4";
            UITableViewCell *cell =[tableView dequeueReusableCellWithIdentifier:cellId];
            if (!cell) {
                cell = [[UITableViewCell alloc]initWithStyle:UITableViewCellStyleValue1 reuseIdentifier:cellId];
                cell.accessoryType = UITableViewCellAccessoryDisclosureIndicator;
                cell.textLabel.font = [UIFont systemFontOfSize:18];
            }
            cell.textLabel.text = arr_model_contact[indexPath.row];
            cell.detailTextLabel.text = arr_model_contactT[indexPath.row];
            return cell;
        }
            break;
            case 5:
        {
            static NSString *cellId=@"cellID50";
            FBLabel_segmentTableViewCell *cell =[tableView dequeueReusableCellWithIdentifier:cellId];
            if (!cell) {
                cell = [[FBLabel_segmentTableViewCell alloc]initWithStyle:UITableViewCellStyleDefault reuseIdentifier:cellId];
                cell.accessoryType = UITableViewCellAccessoryNone;
            }else
            {
            }
            cell.L_name.text = @"发布人身份";
            cell.SC_choose.indexPath = indexPath;
            [cell.SC_choose setSelectedSegmentIndex:shenfen];
            [cell.SC_choose  setTitle:@"个人" forSegmentAtIndex:0];
            [cell.SC_choose  setTitle:@"企业" forSegmentAtIndex:1];
            [cell.SC_choose addTarget:self action:@selector(shenFenCLick:) forControlEvents:UIControlEventValueChanged];
            
            return cell;
        }
            break;
        default:
        {
            return nil;
        }
            break;
    }
    
    
    
    
  /*  static NSString *cellId=@"cellID";
    UITableViewCell *cell =[tableView dequeueReusableCellWithIdentifier:cellId];
    if (!cell) {
        cell = [[UITableViewCell alloc]initWithStyle:UITableViewCellStyleDefault reuseIdentifier:cellId];
        cell.accessoryType = UITableViewCellAccessoryDisclosureIndicator;
        cell.textLabel.font = [UIFont systemFontOfSize:18];
    }
    return cell;*/
}
#pragma  mark - 相机选中的协议代理
-(void)imagePickerController:(UIImagePickerController *)picker didFinishPickingMediaWithInfo:(NSDictionary<NSString *,id> *)info
{
    UIImage *image = [info objectForKey:UIImagePickerControllerEditedImage];
    image_fengmian = image;
    [self dismissViewControllerAnimated:NO completion:nil];
   
    dispatch_async(dispatch_get_main_queue(), ^{
        [WebRequest  Reimburse_Upload_FilesWithimages:@[image] And:^(NSDictionary *dic) {
            if ([dic[Y_STATUS] integerValue]==200) {
                NSArray *tarr = [dic[Y_ITEMS] componentsSeparatedByString:@";"];
                image_path = tarr[0];
                [arr_model_contentsT replaceObjectAtIndex:0 withObject:@"已选择"];
                 [tableV reloadRowsAtIndexPaths:@[[NSIndexPath indexPathForRow:0 inSection:1]] withRowAnimation:UITableViewRowAnimationNone];
            }else
            {
                MBFadeAlertView *alert = [[MBFadeAlertView alloc]init];
                [alert showAlertWith:@"图片解析错误，请重试"];
            }
        }];
    });
   
    
}
#pragma  mark - 发布人身份
-(void)shenFenCLick:(FBSegmentedControl*)SC_choose{
   if(SC_choose.selectedSegmentIndex ==0)
   {
       shenfen =0;
   }else
   {
       shenfen =1;
   }
}
#pragma  mark - 报名
-(void)baomingCLick:(FBSegmentedControl*)SC_choose{
    if (SC_choose.selectedSegmentIndex ==0) {
        //不审核
        canHui = 0;
    }else
    {
        //审核
        canHui =1;
    }
}
#pragma  mark - 费用
-(void)feiyongCLIck:(FBSegmentedControl*)SC_choose{
    if(SC_choose.selectedSegmentIndex ==1)
    {
        //收费
        UIAlertController *alert = [UIAlertController alertControllerWithTitle:@"请输入活动报名费用（元）" message:nil preferredStyle:UIAlertControllerStyleAlert];
        [alert addTextFieldWithConfigurationHandler:^(UITextField * _Nonnull textField) {
            textField.placeholder = @"报名费用(元)";
        }];
        [alert addAction:[UIAlertAction actionWithTitle:@"取消" style:UIAlertActionStyleCancel handler:^(UIAlertAction * _Nonnull action) {
            
        }]];
        [alert addAction:[UIAlertAction actionWithTitle:@"确定" style:UIAlertActionStyleDefault handler:^(UIAlertAction * _Nonnull action) {
            price_name = [NSString stringWithFormat:@"报名费用：%@元",alert.textFields[0].text];
            active_price = alert.textFields[0].text;
            [tableV reloadRowsAtIndexPaths:@[[NSIndexPath indexPathForRow:0 inSection:3]] withRowAnimation:UITableViewRowAnimationNone];
        }]];
        
        [self presentViewController:alert animated:NO completion:nil];
        
    }else
    {
        active_price =@"0";
        price_name = @"活动费用";
        [tableV reloadRowsAtIndexPaths:@[[NSIndexPath indexPathForRow:0 inSection:3]] withRowAnimation:UITableViewRowAnimationNone];
    }
}
#pragma  mark - 活动类型
-(void)getClass:(NSString *)activeClass withIndexPath:(NSIndexPath *)indexPath
{
    [arr_model_baseT replaceObjectAtIndex:indexPath.row withObject:activeClass];
    [tableV  reloadRowsAtIndexPaths:@[indexPath] withRowAnimation:UITableViewRowAnimationNone];

}
#pragma  mark - 表的协议代理
-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    switch (indexPath.section) {
        case 0:
        {
           //活动的基本信息
            if(indexPath.row ==0 || indexPath.row ==3 || indexPath.row ==4)
            {
                FBTextFieldViewController *TFvc =[[FBTextFieldViewController alloc]init];
                TFvc.delegate =self;
                TFvc.indexPath =indexPath;
                TFvc.content =arr_model_baseT[indexPath.row];
                TFvc.contentTitle =arr_model_base[indexPath.row];
                [self.navigationController pushViewController:TFvc animated:NO];
            }else if (indexPath.row ==1)
            {
                //活动类型
                ActiveClassViewController  *ACvc = [[ActiveClassViewController alloc]init];
                ACvc.delegate_activity = self;
                ACvc.indexPath = indexPath;
                [self.navigationController pushViewController:ACvc animated:NO];
            }else if (indexPath.row ==2)
            {
                ///活动分类
                ActiveFenLeiViewController  *FLvc = [[ActiveFenLeiViewController alloc]init];
                FLvc.delegate_class = self;
                FLvc.indexpath = indexPath;
                [self.navigationController pushViewController:FLvc animated:NO];
            }else if (indexPath.row ==5 || indexPath.row ==6)
            {
                //活动时间
                date_alert.two_btn.B_right.indexpath = indexPath;
                [self.view addSubview:date_alert];
            
            }else if (indexPath.row ==7)
            {
               //活动地址
                FBAddressViewController  *Avc = [[FBAddressViewController alloc]init];
                Avc.indexPath = indexPath;
                Avc.delegate = self;
                Avc.isXiangXi = YES;
                [self.navigationController pushViewController:Avc animated:NO];
            }
            else
            {
                
            }
        }
            break;
            case 1:
        {
          //活动的内容
            if (indexPath.row ==0) {
                ///活动封面图
                UIAlertController *alert = [[UIAlertController alloc]init];
                if([UIImagePickerController isSourceTypeAvailable:UIImagePickerControllerSourceTypePhotoLibrary])
                {
                    [alert addAction:[UIAlertAction actionWithTitle:@"相册" style:UIAlertActionStyleDefault handler:^(UIAlertAction * _Nonnull action) {
                        picker.sourceType = UIImagePickerControllerSourceTypePhotoLibrary;
                        dispatch_async(dispatch_get_main_queue(), ^{
                            [self presentViewController:picker animated:NO completion:nil];
                        });
                    }]];
                    
                }
                if ([UIImagePickerController isSourceTypeAvailable:UIImagePickerControllerSourceTypeCamera]) {
                    picker.sourceType = UIImagePickerControllerSourceTypeCamera;
                    dispatch_async(dispatch_get_main_queue(), ^{
                        [self presentViewController:picker animated:NO completion:nil];
                    });
                }
                [alert addAction:[UIAlertAction actionWithTitle:@"取消" style:UIAlertActionStyleCancel handler:^(UIAlertAction * _Nonnull action) {
                    
                }]];
                
                [self presentViewController:alert animated:NO completion:nil];
                
            }else if (indexPath.row ==1 || indexPath.row ==2)
            {
               //活动描述  活动日程
                FBEQDEditer_AllViewController  *Avc = [[FBEQDEditer_AllViewController alloc]init];
                Avc.delegate = self;
                Avc.temp = 10;
                temp = indexPath.row;
                [self.navigationController pushViewController:Avc animated:NO];
                
            }else
            {
                
            }
        }
            break;
        case 2:
        {
            //报名
            if (indexPath.row ==1) {
                FBTextFieldViewController *TFvc =[[FBTextFieldViewController alloc]init];
                TFvc.delegate =self;
                TFvc.indexPath =indexPath;
                TFvc.content =arr_model_baomingT[indexPath.row];
                TFvc.contentTitle =arr_model_baoming[indexPath.row];
                [self.navigationController pushViewController:TFvc animated:NO];
            }else
            {
                
            }
        }
            break;
            case 3:
        {
           //费用
        }
            break;
            case 4:
        {
            ///联系人信息
            FBTextFieldViewController *TFvc =[[FBTextFieldViewController alloc]init];
            TFvc.delegate =self;
            TFvc.indexPath =indexPath;
            TFvc.content =arr_model_contactT[indexPath.row];
            TFvc.contentTitle =arr_model_contact[indexPath.row];
            [self.navigationController pushViewController:TFvc animated:NO];
        }
            break;
            
        default:
            break;
    }
}

#pragma  mark - 富文本编辑
-(void)getEditerTitle:(NSString *)title html:(NSString *)html text:(NSString *)text imgurl:(NSString *)imgurl stringData:(NSData *)data
{
    [arr_model_contentsT replaceObjectAtIndex:temp withObject:html];
    [tableV reloadRowsAtIndexPaths:@[[NSIndexPath indexPathForRow:temp inSection:1]] withRowAnimation:UITableViewRowAnimationNone];
}
#pragma  mark - 活动分类
-(void)getClass:(NSString *)className WithIndexPath:(NSIndexPath *)indexPath
{
    [arr_model_baseT replaceObjectAtIndex:indexPath.row withObject:className];
    [tableV reloadRowsAtIndexPaths:@[indexPath] withRowAnimation:UITableViewRowAnimationNone];
}



@end
