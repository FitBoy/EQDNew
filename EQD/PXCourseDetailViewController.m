//
//  PXCourseDetailViewController.m
//  EQD
//
//  Created by 梁新帅 on 2018/2/6.
//  Copyright © 2018年 FitBoy. All rights reserved.
//

#import "PXCourseDetailViewController.h"
#import "PX_courseManageModel.h"
#import "FBLabel_YYAddTableViewCell.h"
#import <Masonry.h>
#import "FBEQDEditer_AllViewController.h"
#import "EQDS_SearchViewController.h"
#import "FB_twoTongShi2ViewController.h"
#import "FBTextFieldViewController.h"
#import "FBTextVViewController.h"
@interface PXCourseDetailViewController ()<UITableViewDelegate,UITableViewDataSource,FBEQDEditer_AllViewControllerDlegate,EQDS_SearchViewControllerDelegate,FB_twoTongShi2ViewControllerDelegate,FBTextFieldViewControllerDelegate,FBTextVViewControllerDelegate>
{
    UITableView *tableV;
    NSArray *arr_names1;
    NSArray *arr_names2;
    NSArray *arr_names3;
    
    NSMutableArray *arr_contents1;
    NSMutableArray *arr_contents2;
    NSMutableArray *arr_contents3;
    UserModel *user;
    NSArray *arr_titles;
    PX_courseManageModel *model_detail;
    
    NSMutableArray *arr_height1;
    NSMutableArray *arr_height2;
    NSMutableArray *arr_height3;
    
    NSString *Guid_teacher; //讲师的Guid
    NSString *name_teacher;
}

@end

@implementation PXCourseDetailViewController
-(void)textVtext:(NSString *)text indexPath:(NSIndexPath *)indexPath
{
    MBProgressHUD *hud = [MBProgressHUD showHUDAddedTo:self.view animated:YES];
    hud.mode = MBProgressHUDModeAnnularDeterminate;
    hud.label.text = @"正在修改";
    [WebRequest Courses_Update_CourseLectureWithcourseId:self.courseId userGuid:user.Guid lectureGuid:Guid_teacher lectureDescribe:text lectureRealName:name_teacher And:^(NSDictionary *dic) {
        hud.label.text = dic[Y_MSG];
        dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(0.7 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
            if ([dic[Y_STATUS] integerValue]==200) {
                [hud hideAnimated:NO];
                [arr_contents2 replaceObjectAtIndex:1 withObject:text];
                dispatch_async(dispatch_get_main_queue(), ^{
                     [tableV reloadRowsAtIndexPaths:@[indexPath] withRowAnimation:UITableViewRowAnimationNone];
                
                });
            }
        });
    }];
    
}
-(void)getEditerTitle:(NSString *)title html:(NSString *)html text:(NSString *)text imgurl:(NSString *)imgurl stringData:(NSData *)data
{
    [WebRequest  Courses_Update_courseOutlintWithcourseId:self.courseId userGuid:user.Guid courseOutlint:html And:^(NSDictionary *dic) {
        if ([dic[Y_STATUS] integerValue]==200) {
            [arr_contents1 replaceObjectAtIndex:4 withObject:html];
            dispatch_async(dispatch_get_main_queue(), ^{
              [tableV reloadRowsAtIndexPaths:@[[NSIndexPath indexPathForRow:4 inSection:0]] withRowAnimation:UITableViewRowAnimationNone];
            });
        }
    }];
}
#pragma  mark - 搜索讲师
-(void)getTeacherInfo:(EQDS_teacherInfoModel *)model
{
    Guid_teacher = model.userGuid;
    name_teacher = model.realname;
    [self updateTeacherInfoWithTeacherName:model.realname];
}

-(void)getComUserModel:(Com_UserModel *)model_com indexpath:(NSIndexPath *)indexPath
{
    Guid_teacher = model_com.userGuid;
    name_teacher = model_com.username;
    [self updateTeacherInfoWithTeacherName:model_com.username];
}

-(void)content:(NSString *)content WithindexPath:(NSIndexPath *)indexPath
{
    Guid_teacher = @" ";
    name_teacher = content;
    [self updateTeacherInfoWithTeacherName:content];
}
-(void)updateTeacherInfoWithTeacherName:(NSString*)TeacherName{
    MBProgressHUD *hud = [MBProgressHUD showHUDAddedTo:self.view animated:YES];
    hud.mode = MBProgressHUDModeAnnularDeterminate;
    hud.label.text = @"正在修改";
    [WebRequest Courses_Update_CourseLectureWithcourseId:self.courseId userGuid:user.Guid lectureGuid:Guid_teacher lectureDescribe:@" " lectureRealName:TeacherName And:^(NSDictionary *dic) {
        hud.label.text = dic[Y_MSG];
        
        dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(0.7 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
            if ([dic[Y_STATUS] integerValue]==200) {
                [hud hideAnimated:NO];
                [arr_contents2 replaceObjectAtIndex:0 withObject:TeacherName];
                dispatch_async(dispatch_get_main_queue(), ^{
                    [tableV reloadRowsAtIndexPaths:@[[NSIndexPath indexPathForRow:0 inSection:1]] withRowAnimation:UITableViewRowAnimationNone];
                });
            }
        });
    }];
}

- (void)viewDidLoad {
    [super viewDidLoad];
    user = [WebRequest GetUserInfo];
    arr_titles = @[@"课程信息",@"讲师信息",@"其他"];
    arr_names1 =@[@"课程主题",@"课程类别",@"课程时长/h",@"适合人群",@"课程大纲"];
    arr_names2 = @[@"讲师",@"讲师简介",@"受训对象",@"费用预算"];
    arr_names3 = @[@"课件",@"课程作业",@"课程作业答案",@"课程试卷",@"课程试卷答案",@"音频",@"视频(仅支持优酷)"];
    arr_height1 = [NSMutableArray arrayWithArray:@[@"60",@"60",@"60",@"60",@"60"]];
    arr_height2 = [NSMutableArray arrayWithArray:@[@"60",@"60",@"60",@"60"]];
    arr_height3 = [NSMutableArray arrayWithArray:@[@"60",@"60",@"60",@"60",@"60",@"60",@"60"]];
    [WebRequest  Courses_Get_CourseByIdWithcourseId:self.courseId And:^(NSDictionary *dic) {
        if ([dic[Y_STATUS] integerValue]==200) {
            model_detail = [PX_courseManageModel mj_objectWithKeyValues:dic[Y_ITEMS]];
            arr_contents1 = [NSMutableArray arrayWithArray:@[model_detail.courseTheme,model_detail.courseType,model_detail.courseTimes,model_detail.objecter,model_detail.courseOutlint]];
            NSMutableString  *posts = [NSMutableString string];
            for (int i=0; i<model_detail.posts2.count; i++) {
                if (i==model_detail.posts2.count-1) {
                    [posts appendString:model_detail.posts2[i]];
                }else
                {
                    [posts appendFormat:@"%@  ",model_detail.posts2[i]];
                }
            }
            arr_contents2 = [NSMutableArray arrayWithArray:@[model_detail.LectureRealName,model_detail.LectureIntroduce,posts,model_detail.Costbudget]];
            arr_contents3 =[NSMutableArray arrayWithArray:@[@"查看",@"查看",@"查看",@"查看",@"查看",@"查看",@"查看"]] ;
            
            [tableV reloadData];
        }
    }];
    
    self.navigationItem.title =@"课程详情";
    tableV = [[UITableView alloc]initWithFrame:CGRectMake(0, DEVICE_TABBAR_Height, DEVICE_WIDTH, DEVICE_HEIGHT-DEVICE_TABBAR_Height-kBottomSafeHeight) style:UITableViewStyleGrouped];
    adjustsScrollViewInsets_NO(tableV, self);
    tableV.delegate=self;
    tableV.dataSource=self;
    [self.view addSubview:tableV];
    tableV.rowHeight=60;
    tableV.contentInset = UIEdgeInsetsMake(15, 0, 0, 0);
}
#pragma  mark - 表的数据源
-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    if (indexPath.section==0) {
        return [arr_height1[indexPath.row] integerValue];
    }else if (indexPath.section==1)
    {
        return [arr_height2[indexPath.row] integerValue];
    }else
    {
        return [arr_height3[indexPath.row] integerValue];
    }
}
-(CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section
{
    return 15;
}
-(NSString*)tableView:(UITableView *)tableView titleForHeaderInSection:(NSInteger)section
{
    return arr_titles[section];
}
-(NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return 3;
}
-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    if (section==0) {
        return arr_contents1.count;
    }else if(section==1)
    {
        return arr_contents2.count;
    }else
    {
        return arr_contents3.count;
    }
}
-(UITableViewCell*)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    static NSString *cellId=@"cellID";
    FBLabel_YYAddTableViewCell *cell =[tableView dequeueReusableCellWithIdentifier:cellId];
    if (!cell) {
        cell = [[FBLabel_YYAddTableViewCell alloc]initWithStyle:UITableViewCellStyleDefault reuseIdentifier:cellId];
        cell.accessoryType = UITableViewCellAccessoryNone;
    }
    if (indexPath.section==0) {
        cell.L_name.text = arr_names1[indexPath.row];
        
        if (indexPath.row==4) {
            //课程大纲
            NSString * htmlString = [NSString stringWithFormat:@"<html><body style= \"font-size:16px\">%@ </body></html>",arr_contents1[4]];
            NSAttributedString * attrStr = [[NSAttributedString alloc] initWithData:[htmlString dataUsingEncoding:NSUnicodeStringEncoding] options:@{ NSDocumentTypeDocumentAttribute: NSHTMLTextDocumentType } documentAttributes:nil error:nil];
            CGSize size = [attrStr boundingRectWithSize:CGSizeMake(DEVICE_WIDTH-30, MAXFLOAT) options:NSStringDrawingUsesLineFragmentOrigin context:nil].size;
            [cell.YL_content mas_remakeConstraints:^(MASConstraintMaker *make) {
                make.height.mas_equalTo(size.height+5);
                make.left.mas_equalTo(cell.mas_left).mas_offset(15);
                make.right.mas_equalTo(cell.mas_right).mas_equalTo(-15);
                make.bottom.mas_equalTo(cell.mas_bottom).mas_offset(-5);
            }];
            
            [arr_height1 replaceObjectAtIndex:indexPath.row withObject:[NSString stringWithFormat:@"%.2f",size.height+30]];
            cell.YL_content.attributedText = attrStr;
        }else
        {
        NSString *tstr =arr_contents1[indexPath.row];
        CGSize size=   [tstr boundingRectWithSize:CGSizeMake(DEVICE_WIDTH-30, MAXFLOAT) options:NSStringDrawingUsesLineFragmentOrigin attributes:@{NSFontAttributeName:[UIFont systemFontOfSize:16]} context:nil].size;
      
        [cell.YL_content mas_remakeConstraints:^(MASConstraintMaker *make) {
            make.height.mas_equalTo(size.height+5);
            make.left.mas_equalTo(cell.mas_left).mas_offset(15);
            make.right.mas_equalTo(cell.mas_right).mas_equalTo(-15);
            make.bottom.mas_equalTo(cell.mas_bottom).mas_offset(-5);
        }];
        
        [arr_height1 replaceObjectAtIndex:indexPath.row withObject:[NSString stringWithFormat:@"%.2f",size.height+30]];
        cell.YL_content.text = arr_contents1[indexPath.row];
        }
        
    }else if (indexPath.section==1)
    {
        NSString *tstr =arr_contents2[indexPath.row];
        CGSize size=   [tstr boundingRectWithSize:CGSizeMake(DEVICE_WIDTH-30, MAXFLOAT) options:NSStringDrawingUsesLineFragmentOrigin attributes:@{NSFontAttributeName:[UIFont systemFontOfSize:16]} context:nil].size;
        [cell.YL_content mas_remakeConstraints:^(MASConstraintMaker *make) {
            make.height.mas_equalTo(size.height+5);
            make.left.mas_equalTo(cell.mas_left).mas_offset(15);
            make.right.mas_equalTo(cell.mas_right).mas_equalTo(-15);
            make.bottom.mas_equalTo(cell.mas_bottom).mas_offset(-5);
        }];
        
        [arr_height2 replaceObjectAtIndex:indexPath.row withObject:[NSString stringWithFormat:@"%.2f",size.height+30]];
        cell.L_name.text = arr_names2[indexPath.row];
        cell.YL_content.text = arr_contents2[indexPath.row];
    }
    else
    {
        NSString *tstr =arr_contents3[indexPath.row];
        CGSize size=   [tstr boundingRectWithSize:CGSizeMake(DEVICE_WIDTH-30, MAXFLOAT) options:NSStringDrawingUsesLineFragmentOrigin attributes:@{NSFontAttributeName:[UIFont systemFontOfSize:16]} context:nil].size;
        [cell.YL_content mas_remakeConstraints:^(MASConstraintMaker *make) {
            make.height.mas_equalTo(size.height+5);
            make.left.mas_equalTo(cell.mas_left).mas_offset(15);
            make.right.mas_equalTo(cell.mas_right).mas_equalTo(-15);
            make.bottom.mas_equalTo(cell.mas_bottom).mas_offset(-5);
        }];
        
        [arr_height3 replaceObjectAtIndex:indexPath.row withObject:[NSString stringWithFormat:@"%.2f",size.height+30]];
        cell.L_name.text =arr_names3[indexPath.row];
        cell.YL_content.text =arr_contents3[indexPath.row];
    }
    return cell;
}

#pragma  mark - 表的协议代理
-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    if (indexPath.section==0) {
        if (indexPath.row==4) {
            //修改课程大纲
            FBEQDEditer_AllViewController  *Avc = [[FBEQDEditer_AllViewController alloc]init];
            Avc.delegate =self;
            Avc.editor_htmlText = arr_contents1[4];
            Avc.temp =10;
            [self.navigationController pushViewController:Avc animated:NO];
            
        }else
        {
            
        }
    }else if (indexPath.section==1)
    {
        if (indexPath.row==0) {
            //修改讲师
            UIAlertController  *alert = [UIAlertController alertControllerWithTitle:@"讲师来自？" message:nil preferredStyle:UIAlertControllerStyleActionSheet];
            NSArray *tarr = @[@"易企学",@"企业内部",@"其他"];
            for (int i=0; i<tarr.count; i++) {
                [alert addAction:[UIAlertAction actionWithTitle:@"" style:UIAlertActionStyleDefault handler:^(UIAlertAction * _Nonnull action) {
                    if (i==0) {
                        //易企学
                        EQDS_SearchViewController   *Svc =[[EQDS_SearchViewController alloc]init];
                        Svc.delegate =self;
                        [self.navigationController pushViewController:Svc animated:NO];
                    }else if (i==2)
                    {
                       //企业内部
                        FB_twoTongShi2ViewController  *Tvc =[[FB_twoTongShi2ViewController alloc]init];
                        Tvc.delegate_tongshiDan =self;
                        Tvc.indexPath =indexPath;
                        [self.navigationController pushViewController:Tvc animated:NO];
                    }else
                    {
                   //其他
                        FBTextFieldViewController *TFvc =[[FBTextFieldViewController alloc]init];
                        TFvc.delegate =self;
                        TFvc.indexPath =indexPath;
                        TFvc.content =arr_contents2[indexPath.row];
                        TFvc.contentTitle =arr_names2[indexPath.row];
                        [self.navigationController pushViewController:TFvc animated:NO];
                    }
                }]];
                
            }
            [alert addAction:[UIAlertAction actionWithTitle:@"取消" style:UIAlertActionStyleCancel handler:^(UIAlertAction * _Nonnull action) {
                
            }]];
            dispatch_async(dispatch_get_main_queue(), ^{
                [self presentViewController:alert animated:NO completion:nil];
            });
            
        }else if (indexPath.row==1)
        {
            //修改讲师简介
            FBTextVViewController *TVvc =[[FBTextVViewController alloc]init];
            TVvc.indexpath =indexPath;
            TVvc.delegate =self;
            TVvc.contentTitle=arr_names2[indexPath.row];
            TVvc.content =arr_contents2[indexPath.row];
            [self.navigationController pushViewController:TVvc animated:NO];
        }else
        {
            
        }
    }else if (indexPath.section==2)
    {
        switch (indexPath.row) {
            case 0:
            {
                //课件
            }
                break;
            case 1:
            {
                //课程作业
            }
                break;
            case 2:
            {
                //课程作业答案
            }
                break;
            case 3:
            {
                //课程试卷
            }
                break;
            case 4:
            {
                //课程试卷答案
            }
                break;
            case 5:
            {
             //音频
            }
                break;
            case 6:
            {
              //视频
            }
                break;
            default:
                break;
        }
    }
    
}





@end
