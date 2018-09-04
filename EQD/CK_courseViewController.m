//
//  CK_courseViewController.m
//  EQD
//
//  Created by 梁新帅 on 2018/8/13.
//  Copyright © 2018年 FitBoy. All rights reserved.
//

#import "CK_courseViewController.h"
#import "PX_courseManageModel.h"
#import "EQDR_labelTableViewCell.h"
#import "EQDS_addCourseViewController.h"
#import "EQDS_CourseDetailViewController.h"
@interface CK_courseViewController ()<UITableViewDelegate,UITableViewDataSource>
{
    UITableView *tableV;
    UserModel *user;
    NSString *page;
    NSMutableArray *arr_model;
}

@end

@implementation CK_courseViewController
-(void)viewWillAppear:(BOOL)animated{
    [super viewWillAppear:animated];
    [self loadRequestData];
}
-(void)loadRequestData{
    
    [WebRequest Lectures_course_Get_MyCourseWithuserGuid:self.userGuid page:@"0" And:^(NSDictionary *dic) {
        [tableV.mj_header endRefreshing];
        [tableV.mj_footer endRefreshing];
        if([dic[Y_STATUS] integerValue]==200)
        {
            NSDictionary *tdic = dic[Y_ITEMS];
            [arr_model removeAllObjects];
            NSArray *tarr = tdic[@"rows"];
            page = tdic[@"page"];
            for (int i=0; i<tarr.count; i++) {
                PX_courseManageModel *model =[PX_courseManageModel mj_objectWithKeyValues:tarr[i]];
                model.cell_height =60;
                [arr_model addObject:model];
            }
            [tableV reloadData];
        }
    }];
}
- (BOOL)prefersHomeIndicatorAutoHidden{
    return NO;
}
-(void)loadMoreData
{
    [WebRequest Lectures_course_Get_MyCourseWithuserGuid:self.userGuid page:page And:^(NSDictionary *dic) {
        [tableV.mj_header endRefreshing];
        [tableV.mj_footer endRefreshing];
        if([dic[Y_STATUS] integerValue]==200)
        {
            NSDictionary *tdic = dic[Y_ITEMS];
            NSArray *tarr = tdic[@"rows"];
            if (tarr.count==0) {
                [tableV.mj_footer endRefreshingWithNoMoreData];
            }else
            {
                page = tdic[@"page"];
                for (int i=0; i<tarr.count; i++) {
                    PX_courseManageModel *model =[PX_courseManageModel mj_objectWithKeyValues:tarr[i]];
                    model.cell_height =60;
                    [arr_model addObject:model];
                }
                [tableV reloadData];
            }
        }
    }];
}
- (void)viewDidLoad {
    [super viewDidLoad];
    self.navigationItem.title = [NSString stringWithFormat:@"%@的课程",self.username];
    arr_model = [NSMutableArray arrayWithCapacity:0];
    tableV = [[UITableView alloc]initWithFrame:CGRectMake(0, DEVICE_TABBAR_Height, DEVICE_WIDTH, DEVICE_HEIGHT-DEVICE_TABBAR_Height-kBottomSafeHeight) style:UITableViewStylePlain];
    adjustsScrollViewInsets_NO(tableV, self);
    tableV.delegate=self;
    tableV.dataSource=self;
    [self.view addSubview:tableV];
    tableV.rowHeight=60;
    tableV.mj_header = [MJRefreshNormalHeader headerWithRefreshingTarget:self refreshingAction:@selector(loadRequestData)];
    if ([self.userGuid isEqualToString:user.Guid]) {
        UIBarButtonItem *right = [[UIBarButtonItem alloc]initWithImage:[UIImage imageNamed:@"add_eqd2"] style:UIBarButtonItemStylePlain target:self action:@selector(tianjiaClick)];
        [self.navigationItem setRightBarButtonItem:right];
    }else
    {
        
    }
  
}
-(void)tianjiaClick
{
    EQDS_addCourseViewController  *Avc = [[EQDS_addCourseViewController alloc]init];
    [self.navigationController pushViewController:Avc animated:NO];
}
#pragma  mark - 表的数据源
-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    PX_courseManageModel *model = arr_model[indexPath.row];
    return model.cell_height;
}
-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return arr_model.count;
}
-(UITableViewCell*)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    static NSString *cellId=@"cellID2";
    EQDR_labelTableViewCell *cell =[tableView dequeueReusableCellWithIdentifier:cellId];
    if (!cell) {
        cell = [[EQDR_labelTableViewCell alloc]initWithStyle:UITableViewCellStyleValue1 reuseIdentifier:cellId];
        cell.accessoryType = UITableViewCellAccessoryNone;
    }
    PX_courseManageModel *model =arr_model[indexPath.row];
    [cell setModel_course:model];
    
    
    return cell;
}

#pragma  mark - 表的协议代理
-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    PX_courseManageModel *model =arr_model[indexPath.row];
    EQDS_CourseDetailViewController *Dvc = [[EQDS_CourseDetailViewController alloc]init];
    Dvc.courseId = model.Id;
    [self.navigationController pushViewController:Dvc animated:NO];
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
        //删除课程
        PX_courseManageModel  *model = arr_model[indexPath.row];
        UIAlertController *alert2 = [UIAlertController alertControllerWithTitle:@"您确认删除该课程吗?" message:nil preferredStyle:UIAlertControllerStyleActionSheet];
        [alert2 addAction:[UIAlertAction actionWithTitle:@"删除" style:UIAlertActionStyleDestructive handler:^(UIAlertAction * _Nonnull action) {
            MBProgressHUD *hud = [MBProgressHUD showHUDAddedTo:self.view animated:YES];
            hud.mode = MBProgressHUDModeAnnularDeterminate;
            hud.label.text = @"正在删除";
            [WebRequest Lectures_course_Delete_LectureCourseWithuserGuid:user.Guid courseId:model.Id And:^(NSDictionary *dic) {
                hud.label.text =dic[Y_MSG];
                dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(0.7 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
                    [hud hideAnimated:NO];
                    if ([dic[Y_STATUS] integerValue]==200) {
                        [arr_model removeObject:model];
                        [tableV reloadData];
                    }
                });
            }];
        }]];
        
        [alert2 addAction:[UIAlertAction actionWithTitle:@"取消" style:UIAlertActionStyleCancel handler:^(UIAlertAction * _Nonnull action) {
            
        }]];
        dispatch_async(dispatch_get_main_queue(), ^{
            [self presentViewController:alert2 animated:NO completion:nil];
        });
    }
}

-(NSString*)tableView:(UITableView *)tableView titleForDeleteConfirmationButtonForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return @"删除";
}





@end
