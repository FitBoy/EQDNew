//
//  CK_hangyeViewController.m
//  EQD
//
//  Created by 梁新帅 on 2018/8/4.
//  Copyright © 2018年 FitBoy. All rights reserved.
//

#import "CK_hangyeViewController.h"
#import "headTitleAddView.h"
#import "FBHangYeViewController.h"
#import "FBJobViewController.h"
#import "CK_fuWuChoosViewController.h"
#import "DatePicer_AlertView.h"
#import "CK_hangyeModel.h"
@interface CK_hangyeViewController ()<UITableViewDelegate,UITableViewDataSource,FBHangYeViewControllerDelegate,FBJobViewControllerDelegate,CK_fuWuChoosViewControllerDelegate>
{
    UITableView *tableV;
    UserModel *user;

    headTitleAddView *headview1;
    NSMutableArray *arr_names1;
    headTitleAddView *headview2;
    NSMutableArray *arr_names2;
    headTitleAddView *headview3;
    NSMutableArray *arr_names3;
    headTitleAddView *headview4;
    NSMutableArray *arr_names4;
    headTitleAddView *headview5;
    NSMutableArray *arr_names5;
    headTitleAddView *headview6;
    NSMutableArray *arr_names6;
    NSString *shiduan;
    NSString *shiduan_start;
    NSString *shiduan_end;
    
    NSArray *arr_fangshi;
    NSArray *arr_time;
    
    DatePicer_AlertView *date_alert;
}

@end

@implementation CK_hangyeViewController
-(void)viewWillAppear:(BOOL)animated{
    [super viewWillAppear:animated];
   
}
#pragma  mark - 服务方式
-(void)getFuwu:(NSString *)fuwu dayTime:(NSString *)dayTime hourTime:(NSString *)hourTime index:(NSString *)index
{
    
    [WebRequest Makerspacey_MakerIndustry_Add_MakerServiceModeWithtype:index oneDayPrice:dayTime oneHourPrice:hourTime userGuid:user.Guid  And:^(NSDictionary *dic) {
        if ([dic[Y_STATUS] integerValue]==200) {
            CK_hangyeModel *model = [CK_hangyeModel mj_objectWithKeyValues:dic[Y_ITEMS]];
             [arr_names5 addObject:model];
            dispatch_async(dispatch_get_main_queue(), ^{
              [tableV reloadSections:[NSIndexSet indexSetWithIndex:4] withRowAnimation:UITableViewRowAnimationNone];
            });
        }else
        {
            MBFadeAlertView *alert = [[MBFadeAlertView alloc]init];
            [alert showAlertWith:dic[Y_MSG]];
        }
        
    }];
   
   
}
-(void)loadRequestData{
    [WebRequest Makerspacey_MakerIndustry_Get_MakerIndustryWithuserGuid:user.Guid And:^(NSDictionary *dic) {
        if ([dic[Y_STATUS] integerValue]==200) {
            NSDictionary  *tdic = dic[Y_ITEMS];
            /// 所在行业
            NSArray *tarr1 =tdic[@"Industry"];
            [arr_names1 removeAllObjects];
            for(int i=0;i<tarr1.count;i++)
            {
                CK_hangyeModel  *model = [CK_hangyeModel mj_objectWithKeyValues:tarr1[i]];
                [arr_names1 addObject:model];
            }
            ///所在的岗位
            NSArray *tarr2 = tdic[@"Post"];
            [arr_names2 removeAllObjects];
            for (int i=0; i<tarr2.count; i++) {
            CK_hangyeModel  *model = [CK_hangyeModel mj_objectWithKeyValues:tarr2[i]];
                [arr_names2 addObject:model];
            }
            
            /// 您提供的所在的服务
            NSArray *tarr3 = tdic[@"ServiceIndustry"];
            [arr_names3 removeAllObjects];
            for (int i=0; i<tarr3.count; i++) {
                CK_hangyeModel  *model = [CK_hangyeModel mj_objectWithKeyValues:tarr3[i]];
                [arr_names3 addObject:model];
                
            }
            ///服务的岗位
            NSArray *tarr4 = tdic[@"ServicePost"];
            [arr_names4 removeAllObjects];
            for (int i=0; i<tarr4.count; i++) {
                  CK_hangyeModel  *model = [CK_hangyeModel mj_objectWithKeyValues:tarr4[i]];
                [arr_names4 addObject:model];
            }
            ///服务方式
            /*
             {
             Id = 20;
             OneDayPrice = 200;
             OneHourPrice = 10;
             createTime = "2018/8/7 17:08:43";
             type = 1;
             }
             
             {
             Id = 10;
             createTime = "2018/8/7 17:11:57";
             post = "PS\U8bbe\U8ba1";
             type = 1;
             }
             */
            NSArray *tarr5 = tdic[@"ServiceMode"];
            [arr_names5  removeAllObjects];
            for (int i=0; i<tarr5.count; i++) {
                CK_hangyeModel *model = [CK_hangyeModel mj_objectWithKeyValues:tarr5[i]];
                [arr_names5 addObject:model];
            }
            //服务时间
            NSArray *tarr7 =tdic[@"ServiceTime"];
            for (int i=0; i<tarr7.count; i++) {
                CK_hangyeModel  *model = [CK_hangyeModel mj_objectWithKeyValues:tarr7[i]];
                [arr_names6 addObject:model];
            }
            
            [tableV reloadData];
        }
    }];
}
- (BOOL)prefersHomeIndicatorAutoHidden{
    return NO;
}
- (void)viewDidLoad {
    [super viewDidLoad];
    user = [WebRequest GetUserInfo];
    self.navigationItem.title = @"所属行业";
    tableV = [[UITableView alloc]initWithFrame:CGRectMake(0, DEVICE_TABBAR_Height, DEVICE_WIDTH, DEVICE_HEIGHT-DEVICE_TABBAR_Height-kBottomSafeHeight) style:UITableViewStyleGrouped];
    adjustsScrollViewInsets_NO(tableV, self);
    tableV.delegate=self;
    tableV.dataSource=self;
    [self.view addSubview:tableV];
    tableV.rowHeight=60;
    [self headViewinit];
    
    date_alert =[[DatePicer_AlertView alloc]initWithFrame:self.view.frame];
    NSDateFormatter *formatter =[[NSDateFormatter alloc]init];
    [formatter setDateFormat:@"HH:mm"];
    NSString *date_str = [formatter stringFromDate:[NSDate date]];
    [date_alert setDate2:date_str];
    date_alert.picker.datePickerMode =UIDatePickerModeTime;
    [date_alert.two_btn setleftname:@"取消" rightname:@"确定"];
    [date_alert.two_btn.B_left addTarget:self action:@selector(leftClick) forControlEvents:UIControlEventTouchUpInside];
    [date_alert.two_btn.B_right addTarget:self action:@selector(rightClick) forControlEvents:UIControlEventTouchUpInside];
 [self loadRequestData];
    
    arr_fangshi =@[@"线下服务",@"电话服务",@"线上服务"];
    arr_time = @[@"白天",@"晚上"];
}
-(void)leftClick
{
    shiduan_start = nil;
    shiduan_end = nil;
    shiduan =nil;
    [date_alert removeFromSuperview];
}
-(void)rightClick
{
    NSDateFormatter *formatter =[[NSDateFormatter alloc]init];
    [formatter setDateFormat:@"HH:mm"];
    NSString *date_str = [formatter stringFromDate:date_alert.picker.date];
    if (shiduan_start ==nil) {
        shiduan_start = date_str;
        date_alert.L_title.text =[NSString stringWithFormat:@"请选择结束时间"];
        date_alert.L_title.textColor = [UIColor redColor];
    }else
    {
         shiduan_end = date_str;
        [WebRequest Makerspacey_MakerIndustry_Add_MakerServiceTimeWithuserGuid:user.Guid type:shiduan startTime:shiduan_start endTime:shiduan_end And:^(NSDictionary *dic) {
            if ([dic[Y_STATUS] integerValue]==200) {
                CK_hangyeModel *model = [CK_hangyeModel mj_objectWithKeyValues:dic[Y_ITEMS]];
                [arr_names6 addObject:model];
                dispatch_async(dispatch_get_main_queue(), ^{
                    [tableV reloadSections:[NSIndexSet indexSetWithIndex:5] withRowAnimation:UITableViewRowAnimationNone];
                    shiduan_start = nil;
                    shiduan_end = nil;
                    shiduan =nil;
                });
            }else
            {
                MBFadeAlertView  *alert = [[MBFadeAlertView alloc]init];
                [alert showAlertWith:dic[Y_MSG]];
            }
        }];
       
      
        [date_alert removeFromSuperview];
    }
   
}
-(void)headViewinit
{
    arr_names1 = [NSMutableArray arrayWithCapacity:0];
    arr_names2 = [NSMutableArray arrayWithCapacity:0];
    arr_names3 = [NSMutableArray arrayWithCapacity:0];
    arr_names4 = [NSMutableArray arrayWithCapacity:0];
    arr_names5 = [NSMutableArray arrayWithCapacity:0];
    arr_names6 = [NSMutableArray arrayWithCapacity:0];
    headview1 = [[headTitleAddView alloc]init];
    headview2 = [[headTitleAddView alloc]init];
    headview3 = [[headTitleAddView alloc]init];
    headview4 = [[headTitleAddView alloc]init];
    headview5 = [[headTitleAddView alloc]init];
    headview6 = [[headTitleAddView alloc]init];
    headview1.L_text.text = @"您所在的行业";
     headview2.L_text.text = @"您所在的岗位";
     headview3.L_text.text = @"您提供服务的所在行业";
     headview4.L_text.text = @"您提供服务的所在岗位";
    headview5.L_text.text = @"服务方式";
    headview6.L_text.text = @"服务时间段";
   
    UITapGestureRecognizer  *tap_head1 = [[UITapGestureRecognizer alloc]initWithTarget:self action:@selector(tap_head1Click)];
    [headview1.IV_add addGestureRecognizer:tap_head1];
    UITapGestureRecognizer  *tap_head2 = [[UITapGestureRecognizer alloc]initWithTarget:self action:@selector(tap_head2Click)];
    [headview2.IV_add addGestureRecognizer:tap_head2];
    UITapGestureRecognizer  *tap_head3 = [[UITapGestureRecognizer alloc]initWithTarget:self action:@selector(tap_head3Click)];
    [headview3.IV_add addGestureRecognizer:tap_head3];
    UITapGestureRecognizer  *tap_head4 = [[UITapGestureRecognizer alloc]initWithTarget:self action:@selector(tap_head4Click)];
    [headview4.IV_add addGestureRecognizer:tap_head4];
    UITapGestureRecognizer  *tap_head5 = [[UITapGestureRecognizer alloc]initWithTarget:self action:@selector(tap_head5Click)];
    [headview5.IV_add addGestureRecognizer:tap_head5];
    UITapGestureRecognizer  *tap_head6 = [[UITapGestureRecognizer alloc]initWithTarget:self action:@selector(tap_head6Click)];
    [headview6.IV_add addGestureRecognizer:tap_head6];
    
}
-(void)tap_head6Click
{
    UIAlertController  *alert = [UIAlertController alertControllerWithTitle:@"请选择服务时段" message:nil preferredStyle:UIAlertControllerStyleActionSheet];
    [alert addAction:[UIAlertAction actionWithTitle:@"白天" style:UIAlertActionStyleDefault handler:^(UIAlertAction * _Nonnull action) {
        shiduan = @"0";
        shiduan_start = nil;
        date_alert.L_title.text = @"请选择白天开始时间";
        [self.view addSubview:date_alert];
    }]];
    [alert addAction:[UIAlertAction actionWithTitle:@"晚上" style:UIAlertActionStyleDefault handler:^(UIAlertAction * _Nonnull action) {
        shiduan = @"1";
        shiduan_start = nil;
        date_alert.L_title.text = @"请选择白天开始时间";
        [self.view addSubview:date_alert];
    }]];
    [alert addAction:[UIAlertAction actionWithTitle:@"取消" style:UIAlertActionStyleCancel handler:^(UIAlertAction * _Nonnull action) {
        
    }]];
    [self presentViewController:alert animated:NO completion:nil];
}
-(void)tap_head5Click
{
    CK_fuWuChoosViewController  *FWvc = [[CK_fuWuChoosViewController alloc]init];
    FWvc.delegate_fuwu =self;
    [self.navigationController pushViewController:FWvc animated:NO];
}
-(void)tap_head4Click
{
    FBJobViewController  *GWvc =[[FBJobViewController alloc]init];
    GWvc.delegate =self;
    GWvc.indexPath = [NSIndexPath indexPathForRow:0 inSection:3];
    [self.navigationController pushViewController:GWvc animated:NO];
}
-(void)tap_head3Click
{
    FBHangYeViewController *HYvc = [[FBHangYeViewController alloc]init];
    HYvc.delegate =self;
    HYvc.indexPath = [NSIndexPath indexPathForRow:0 inSection:2];
    [self.navigationController pushViewController:HYvc animated:NO];
}
-(void)tap_head2Click
{
    FBJobViewController  *GWvc =[[FBJobViewController alloc]init];
    GWvc.delegate =self;
    GWvc.indexPath = [NSIndexPath indexPathForRow:0 inSection:1];
    [self.navigationController pushViewController:GWvc animated:NO];
}
-(void)tap_head1Click
{
    FBHangYeViewController *HYvc = [[FBHangYeViewController alloc]init];
    HYvc.delegate =self;
    HYvc.indexPath = [NSIndexPath indexPathForRow:0 inSection:0];
    [self.navigationController pushViewController:HYvc animated:NO];
}
#pragma  mark - 岗位
-(void)model:(AllModel*)model indexPath:(NSIndexPath*)indexpath{
    
    NSString *type = [NSString stringWithFormat:@"%ld",indexpath.section%2];
    [WebRequest MakerIndustry_Add_MakerPostWithuserGuid:user.Guid type:type post:model.child_name And:^(NSDictionary *dic) {
        if ([dic[Y_STATUS] integerValue]==200) {
            CK_hangyeModel  *model = [CK_hangyeModel mj_objectWithKeyValues:dic[Y_ITEMS]];
            if (indexpath.section ==1) {
                [arr_names2 addObject:model];
            }else if (indexpath.section == 3)
            {
                [arr_names4 addObject:model];
            }else
            {
                
            }
            dispatch_async(dispatch_get_main_queue(), ^{
                 [tableV reloadSections:[NSIndexSet indexSetWithIndex:indexpath.section] withRowAnimation:UITableViewRowAnimationNone];
            });
        }
    }];
    
    
   
}
#pragma  mark - 行业
-(void)hangye:(NSString*)hangye Withindexpath:(NSIndexPath*)indexpath{
    NSArray *tarr = [hangye componentsSeparatedByString:@"-"];
    NSString  *type = [NSString stringWithFormat:@"%ld",indexpath.section%2];
    [WebRequest Makerspacey_MakerIndustry_Add_MakerIndustrysWithuserGuid:user.Guid type:type Industry:tarr[0] post:@" " And:^(NSDictionary *dic) {
        if ([dic[Y_STATUS] integerValue]==200) {
            CK_hangyeModel *model = [CK_hangyeModel mj_objectWithKeyValues:dic[Y_ITEMS]];
            if (indexpath.section ==0) {
                [arr_names1 addObject:model];
            }else if (indexpath.section ==2)
            {
                [arr_names3 addObject:model];
            }else
            {
                
            }
            dispatch_async(dispatch_get_main_queue(), ^{
                [tableV reloadSections:[NSIndexSet indexSetWithIndex:indexpath.section] withRowAnimation:UITableViewRowAnimationNone];
            });
        }
    }];
   
   
}
-(NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return 6;
}
-(CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section
{
    return 40;
}
-(UIView*)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section
{
    if (section==0) {
        return headview1;
    }else if (section==1)
    {
        return headview2;
    }else if (section==2)
    {
        return headview3;
    }else if (section ==3)
    {
        return headview4;
    }else if (section==4)
    {
        return headview5;
    }else if (section==5)
    {
        return headview6;
    }else
    {
        return nil;
    }
}

-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return 60;
}

#pragma  mark - 表的数据源
-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    if (section ==0) {
        return arr_names1.count;
    }else if (section ==1)
    {
        return arr_names2.count;
    }else if (section ==2)
    {
        return arr_names3.count;
    }else if (section ==3)
    {
        return arr_names4.count;
    }else if (section ==4)
    {
        return arr_names5.count;
    }else if (section ==5)
    {
        return arr_names6.count;
    }else
    {
        return 0;
    }
}
-(UITableViewCell*)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    if (indexPath.section ==0) {
        static NSString *cellId=@"cellID0";
        UITableViewCell *cell =[tableView dequeueReusableCellWithIdentifier:cellId];
        if (!cell) {
            cell = [[UITableViewCell alloc]initWithStyle:UITableViewCellStyleDefault reuseIdentifier:cellId];
            cell.accessoryType = UITableViewCellAccessoryNone;
            cell.textLabel.font = [UIFont systemFontOfSize:18];
        }
        CK_hangyeModel  *model = arr_names1[indexPath.row];
        cell.textLabel.text = model.Industry;
        return cell;
    }else if (indexPath.section ==1) {
        static NSString *cellId=@"cellID1";
        UITableViewCell *cell =[tableView dequeueReusableCellWithIdentifier:cellId];
        if (!cell) {
            cell = [[UITableViewCell alloc]initWithStyle:UITableViewCellStyleDefault reuseIdentifier:cellId];
            cell.accessoryType = UITableViewCellAccessoryNone;
            cell.textLabel.font = [UIFont systemFontOfSize:18];
        }
        CK_hangyeModel  *model =arr_names2[indexPath.row];
        cell.textLabel.text =model.post;
        
        return cell;
    }else if (indexPath.section ==2) {
        static NSString *cellId=@"cellID2";
        UITableViewCell *cell =[tableView dequeueReusableCellWithIdentifier:cellId];
        if (!cell) {
            cell = [[UITableViewCell alloc]initWithStyle:UITableViewCellStyleDefault reuseIdentifier:cellId];
            cell.accessoryType = UITableViewCellAccessoryNone;
            cell.textLabel.font = [UIFont systemFontOfSize:18];
        }
        CK_hangyeModel *model =arr_names3[indexPath.row];
        cell.textLabel.text = model.Industry;
        return cell;
    }else if (indexPath.section ==3) {
        static NSString *cellId=@"cellID3";
        UITableViewCell *cell =[tableView dequeueReusableCellWithIdentifier:cellId];
        if (!cell) {
            cell = [[UITableViewCell alloc]initWithStyle:UITableViewCellStyleDefault reuseIdentifier:cellId];
            cell.accessoryType = UITableViewCellAccessoryNone;
            cell.textLabel.font = [UIFont systemFontOfSize:18];
        }
        CK_hangyeModel *model =arr_names4[indexPath.row];
        cell.textLabel.text =model.post;
        return cell;
    }else if (indexPath.section ==4) {
        static NSString *cellId=@"cellID4";
        UITableViewCell *cell =[tableView dequeueReusableCellWithIdentifier:cellId];
        if (!cell) {
            cell = [[UITableViewCell alloc]initWithStyle:UITableViewCellStyleValue1 reuseIdentifier:cellId];
            cell.accessoryType = UITableViewCellAccessoryNone;
            cell.textLabel.font = [UIFont systemFontOfSize:18];
        }
        CK_hangyeModel  *model = arr_names5[indexPath.row];

        
        
        cell.textLabel.text = arr_fangshi[[model.type integerValue]];
        cell.detailTextLabel.text = [NSString stringWithFormat:@"%@元/天  %@元/小时",model.OneDayPrice,model.OneHourPrice];
        return cell;
    }else if (indexPath.section ==5) {
        static NSString *cellId=@"cellID5";
        UITableViewCell *cell =[tableView dequeueReusableCellWithIdentifier:cellId];
        if (!cell) {
            cell = [[UITableViewCell alloc]initWithStyle:UITableViewCellStyleValue1 reuseIdentifier:cellId];
            cell.accessoryType = UITableViewCellAccessoryNone;
            cell.textLabel.font = [UIFont systemFontOfSize:18];
        }
        CK_hangyeModel *model =arr_names6[indexPath.row];
        
        cell.textLabel.text = arr_time[[model.type integerValue]];
        cell.detailTextLabel.text = [NSString stringWithFormat:@"%@ ~ %@",model.startTime,model.endTime];
        return cell;
    }else
    {
        return nil;
    }
    
}

#pragma  mark - 表的协议代理
-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    
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
        
        if (indexPath.section ==0) {
            //行业
            CK_hangyeModel  *model = arr_names1[indexPath.row];
            [WebRequest Makerspacey_MakerIndustry_Delete_MakerIndustrysWithuserGuid:user.Guid industryId:model.Id And:^(NSDictionary *dic) {
                 MBFadeAlertView *alert = [[MBFadeAlertView alloc]init];
                if ([dic[Y_STATUS] integerValue]==200) {
                    [alert showAlertWith:@"删除成功"];
                    [arr_names1 removeObject:model];
                    [tableV reloadSections:[NSIndexSet indexSetWithIndex:0] withRowAnimation:UITableViewRowAnimationNone];
                }else
                {
                   
                    [alert showAlertWith:dic[Y_MSG]];
                }
            }];
        }else if (indexPath.section ==1)
        {
            //岗位
            CK_hangyeModel *model = arr_names2[indexPath.row];
            [WebRequest MakerIndustry_Delete_MakerPostWithuserGuid:user.Guid postId:model.Id And:^(NSDictionary *dic) {
                MBFadeAlertView  *alert = [[MBFadeAlertView alloc]init];
                if ([dic[Y_STATUS] integerValue]==200) {
                    [alert showAlertWith:@"删除成功"];
                    [arr_names2 removeObject:model];
                    [tableV reloadSections:[NSIndexSet indexSetWithIndex:1] withRowAnimation:UITableViewRowAnimationNone];
                }else
                {
                    [alert showAlertWith:dic[Y_MSG]];
                }
            }];
        }else if (indexPath.section ==2)
        {
            //服务的行业
            CK_hangyeModel *model = arr_names3[indexPath.row];
            [WebRequest Makerspacey_MakerIndustry_Delete_MakerIndustrysWithuserGuid:user.Guid industryId:model.Id And:^(NSDictionary *dic) {
                MBFadeAlertView *alert = [[MBFadeAlertView alloc]init];
                if ([dic[Y_STATUS] integerValue]==200) {
                    [alert showAlertWith:@"删除成功"];
                    [arr_names3 removeObject:model];
                    [tableV reloadSections:[NSIndexSet indexSetWithIndex:2] withRowAnimation:UITableViewRowAnimationNone];
                }else
                {
                    
                    [alert showAlertWith:dic[Y_MSG]];
                }
            }];
            
        }else if (indexPath.section ==3)
        {
            //服务的岗位
            
            CK_hangyeModel *model = arr_names4[indexPath.row];
            [WebRequest MakerIndustry_Delete_MakerPostWithuserGuid:user.Guid postId:model.Id And:^(NSDictionary *dic) {
                MBFadeAlertView  *alert = [[MBFadeAlertView alloc]init];
                if ([dic[Y_STATUS] integerValue]==200) {
                    [alert showAlertWith:@"删除成功"];
                    [arr_names4 removeObject:model];
                    [tableV reloadSections:[NSIndexSet indexSetWithIndex:3] withRowAnimation:UITableViewRowAnimationNone];
                }else
                {
                    [alert showAlertWith:dic[Y_MSG]];
                }
            }];
        }else if (indexPath.section ==4)
        {
            //服务方式
            CK_hangyeModel  *model = arr_names5[indexPath.row];
            [WebRequest Makerspacey_MakerIndustry_Delete_MakerServiceModeWithuserGuid:user.Guid modeId:model.Id And:^(NSDictionary *dic) {
                MBFadeAlertView  *alert = [[MBFadeAlertView alloc]init];
                if ([dic[Y_STATUS] integerValue]==200) {
                    [alert showAlertWith:@"删除成功"];
                    [arr_names5 removeObject:model];
                    [tableV reloadSections:[NSIndexSet indexSetWithIndex:4] withRowAnimation:UITableViewRowAnimationNone];
                }else
                {
                    [alert showAlertWith:dic[Y_MSG]];
                }
            }];
        }else if (indexPath.section==5)
        {
            //服务的时间段
            CK_hangyeModel *model = arr_names6[indexPath.row];
            [WebRequest Makerspacey_MakerIndustry_Delete_MakerServiceTimeWithuserGuid:user.Guid timeId:model.Id And:^(NSDictionary *dic) {
                MBFadeAlertView  *alert = [[MBFadeAlertView alloc]init];
                if ([dic[Y_STATUS] integerValue]==200) {
                    [alert showAlertWith:@"删除成功"];
                    [arr_names6 removeObject:model];
                    [tableV reloadSections:[NSIndexSet indexSetWithIndex:5] withRowAnimation:UITableViewRowAnimationNone];
                }else
                {
                    [alert showAlertWith:dic[Y_MSG]];
                }
            }];
        }else
        {
            
        }
    }
}

-(NSString*)tableView:(UITableView *)tableView titleForDeleteConfirmationButtonForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return @"删除";
}



@end
