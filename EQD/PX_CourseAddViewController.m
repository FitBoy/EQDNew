//
//  PX_CourseAddViewController.m
//  EQD
//
//  Created by 梁新帅 on 2018/2/3.
//  Copyright © 2018年 FitBoy. All rights reserved.
//  分课程信息 与 讲师信息

#import "PX_CourseAddViewController.h"
#import "FBLabel_YYAddTableViewCell.h"
#import <Masonry.h>
#import "FBTextFieldViewController.h"
#import "FB_PXLeiBieChooseViewController.h"
#import "FBEQDEditer_AllViewController.h"
#import "EQDS_SearchViewController.h"
#import "FB_PXChooseViewController.h"
#import "FBTextVViewController.h"
#import "FBOneChoose_TongShiViewController.h"
@interface PX_CourseAddViewController ()<UITableViewDelegate,UITableViewDataSource,FB_PXLeiBieChooseViewControllerdelegate,FBTextFieldViewControllerDelegate,FBEQDEditer_AllViewControllerDlegate,EQDS_SearchViewControllerDelegate,FB_PXChooseViewControllerDelegate,FBTextVViewControllerDelegate,FBOneChoose_TongShiViewControllerDelegate>
{
    UITableView *tableV;
    NSArray *arr_names;
    NSMutableArray *arr_contents1;
    NSMutableArray *arr_contents2;
    UserModel *user;
    NSMutableArray *arr_height1;
    NSMutableArray *arr_height2;
    NSArray  *arr_leibieModel; // 课程类别
    NSString *html_editor;
    NSArray *arr_duixiang;// 受训对象
    
    NSString *Guid_teacher;
    
    NSString  *Sourcelecturer;//（1,内部，2,外部-培训采购，3,网络
    
    
}

@end

@implementation PX_CourseAddViewController
#pragma  mark - 同事
-(void)chooseModel:(Com_UserModel *)model indexpath:(NSIndexPath *)indepPath
{
    Guid_teacher = model.userGuid;
    [arr_contents2 replaceObjectAtIndex:0 withObject:model.username];
    [tableV reloadRowsAtIndexPaths:@[indepPath] withRowAnimation:UITableViewRowAnimationNone];
}
#pragma  mark - 课程大纲
-(void)getEditerTitle:(NSString *)title html:(NSString *)html text:(NSString *)text imgurl:(NSString *)imgurl stringData:(NSData *)data
{
    html_editor = html;
    [arr_contents1 replaceObjectAtIndex:4 withObject:text];
    [tableV reloadRowsAtIndexPaths:@[[NSIndexPath indexPathForRow:4 inSection:0]] withRowAnimation:UITableViewRowAnimationNone];
}
#pragma  mark - 课程类别
-(void)getTecherLeiBieModel:(NSArray<FBAddressModel *> *)arr_teachers
{
    arr_leibieModel =arr_teachers;
    NSMutableString  *Tstr = [NSMutableString string];
    for (int i=0; i<arr_teachers.count; i++) {
        FBAddressModel  *model = arr_teachers[i];
        if (i==arr_teachers.count-1) {
            [Tstr appendString:model.name];
        }else
        {
            [Tstr appendFormat:@"%@ ",model.name];
        }
    }
    [arr_contents1 replaceObjectAtIndex:1 withObject:Tstr];
    [tableV reloadRowsAtIndexPaths:@[[NSIndexPath indexPathForRow:1 inSection:0]] withRowAnimation:UITableViewRowAnimationNone];
}
#pragma  mark - 文本的协议代理
-(void)content:(NSString *)content WithindexPath:(NSIndexPath *)indexPath
{
    if (indexPath.section==0) {
        [arr_contents1 replaceObjectAtIndex:indexPath.row withObject:content];
    }else
    {
        [arr_contents2 replaceObjectAtIndex:indexPath.row withObject:content];
        if (indexPath.row==0) {
            //讲师
            Guid_teacher =@" ";
        }
    }
    [tableV reloadRowsAtIndexPaths:@[indexPath] withRowAnimation:UITableViewRowAnimationNone];
}
#pragma  mark - 易企学的讲师 
-(void)getTeacherInfo:(EQDS_teacherInfoModel *)model
{
    [arr_contents2 replaceObjectAtIndex:0 withObject:model.realname];
    Guid_teacher = model.userGuid;
    [arr_contents2 replaceObjectAtIndex:1 withObject:model.PersonalProfile];
    [tableV reloadRowsAtIndexPaths:@[[NSIndexPath indexPathForRow:0 inSection:1],[NSIndexPath indexPathForRow:1 inSection:1]] withRowAnimation:UITableViewRowAnimationNone];
}
#pragma  mark - 多文本的内容
-(void)textVtext:(NSString *)text indexPath:(NSIndexPath *)indexPath
{
    [arr_contents2 replaceObjectAtIndex:indexPath.row withObject:text];
    [arr_contents2 replaceObjectAtIndex:indexPath.row withObject:text];
    [tableV reloadRowsAtIndexPaths:@[indexPath] withRowAnimation:UITableViewRowAnimationNone];
}
#pragma  mark - 受训对象
-(void)getGangweiModel:(NSArray<GangweiModel *> *)arr_gangwei
{
    arr_duixiang =arr_gangwei;
    NSMutableString  *Tstr = [NSMutableString string];
    for (int i=0; i<arr_gangwei.count; i++) {
        GangweiModel  *model =arr_gangwei[i];
        if (i==arr_gangwei.count-1) {
            
            [Tstr appendString:model.name];
        }else
        {
            [Tstr appendFormat:@"%@  ",model.name];
        }
      
    }
    [arr_contents2 replaceObjectAtIndex:2 withObject:Tstr];
    [tableV reloadRowsAtIndexPaths:@[[NSIndexPath indexPathForRow:2 inSection:1]] withRowAnimation:UITableViewRowAnimationNone];
}
- (void)viewDidLoad {
    [super viewDidLoad];
    self.navigationItem.title = @"添加企业课程";
    user = [WebRequest GetUserInfo];
    arr_names=@[@[@"课程主题",@"课程类别",@"课程时长/天",@"适合人群",@"课程大纲"],@[@"讲师",@"讲师介绍",@"受训对象",@"费用预算/元"]];
    arr_contents1= [NSMutableArray arrayWithArray:@[@"请输入",@"请选择",@"请输入",@"请输入",@"请输入"]];
    arr_height1 = [NSMutableArray arrayWithArray:@[@"60",@"60",@"60",@"60",@"60"]];
    arr_contents2=[NSMutableArray arrayWithArray:@[@"请选择",@"请输入",@"请选择",@"请输入"]];
    arr_height2 = [NSMutableArray arrayWithArray:@[@"60",@"60",@"60",@"60"]];
    tableV = [[UITableView alloc]initWithFrame:CGRectMake(0, DEVICE_TABBAR_Height, DEVICE_WIDTH, DEVICE_HEIGHT-DEVICE_TABBAR_Height-kBottomSafeHeight) style:UITableViewStyleGrouped];
    adjustsScrollViewInsets_NO(tableV, self);
    tableV.delegate=self;
    tableV.dataSource=self;
    [self.view addSubview:tableV];
    tableV.rowHeight=60;
    tableV.contentInset = UIEdgeInsetsMake(15, 0, 0, 0  );
    arr_leibieModel = nil;
    html_editor =nil;
    arr_duixiang = nil;
    Guid_teacher =@" ";
    UIBarButtonItem *right = [[UIBarButtonItem alloc]initWithTitle:@"提交" style:UIBarButtonItemStylePlain target:self action:@selector(tijiaoClick)];
    [self.navigationItem setRightBarButtonItem:right];
}
#pragma  mark - 提交
-(void)tijiaoClick
{
    NSInteger temp =0;
    for (int i=0; i<arr_contents1.count; i++) {
        if ([arr_contents1[i] isEqualToString:@"请输入"] || [arr_contents1[i] isEqualToString:@"请选择"]) {
            temp =1;
            break;
        }
    }
    for (int i=0; i<arr_contents2.count; i++) {
        if ([arr_contents2[i] isEqualToString:@"请输入"] || [arr_contents2[i] isEqualToString:@"请选择"]) {
            temp =1;
            break;
        }
    }
    NSMutableString  *courseType = [NSMutableString string];
    for (int i=0; i<arr_leibieModel.count; i++) {
        FBAddressModel *model = arr_leibieModel[i];
        if (i==arr_leibieModel.count-1) {
            [courseType appendString:model.name];
        }else
        {
            [courseType appendFormat:@"%@,",model.name];
        }
    }
    NSMutableString  *MatchIds = [NSMutableString string];
    for (int i=0; i<arr_duixiang.count; i++) {
        GangweiModel  *model = arr_duixiang[i];
        if (i==arr_duixiang.count-1) {
            [MatchIds appendString:model.ID];
        }else
        {
            [MatchIds appendFormat:@"%@,",model.ID];
        }
        
    }
    
    if(temp ==0)
    {
        MBProgressHUD *hud=[MBProgressHUD showHUDAddedTo:self.view  animated:YES];
        hud.mode = MBProgressHUDModeText;
        hud.label.text =@"正在提交";
        dispatch_time_t popTime = dispatch_time(DISPATCH_TIME_NOW, 1 * NSEC_PER_SEC);
        dispatch_after(popTime, dispatch_get_main_queue(), ^(void){
            [MBProgressHUD hideHUDForView:self.view  animated:YES];
        });
        [WebRequest Courses_Add_CourseWithuserGuid:user.Guid companyId:user.companyId courseType:courseType courseTheme:arr_contents1[0] courseTimes:arr_contents1[2] courseOutlint:html_editor sourceCourse:@"2" objecter:arr_contents1[3] Sourcelecturer: Sourcelecturer Lecture:Guid_teacher TrainingId:@"0" LectureIntroduce:arr_contents2[1] MatchType:@"1" MatchIds:MatchIds Costbudget:arr_contents2[3] LectureRealName:arr_contents2[0] And:^(NSDictionary *dic) {
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
#pragma  mark - 表的数据源
-(NSString*)tableView:(UITableView *)tableView titleForHeaderInSection:(NSInteger)section
{
    NSArray *tarr= @[@"课程信息",@"讲师信息"];
    return tarr[section];
}
-(CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section
{
    return 15;
}
-(NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return 2;
}
-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    if (indexPath.section==0) {
        return [arr_height1[indexPath.row] integerValue];
    }else
    {
        return [arr_height2[indexPath.row] integerValue];
    }
}
-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return section==0?arr_contents1.count:arr_contents2.count;
}
-(UITableViewCell*)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    static NSString *cellId=@"cellID";
    FBLabel_YYAddTableViewCell *cell =[tableView dequeueReusableCellWithIdentifier:cellId];
    if (!cell) {
        cell = [[FBLabel_YYAddTableViewCell alloc]initWithStyle:UITableViewCellStyleDefault reuseIdentifier:cellId];
        cell.accessoryType = UITableViewCellAccessoryDisclosureIndicator;
        cell.textLabel.font = [UIFont systemFontOfSize:18];
    }
    NSArray *tarr = arr_names[indexPath.section];
    cell.L_name.text =tarr[indexPath.row];
    if (indexPath.section==0) {
        NSAttributedString  *content = [[NSAttributedString alloc]initWithString:arr_contents1[indexPath.row] attributes:@{NSFontAttributeName:[UIFont systemFontOfSize:17]}];
        
        CGSize size1 = [content boundingRectWithSize:CGSizeMake(DEVICE_WIDTH-30, MAXFLOAT) options:NSStringDrawingUsesLineFragmentOrigin context:nil].size;
        [cell.YL_content mas_remakeConstraints:^(MASConstraintMaker *make) {
            make.size.mas_equalTo(size1.height+5);
            make.left.mas_equalTo(cell.mas_left).mas_offset(15);
            make.right.mas_equalTo(cell.mas_right).mas_offset(-15);
            make.top.mas_equalTo(cell.L_name.mas_bottom).mas_offset(5);
        }];
        cell.YL_content.attributedText = content;
        [arr_height1 replaceObjectAtIndex:indexPath.row withObject:[NSString stringWithFormat:@"%.2f",size1.height+10+20]];
        
    }else
    {
        NSAttributedString  *content = [[NSAttributedString alloc]initWithString:arr_contents2[indexPath.row] attributes:@{NSFontAttributeName:[UIFont systemFontOfSize:17]}];
        
        CGSize size1 = [content boundingRectWithSize:CGSizeMake(DEVICE_WIDTH-30, MAXFLOAT) options:NSStringDrawingUsesLineFragmentOrigin context:nil].size;
        [cell.YL_content mas_remakeConstraints:^(MASConstraintMaker *make) {
            make.size.mas_equalTo(size1.height+5);
            make.left.mas_equalTo(cell.mas_left).mas_offset(15);
            make.right.mas_equalTo(cell.mas_right).mas_offset(-15);
            make.top.mas_equalTo(cell.L_name.mas_bottom).mas_offset(5);
        }];
        cell.YL_content.attributedText = content;
        [arr_height2 replaceObjectAtIndex:indexPath.row withObject:[NSString stringWithFormat:@"%.2f",size1.height+10+20]];
    }
    return cell;
}

#pragma  mark - 表的协议代理
-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
 if(indexPath.section==0)
 {
     if (indexPath.row==0 || indexPath.row==2 || indexPath.row==3 ) {
         // 课程主题
         FBTextFieldViewController *TFvc =[[FBTextFieldViewController alloc]init];
         TFvc.delegate =self;
         TFvc.indexPath =indexPath;
         TFvc.content =arr_contents1[indexPath.row];
        
         TFvc.contentTitle =arr_names[indexPath.section][indexPath.row];
         [self.navigationController pushViewController:TFvc animated:NO];
     }else if (indexPath.row==1)
     {
         FB_PXLeiBieChooseViewController  *Lvc =[[FB_PXLeiBieChooseViewController alloc]init];
         Lvc.delegate =self;
         Lvc.arr_chosemodel = arr_leibieModel;
         [self.navigationController pushViewController:Lvc animated:NO];
     }else if (indexPath.row==4)
     {
         FBEQDEditer_AllViewController  *Avc = [[FBEQDEditer_AllViewController alloc]init];
         Avc.delegate =self;
         Avc.editor_title = @"课程大纲";
         Avc.temp =10;
         Avc.editor_htmlText = html_editor;
         [self.navigationController pushViewController:Avc animated:NO];
     }else{
         
     }
 }else
 {
     if (indexPath.row==0) {
       ///讲师
         UIAlertController  *alert = [UIAlertController alertControllerWithTitle:@"讲师来自？" message:nil preferredStyle:UIAlertControllerStyleActionSheet];
         NSArray *tarr= @[@"易企学",@"企业内部",@"其他"];
         for(int i=0;i<tarr.count;i++)
         {
             [alert addAction:[UIAlertAction actionWithTitle:tarr[i] style:UIAlertActionStyleDefault handler:^(UIAlertAction * _Nonnull action) {
                 if (i==0) {
                     //易企学
                     Sourcelecturer =@"2";
                     EQDS_SearchViewController *Svc = [[EQDS_SearchViewController alloc]init];
                     Svc.delegate =self;
                     [self.navigationController pushViewController:Svc animated:NO];
                 }else if (i==1)
                 {
                     // 企业内部
                      Sourcelecturer =@"1";
                     FBOneChoose_TongShiViewController  *TSvc =[[FBOneChoose_TongShiViewController alloc]init];
                     TSvc.delegate =self;
                     TSvc.indexpath =indexPath;
                     [self.navigationController pushViewController:TSvc animated:NO];
                 }else
                 {
                     //其他
                      Sourcelecturer =@"3";
                     FBTextFieldViewController *TFvc =[[FBTextFieldViewController alloc]init];
                     TFvc.delegate =self;
                     TFvc.indexPath =indexPath;
                     TFvc.content =arr_contents2[indexPath.row];
                     TFvc.contentTitle =arr_names[indexPath.row];
                     [self.navigationController pushViewController:TFvc animated:NO];
                 }
             }]];
             
         }
         [alert addAction:[UIAlertAction actionWithTitle:@"取消" style:UIAlertActionStyleCancel handler:^(UIAlertAction * _Nonnull action) {
             
         }]];
         [self presentViewController:alert animated:NO completion:nil];
         
     }else if (indexPath.row==1)
     {
         //讲师介绍
         FBTextVViewController *TVvc =[[FBTextVViewController alloc]init];
         TVvc.indexpath =indexPath;
         TVvc.delegate =self;
         TVvc.contentTitle=arr_names[indexPath.section][indexPath.row];
         TVvc.content =arr_contents2[indexPath.row];
         [self.navigationController pushViewController:TVvc animated:NO];
     }else if (indexPath.row==2)
     {
         //受训对象
         FB_PXChooseViewController  *Cvc =[[FB_PXChooseViewController alloc]init];
         Cvc.delegate =self;
         Cvc.arr_choseModel = arr_duixiang;
         [self.navigationController pushViewController:Cvc animated:NO];
         
     }else if (indexPath.row==3)
     {
         //费用预算
         FBTextFieldViewController *TFvc =[[FBTextFieldViewController alloc]init];
         TFvc.delegate =self;
         TFvc.indexPath =indexPath;
         TFvc.content =arr_contents2[indexPath.row];
         TFvc.contentTitle =arr_names[indexPath.section][indexPath.row];
         [self.navigationController pushViewController:TFvc animated:NO];
     }
     else
     {
         
     }
 }
}




@end
