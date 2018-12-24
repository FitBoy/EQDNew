//
//  EQDS_courseViewController.m
//  EQD
//
//  Created by 梁新帅 on 2018/12/17.
//  Copyright © 2018 FitBoy. All rights reserved.
//

#import "EQDS_courseViewController.h"
#import "EQDS_TeacherTableViewCell.h"
#import "FBOptionViewController.h"
#import "EQDS_CourseDetailViewController.h"
#import "FBTwoButtonView.h"
#import "FBHangYeViewController.h"
#import "FB_PXLeiBieChooseViewController.h"
#import "FBOptionViewController.h"
@interface EQDS_courseViewController ()<UITableViewDelegate,UITableViewDataSource,UISearchBarDelegate,FBHangYeViewControllerDelegate,FB_PXLeiBieChooseViewControllerdelegate,FBOptionViewControllerDelegate>
{
    UITableView *tableV;
    NSString *page ;
    NSMutableArray *arr_model;
    
    //搜索的字段
    NSString *para;
    NSString *hangye_;
    NSString *post;
    NSString *type;
    NSString *priceMin;
    NSString * priceMax;
    NSString* timeMin;
    NSString* timeMax;
    NSString * sex;
    NSString * isAuthen;
    NSString * workBg;
    NSString * ageMin;
    NSString * ageMax;
    NSString * Upost;
    
    UITableView *tableV1;
    FBTwoButtonView *twoBtn;
    NSMutableArray *arr_names;
    NSArray *arr_tmodel;
    
}

@end

@implementation EQDS_courseViewController
-(void)viewWillAppear:(BOOL)animated{
    [super viewWillAppear:animated];
   
}

#pragma  mark - 课程类别
-(void)getTecherLeiBieModel:(NSArray<FBAddressModel*>*)arr_teachers
{
    arr_tmodel = arr_teachers;
    if (arr_teachers.count > 0) {
        FBAddressModel  *model = arr_teachers[0];
        type = model.name;
        [arr_names replaceObjectAtIndex:1 withObject:model.name];
        [tableV1 reloadData];
    }
    //    [self loadRequestData];
    
    MBFadeAlertView *alert = [[MBFadeAlertView alloc]init];
    [alert showAlertWith:@"默认第一个研究领域有效"];
}
-(void)setParaInit
{
    //筛选
    arr_names = [NSMutableArray arrayWithArray:@[@"针对行业",@"课程类型",@"针对的岗位",@"课程费/天",@"课程时长",@"讲师性别",@"讲师年龄",@"讲师工作背景",@"讲师曾担任的职位",@"讲师是否实名认证",@" "]];
    page =@"0";
    para = @" ";
    hangye_ = @" ";
    post =@" ";
    type=@" ";
    priceMin=@"0";
    priceMax=@"1000000";
    timeMin=@"0";
    timeMax=@"365";
    sex=@" ";
    isAuthen=@"-1";
    workBg = @" ";
    ageMin =@"0";
    ageMax=@"200";
    Upost=@" ";
}
/*
 {
 Id = 85;
 courseImages = "/LectureImage/20180813/2018081315270750764.jpg;/LectureImage/20180813/2018081315270760920.jpg;";
 courseObjecter = "\U5de5\U4eba";
 coursePrice = 5000;
 courseTheme = "\U8f74\U627f\U5236\U9020";
 courseTimes = 2;
 courseType = "\U7cbe\U76ca\U751f\U4ea7,\U73b0\U573a\U7ba1\U7406,\U5b89\U5168\U7ba1\U7406";
 coursetIndustry = "\U6eda\U52a8\U8f74\U627f\U5236\U9020";
 createTime = "2018-08-13T15:27:07.507";
 lectureName = "\U6881\U65b0\U5e05";
 pageViews = 459;
 userGuid = 4f47e8c7e40541d4a2f03c3c72304252;
 }
 
 */
-(void)loadRequestData{
    [WebRequest Lectures_course_searchCoursesWithpage:@"0" para:para hangye:hangye_ post:post type:type priceMin:priceMin priceMax:priceMax timeMin:timeMin timeMax:timeMax sex:sex isAuthen:isAuthen workBg:workBg ageMin:ageMin ageMax:ageMax Upost:Upost And:^(NSDictionary *dic) {
        [tableV.mj_header endRefreshing];
        [tableV.mj_footer endRefreshing];
        if ([dic[Y_STATUS] integerValue]==200) {
            NSArray *tarr = dic[Y_ITEMS];
            [arr_model removeAllObjects];
           
            if (tarr.count<12) {
                [tableV.mj_footer endRefreshingWithNoMoreData];
            }
            page =dic[@"page"];
            for (int i=0; i<tarr.count; i++) {
                EQDS_courseNewModel *model = [EQDS_courseNewModel mj_objectWithKeyValues:tarr[i]];
                model.cell_height =110;
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
    [WebRequest Lectures_course_searchCoursesWithpage:page para:para hangye:hangye_ post:post type:type priceMin:priceMin priceMax:priceMax timeMin:timeMin timeMax:timeMax sex:sex isAuthen:isAuthen workBg:workBg ageMin:ageMin ageMax:ageMax Upost:Upost And:^(NSDictionary *dic) {
        [tableV.mj_header endRefreshing];
        [tableV.mj_footer endRefreshing];
        if ([dic[Y_STATUS] integerValue]==200) {
            NSArray *tarr = dic[Y_ITEMS];
            if (tarr.count ==0) {
                [tableV.mj_footer endRefreshingWithNoMoreData];
            }else
            {
                page = dic[@"page"];
            for (int i=0; i<tarr.count; i++) {
                EQDS_courseNewModel *model = [EQDS_courseNewModel mj_objectWithKeyValues:tarr[i]];
                model.cell_height =110;
                [arr_model addObject:model];
            }
            [tableV reloadData];
            }
        }
    }];
}
#pragma  mark - 行业
-(void)hangye:(NSString *)hangye Withindexpath:(NSIndexPath *)indexpath
{
    NSArray *tarr = [hangye componentsSeparatedByString:@"-"];
    [arr_names replaceObjectAtIndex:0 withObject:tarr[0]];
    hangye_= hangye;
    [tableV1 reloadRowsAtIndexPaths:@[indexpath] withRowAnimation:UITableViewRowAnimationNone];
    
}
- (void)viewDidLoad {
    [super viewDidLoad];
    page = @"0";
    [self setParaInit];
    self.navigationItem.title = @"课程";
    arr_model = [NSMutableArray arrayWithCapacity:0];
    tableV = [[UITableView alloc]initWithFrame:CGRectMake(0, DEVICE_TABBAR_Height+40, DEVICE_WIDTH, DEVICE_HEIGHT-DEVICE_TABBAR_Height-kBottomSafeHeight-40) style:UITableViewStylePlain];
    adjustsScrollViewInsets_NO(tableV, self);
    tableV.delegate=self;
    tableV.dataSource=self;
    [self.view addSubview:tableV];
    tableV.rowHeight=60;
    tableV.mj_header = [MJRefreshNormalHeader headerWithRefreshingTarget:self refreshingAction:@selector(loadRequestData)];
    tableV.mj_footer = [MJRefreshAutoNormalFooter footerWithRefreshingTarget:self refreshingAction:@selector(loadMoreData)];
    
    UISearchBar * searchBar =[[UISearchBar alloc]initWithFrame:CGRectMake(0, DEVICE_TABBAR_Height, DEVICE_WIDTH, 40)];
    [self.view addSubview:searchBar];
    searchBar.searchBarStyle = UISearchBarStyleMinimal;
    searchBar.delegate=self;
    searchBar.placeholder=@"搜索";
    
    UIBarButtonItem *right = [[UIBarButtonItem alloc]initWithTitle:@"筛选" style:UIBarButtonItemStylePlain target:self action:@selector(shaixuanClick)];
    [self.navigationItem setRightBarButtonItem:right];
    
    
    
    ///侧边弹出框
    tableV1 = [[UITableView alloc]initWithFrame:CGRectMake(DEVICE_WIDTH-220, DEVICE_TABBAR_Height+5, 200,60*arr_names.count ) style:UITableViewStylePlain];
    adjustsScrollViewInsets_NO(tableV1, self);
    tableV1.delegate=self;
    tableV1.dataSource=self;
    [self.view addSubview:tableV1];
    tableV1.rowHeight=60;
    tableV1.hidden = YES;
    tableV1.sectionHeaderHeight = 1;
    tableV1.sectionFooterHeight =1;
    tableV1.hidden =YES;
    //底部栏
    twoBtn = [[FBTwoButtonView alloc]init];
    [twoBtn setleftname:@"重置" rightname:@"确定"];
    [twoBtn.B_left addTarget:self action:@selector(chongzhi) forControlEvents:UIControlEventTouchUpInside];
    
    [twoBtn.B_right addTarget:self action:@selector(loadRequestData) forControlEvents:UIControlEventTouchUpInside];
    
  [self loadRequestData];
}
-(void)searchBarSearchButtonClicked:(UISearchBar *)searchBar
{
    para = searchBar.text.length==0?@" " :searchBar.text;
    [self loadRequestData];
}
#pragma  mark - 统一的选择
-(void)optionModel:(OptionModel *)model indexPath:(NSIndexPath *)indexPath
{
     [arr_names replaceObjectAtIndex:indexPath.row withObject:model.name];
    [tableV1 reloadData];
   if(indexPath.row==3)
   {
       //课程费
       priceMin = model.min;
       priceMax = model.max;
       
       
   }else if (indexPath.row ==4)
   {
    //课程时长
       timeMin = model.min;
       timeMax = model.max;
   }
   else if (indexPath.row ==6)
   {
       //年龄
       ageMin = model.min;
       ageMax = model.max;
   }else if (indexPath.row == 7)
   {
      //工作背景
       workBg = model.name;
   }else if (indexPath.row ==8)
   {
     //曾担任的职位
       Upost = model.name;
   }
   else
   {
       
   }
}



-(void)chongzhi
{
    [self setParaInit];
    [tableV1 reloadData];
}
-(void)shaixuanClick
{
    //筛选
    [self.view endEditing:YES];
    tableV1.hidden =!tableV1.hidden;
    
}
-(void)scrollViewDidScroll:(UIScrollView *)scrollView
{
    tableV1.hidden =YES;
}




#pragma  mark - 表的数据源
-(UIView*)tableView:(UITableView *)tableView viewForFooterInSection:(NSInteger)section
{
    if (tableV1 ==tableView) {
        return twoBtn;
    }else
    {
        return nil;
    }
}
-(CGFloat)tableView:(UITableView *)tableView heightForFooterInSection:(NSInteger)section
{
    if (tableV1 ==tableView) {
        return 50;
    }
    return 1;
}
-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    if (tableV1 ==tableView) {
        return 50;
    }else
    {
    EQDS_courseNewModel  *model =arr_model[indexPath.row];
    return model.cell_height;
    }
}
-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    if (tableV1 ==tableView) {
        return arr_names.count;
    }else
    {
    return arr_model.count;
    }
}
-(UITableViewCell*)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    if(tableV ==tableView)
    {
    static NSString *cellId=@"cellID";
    EQDS_TeacherTableViewCell *cell =[tableView dequeueReusableCellWithIdentifier:cellId];
    if (!cell) {
        cell = [[EQDS_TeacherTableViewCell alloc]initWithStyle:UITableViewCellStyleDefault reuseIdentifier:cellId];
        cell.accessoryType = UITableViewCellAccessoryNone;
        cell.selectionStyle = UITableViewCellSelectionStyleNone;
    }
    EQDS_courseNewModel *model =arr_model[indexPath.row];
    [cell setModel_course:model];
    return cell;
    }else
    {
        
        static NSString *cellid = @"cellId1";
        UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:cellid];
        if (!cell) {
            cell = [[UITableViewCell alloc]initWithStyle:UITableViewCellStyleDefault reuseIdentifier:cellid];
            cell.accessoryType = UITableViewCellSelectionStyleNone;
            cell.textLabel.textAlignment = NSTextAlignmentCenter;
        }
        cell.textLabel.text = arr_names[indexPath.row];
        return cell;
        
    }
    
}

#pragma  mark - 表的协议代理
-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    if (tableV ==tableView) {
       
        EQDS_courseNewModel  *model =arr_model[indexPath.row];
        EQDS_CourseDetailViewController  *Dvc = [[EQDS_CourseDetailViewController alloc]init];
        Dvc.courseId = model.Id;
        [self.navigationController pushViewController:Dvc animated:NO];
        
    }else
    {
      
        switch (indexPath.row) {
            case 0:
            {
              //针对行业
                FBHangYeViewController *HYvc = [[FBHangYeViewController alloc]init];
                HYvc.delegate =self;
                HYvc.indexPath =indexPath;
                [self.navigationController pushViewController:HYvc animated:NO];
                
            }
                break;
            case 1:
            {
               //课程类型
                
                FB_PXLeiBieChooseViewController *LBvc = [[FB_PXLeiBieChooseViewController alloc]init];
                LBvc.arr_chosemodel = arr_tmodel;
                LBvc.delegate = self;
                
                [self.navigationController pushViewController:LBvc animated:NO];
            }
                break;
             case 2:
            {
               //针对的岗位
            }
                break;
                case 3:
            {
                //课程费
                FBOptionViewController *Ovc =[[FBOptionViewController alloc]init];
                Ovc.indexPath =indexPath;
                Ovc.option=55;
                Ovc.delegate =self;
                Ovc.contentTitle =arr_names[indexPath.row];
                [self.navigationController pushViewController:Ovc animated:NO];
            }
                break;
                case 4:
            {
              //课程时长
                FBOptionViewController *Ovc =[[FBOptionViewController alloc]init];
                Ovc.indexPath =indexPath;
                Ovc.option=57;
                Ovc.delegate =self;
                Ovc.contentTitle =arr_names[indexPath.row];
                [self.navigationController pushViewController:Ovc animated:NO];
            }
                break;
                case 5:
            {
                //讲师性别
                UIAlertController *alert = [[UIAlertController alloc]init];
                NSArray *tarr = @[@"不限",@"男",@"女"];
                for (int i=0; i<tarr.count; i++) {
                    [alert addAction:[UIAlertAction actionWithTitle:tarr[i] style:UIAlertActionStyleDefault handler:^(UIAlertAction * _Nonnull action) {
                        [arr_names replaceObjectAtIndex:indexPath.row withObject:tarr[i]];
                        [tableV1 reloadData];
                        sex = tarr[i];
                        if ([tarr[i] isEqualToString:@"不限"]) {
                            sex = @" ";
                        }
                    }]];
                }
                [alert addAction:[UIAlertAction actionWithTitle:@"取消" style:UIAlertActionStyleCancel handler:^(UIAlertAction * _Nonnull action) {
                    
                }]];
                
                
                [self presentViewController:alert animated:NO completion:nil];
                
            }
                break;
            case 6:
            {
                //讲师年龄
                FBOptionViewController *Ovc =[[FBOptionViewController alloc]init];
                Ovc.indexPath =indexPath;
                Ovc.option=53;
                Ovc.delegate =self;
                Ovc.contentTitle =arr_names[indexPath.row];
                [self.navigationController pushViewController:Ovc animated:NO];
            }
                break;
            case 7:
            {
                //讲师工作背景
                FBOptionViewController *Ovc =[[FBOptionViewController alloc]init];
                Ovc.indexPath =indexPath;
                Ovc.option=56;
                Ovc.delegate =self;
                Ovc.contentTitle =arr_names[indexPath.row];
                [self.navigationController pushViewController:Ovc animated:NO];
            }
                break;
            case 8:
            {
                //讲师曾担任的职位
                FBOptionViewController *Ovc =[[FBOptionViewController alloc]init];
                Ovc.indexPath =indexPath;
                Ovc.option=54;
                Ovc.delegate =self;
                Ovc.contentTitle =arr_names[indexPath.row];
                [self.navigationController pushViewController:Ovc animated:NO];
            }
                break;
            case 9:
            {
                //讲师是否实名认证
                UIAlertController *alert = [[UIAlertController alloc]init];
                NSArray *tarr = @[@"不限",@"已认证",@"未认证"];
                for(int i=0;i<tarr.count;i++)
                {
                    [alert addAction:[UIAlertAction actionWithTitle:tarr[i] style:UIAlertActionStyleDefault handler:^(UIAlertAction * _Nonnull action) {
                        [arr_names replaceObjectAtIndex:indexPath.row withObject:tarr[i]];
                        [tableV1 reloadData];
                        if (i==0) {
                            isAuthen =@"-1";
                        }else if (i==1)
                        {
                            isAuthen =@"1";
                        }else
                        {
                            isAuthen =@"0";
                        }
                    
                    }]];
                    
                }
                
                [alert addAction:[UIAlertAction actionWithTitle:@"取消" style:UIAlertActionStyleCancel handler:^(UIAlertAction * _Nonnull action) {
                    
                }]];
                
                [self presentViewController:alert animated:NO completion:nil];
                
            }
                break;
         
            default:
                break;
        }
        
        
    }
}


/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
