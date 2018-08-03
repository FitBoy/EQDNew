//
//  Meeting_addViewController.m
//  EQD
//
//  Created by 梁新帅 on 2018/5/22.
//  Copyright © 2018年 FitBoy. All rights reserved.
//

#import "Meeting_addViewController.h"
#import "FBone_SwitchTableViewCell.h"
#import "EQDR_labelTableViewCell.h"
#import "GNmodel.h"
#import <Masonry.h>
#import "DatePicer_AlertView.h"
#import "FBTextFieldViewController.h"
#import "FBTextVViewController.h"
#import "FB_twoTongShiChooseViewController.h"
#import "FB_twoTongShi2ViewController.h"
#import "BB_WeeksViewController.h"
#import "MeetingModel.h"
@interface Meeting_addViewController ()<UITableViewDelegate,UITableViewDataSource,FBTextVViewControllerDelegate,FBTextFieldViewControllerDelegate,FB_twoTongShi2ViewControllerDelegate,FB_twoTongShiChooseViewControllerDelegate,BB_WeeksViewControllerDelegate>
{
    UITableView *tableV;
    NSMutableArray *arr_model;
    DatePicer_AlertView *date_alert;
    NSMutableArray *arr_guid;
    NSArray *arr_zhouqi;
    UserModel *user;
    NSString *timeInterval;
    //会议参与人
    NSString *attendees;
    ///主持人
    NSString *compere;
    ///记录人
    NSString  *recorder;
    ///会议通知发布人
    NSString *admin;
    ///是否预案
    NSString *isYuAn;
    ///会议频率
    NSString *frequency;
    
    NSArray *arr_keys;
    
}

@end

@implementation Meeting_addViewController

-(void)leftClick
{
    [date_alert removeFromSuperview];
}
-(void)rightClick
{
    GNmodel *model = arr_model[date_alert.two_btn.B_right.indexpath.row];
    NSDateFormatter *formatter =[[NSDateFormatter alloc]init];
    NSString *date_str  =nil;
    if (self.temp ==1) {
        [formatter setDateFormat:@"yyyy-MM-dd HH:mm"];
        date_str = [formatter stringFromDate:date_alert.picker.date];

    }else
    {
    [formatter setDateFormat:@"HH:mm"];
    date_str = [formatter stringFromDate:date_alert.picker.date];
    }
    if (self.temp == 2) {
        [self updateParaKey:arr_keys[date_alert.two_btn.B_right.indexpath.row] Value:date_str WithindexPath:date_alert.two_btn.B_right.indexpath];
    }else{
    model.content = date_str;
    [arr_model replaceObjectAtIndex:date_alert.two_btn.B_right.indexpath.row withObject:model];
    [tableV reloadRowsAtIndexPaths:@[date_alert.two_btn.B_right.indexpath] withRowAnimation:UITableViewRowAnimationNone];
    }
    [date_alert removeFromSuperview];
}
- (void)viewDidLoad {
    [super viewDidLoad];
    user = [WebRequest GetUserInfo];
    isYuAn =@"false";
    arr_guid = [NSMutableArray arrayWithCapacity:0];
    date_alert =[[DatePicer_AlertView alloc]initWithFrame:self.view.frame];
    NSDateFormatter *formatter =[[NSDateFormatter alloc]init];
    if (self.temp ==1) {
        [formatter setDateFormat:@"yyyy-MM-dd HH:mm"];
         NSString *date_str = [formatter stringFromDate:[NSDate date]];
        [date_alert setDate:date_str];
        date_alert.picker.datePickerMode =UIDatePickerModeDateAndTime;
    }else
    {
    [formatter setDateFormat:@"HH:mm"];
    NSString *date_str = [formatter stringFromDate:[NSDate date]];
    [date_alert setDate2:date_str];
    date_alert.picker.datePickerMode =UIDatePickerModeTime;
    }
    [date_alert.two_btn setleftname:@"取消" rightname:@"确定"];
    [date_alert.two_btn.B_left addTarget:self action:@selector(leftClick) forControlEvents:UIControlEventTouchUpInside];
    [date_alert.two_btn.B_right addTarget:self action:@selector(rightClick) forControlEvents:UIControlEventTouchUpInside];
    
    NSString *tstr = nil;
    if (self.temp ==0) {
        tstr =@"添加会议类型设置";
    }else if (self.temp ==1)
    {
        tstr =@"发布会议通知";
    }else if (self.temp ==2)
    {
        tstr = @"会议类型详情";
    }else
    {
        
    }
    self.navigationItem.title = tstr;
    arr_model = [NSMutableArray arrayWithCapacity:0];
    
    if(self.temp ==1)
    {
        
        arr_keys =@[@"type",@"frequency",@"timeInterval",@"startTime",@"endTime",@"place",@"attendees",@"compere",@"recorder",@"aim",@"admin",@"motion"];
        
        [WebRequest Meeting_Get_MettingByIdWithcompanyId:user.companyId mettingId:self.settingId And:^(NSDictionary *dic) {
            if ([dic[Y_STATUS] integerValue]==200) {
                MeetingModel *model = [MeetingModel mj_objectWithKeyValues:dic[Y_ITEMS]];
                NSMutableString *Tstr = [NSMutableString string];
                NSMutableString *Tstr2 = [NSMutableString string];
                for (int i=0; i<model.attendees.count; i++) {
                    HeadPersonModel *tmodel = model.attendees[i];
                    [Tstr appendFormat:@"%@ ",tmodel.username];
                    [Tstr2 appendFormat:@"%@,",tmodel.userGuid];
                }
                attendees = [Tstr2 substringWithRange:NSMakeRange(0, Tstr2.length-1)];
                compere = model.compere.userGuid;
                recorder = model.recorder.userGuid;
                NSDateFormatter *formatter = [[NSDateFormatter alloc]init];
                [formatter setDateFormat:@"yyyy-MM-dd"];
                NSString *date_str = [formatter stringFromDate:[NSDate date]];
                
                
                NSArray  *tarr = @[
                                   @{
                                       @"name":@"会议类型",
                                       @"content":model.type,
                                       },
                                   @{
                                       @"name":@"会议频率",
                                       @"content":model.frequency,
                                       },
                                   @{
                                       @"name":@"会议时段",
                                       @"content":model.timeInterval,
                                       },
                                   @{
                                       @"name":@"会议开始时间",
                                       @"content":[NSString stringWithFormat:@"%@ %@",date_str,model.startTime],
                                       },
                                   @{
                                       @"name":@"会议结束时间",
                                       @"content":[NSString stringWithFormat:@"%@ %@",date_str,model.endTime],
                                       },
                                   @{
                                       @"name":@"会议地点",
                                       @"content":model.place,
                                       },
                                   @{
                                       @"name":@"参加人员",
                                       @"content":Tstr,
                                       },
                                   @{
                                       @"name":@"主持人",
                                       @"content":model.compere.username,
                                       },
                                   @{
                                       @"name":@"记录人",
                                       @"content":model.recorder.username,
                                       },
                                   @{
                                       @"name":@"会议目的",
                                       @"content":model.aim,
                                       },
                                   
                                   ];
                for (int i=0; i<tarr.count; i++) {
                    GNmodel  *model = [GNmodel mj_objectWithKeyValues:tarr[i]];
                    model.cellHeight =60;
                    [arr_model addObject:model];
                }
                dispatch_async(dispatch_get_main_queue(), ^{
                    [tableV reloadData];
                });
               
            }
        }];
        
    }else if (self.temp ==2)
    {
        arr_keys =@[@"type",@"frequency",@"timeInterval",@"startTime",@"endTime",@"place",@"attendees",@"compere",@"recorder",@"aim",@"admin",@"motion"];
        
        [WebRequest Meeting_Get_MettingByIdWithcompanyId:user.companyId mettingId:self.settingId And:^(NSDictionary *dic) {
            if ([dic[Y_STATUS] integerValue]==200) {
                MeetingModel *model = [MeetingModel mj_objectWithKeyValues:dic[Y_ITEMS]];
                NSMutableString *Tstr = [NSMutableString string];
                NSMutableString *Tstr2 = [NSMutableString string];
                for (int i=0; i<model.attendees.count; i++) {
                    HeadPersonModel *tmodel = model.attendees[i];
                    [Tstr appendFormat:@"%@ ",tmodel.username];
                    [Tstr2 appendFormat:@"%@,",tmodel.userGuid];
                }
                attendees = [Tstr2 substringWithRange:NSMakeRange(0, Tstr2.length-1)];
                compere = model.compere.userGuid;
                recorder = model.recorder.userGuid;
                NSDateFormatter *formatter = [[NSDateFormatter alloc]init];
                [formatter setDateFormat:@"yyyy-MM-dd"];
                NSString *date_str = [formatter stringFromDate:[NSDate date]];
                
                
                NSArray  *tarr = @[
                                   @{
                                       @"name":@"会议类型",
                                       @"content":model.type,
                                       },
                                   @{
                                       @"name":@"会议频率",
                                       @"content":model.frequency,
                                       },
                                   @{
                                       @"name":@"会议时段",
                                       @"content":model.timeInterval,
                                       },
                                   @{
                                       @"name":@"会议开始时间",
                                       @"content":[NSString stringWithFormat:@"%@ %@",date_str,model.startTime],
                                       },
                                   @{
                                       @"name":@"会议结束时间",
                                       @"content":[NSString stringWithFormat:@"%@ %@",date_str,model.endTime],
                                       },
                                   @{
                                       @"name":@"会议地点",
                                       @"content":model.place,
                                       },
                                   @{
                                       @"name":@"参加人员",
                                       @"content":Tstr,
                                       },
                                   @{
                                       @"name":@"主持人",
                                       @"content":model.compere.username,
                                       },
                                   @{
                                       @"name":@"记录人",
                                       @"content":model.recorder.username,
                                       },
                                   
                                   @{
                                       @"name":@"会议目的",
                                       @"content":model.aim,
                                       },
                                   @{
                                       @"name":@"会议通知发布人",
                                       @"content":model.adminName,
                                       }
                                   
                                   ];
                for (int i=0; i<tarr.count; i++) {
                    GNmodel  *model = [GNmodel mj_objectWithKeyValues:tarr[i]];
                    model.cellHeight =60;
                    [arr_model addObject:model];
                }
                dispatch_async(dispatch_get_main_queue(), ^{
                    [tableV reloadData];
                });
                
            }
        }];
    }
    else
    {
    NSArray  *tarr = @[
                       @{
                           @"name":@"会议类型",
                           @"content":@"请输入",
                           },
                       @{
                           @"name":@"会议频率",
                           @"content":@"请选择",
                           },
                       @{
                           @"name":@"会议时段",
                           @"content":@"请选择",
                           },
                       @{
                           @"name":@"会议开始时间",
                           @"content":@"请选择",
                           },
                       @{
                           @"name":@"会议结束时间",
                           @"content":@"请选择",
                           },
                       @{
                           @"name":@"会议地点",
                           @"content":@"请输入",
                           },
                       @{
                           @"name":@"参加人员",
                           @"content":@"请选择",
                           },
                       @{
                           @"name":@"主持人",
                           @"content":@"请选择",
                           },
                       @{
                           @"name":@"记录人",
                           @"content":@"请选择",
                           },
                       @{
                           @"name":@"会议目的",
                           @"content":@"请输入",
                           },
                       @{
                           @"name":@"会议通知发布人",
                           @"content":@"请选择",
                           },
                       @{
                           @"name":@"是否提供预案",
                           @"content":@"是否",
                           }
                       
                       
                       ];
    for (int i=0; i<tarr.count; i++) {
        GNmodel  *model = [GNmodel mj_objectWithKeyValues:tarr[i]];
        model.cellHeight =60;
        [arr_model addObject:model];
    }
    }
   
    tableV = [[UITableView alloc]initWithFrame:CGRectMake(0, DEVICE_TABBAR_Height, DEVICE_WIDTH, DEVICE_HEIGHT-DEVICE_TABBAR_Height-kBottomSafeHeight) style:UITableViewStylePlain];
    adjustsScrollViewInsets_NO(tableV, self);
    tableV.delegate=self;
    tableV.dataSource=self;
    [self.view addSubview:tableV];
    tableV.rowHeight=60;
    
   
    if (self.temp ==2) {
        ///详情
    }else
    {
         UIBarButtonItem *right = [[UIBarButtonItem alloc]initWithTitle:@"确定" style:UIBarButtonItemStylePlain target:self action:@selector(QueDingClick)];
         [self.navigationItem setRightBarButtonItem:right];
    }
   
}
-(void)QueDingClick{
  
    
    NSInteger temp =0;
    for(int i=0;i<arr_model.count;i++)
    {
        GNmodel *model =arr_model[i];
        if ([model.content isEqualToString:@"请输入"] || [model.content isEqualToString:@"请选择"]) {
            temp =1;
            break;
        }
    }
    if (temp ==0) {
        
        if (self.temp ==1) {
            MBProgressHUD *hud = [MBProgressHUD showHUDAddedTo:self.view animated:YES];
            hud.mode = MBProgressHUDModeAnnularDeterminate;
            hud.label.text = @"正在发布";
            GNmodel *model0 = arr_model[0];
            
            GNmodel *model3 = arr_model[3];
            GNmodel *model4 = arr_model[4];
            GNmodel *model5 = arr_model[5];
            GNmodel *model9 = arr_model[9];
            [WebRequest Meeting_Add_meettingNoticeWithuserGuid:user.Guid comid:user.companyId settingId:self.settingId type:model0.content startTime:model3.content endTime:model4.content place:model5.content attendees:attendees compere:compere recorder:recorder aim:model9.content And:^(NSDictionary *dic) {
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
        MBProgressHUD *hud = [MBProgressHUD showHUDAddedTo:self.view animated:YES];
        hud.mode = MBProgressHUDModeAnnularDeterminate;
        hud.label.text = @"正在添加";
        GNmodel *model0 = arr_model[0];
       
        GNmodel *model3 = arr_model[3];
        GNmodel *model4 = arr_model[4];
        GNmodel *model5 = arr_model[5];
        GNmodel *model9 = arr_model[9];
        [WebRequest Meeting_Add_settingWithuserGuid:user.Guid comid:user.companyId type:model0.content frequency:frequency timeInterval:timeInterval startTime:model3.content endTime:model4.content place:model5.content attendees:attendees compere:compere recorder:recorder aim:model9.content motion:isYuAn admin:admin  And:^(NSDictionary *dic) {
            hud.label.text = dic[Y_MSG];
            dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(0.7 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
                [hud hideAnimated:NO];
                if ([dic[Y_STATUS] integerValue]==200) {
                    [self.navigationController popViewControllerAnimated:NO];
                }
            });
           
        }];
        }
    }else
    {
        MBProgressHUD *hud=[MBProgressHUD showHUDAddedTo:self.view  animated:YES];
        hud.mode = MBProgressHUDModeText;
        hud.label.text =@"参数不全";
        dispatch_time_t popTime = dispatch_time(DISPATCH_TIME_NOW, 1 * NSEC_PER_SEC);
        dispatch_after(popTime, dispatch_get_main_queue(), ^(void){
            [MBProgressHUD hideHUDForView:self.view  animated:YES];
        });
    }
    
}
#pragma  mark - 表的数据源
-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return arr_model.count;
}
-(void)kaiguanClick:(UISwitch*)S_kai
{
    
    if (S_kai.isOn == NO) {
        isYuAn = @"false";
    }else
    {
        isYuAn =@"true";
    }
    if (self.temp == 2) {
        [self updateParaKey:arr_keys[11] Value:isYuAn WithindexPath:[NSIndexPath indexPathForRow:11 inSection:0]];
    }else
    {
   
    }
}
-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    GNmodel *model =arr_model[indexPath.row];
    return model.cellHeight;
}
-(UITableViewCell*)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
     GNmodel  *model =arr_model[indexPath.row];
    if(indexPath.row ==11)
    {
        FBone_SwitchTableViewCell  *cell = [[FBone_SwitchTableViewCell alloc]init];
       
        cell.L_left0.text = model.name;
        [cell.S_kaiguan addTarget:self action:@selector(kaiguanClick:) forControlEvents:UIControlEventValueChanged];
        return cell;
    }else
    {
        if (!([model.content isEqualToString:@"请选择"]|| [model.content isEqualToString:@"请输入"])) {
            static NSString *cellId=@"cellID0";
            EQDR_labelTableViewCell *cell =[tableView dequeueReusableCellWithIdentifier:cellId];
            if (!cell) {
                cell = [[EQDR_labelTableViewCell alloc]initWithStyle:UITableViewCellStyleValue1 reuseIdentifier:cellId];
                cell.accessoryType = UITableViewCellAccessoryNone;
            }
            NSMutableAttributedString  *name = [[NSMutableAttributedString alloc]initWithString:[NSString stringWithFormat:@"%@:",model.name] attributes:@{NSFontAttributeName:[UIFont systemFontOfSize:18]}];
            NSMutableAttributedString *contents = [[NSMutableAttributedString alloc]initWithString:model.content attributes:@{NSFontAttributeName:[UIFont systemFontOfSize:16],NSForegroundColorAttributeName:[UIColor grayColor]}];
            
            [name appendAttributedString:contents];
            name.yy_lineSpacing =6;
            cell.YL_label.attributedText = name;
            CGSize size = [name boundingRectWithSize:CGSizeMake(DEVICE_WIDTH-30, MAXFLOAT) options:NSStringDrawingUsesLineFragmentOrigin context:nil].size;
            model.cellHeight = size.height + 20;
            [cell.YL_label mas_remakeConstraints:^(MASConstraintMaker *make) {
                
                make.height.mas_equalTo(size.height+15);
                make.centerY.mas_equalTo(cell.mas_centerY);
                make.left.mas_equalTo(cell.mas_left).mas_offset(15);
                make.right.mas_equalTo(cell.mas_right).mas_offset(-15);
            }];
            
            
            return cell;
        }else
        {
        
    static NSString *cellId=@"cellID1";
    UITableViewCell *cell =[tableView dequeueReusableCellWithIdentifier:cellId];
    if (!cell) {
        cell = [[UITableViewCell alloc]initWithStyle:UITableViewCellStyleValue1 reuseIdentifier:cellId];
        cell.accessoryType = UITableViewCellAccessoryDisclosureIndicator;
        cell.textLabel.font = [UIFont systemFontOfSize:18];
    }
        cell.textLabel.text = model.name;
        cell.detailTextLabel.text = model.content;
    return cell;
        }
    }
}

#pragma  mark - 上班周期与月份
-(void)chooseArr:(NSArray*)tarr indexPath:(NSIndexPath*)indexPath
{
    arr_zhouqi =tarr;
    NSMutableString *Tstr = [NSMutableString string];
    timeInterval = nil;
    NSMutableString *timeInterval_t = [NSMutableString string];
    for (int i=0; i<tarr.count; i++) {
        [Tstr appendFormat:@"%@ ",tarr[i]];
        [timeInterval_t appendFormat:@"%@,",tarr[i]];
    }
  timeInterval = [timeInterval_t substringWithRange:NSMakeRange(0, timeInterval_t.length-1)];
    if (self.temp ==2) {
        [self updateParaKey:arr_keys[indexPath.row] Value:timeInterval WithindexPath:indexPath];
    }else
    {
    GNmodel *model =arr_model[indexPath.row];
    model.content =Tstr;
    [arr_model replaceObjectAtIndex:indexPath.row withObject:model];
    [tableV reloadRowsAtIndexPaths:@[indexPath] withRowAnimation:UITableViewRowAnimationNone];
    }
}

#pragma  mark - 表的协议代理
-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    GNmodel *model =arr_model[indexPath.row];
    if (indexPath.row ==0 || indexPath.row ==5) {
        ///会议类型
        if (self.temp==0 || self.temp ==2) {

        FBTextFieldViewController *TFvc =[[FBTextFieldViewController alloc]init];
        TFvc.delegate =self;
        TFvc.indexPath =indexPath;
        TFvc.content =model.content;
        TFvc.contentTitle =model.name;
        [self.navigationController pushViewController:TFvc animated:NO];
        }else
        {
            
        }
        
    }else if (indexPath.row ==1&&self.temp!=1 )
    {
       ///会议频率
        GNmodel *model =arr_model[indexPath.row];
        NSArray *tarr = @[@"每周",@"每月",@"每日",@"一次"];
        UIAlertController  *alert = [[UIAlertController alloc]init];
        
        for (int i=0; i<tarr.count; i++) {
            
            [alert addAction:[UIAlertAction actionWithTitle:tarr[i] style:UIAlertActionStyleDefault handler:^(UIAlertAction * _Nonnull action) {
                frequency = [NSString stringWithFormat:@"%d",i+1];
                if (self.temp == 2) {
                    [self updateParaKey:arr_keys[indexPath.row] Value:frequency WithindexPath:indexPath];
                }else
                {
                model.content = tarr[i];
                [arr_model replaceObjectAtIndex:indexPath.row withObject:model];
                [tableV reloadRowsAtIndexPaths:@[indexPath] withRowAnimation:UITableViewRowAnimationNone];
               
                if (i==3) {
                    GNmodel *model2 = arr_model[2];
                    model2.content = @"一次";
                    [arr_model replaceObjectAtIndex:2 withObject:model2];
                    [tableV reloadRowsAtIndexPaths:@[[NSIndexPath indexPathForRow:2 inSection:0]] withRowAnimation:UITableViewRowAnimationNone];
                }
                }
            }]];
            
        }
        [alert addAction:[UIAlertAction actionWithTitle:@"取消" style:UIAlertActionStyleCancel handler:^(UIAlertAction * _Nonnull action) {
            
        }]];
        dispatch_async(dispatch_get_main_queue(), ^{
            [self presentViewController:alert animated:NO completion:nil];

        });
    }else if (indexPath.row ==2 && self.temp !=1)
    {
        //会议时段
        GNmodel  *model2 = arr_model[1];
        if ([model2.content isEqualToString:@"每周"]) {
            BB_WeeksViewController  *Wvc =[[BB_WeeksViewController alloc]init];
            Wvc.delegate  =self;
            Wvc.indexPath = indexPath;
            Wvc.arr_names = @[@"周一",@"周二",@"周三",@"周四",@"周五",@"周六",@"周日"];
            
            
            Wvc.arr_contents = [NSMutableArray arrayWithCapacity:0];
            for (int i=0; i<Wvc.arr_names.count; i++) {
                if ([arr_zhouqi containsObject:Wvc.arr_names[i]]) {
                    [Wvc.arr_contents addObject:@"1"];
                }else
                {
                   [Wvc.arr_contents addObject:@"0"];
                }
            }
            
            [self.navigationController pushViewController:Wvc animated:NO];
        }else if ([model2.content isEqualToString:@"每月"])
        {
            BB_WeeksViewController  *Wvc =[[BB_WeeksViewController alloc]init];
            Wvc.delegate  =self;
            Wvc.indexPath = indexPath;
            Wvc.arr_names = @[@"1日",@"2日",@"3日",@"4日",@"5日",@"6日",@"7日",@"8日",@"9日",@"10日",@"11日",@"12日",@"13日",@"14日",@"15日",@"16日",@"17日",@"18日",@"19日",@"20日",@"21日",@"22日",@"23日",@"24日",@"25日",@"26日",@"27日",@"28日",@"29日",@"30日",@"31日"];
            Wvc.arr_contents = [NSMutableArray arrayWithCapacity:0];
            for (int i=0; i<Wvc.arr_names.count; i++) {
                if ([arr_zhouqi containsObject:Wvc.arr_names[i]]) {
                    [Wvc.arr_contents addObject:@"1"];
                }else
                {
                    [Wvc.arr_contents addObject:@"0"];
                }
            }
            [self.navigationController pushViewController:Wvc animated:NO];
        }
        else if ([model2.content isEqualToString:@"每日"])
        {
            
            NSArray *tarr = @[@"上午",@"下午"];
            UIAlertController *alert = [[UIAlertController alloc]init];
            for (int i=0; i<tarr.count; i++) {
                [alert addAction:[UIAlertAction actionWithTitle:tarr[i] style:UIAlertActionStyleDefault handler:^(UIAlertAction * _Nonnull action) {
                    model2.content =tarr[i];
                    [arr_model replaceObjectAtIndex:indexPath.row withObject:model2];
                    [tableV reloadRowsAtIndexPaths:@[indexPath] withRowAnimation:UITableViewRowAnimationNone];
                }]];
                
            }
            [alert addAction:[UIAlertAction actionWithTitle:@"取消" style:UIAlertActionStyleCancel handler:^(UIAlertAction * _Nonnull action) {
                
            }]];
            dispatch_async(dispatch_get_main_queue(), ^{
                    [self presentViewController:alert animated:NO completion:nil];
            });
        
        }
        else if ([model2.content isEqualToString:@"一次"])
        {
            model2.content = @"一次";
            [arr_model replaceObjectAtIndex:indexPath.row withObject:model2];
            [tableV reloadRowsAtIndexPaths:@[indexPath] withRowAnimation:UITableViewRowAnimationNone];
        }else
        {
            MBProgressHUD *hud=[MBProgressHUD showHUDAddedTo:self.view  animated:YES];
            hud.mode = MBProgressHUDModeText;
            hud.label.text =@"请先选择会议频率";
            dispatch_time_t popTime = dispatch_time(DISPATCH_TIME_NOW, 1 * NSEC_PER_SEC);
            dispatch_after(popTime, dispatch_get_main_queue(), ^(void){
                [MBProgressHUD hideHUDForView:self.view  animated:YES];
            });
        }
        
    }else if (indexPath.row==3 ||  indexPath.row ==4)
    {
        //会议时间
        date_alert.two_btn.B_right.indexpath =indexPath;
        [self.view addSubview:date_alert];
    }else if (indexPath.row ==6)
    {
        //参加人员
        FB_twoTongShiChooseViewController  *Tvc = [[FB_twoTongShiChooseViewController alloc]init];
        Tvc.delegate_tongshi = self;
        Tvc.indexPath =indexPath;
        Tvc.arr_guid = arr_guid;
        [self.navigationController pushViewController:Tvc animated:NO];
    }else if (indexPath.row ==7 || indexPath.row ==8 || indexPath.row ==10)
    {
        //主持人 记录人
        FB_twoTongShi2ViewController  *TSvc = [[FB_twoTongShi2ViewController alloc]init];
        TSvc.delegate_tongshiDan = self;
        TSvc.indexPath =indexPath;
        [self.navigationController pushViewController:TSvc animated:NO];
    }else if (indexPath.row ==9)
    {
        FBTextVViewController *TVvc =[[FBTextVViewController alloc]init];
        TVvc.indexpath =indexPath;
        TVvc.delegate =self;
        TVvc.contentTitle=model.name;
        TVvc.content =model.content;
        [self.navigationController pushViewController:TVvc animated:NO];
    }
    else
    {
        
    }
}
-(void)textVtext:(NSString *)text indexPath:(NSIndexPath *)indexPath
{
    if (self.temp ==2) {
        [self updateParaKey:arr_keys[indexPath.row] Value:text WithindexPath:indexPath];
    }else
    {
    GNmodel  *model = arr_model[indexPath.row];
    model.content = text;
    [arr_model replaceObjectAtIndex:indexPath.row withObject:model];
    [tableV reloadRowsAtIndexPaths:@[indexPath] withRowAnimation:UITableViewRowAnimationNone];
    }
}
#pragma  mark - 同事的单选
-(void)getComUserModel:(Com_UserModel*)model_com indexpath:(NSIndexPath*)indexPath
{
    GNmodel *model = arr_model[indexPath.row];
    model.content = model_com.username;
  
    if (indexPath.row==7) {
        compere = model_com.userGuid;
    
          [self updateParaKey:arr_keys[indexPath.row] Value:compere WithindexPath:indexPath];
        
        
    }else if (indexPath.row ==8)
    {
        recorder =model_com.userGuid;
        
            [self updateParaKey:arr_keys[indexPath.row] Value:recorder WithindexPath:indexPath];
        
    }else if (indexPath.row == 10)
    {
        admin =model_com.userGuid;
       
            [self updateParaKey:arr_keys[indexPath.row] Value:admin WithindexPath:indexPath];
        

    }
    else
    {
        
    }
    
    
    [arr_model replaceObjectAtIndex:indexPath.row withObject:model];
    [tableV reloadRowsAtIndexPaths:@[indexPath] withRowAnimation:UITableViewRowAnimationNone];
}
#pragma  mark - 同事的多选
-(void)getChooseArr_model:(NSArray*)arr_tmodel indexpath:(NSIndexPath*)indexpath
{
    [arr_guid removeAllObjects];
    attendees = nil;
    NSMutableString  *attendees_t = [NSMutableString string];
    
    NSMutableString *tstr  = [NSMutableString string];
    for (int i=0; i<arr_tmodel.count; i++) {
        Com_UserModel *model2 = arr_tmodel[i];
        [tstr appendFormat:@"%@   ",model2.username];
        [arr_guid addObject:model2.userGuid];
        [attendees_t appendFormat:@"%@,",model2.userGuid];
    }
    attendees = [attendees_t substringWithRange:NSMakeRange(0, attendees_t.length-1)];
    if (self.temp ==2) {
        
        [self updateParaKey:arr_keys[indexpath.row] Value:attendees WithindexPath:indexpath];
    }else
    {
    GNmodel *model3 =arr_model[indexpath.row];
    model3.content = tstr;
    [arr_model replaceObjectAtIndex:indexpath.row withObject:model3];
    [tableV reloadRowsAtIndexPaths:@[indexpath] withRowAnimation:UITableViewRowAnimationNone];
    }
    
}
#pragma  mark - 单输入框
-(void)content:(NSString *)content WithindexPath:(NSIndexPath *)indexPath
{
    if (self.temp ==2) {
        [self updateParaKey:arr_keys[indexPath.row] Value:content WithindexPath:indexPath];
    }else
    {
    GNmodel *model = arr_model[indexPath.row];
    model.content = content;
    [arr_model replaceObjectAtIndex:indexPath.row withObject:model];
    [tableV reloadRowsAtIndexPaths:@[indexPath] withRowAnimation:UITableViewRowAnimationNone];
    }
}

#pragma  mark -详情单项 修改
-(void)updateParaKey:(NSString*)key Value:(NSString*)value WithindexPath:(NSIndexPath*)indexPath
{
    
    if (self.temp ==2) {
        
    NSString *para = [NSString stringWithFormat:@"%@='%@'",key,value];
    MBProgressHUD *hud = [MBProgressHUD showHUDAddedTo:self.view animated:YES];
    hud.mode = MBProgressHUDModeAnnularDeterminate;
    hud.label.text = @"正在修改";
    [WebRequest Meeting_Update_MettingSettingWithuserGuid:user.Guid companyId:user.companyId mettingId:self.settingId para:para And:^(NSDictionary *dic) {
        hud.label.text =dic[Y_MSG];
        dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(0.7 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
            [hud hideAnimated:NO];
            if ([dic[Y_STATUS] integerValue]==200) {
                GNmodel  *model =arr_model[indexPath.row];
                if (indexPath.row ==7 || indexPath.row ==8 || indexPath.row ==10 || indexPath.row ==6) {
                    
                }else
                {
                 model.content = value;
                }
                if(indexPath.row ==1)
                {
                    NSArray *tarr = @[@"每周",@"每月",@"每日",@"一次"];
                    model.content = tarr[[value integerValue]-1];
                }
                
               
                [arr_model replaceObjectAtIndex:indexPath.row withObject:model];
                [tableV reloadRowsAtIndexPaths:@[indexPath] withRowAnimation:UITableViewRowAnimationNone];
            }
        });
      
    }];
        
    }
    
}


@end
