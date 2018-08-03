//
//  FB_notificationAddViewController.m
//  EQD
//
//  Created by 梁新帅 on 2018/1/12.
//  Copyright © 2018年 FitBoy. All rights reserved.
//

#import "FB_notificationAddViewController.h"
#import "PX_PlanViewController.h"
#import "FBTextFieldViewController.h"
#import "FBTextVViewController.h"
#import "FBEQDEditer_AllViewController.h"
#import "EQDR_labelTableViewCell.h"
#import <Masonry.h>
#import "FB_twoTongShi2ViewController.h"
#import "EQDS_SearchViewController.h"
#import "FB_TimeSectionViewController.h"
#import "Bumen_ChooseViewController.h"
#import "FBWebUrlViewController.h"
#import "EQD_HtmlTool.h"
@interface FB_notificationAddViewController ()<UITableViewDelegate,UITableViewDataSource,PX_PlanViewControllerDelegate,FBTextFieldViewControllerDelegate,FBTextVViewControllerDelegate,FBEQDEditer_AllViewControllerDlegate,FB_twoTongShi2ViewControllerDelegate,EQDS_SearchViewControllerDelegate,FB_TimeSectionViewControllerdelegate,Bumen_ChooseViewControllerDelegate>
{
    UITableView *tableV;
    NSArray *arr_names;
    NSMutableArray *arr_contents;
    UserModel *user;
    PlanListModel  *model_detail;
    NSString *html_str;
    NSMutableArray *arr_height;
    NSData *data_editor;
    NSString *techerGuid;
    
    NSString *depId;
    NSString *dutyGuid;
    NSInteger duty_temp;
}

@end

@implementation FB_notificationAddViewController
#pragma  mark - 选择的部门
-(void)getBumenModel:(ZuZhiModel *)model indexPath:(NSIndexPath *)indexPath
{
    if ([model.type integerValue]==0) {
        MBProgressHUD *hud=[MBProgressHUD showHUDAddedTo:self.view  animated:YES];
        hud.mode = MBProgressHUDModeText;
        hud.label.text =@"请选择部门，禁选全体员工";
        dispatch_time_t popTime = dispatch_time(DISPATCH_TIME_NOW, 1 * NSEC_PER_SEC);
        dispatch_after(popTime, dispatch_get_main_queue(), ^(void){
            [MBProgressHUD hideHUDForView:self.view  animated:YES];
        });
    }else
    {
    [arr_contents replaceObjectAtIndex:8 withObject:model.departName];
    depId = model.departId;
    [tableV reloadRowsAtIndexPaths:@[indexPath] withRowAnimation:UITableViewRowAnimationNone];
    }
}
#pragma  mark - 三段时间的选择
-(void)getThreeSectionModel:(NSArray<ThreeSectionModel *> *)arr_threeSectionModel
{
    NSMutableString *Tstr = [NSMutableString string];
    for (int i=0; i<arr_threeSectionModel.count; i++) {
        ThreeSectionModel  *model =arr_threeSectionModel[i];
        if (i==arr_threeSectionModel.count-1) {
            [Tstr appendFormat:@"%@ %@~%@",model.date,model.time1,model.time2];
        }else
        {
           [Tstr appendFormat:@"%@ %@~%@,",model.date,model.time1,model.time2];
        }
    }
    
    [arr_contents replaceObjectAtIndex:3 withObject:Tstr];
    [tableV reloadRowsAtIndexPaths:@[[NSIndexPath indexPathForRow:3 inSection:0]] withRowAnimation:UITableViewRowAnimationNone];
}
#pragma  mark - 课程大纲的协议代理
-(void)getEditerTitle:(NSString *)title html:(NSString *)html text:(NSString *)text imgurl:(NSString *)imgurl stringData:(NSData *)data
{
    html_str = html;
    data_editor =data;
    [arr_contents replaceObjectAtIndex:7 withObject:text];
    [tableV reloadRowsAtIndexPaths:@[[NSIndexPath indexPathForRow:7 inSection:0]] withRowAnimation:UITableViewRowAnimationNone];
    if (model_detail) {
        [WebRequest Courses_Update_courseOutlintWithcourseId:model_detail.courseId userGuid:user.Guid courseOutlint:html And:^(NSDictionary *dic) {
            
        }];
    }
    
}
#pragma  mark - 易企学讲师的搜索
 -(void)getTeacherInfo:(EQDS_teacherInfoModel *)model
{
    techerGuid = model.userGuid;
    [arr_contents replaceObjectAtIndex:5 withObject:model.realname];
    [arr_contents replaceObjectAtIndex:6 withObject:model.PersonalProfile];
    [tableV reloadRowsAtIndexPaths:@[[NSIndexPath indexPathForRow:5 inSection:0],[NSIndexPath indexPathForRow:6 inSection:0]] withRowAnimation:UITableViewRowAnimationNone];
    if (model_detail) {
        [WebRequest Courses_Update_CourseLectureWithcourseId:model_detail.courseId userGuid:user.Guid lectureGuid:techerGuid lectureDescribe:model.PersonalProfile lectureRealName:model.realname And:^(NSDictionary *dic) {
            
        }];
    }
}
#pragma  mark - 同事的选择
-(void)getComUserModel:(Com_UserModel *)model_com indexpath:(NSIndexPath *)indexPath
{
    if (duty_temp ==1) {
        //培训负责人
        [arr_contents replaceObjectAtIndex:9 withObject:model_com.username];
        dutyGuid = model_com.userGuid;
        [tableV reloadRowsAtIndexPaths:@[indexPath] withRowAnimation:UITableViewRowAnimationNone];
        
    }else
    {
        techerGuid = model_com.userGuid;
        [arr_contents replaceObjectAtIndex:5 withObject:model_com.username];
        
        
        if (model_detail) {
            [WebRequest  Courses_Update_CourseLectureWithcourseId:model_detail.courseId userGuid:user.Guid lectureGuid:techerGuid lectureDescribe:@" " lectureRealName:model_com.userGuid And:^(NSDictionary *dic) {
                
            }];
        }
        [tableV reloadRowsAtIndexPaths:@[[NSIndexPath indexPathForRow:5 inSection:0]] withRowAnimation:UITableViewRowAnimationNone];
        
    }
}

- (void)viewDidLoad {
    [super viewDidLoad];
    user = [WebRequest GetUserInfo];
    self.navigationItem.title = @"添加培训通知";
    arr_names = @[@"培训主题",@"受训对象",@"受训人数",@"培训时间",@"培训地点",@"主讲老师",@"讲师介绍",@"课程大纲",@"主办部门",@"培训负责人",@"纪律要求"];
    arr_height = [NSMutableArray arrayWithArray:@[@"60",@"60",@"60",@"60",@"60",@"60",@"60",@"60",@"60",@"60",@"60"]];
    arr_contents = [NSMutableArray arrayWithArray:@[@"请选择",@"根据主题生成",@"根据主题生成",@"根据主题生成",@"请输入",@"根据主题生成",@"请输入",@"请输入",@"请选择",@"请选择",@"查看"]];
    tableV = [[UITableView alloc]initWithFrame:CGRectMake(0, DEVICE_TABBAR_Height, DEVICE_WIDTH, DEVICE_HEIGHT-DEVICE_TABBAR_Height-kBottomSafeHeight) style:UITableViewStylePlain];
    adjustsScrollViewInsets_NO(tableV, self);
    tableV.delegate=self;
    tableV.dataSource=self;
    [self.view addSubview:tableV];
    tableV.rowHeight=60;
    UIBarButtonItem *right = [[UIBarButtonItem alloc]initWithTitle:@"发布" style:UIBarButtonItemStylePlain target:self action:@selector(quedingClick)];
    [self.navigationItem setRightBarButtonItem:right];

    techerGuid = @" ";
    dutyGuid = @" ";
    depId =@"0";
}
-(void)quedingClick{
    NSInteger temp = 0;
    for (int i=0; i<arr_contents.count; i++) {
        if ([arr_contents[i] isEqualToString:@"请选择"] || [arr_contents[i] isEqualToString:@"请输入"]) {
            temp =1;
            break;
        }
    }
    if (temp==0) {
        MBProgressHUD *hud = [MBProgressHUD showHUDAddedTo:self.view animated:YES];
        hud.mode = MBProgressHUDModeAnnularDeterminate;
        hud.label.text = @"正在提交";
        [WebRequest Training_Add_trainingNoticeWithuserGuid:user.Guid comid:user.companyId thePlanId:model_detail.Id theplace:arr_contents[4] teacherGuid:techerGuid teacherName:model_detail.teacherName teacherInfo:arr_contents[6] aSyllabus:html_str presetReleaseTime:@"" theTrainTime:arr_contents[3] hostdepId:depId hostdepName:arr_contents[8] respoPerson:dutyGuid respoPersonName:arr_contents[9]  And:^(NSDictionary *dic) {
            hud.label.text =dic[Y_MSG];
            dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(0.8 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
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
-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return [arr_height[indexPath.row] integerValue];
}
-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return arr_contents.count;
}
-(UITableViewCell*)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    static NSString *cellId=@"cellID";
    EQDR_labelTableViewCell *cell =[tableView dequeueReusableCellWithIdentifier:cellId];
    if (!cell) {
        cell = [[EQDR_labelTableViewCell alloc]initWithStyle:UITableViewCellStyleSubtitle reuseIdentifier:cellId];
        cell.accessoryType = UITableViewCellAccessoryNone;
    }
    
  
        NSMutableAttributedString *name = [[NSMutableAttributedString alloc]initWithString:[NSString stringWithFormat:@"%@: \n",arr_names[indexPath.row]] attributes:@{NSFontAttributeName:[UIFont systemFontOfSize:15],NSForegroundColorAttributeName:[UIColor grayColor]}];
    if (indexPath.row==3) {
        NSArray *tarr = [arr_contents[3] componentsSeparatedByString:@","];
        for (int i=0; i<tarr.count; i++) {
            NSAttributedString *content = [[NSAttributedString alloc]initWithString:[NSString stringWithFormat:@"%@\n",tarr[i]] attributes:@{NSFontAttributeName:[UIFont systemFontOfSize:16]}];
            [name appendAttributedString:content];
        }
    
    }else
    {
        NSAttributedString *content = [[NSAttributedString alloc]initWithString:arr_contents[indexPath.row] attributes:@{NSFontAttributeName:[UIFont systemFontOfSize:16]}];
        [name appendAttributedString:content];
    }
        cell.YL_label.attributedText = name;
        CGSize size = [name boundingRectWithSize:CGSizeMake(DEVICE_WIDTH-45, MAXFLOAT) options:NSStringDrawingUsesLineFragmentOrigin context:nil].size;
        [cell.YL_label mas_remakeConstraints:^(MASConstraintMaker *make) {
            make.height.mas_equalTo(size.height+5);
            make.left.mas_equalTo(cell.mas_left).mas_offset(15);
            make.right.mas_equalTo(cell.mas_right).mas_offset(-30);
            make.centerY.mas_equalTo(cell.mas_centerY);
        }];
        [arr_height replaceObjectAtIndex:indexPath.row withObject:[NSString stringWithFormat:@"%.2f",size.height+20]];
    
    
    if(indexPath.row==0 || indexPath.row>2)
    {
       cell.accessoryType = UITableViewCellAccessoryDisclosureIndicator;
    }else
    {
       cell.accessoryType = UITableViewCellAccessoryNone;
    }
    return cell;
}

#pragma  mark - 表的协议代理
-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    if (indexPath.row==0) {
        //通知的主题
        PX_PlanViewController *Pvc = [[PX_PlanViewController alloc]init];
        Pvc.delegate =self;
        [self.navigationController pushViewController:Pvc animated:NO];
        
    }else if(indexPath.row==4  )
    {
      //培训地点
        FBTextFieldViewController *TFvc =[[FBTextFieldViewController alloc]init];
        TFvc.delegate =self;
        TFvc.indexPath =indexPath;
        TFvc.content =arr_contents[indexPath.row];
        TFvc.contentTitle =arr_names[indexPath.row];
        [self.navigationController pushViewController:TFvc animated:NO];
    }else if (indexPath.row ==5)
    {
        //修改讲师
        UIAlertController  *alert = [UIAlertController alertControllerWithTitle:@"讲师来自？" message:nil preferredStyle:UIAlertControllerStyleActionSheet];
        NSArray *tarr = @[@"易企学",@"企业内部",@"其他"];
        for(int i=0;i<tarr.count;i++ )
        {
            [alert addAction:[UIAlertAction actionWithTitle:tarr[i] style:UIAlertActionStyleDefault handler:^(UIAlertAction * _Nonnull action) {
                if (i==0) {
                   //易企学
                    EQDS_SearchViewController  *Svc = [[EQDS_SearchViewController alloc]init];
                    Svc.delegate =self;
                    [self.navigationController pushViewController:Svc animated:NO];
                    
                }else if (i==1)
                {
                   // 企业内部
                    FB_twoTongShi2ViewController *TSvc =[[FB_twoTongShi2ViewController alloc]init];
                    TSvc.delegate_tongshiDan =self;
                    TSvc.indexPath =indexPath;
                    duty_temp=0;
                    [self.navigationController pushViewController:TSvc animated:NO];
                    
                }else
                {
                    //其他
                    FBTextFieldViewController *TFvc =[[FBTextFieldViewController alloc]init];
                    TFvc.delegate =self;
                    TFvc.indexPath =indexPath;
                    TFvc.content =arr_contents[indexPath.row];
                    TFvc.contentTitle =@"请输入讲师姓名";
                    [self.navigationController pushViewController:TFvc animated:NO];
                }
                
            }]];
            
        }
        [alert addAction:[UIAlertAction actionWithTitle:@"取消" style:UIAlertActionStyleCancel handler:^(UIAlertAction * _Nonnull action) {
            
        }]];
        dispatch_async(dispatch_get_main_queue(), ^{
            [self presentViewController:alert animated:NO completion:nil];
        });
        
        
    }
    else if (indexPath.row ==6 )
    {
        // 讲师介绍
        FBTextVViewController *TVvc =[[FBTextVViewController alloc]init];
        TVvc.indexpath =indexPath;
        TVvc.delegate =self;
        TVvc.contentTitle=arr_names[indexPath.row];
        TVvc.content =arr_contents[indexPath.row];
        [self.navigationController pushViewController:TVvc animated:NO];
    }else if (indexPath.row==7)
    {
        //课程大纲
        FBEQDEditer_AllViewController *Avc = [[FBEQDEditer_AllViewController alloc]init];
        Avc.temp =10;
        Avc.delegate =self;
        if (html_str) {
//            Avc.editor_data =data_editor;
            Avc.editor_htmlText = html_str;
        }
        [self.navigationController pushViewController:Avc animated:NO];
    }
    else if (indexPath.row==8)
    {
        //主办部门
        Bumen_ChooseViewController  *Bvc = [[Bumen_ChooseViewController alloc]init];
        Bvc.indexPath = indexPath;
        Bvc.delegate =self;
        [self.navigationController pushViewController:Bvc animated:NO];
    }else if (indexPath.row==9)
    {
      //培训负责人
        FB_twoTongShi2ViewController  *Tvc = [[FB_twoTongShi2ViewController alloc]init];
        Tvc.delegate_tongshiDan =self;
        Tvc.indexPath = indexPath;
        duty_temp =1;
        [self.navigationController pushViewController:Tvc animated:NO];
    }else if (indexPath.row==10)
    {
       //培训的纪律要求
        FBWebUrlViewController   *Wvc =[[FBWebUrlViewController alloc]init];
        Wvc.url =[EQD_HtmlTool  getEQD_TrainJiLv];
        Wvc.contentTitle = @"纪律要求";
        [self.navigationController pushViewController:Wvc animated:NO];
    }
    else if (indexPath.row==3)
    {
        //培训时间
        FB_TimeSectionViewController  *Svc = [[FB_TimeSectionViewController alloc]init];
        Svc.delegate =self;
        NSArray *tarr = [arr_contents[3] componentsSeparatedByString:@","];
        NSMutableArray *arr_m=[NSMutableArray arrayWithCapacity:0];
        for (int i=0; i<tarr.count; i++) {
            ThreeSectionModel *model = [[ThreeSectionModel alloc]init];
            NSArray *tarr2 = [tarr[i] componentsSeparatedByString:@" "];
            if (tarr2.count==2) {
               NSArray *tarr3 =[tarr2[1] componentsSeparatedByString:@"~"];
                model.date =tarr2[0];
                model.time1 = tarr3[0];
                model.time2 = tarr3[1];
                 [arr_m addObject:model];
            }
        
           
        }
        Svc.arr_IthreeSectionModel =arr_m;
        [self.navigationController pushViewController:Svc animated:NO];
    }
    else
    {
        
    }
}

#pragma  mark - 自定义的协议代理
-(void)content:(NSString *)content WithindexPath:(NSIndexPath *)indexPath
{
    if (indexPath.row==5 && model_detail) {
        ///修改讲师
        [WebRequest Courses_Update_CourseLectureWithcourseId:model_detail.courseId userGuid:user.Guid lectureGuid:@" " lectureDescribe:@" " lectureRealName:content And:^(NSDictionary *dic) {
            
        }];
    }
    [arr_contents replaceObjectAtIndex:indexPath.row withObject:content];
    [tableV reloadRowsAtIndexPaths:@[indexPath] withRowAnimation:UITableViewRowAnimationNone];
}
-(void)textVtext:(NSString *)text indexPath:(NSIndexPath *)indexPath
{
    if (indexPath.row==6) {
        //讲师简介
        if (model_detail) {
            [WebRequest Courses_Update_CourseLectureWithcourseId:model_detail.courseId userGuid:user.Guid lectureGuid:techerGuid lectureDescribe:text lectureRealName:arr_contents[5] And:^(NSDictionary *dic) {
                
            }];
        }
       
    }
    [arr_contents replaceObjectAtIndex:indexPath.row withObject:text];
    [tableV reloadRowsAtIndexPaths:@[indexPath] withRowAnimation:UITableViewRowAnimationNone];
}
-(void)getPlanListModel:(PlanListModel *)planModel
{
    //根据课程id获取课程的详情
    
    [WebRequest  Training_Get_trainingPlanDetailWithuserGuid:user.Guid comid:user.companyId planId:planModel.ID And:^(NSDictionary *dic) {
        if ([dic[Y_STATUS] integerValue]==200) {
            model_detail = [PlanListModel mj_objectWithKeyValues:dic[Y_ITEMS]];
            [arr_contents replaceObjectAtIndex:0 withObject:model_detail.theTheme];
            [arr_contents replaceObjectAtIndex:1 withObject:model_detail.trainees];
            [arr_contents replaceObjectAtIndex:2 withObject:model_detail.personNumber];
            [arr_contents replaceObjectAtIndex:3 withObject:model_detail.theTrainTime];
            [arr_contents replaceObjectAtIndex:5 withObject:model_detail.teacherName];
//            [arr_contents replaceObjectAtIndex:8 withObject:model_detail.receTrainDepName];
            techerGuid = model_detail.teacherGuid;
            
            dispatch_async(dispatch_get_main_queue(), ^{
                [tableV reloadData];
            });
        }else
        {
            MBProgressHUD *hud=[MBProgressHUD showHUDAddedTo:self.view  animated:YES];
            hud.mode = MBProgressHUDModeText;
            hud.label.text =@"服务器错误请重试";
            dispatch_time_t popTime = dispatch_time(DISPATCH_TIME_NOW, 1 * NSEC_PER_SEC);
            dispatch_after(popTime, dispatch_get_main_queue(), ^(void){
                [MBProgressHUD hideHUDForView:self.view  animated:YES];
            });
        }
    }];
    
}


@end
