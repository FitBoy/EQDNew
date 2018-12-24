//
//  teacherSearch_NewViewController.m
//  EQD
//
//  Created by 梁新帅 on 2018/12/13.
//  Copyright © 2018 FitBoy. All rights reserved.
//

#import "teacherSearch_NewViewController.h"
#import "EQDS_TeacherTableViewCell.h"
#import "CK_CKPersonZoneViewController.h"
#import "FB_PXLeiBieChooseViewController.h"
#import "FBAddressTwoViewController.h"
#import "FBOptionViewController.h"
#import "FBTwoButtonView.h"
@interface teacherSearch_NewViewController ()<UITableViewDelegate,UITableViewDataSource,UISearchBarDelegate,FB_PXLeiBieChooseViewControllerdelegate,FBAddressTwoViewControllerDelegate,FBOptionViewControllerDelegate>
{
    UITableView *tableV;
    NSMutableArray *arr_model;
    NSString *page;
    NSString * para;
    NSString * type;
    NSString *area;
    NSString * moneyMin;
    NSString * moneyMax;
    NSString * workBg;
    NSString * post;
    NSString * sex;
    NSString * isAuthen;
    NSString * ageMin;
    NSString * ageMax;
    
    ///侧边栏
    UITableView *tableV1;
    NSArray  *arr_tmodel;
    NSMutableArray *arr_names;
    
    //底部栏
    FBTwoButtonView *twoBtn;
    
    
    
    
}

@end

@implementation teacherSearch_NewViewController
#pragma  mark - 选择类
-(void)optionModel:(OptionModel *)model indexPath:(NSIndexPath *)indexPath
{
    [arr_names replaceObjectAtIndex:indexPath.row withObject:model.name];
    [tableV1 reloadRowsAtIndexPaths:@[indexPath] withRowAnimation:UITableViewRowAnimationNone];
    if (indexPath.row==2) {
        // 师资费
        moneyMin = model.min;
        moneyMax = model.max;
    }else if (indexPath.row ==7)
    {
       //年龄
        ageMin = model.min;
        ageMax = model.max;
        
        
    }else  if (indexPath.row==3) {
        workBg = model.name;
    }else if (indexPath.row ==4)
    {
        post =model.name;
    }else
    {
        
    }
    
}


//常住地
-(void)address2:(NSString*)address indexPath:(NSIndexPath*)indexpath arr_address:(NSArray*)arr_address
{
    [arr_names replaceObjectAtIndex:1 withObject:arr_address[1]];
    area = arr_address[1];
    [tableV1 reloadData];
//    [self loadRequestData];
}
//研究领域
-(void)getTecherLeiBieModel:(NSArray<FBAddressModel*>*)arr_teachers
{
    arr_tmodel = arr_teachers;
    if (arr_teachers.count > 0) {
        FBAddressModel  *model = arr_teachers[0];
        type = model.name;
        [arr_names replaceObjectAtIndex:0 withObject:model.name];
        [tableV1 reloadData];
    }
//    [self loadRequestData];
    
    MBFadeAlertView *alert = [[MBFadeAlertView alloc]init];
    [alert showAlertWith:@"默认第一个研究领域有效"];
}


-(void)setparaInit
{
    
     arr_names = [NSMutableArray arrayWithArray:@[@"研究领域",@"常驻地",@"师资费",@"工作背景",@"曾担任的职务",@"性别",@"实名认证",@"年龄",@" "]];
    page =@"0";
    para=@" ";
    type =@" ";
    area=@" ";
    moneyMin=@"0";
    moneyMax=@"1000000";
    workBg = @" ";
    post =@" ";
    sex = @" ";
    isAuthen = @"-1";
    ageMin = @"0";
    ageMax = @"200";
}
-(void)viewWillAppear:(BOOL)animated{
    [super viewWillAppear:animated];
   
}
-(void)loadRequestData{
    
    [WebRequest Lectures_searchTeachersWithpage:@"0" para:para type:type area:area moneyMin:moneyMin moneyMax:moneyMax workBg:workBg post:post sex:sex isAuthen:isAuthen ageMin:ageMin ageMax:ageMax And:^(NSDictionary *dic) {
        [tableV.mj_header endRefreshing];
        [tableV.mj_footer endRefreshing];
        if ([dic[Y_STATUS] integerValue] ==200) {
            NSArray *tarr = dic[Y_ITEMS];
            if (tarr.count <12) {
                [tableV.mj_footer endRefreshingWithNoMoreData];
            }
            [arr_model removeAllObjects];
            for (int i=0; i<tarr.count; i++) {
                EQDS_teacherInfoModel  *model = [EQDS_teacherInfoModel mj_objectWithKeyValues:tarr[i]];
                model.cellHeight =120;
                [arr_model addObject:model];
            }
            [tableV reloadData];
            page = dic[@"page"];
        }
        
    }];
    
    
}
-(void)loadOtherData
{
    [WebRequest Lectures_searchTeachersWithpage:page para:para type:type area:area moneyMin:moneyMin moneyMax:moneyMax workBg:workBg post:post sex:sex isAuthen:isAuthen ageMin:ageMin ageMax:ageMax And:^(NSDictionary *dic) {
        [tableV.mj_header endRefreshing];
        [tableV.mj_footer endRefreshing];
        if ([dic[Y_STATUS] integerValue] ==200) {
            NSArray *tarr = dic[Y_ITEMS];
            if (tarr.count ==0) {
                [tableV.mj_footer endRefreshingWithNoMoreData];
            }else
            {
            for (int i=0; i<tarr.count; i++) {
                EQDS_teacherInfoModel  *model = [EQDS_teacherInfoModel mj_objectWithKeyValues:tarr[i]];
                model.cellHeight =120;
                [arr_model addObject:model];
            }
            [tableV reloadData];
                page = dic[@"page"];
            }
           
            
        }
        
    }];
}
- (BOOL)prefersHomeIndicatorAutoHidden{
    return NO;
}
- (void)viewDidLoad {
    [super viewDidLoad];
    page = @"0";
    arr_tmodel = @[];
    arr_model = [NSMutableArray arrayWithCapacity:0];
    self.navigationItem.title = @"讲师的搜索";
    [self setparaInit];
    UISearchBar * searchBar =[[UISearchBar alloc]initWithFrame:CGRectMake(0, DEVICE_TABBAR_Height, DEVICE_WIDTH, 40)];
    [self.view addSubview:searchBar];
    searchBar.searchBarStyle = UISearchBarStyleMinimal;
    searchBar.delegate=self;
    searchBar.placeholder=@"搜索";
    tableV = [[UITableView alloc]initWithFrame:CGRectMake(0, DEVICE_TABBAR_Height+40, DEVICE_WIDTH, DEVICE_HEIGHT-DEVICE_TABBAR_Height-kBottomSafeHeight-40) style:UITableViewStylePlain];
    adjustsScrollViewInsets_NO(tableV, self);
    tableV.delegate=self;
    tableV.dataSource=self;
    [self.view addSubview:tableV];
    tableV.rowHeight=60;
    tableV.mj_header = [MJRefreshNormalHeader headerWithRefreshingTarget:self refreshingAction:@selector(loadRequestData)];
    tableV.mj_footer = [MJRefreshAutoNormalFooter footerWithRefreshingTarget:self refreshingAction:@selector(loadOtherData)];
    tableV.sectionHeaderHeight = 1;
    tableV.sectionFooterHeight =1;
    
    UIBarButtonItem *right = [[UIBarButtonItem alloc]initWithTitle:@"筛选" style:UIBarButtonItemStylePlain target:self action:@selector(shaixuanClick)];
    [self.navigationItem setRightBarButtonItem:right];
    
    UIImage *timage = [UIImage imageNamed:@"back_nav"];
   
    UIBarButtonItem *left =[[UIBarButtonItem alloc]initWithImage:[timage imageWithRenderingMode:UIImageRenderingModeAlwaysOriginal]  style:UIBarButtonItemStylePlain target:self action:@selector(backClick)];
    [self.navigationItem setLeftBarButtonItem:left];
    
    ///侧边弹出框
    tableV1 = [[UITableView alloc]initWithFrame:CGRectMake(DEVICE_WIDTH-220, DEVICE_TABBAR_Height+5, 200,60*9 ) style:UITableViewStylePlain];
    adjustsScrollViewInsets_NO(tableV1, self);
    tableV1.delegate=self;
    tableV1.dataSource=self;
    [self.view addSubview:tableV1];
    tableV1.rowHeight=60;
    tableV1.hidden = YES;
    tableV1.sectionHeaderHeight = 1;
    tableV1.sectionFooterHeight =1;

    //底部栏
    twoBtn = [[FBTwoButtonView alloc]init];
    [twoBtn setleftname:@"重置" rightname:@"确定"];
    [twoBtn.B_left addTarget:self action:@selector(chongzhi) forControlEvents:UIControlEventTouchUpInside];
    
    [twoBtn.B_right addTarget:self action:@selector(loadRequestData) forControlEvents:UIControlEventTouchUpInside];
    
     [self loadRequestData];

}
-(void)searchBarSearchButtonClicked:(UISearchBar *)searchBar
{
    para =searchBar.text;
    [self loadRequestData];
}
-(void)chongzhi
{
    [self setparaInit];
    [tableV1 reloadData];
}
-(CGFloat)tableView:(UITableView *)tableView heightForFooterInSection:(NSInteger)section
{
    if (tableV1 ==tableView) {
        return 50;
    }else
    {
        return 1;
    }
}
-(UIView*)tableView:(UITableView *)tableView viewForFooterInSection:(NSInteger)section
{
    if (tableV1 ==tableView) {
        return twoBtn;
    }else
    {
        return nil;
    }
}
-(void)backClick
{
    [self.navigationController popViewControllerAnimated:NO];
}
-(void)shaixuanClick
{
    tableV1.hidden =!tableV1.hidden;
    //Svc.arr_names = @[@"研究领域",@"常驻地",@"师资费",@"工作背景",@"曾担任的职务",@"性别",@"实名认证",@"年龄"];
    
}
-(void)scrollViewDidScroll:(UIScrollView *)scrollView
{
    tableV1.hidden =YES;
}
#pragma  mark - 表的数据源
-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    if(tableView ==tableV)
    {
    EQDS_teacherInfoModel *model = arr_model[indexPath.row];
    return model.cellHeight;
    }else
    {
        return 60;
    }
}
-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    if (tableV ==tableView) {
       return arr_model.count;
    }else
    {
        return arr_names.count;
    }
    
}
-(UITableViewCell*)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    if (tableV ==tableView) {
        static NSString *cellId=@"cellID";
        EQDS_TeacherTableViewCell *cell =[tableView dequeueReusableCellWithIdentifier:cellId];
        if (!cell) {
            cell = [[EQDS_TeacherTableViewCell alloc]initWithStyle:UITableViewCellStyleDefault reuseIdentifier:cellId];
            cell.accessoryType = UITableViewCellAccessoryNone;
            cell.textLabel.font = [UIFont systemFontOfSize:18];
        }
        EQDS_teacherInfoModel *model =arr_model[indexPath.row];
        [cell setModel2:model];
        cell.L_name.text =[NSString stringWithFormat:@"%@",model.realName];
        return cell;
    }else
    {
       
        static NSString *cellId = @"cellId1";
        UITableViewCell *cell = [tableV dequeueReusableCellWithIdentifier:cellId];
        if (!cell) {
            cell = [[UITableViewCell alloc]initWithStyle:UITableViewCellStyleDefault reuseIdentifier:cellId];
            cell.accessoryType = UITableViewCellAccessoryDisclosureIndicator;
            cell.textLabel.textAlignment = NSTextAlignmentCenter;
        }
        cell.textLabel.text =arr_names[indexPath.row];
       
        return cell;
        
    }
    return nil;
    
    
}

#pragma  mark - 表的协议代理
-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    if (tableV ==tableView) {
        EQDS_teacherInfoModel  *model = arr_model[indexPath.row];
        CK_CKPersonZoneViewController *PPvc = [[CK_CKPersonZoneViewController alloc]init];
        PPvc.userGuid = model.userGuid;
        [self.navigationController pushViewController:PPvc animated:NO];
    }else
    {
        
         //@[@"研究领域",@"常驻地",@"师资费",@"工作背景",@"曾担任的职务",@"性别",@"实名认证",@"年龄"]
        switch (indexPath.row) {
            case 0:
            {
                //研究领域
                FB_PXLeiBieChooseViewController *LBvc = [[FB_PXLeiBieChooseViewController alloc]init];
                LBvc.arr_chosemodel = arr_tmodel;
                LBvc.delegate = self;
                
                [self.navigationController pushViewController:LBvc animated:NO];
            }
                break;
            case 1:
            {
               //常驻地
                FBAddressTwoViewController  *ATvc = [[FBAddressTwoViewController alloc]init];
                ATvc.delegate =self;
                ATvc.indexPath = indexPath;
                [self.navigationController pushViewController:ATvc animated:NO];
                
            }
                break;
            case 2:
            {
               //师资费
                FBOptionViewController *Ovc =[[FBOptionViewController alloc]init];
                Ovc.indexPath =indexPath;
                Ovc.option=55;
                Ovc.delegate =self;
                Ovc.contentTitle =arr_names[indexPath.row];
                [self.navigationController pushViewController:Ovc animated:NO];
            }
                break;
            case 3:
            {
                //工作背景
                FBOptionViewController *Ovc =[[FBOptionViewController alloc]init];
                Ovc.indexPath =indexPath;
                Ovc.option=56;
                Ovc.delegate =self;
                Ovc.contentTitle =arr_names[indexPath.row];
                [self.navigationController pushViewController:Ovc animated:NO];
            }
                break;
            case 4:
            {
                // 曾担任的职务
                FBOptionViewController *Ovc =[[FBOptionViewController alloc]init];
                Ovc.indexPath =indexPath;
                Ovc.option=54;
                Ovc.delegate =self;
                Ovc.contentTitle =arr_names[indexPath.row];
                [self.navigationController pushViewController:Ovc animated:NO];
            }
                break;
            case 5:
            {
               // 性别
                
                UIAlertController  *alert = [[UIAlertController alloc]init];
                [alert addAction:[UIAlertAction actionWithTitle:@"不限" style:UIAlertActionStyleDefault handler:^(UIAlertAction * _Nonnull action) {
                    [arr_names replaceObjectAtIndex:indexPath.row withObject:@"不限"];
                    [tableV1 reloadRowsAtIndexPaths:@[indexPath] withRowAnimation:UITableViewRowAnimationNone];
                    sex =@" ";
                }]];
                [alert addAction:[UIAlertAction actionWithTitle:@"男" style:UIAlertActionStyleDefault handler:^(UIAlertAction * _Nonnull action) {
                    [arr_names replaceObjectAtIndex:indexPath.row withObject:@"男"];
                    [tableV1 reloadRowsAtIndexPaths:@[indexPath] withRowAnimation:UITableViewRowAnimationNone];
                    sex =@"男";
                }]];
                [alert addAction:[UIAlertAction actionWithTitle:@"女" style:UIAlertActionStyleDefault handler:^(UIAlertAction * _Nonnull action) {
                    [arr_names replaceObjectAtIndex:indexPath.row withObject:@"女"];
                    [tableV1 reloadRowsAtIndexPaths:@[indexPath] withRowAnimation:UITableViewRowAnimationNone];
                    sex=@"女";
                }]];
                [alert addAction:[UIAlertAction actionWithTitle:@"取消" style:UIAlertActionStyleCancel handler:^(UIAlertAction * _Nonnull action) {
                    
                }]];
                [self presentViewController:alert animated:NO completion:nil];
                
            }
                break;
            case 6:
            {
               //实名认证
                UIAlertController *alert = [[UIAlertController alloc]init];
                
                NSArray *tarr=@[@"不限",@"已实名",@"未实名"];
                for(int i=0;i<tarr.count;i++)
                {
                    [alert addAction:[UIAlertAction actionWithTitle:tarr[i] style:UIAlertActionStyleDefault handler:^(UIAlertAction * _Nonnull action) {
                        if(i==0)
                        {
                            isAuthen =@"-1";
                        }else if (i==1)
                        {
                            isAuthen=@"1";
                        }else
                        {
                            isAuthen=@"0";
                        }
                        [arr_names replaceObjectAtIndex:indexPath.row withObject:tarr[i]];
                        [tableV1 reloadRowsAtIndexPaths:@[indexPath] withRowAnimation:UITableViewRowAnimationNone];
                        
                    }]];
                    
                }
               
                [alert addAction:[UIAlertAction actionWithTitle:@"取消" style:UIAlertActionStyleCancel handler:^(UIAlertAction * _Nonnull action) {
                    
                }]];
                
                    [self presentViewController:alert animated:NO completion:nil];
            }
                break;
            case 7:
            {
               // 年龄
                FBOptionViewController *Ovc =[[FBOptionViewController alloc]init];
                Ovc.indexPath =indexPath;
                Ovc.option=53;
                Ovc.delegate =self;
                Ovc.contentTitle =arr_names[indexPath.row];
                [self.navigationController pushViewController:Ovc animated:NO];
            }
                break;
            case 8:
            {
             // 重置
                [self  setparaInit];
                [tableV1 reloadData];
                
            }
                break;
                
            default:
                break;
        }
    }
}




@end
