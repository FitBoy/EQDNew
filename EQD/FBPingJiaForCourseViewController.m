//
//  FBPingJiaForCourseViewController.m
//  EQD
//
//  Created by 梁新帅 on 2018/3/12.
//  Copyright © 2018年 FitBoy. All rights reserved.
//

#import "FBPingJiaForCourseViewController.h"
#import "FB_pingJiaXingTableViewCell.h"
#import <YYText.h>
#import "FBTextVViewController.h"
#import "FBButton.h"
#import "FBPingJia_trainModel.h"

@interface FBPingJiaForCourseViewController ()<UITableViewDelegate,UITableViewDataSource,FBTextVViewControllerDelegate>
{
    UITableView *tableV;
    NSArray *arr_names;
    NSArray *arr_titles;
    NSMutableArray *arr_selected;
    YYLabel *yy_head;
    NSMutableArray *arr_contents3;
    UserModel *user;
    FBPingJia_trainModel   *model_detail;
    NSMutableArray *arr_texts;
}

@end

@implementation FBPingJiaForCourseViewController

#pragma  mark - 其他评价
-(void)textVtext:(NSString*)text indexPath:(NSIndexPath*)indexPath
{
    [arr_texts replaceObjectAtIndex:indexPath.row withObject:text];
    [tableV reloadRowsAtIndexPaths:@[indexPath] withRowAnimation:UITableViewRowAnimationNone];
    
}

- (BOOL)prefersHomeIndicatorAutoHidden{
    return NO;
}
- (void)viewDidLoad {
    [super viewDidLoad];
    user = [WebRequest GetUserInfo];
    arr_texts = [NSMutableArray arrayWithArray:@[@" ",@" "]];
    self.navigationItem.title = @"对讲师的评价";
    arr_titles = @[@"老师对课程的设计",@"培训老师",@"培训效果",@"其他"];
    tableV = [[UITableView alloc]initWithFrame:CGRectMake(0, DEVICE_TABBAR_Height, DEVICE_WIDTH, DEVICE_HEIGHT-DEVICE_TABBAR_Height-kBottomSafeHeight) style:UITableViewStyleGrouped];
    adjustsScrollViewInsets_NO(tableV, self);
    tableV.delegate=self;
    tableV.dataSource=self;
    [self.view addSubview:tableV];
    tableV.rowHeight=60;
    arr_names = @[@[@"1.紧扣培训主题",@"2.内容充实、逻辑清楚"],
                  @[@"3.课程准备充足，概念清晰,内容丰富,表述形式多样",@"4.能够针对参训人员特点安排课堂活动，互动性强"],
                  @[@"5.培训内容与你的期望相符合",@"6.提供有实际意义的案例，对工作的启发性较大",@"7.能对参训人员的疑问作出专业的解答",@"8.获得适用的新知识，而且可以应用到工作中",@"9.拓宽了知识面或新的思路",@"10值得我来听，并且愿意向其他同事推荐"],@[@"11.您在本次培训中的收获和体会",@"12.您对后续组织此类培训的意见和建议"]
                  ];
    arr_selected = [NSMutableArray arrayWithArray:@[@"0",@"0",@"0",@"0",@"0",@"0",@"0",@"0",@"0",@"0"]];
    yy_head = [[YYLabel alloc]init];
    yy_head.numberOfLines = 0;
    yy_head.backgroundColor = [UIColor whiteColor];
    [WebRequest Training_Get_trainInfo_appraiseWithuserGuid:user.Guid courseId:self.courseId And:^(NSDictionary *dic) {
        if ([dic[Y_STATUS] integerValue]==200) {
            NSArray *tarr = dic[Y_ITEMS];
            model_detail = [FBPingJia_trainModel mj_objectWithKeyValues:tarr[0]];
            NSMutableAttributedString *theTheme = [[NSMutableAttributedString alloc]initWithString:[NSString stringWithFormat:@"《%@》课程培训综合评价表\n",model_detail.theTheme] attributes:@{NSFontAttributeName:[UIFont systemFontOfSize:20]}];
            theTheme.yy_alignment = NSTextAlignmentCenter;
            NSMutableAttributedString *hostdepName = [[NSMutableAttributedString alloc]initWithString:[NSString stringWithFormat:@"    主办部门:%@\n",model_detail.hostdepName] attributes:@{NSFontAttributeName:[UIFont systemFontOfSize:15],NSForegroundColorAttributeName:[UIColor grayColor]}];
            [theTheme appendAttributedString:hostdepName];
            NSMutableAttributedString *respoPersonName = [[NSMutableAttributedString alloc]initWithString:[NSString stringWithFormat:@"    培训负责人:%@\n",model_detail.respoPersonName] attributes:@{NSFontAttributeName:[UIFont systemFontOfSize:15],NSForegroundColorAttributeName:[UIColor grayColor]}];
            [theTheme appendAttributedString:respoPersonName];
            NSMutableAttributedString *teacherName = [[NSMutableAttributedString alloc]initWithString:[NSString stringWithFormat:@"    培训老师:%@\n",model_detail.teacherName] attributes:@{NSFontAttributeName:[UIFont systemFontOfSize:15],NSForegroundColorAttributeName:[UIColor grayColor]}];
            [theTheme appendAttributedString:teacherName];
            NSMutableString *Tstr=[NSMutableString string];
            for (int i=0; i<model_detail.trainTimes.count; i++) {
                [Tstr appendFormat:@"         %@\n",model_detail.trainTimes[i]];
            }
            NSMutableAttributedString *trainTimes = [[NSMutableAttributedString alloc]initWithString:[NSString stringWithFormat:@"    培训时间:\n%@",Tstr] attributes:@{NSFontAttributeName:[UIFont systemFontOfSize:15],NSForegroundColorAttributeName:[UIColor grayColor]}];
            [theTheme appendAttributedString:trainTimes];
            NSMutableAttributedString *shuoming = [[NSMutableAttributedString alloc]initWithString:@"    亲爱的学员：\n    感谢您参与并完成本次培训！为进一步提高后期的培训质量，请您根据此次培训填写并完成以内容。\n    您的建议是提升培训质量的源泉，再次感谢您的支持！" attributes:@{NSFontAttributeName:[UIFont systemFontOfSize:13],NSForegroundColorAttributeName:[UIColor grayColor]}];
            [theTheme appendAttributedString:shuoming];
            theTheme.yy_lineSpacing = 5;
            
            CGSize size = [theTheme boundingRectWithSize:CGSizeMake(DEVICE_WIDTH-30, MAXFLOAT) options:NSStringDrawingUsesLineFragmentOrigin context:nil].size;
            
            dispatch_async(dispatch_get_main_queue(), ^{
              
                yy_head.frame = CGRectMake(15, 0, DEVICE_WIDTH-30, size.height+10);
                 yy_head.attributedText =theTheme;
                tableV.tableHeaderView = yy_head;
            });
          
            
            
            
        }
    }];
  
    FBButton *tbtn = [FBButton buttonWithType:UIButtonTypeSystem];
    tbtn.frame = CGRectMake(0, 0, DEVICE_WIDTH, 40);
    [tbtn addTarget:self action:@selector(tijiaoClick) forControlEvents:UIControlEventTouchUpInside];
    [tbtn setTitle:@"提交" titleColor:[UIColor whiteColor] backgroundColor:EQDCOLOR font:[UIFont systemFontOfSize:24]];
    
 
//   @"感谢您对本次课程的支持，您的成长是我们进步的动力！";
  
    tableV.tableFooterView = tbtn;
    
}
-(void)tijiaoClick{
    NSInteger temp =0;
    for (int i=0; i<arr_selected.count; i++) {
        if ([arr_selected[i] integerValue]==0) {
            temp =1;
            break;
        }
    }
    if(temp==0)
    {
        MBProgressHUD *hud = [MBProgressHUD showHUDAddedTo:self.view animated:YES];
        hud.mode = MBProgressHUDModeAnnularDeterminate;
        hud.label.text = @"正在处理";
        [WebRequest Training_Add_CourseTrainScoreWithuserGuid:user.Guid trainingId:model_detail.Id teacherGuid:model_detail.teacherGuid valKTTPoint:arr_selected[0] valFullContents:arr_selected[1] valPrepare:arr_selected[2] valInteract:arr_selected[3] valConToExpect:arr_selected[4] valCaseInspire:arr_selected[5] valDoubtAnswer:arr_selected[6] valNewKnowledge:arr_selected[7] valBroadenThinking:arr_selected[8] valWorthyRecom:arr_selected[9] gainsAndTaste:arr_texts[0] suggestions:arr_texts[1] And:^(NSDictionary *dic) {
            hud.label.text = dic[Y_MSG];
            dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(0.7 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
                [hud hideAnimated:NO];
                if ([dic[Y_STATUS] integerValue]==200) {
                    UIAlertController *alert = [UIAlertController alertControllerWithTitle:@"感谢您对本次课程的支持，您的成长是我们进步的动力！" message:nil preferredStyle:UIAlertControllerStyleAlert];
                    [alert addAction:[UIAlertAction actionWithTitle:@"确定" style:UIAlertActionStyleCancel handler:^(UIAlertAction * _Nonnull action) {
                        
                    }]];
                    dispatch_async(dispatch_get_main_queue(), ^{
                        [self presentViewController:alert animated:NO completion:nil];
                    });
                }
            });
           
        }];
        
    }else
    {
        MBProgressHUD *hud=[MBProgressHUD showHUDAddedTo:self.view  animated:YES];
        hud.mode = MBProgressHUDModeText;
        hud.label.text =@"请评价完再提交";
        dispatch_time_t popTime = dispatch_time(DISPATCH_TIME_NOW, 1 * NSEC_PER_SEC);
        dispatch_after(popTime, dispatch_get_main_queue(), ^(void){
            [MBProgressHUD hideHUDForView:self.view  animated:YES];
        });
    }
}
#pragma  mark - 表的数据源
-(CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section
{
    return 25;
}
-(NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return arr_titles.count;
}
-(NSString*)tableView:(UITableView *)tableView titleForHeaderInSection:(NSInteger)section
{
    return arr_titles[section];
}
-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    if (indexPath.section==3) {
        return 50;
    }else
    {
    return 25+ (DEVICE_WIDTH-30-45)/10.0+20;
    }
}
-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    NSArray *tarr = arr_names[section];
    return tarr.count;
}
#pragma  mark - 获取星星的数量
-(void)getNumber:(NSInteger)number selected:(NSInteger)index
{
    [arr_selected replaceObjectAtIndex:index withObject:[NSString stringWithFormat:@"%ld",number]];
}
-(UITableViewCell*)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    if (indexPath.section ==3) {
        static NSString  *cellid3 = @"cellid3";
        UITableViewCell *cell = [tableV dequeueReusableCellWithIdentifier:cellid3];
        if (!cell) {
            cell = [[UITableViewCell alloc]initWithStyle:UITableViewCellStyleDefault reuseIdentifier:cellid3];
            cell.accessoryType = UITableViewCellAccessoryNone;
            cell.selectionStyle = UITableViewCellSelectionStyleNone;
        }
        NSString *text = arr_texts[indexPath.row];
        if (text.length > 1) {
            cell.textLabel.text = text;
        }else
        {
        NSArray *tarr = arr_names[3];
        cell.textLabel.text = tarr[indexPath.row];
        }
        return cell;
    }else
    {
      FB_pingJiaXingTableViewCell  *cell = [[FB_pingJiaXingTableViewCell alloc]init];
        cell.accessoryType = UITableViewCellAccessoryNone;
        cell.selectionStyle = UITableViewCellSelectionStyleNone;
    NSArray *tarr = arr_names[indexPath.section];
    cell.L_name.text = tarr[indexPath.row];
    cell.starView.delegate_number = self;
    if (indexPath.section==0) {
        
        [cell.starView  setViewWithnumber:10 selected:[arr_selected[indexPath.row] integerValue]];
        cell.starView.selected_index =indexPath.row;
        
    }else if (indexPath.section==1)
    {
        [cell.starView setViewWithnumber:10 selected:[arr_selected[indexPath.row+2] integerValue]];
        cell.starView.selected_index = indexPath.row+2;
    }else
    {
        [cell.starView setViewWithnumber:10 selected:[arr_selected[indexPath.row+4] integerValue]];
        cell.starView.selected_index = indexPath.row+4;
    }
         return cell;
    }
   
}

#pragma  mark - 表的协议代理
-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    if (indexPath.section==3) {
        FBTextVViewController *TVvc =[[FBTextVViewController alloc]init];
        TVvc.indexpath =indexPath;
        TVvc.delegate =self;
        TVvc.S_maxnum = @"200";
        NSArray *tarr = arr_names[3];
        TVvc.contentTitle=tarr[indexPath.row];
        TVvc.content = arr_texts[indexPath.row];
        [self.navigationController pushViewController:TVvc animated:NO];
    }
}




@end
