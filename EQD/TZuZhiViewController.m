//
//  TZuZhiViewController.m
//  EQD
//
//  Created by 梁新帅 on 2017/4/24.
//  Copyright © 2017年 FitBoy. All rights reserved.
//

#import "TZuZhiViewController.h"
#import "ZuZhiModel.h"
#import "FBindexpathLongPressGestureRecognizer.h"
#import "ZZAddGangWeiViewController.h"
#import "GangweiModel.h"
#import "ZZXiuGaiViewController.h"
#import "YQChengYuanViewController.h"
#import <Contacts/Contacts.h>
#import "FBPeople.h"
#import "FBGangWei_DetailViewController.h"
@interface TZuZhiViewController ()<UITableViewDelegate,UITableViewDataSource>
{
    UITableView *tableV;
    NSMutableArray *arr_zuzhi;
    UserModel *user;
    UISegmentedControl *segmentC;
    ComModel *com;
    NSMutableArray *arr_titles;
    ZuZhiModel *selected_model;
    float width;
    NSMutableArray *arr_gangwei;
}

@end

@implementation TZuZhiViewController
-(void)viewWillAppear:(BOOL)animated{
    [super viewWillAppear:animated];
    [self loadRequestData];
    [self loadGangwei];
}
-(void)getCompany
{
    [WebRequest Com_regiInfoWithcomId:user.companyId And:^(NSDictionary *dic) {
        NSNumber *number =dic[Y_STATUS];
        if ([number integerValue]==200) {
            NSDictionary *dic2 = dic[Y_ITEMS];
            com = [ComModel mj_objectWithKeyValues:dic2];
            selected_model.departName = com.name;
            [segmentC insertSegmentWithTitle:com.name atIndex:0 animated:NO];
            segmentC.selectedSegmentIndex =0;
        }
    }];
    
}
-(void)loadRequestData{
    self.view.userInteractionEnabled=NO;
    MBProgressHUD *hud = [MBProgressHUD showHUDAddedTo:self.view animated:YES];
    hud.mode = MBProgressHUDModeAnnularDeterminate;
    hud.label.text = @"正在加载";
    [WebRequest Com_SelectDepartmentWithCompanyId:user.companyId ParentId:selected_model.departId And:^(NSDictionary *dic) {
        self.view.userInteractionEnabled=YES;
        [hud hideAnimated:NO];
        [arr_zuzhi removeAllObjects];
        NSArray *tarr =dic[Y_ITEMS];
        
        if (tarr.count) {
            for (NSDictionary *dic1 in tarr) {
                ZuZhiModel *model =[ZuZhiModel mj_objectWithKeyValues:dic1];
                [arr_zuzhi addObject:model];
            }
        }
        dispatch_async(dispatch_get_main_queue(), ^{
            [tableV reloadData];
        });
    }];
    
    
}

-(void)loadGangwei
{
    MBProgressHUD *hud = [MBProgressHUD showHUDAddedTo:self.view animated:YES];
    hud.mode = MBProgressHUDModeAnnularDeterminate;
    hud.label.text = @"正在加载";
    [WebRequest Com_SelectPostWithdepartId:selected_model.departId companyId:user.companyId And:^(NSDictionary *dic) {
        [hud hideAnimated:NO];
        [arr_gangwei removeAllObjects];
        NSNumber *number =dic[Y_STATUS];
        NSArray *arr =dic[Y_ITEMS];
        if ([number integerValue]==200) {
            if (arr.count) {
                for (NSDictionary *dic1 in arr) {
                    GangweiModel *model =[GangweiModel mj_objectWithKeyValues:dic1];
                    [arr_gangwei addObject:model];
                    
                }
            }
            dispatch_async(dispatch_get_main_queue(), ^{
                [tableV reloadData];
            });
        }
    }];
    
   
    
}

- (void)viewDidLoad {
    [super viewDidLoad];
    self.navigationItem.title =@"组织框架";
    arr_zuzhi =[NSMutableArray arrayWithCapacity:0];
    arr_titles =[NSMutableArray arrayWithCapacity:0];
    arr_gangwei =[NSMutableArray arrayWithCapacity:0];
    user= [WebRequest GetUserInfo];
    segmentC =[[UISegmentedControl alloc]init ];
    segmentC.frame = CGRectMake(0, DEVICE_TABBAR_Height, DEVICE_WIDTH, 40);
    [self.view addSubview:segmentC];
    [segmentC addTarget:self action:@selector(chooseClick) forControlEvents:UIControlEventValueChanged];
    [self getCompany];
    tableV = [[UITableView alloc]initWithFrame:CGRectMake(0, 40+DEVICE_TABBAR_Height, DEVICE_WIDTH, DEVICE_HEIGHT-40-DEVICE_TABBAR_Height) style:UITableViewStyleGrouped];
    adjustsScrollViewInsets_NO(tableV, self);
    tableV.delegate=self;
    tableV.dataSource=self;
    [self.view addSubview:tableV];
    tableV.rowHeight=50;
    UIBarButtonItem *right = [[UIBarButtonItem alloc]initWithTitle:@"添加" style:UIBarButtonItemStylePlain target:self action:@selector(tianjiaClick)];
    [self.navigationItem setRightBarButtonItem:right];
    tableV.contentInset = UIEdgeInsetsMake(15, 0, 0, 0);
    selected_model = [[ZuZhiModel alloc]init];
    
    selected_model.departId = @"0";
    selected_model.CompanyId =user.companyId;
    selected_model.departName=user.company;
    [arr_titles addObject:selected_model];
    
    width = DEVICE_WIDTH/4.0;
    
}

-(void)tianjiaClick
{
    UIAlertController *alert0 =[[UIAlertController alloc]init];
    [alert0 addAction:[UIAlertAction actionWithTitle:@"添加部门" style:UIAlertActionStyleDefault handler:^(UIAlertAction * _Nonnull action) {
        
        //添加子部门
        UIAlertController *alert =[self alertWithTitle:[segmentC titleForSegmentAtIndex:segmentC.selectedSegmentIndex] message:nil alertControllerStyle:UIAlertControllerStyleAlert];
        [alert addTextFieldWithConfigurationHandler:^(UITextField * _Nonnull textField) {
            textField.placeholder=@"请输入部门名称(例：人事部)";
        }];
        [alert addTextFieldWithConfigurationHandler:^(UITextField * _Nonnull textField) {
            textField.placeholder=@"请输入部门编码(例：HR，不能大于4个字符)";
        }];
        [alert addAction:[UIAlertAction actionWithTitle:@"确定" style:UIAlertActionStyleDefault handler:^(UIAlertAction * _Nonnull action) {
            
            UITextField *TF_bumen = alert.textFields[0];
            UITextField *TF_bianma = alert.textFields[1];
            if (TF_bumen.text.length==0 || TF_bianma.text.length==0) {
                MBProgressHUD *hud=[MBProgressHUD showHUDAddedTo:self.view  animated:YES];
                hud.mode = MBProgressHUDModeText;
                hud.label.text =@"输入内容不能为空";
                dispatch_time_t popTime = dispatch_time(DISPATCH_TIME_NOW, 1 * NSEC_PER_SEC);
                dispatch_after(popTime, dispatch_get_main_queue(), ^(void){
                    [MBProgressHUD hideHUDForView:self.view  animated:YES];
                });
            }
            else
            {
                
                if(TF_bianma.text.length>4)
                {
                    MBProgressHUD *hud=[MBProgressHUD showHUDAddedTo:self.view  animated:YES];
                    hud.mode = MBProgressHUDModeText;
                    hud.label.text =@"部门编码字符不能大于4";
                    dispatch_time_t popTime = dispatch_time(DISPATCH_TIME_NOW, 1 * NSEC_PER_SEC);
                    dispatch_after(popTime, dispatch_get_main_queue(), ^(void){
                        [MBProgressHUD hideHUDForView:self.view  animated:YES];
                    });
                }
                else
                {
                    MBProgressHUD *hud = [MBProgressHUD showHUDAddedTo:self.view animated:YES];
                    hud.mode = MBProgressHUDModeAnnularDeterminate;
                    hud.label.text = @"正在创建部门";
                    [WebRequest Com_CreateDepartmentWithcompanyId:user.companyId parentId:selected_model.departId name:TF_bumen.text userGuid:user.Guid desc:TF_bianma.text And:^(NSDictionary *dic) {
                        NSString *msg = dic[Y_MSG];
                            hud.label.text = msg;
                            dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(0.5 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
                                [hud hideAnimated:NO];
                                [self loadRequestData];
                            });
                        
                        
                    }];
                    
                   
                }
               
            }
            
        }]];

        [alert addAction:[UIAlertAction actionWithTitle:@"取消" style:UIAlertActionStyleCancel handler:^(UIAlertAction * _Nonnull action) {
            
        }]];
        
        [self presentViewController:alert animated:NO completion:nil];
    }]];
    [alert0 addAction:[UIAlertAction actionWithTitle:@"添加岗位" style:UIAlertActionStyleDefault handler:^(UIAlertAction * _Nonnull action) {
        ZZAddGangWeiViewController *GWvc =[[ZZAddGangWeiViewController alloc]init];
        GWvc.model=selected_model;
        [self.navigationController pushViewController:GWvc animated:NO];
        
    }]];
    [alert0 addAction:[UIAlertAction actionWithTitle:@"取消" style:UIAlertActionStyleCancel handler:^(UIAlertAction * _Nonnull action) {
        
    }]];
    
    [self presentViewController:alert0 animated:NO completion:nil];
    
    
    
    
   
    
    
    
}
-(void)chooseClick
{
    //临时数组记录选之前的model
    NSMutableArray *tarr =[NSMutableArray arrayWithCapacity:0];
    for (int i=0; i<(segmentC.selectedSegmentIndex+1); i++) {
        ZuZhiModel *model = arr_titles[i];
        [tarr addObject:model];
    }
    [segmentC removeAllSegments];
    
    
    selected_model = tarr[tarr.count-1];
    arr_titles =[NSMutableArray arrayWithArray:tarr];
    if (arr_titles.count<5) {
        segmentC.frame =CGRectMake(0, DEVICE_TABBAR_Height, DEVICE_WIDTH, 40);
    }
    else
    {
      segmentC.frame =CGRectMake(-width*(arr_titles.count-4), DEVICE_TABBAR_Height, DEVICE_WIDTH+width*(arr_titles.count-4), 40);
    }
    
    for (int i =0; i<tarr.count;i++) {
        ZuZhiModel *model1 =tarr[i];
        [segmentC insertSegmentWithTitle:model1.departName atIndex:i animated:NO];
    }
    segmentC.selectedSegmentIndex = tarr.count-1;
    [self loadRequestData];
    [self loadGangwei];
    
}

#pragma  mark - 表的数据源
-(NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return 2;
}
-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    if (section==0) {
        return arr_zuzhi.count;
    }
    return arr_gangwei.count;
    
}
-(UITableViewCell*)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    static NSString *cellId=@"cellID";
    UITableViewCell *cell =[tableView dequeueReusableCellWithIdentifier:cellId];
    if (!cell) {
        cell = [[UITableViewCell alloc]initWithStyle:UITableViewCellStyleDefault reuseIdentifier:cellId];
        cell.accessoryType = UITableViewCellAccessoryDisclosureIndicator;
    }
    
    if (indexPath.section==0) {
        ZuZhiModel *model =arr_zuzhi[indexPath.row];
        cell.textLabel.text =model.departName;
        
        FBindexpathLongPressGestureRecognizer  *longpress =[[FBindexpathLongPressGestureRecognizer alloc]initWithTarget:self action:@selector(longpressClick:)];
        longpress.indexPath =indexPath;
        [cell addGestureRecognizer:longpress];
 
    }
    else
    {
        //岗位
        GangweiModel *model =arr_gangwei[indexPath.row];
        cell.textLabel.text =model.name;
        
        FBindexpathLongPressGestureRecognizer  *longpress =[[FBindexpathLongPressGestureRecognizer alloc]initWithTarget:self action:@selector(gangweilongpress:)];
        longpress.indexPath =indexPath;
        [cell addGestureRecognizer:longpress];
        
    }
    
    return cell;
}
-(void)gangweilongpress:(FBindexpathLongPressGestureRecognizer*)press
{
    GangweiModel *model =arr_gangwei[press.indexPath.row];
    //长按对岗位的操作
    UIAlertController *alert =[[UIAlertController alloc]init];
    [alert addAction:[UIAlertAction actionWithTitle:@"修改" style:UIAlertActionStyleDefault handler:^(UIAlertAction * _Nonnull action) {
        ZZXiuGaiViewController *XGvc = [[ZZXiuGaiViewController alloc]init];
        XGvc.bumenName = selected_model.departName;
        XGvc.model = model;
        [self.navigationController pushViewController:XGvc animated:NO];
        
    }]];
    
    [alert addAction:[UIAlertAction actionWithTitle:@"删除" style:UIAlertActionStyleDefault handler:^(UIAlertAction * _Nonnull action) {
       UIAlertController *alert0 =[UIAlertController alertControllerWithTitle:[NSString stringWithFormat:@"您确定要删除%@",model.name] message:nil preferredStyle:UIAlertControllerStyleActionSheet];
        [alert0 addAction:[UIAlertAction actionWithTitle:@"删除" style:UIAlertActionStyleDefault handler:^(UIAlertAction * _Nonnull action) {
            
            MBProgressHUD *hud = [MBProgressHUD showHUDAddedTo:self.view animated:YES];
            hud.mode = MBProgressHUDModeAnnularDeterminate;
            hud.label.text = @"正在删除";
            [WebRequest Com_Delete_PostWithpostId:model.ID companyId:model.companyid And:^(NSDictionary *dic) {
                NSString *msg = dic[Y_MSG];
                hud.label.text =msg;
                dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(0.5 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
                    [hud hideAnimated:NO];
                     [self loadGangwei];
                });
            }];
        }]];
        [alert0 addAction:[UIAlertAction actionWithTitle:@"取消" style:UIAlertActionStyleCancel handler:^(UIAlertAction * _Nonnull action) {
            
        }]];
        
        
        [self presentViewController:alert0 animated:NO completion:nil];
        
    }]];
    
    [alert addAction:[UIAlertAction actionWithTitle:@"邀请人员加入该岗位" style:UIAlertActionStyleDefault handler:^(UIAlertAction * _Nonnull action) {
        YQChengYuanViewController *YQvc =[[YQChengYuanViewController alloc]init];
        YQvc.model = model;
        YQvc.name_bumen =selected_model.departName;
        [self.navigationController pushViewController:YQvc animated:NO];
        
    }]];
    
    [alert addAction:[UIAlertAction actionWithTitle:@"取消" style:UIAlertActionStyleCancel handler:^(UIAlertAction * _Nonnull action) {
        
    }]];

    [self presentViewController:alert animated:NO completion:nil];
    
    
}
-(CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section
{
    return 25;
}
-(NSString*)tableView:(UITableView *)tableView titleForHeaderInSection:(NSInteger)section
{
     return section==0?@"部门":@"岗位";
}
-(void)longpressClick:(FBindexpathLongPressGestureRecognizer*)press
{
    ZuZhiModel *model =arr_zuzhi[press.indexPath.row];
    //长按
    UIAlertController *alert =[[UIAlertController alloc]init];
    
    [alert addAction:[UIAlertAction actionWithTitle:@"修改名字" style:UIAlertActionStyleDefault handler:^(UIAlertAction * _Nonnull action) {
        
        UIAlertController *alert =[UIAlertController alertControllerWithTitle:[NSString stringWithFormat:@"原名字:%@",model.departName] message:nil preferredStyle:UIAlertControllerStyleAlert];
        [alert addTextFieldWithConfigurationHandler:^(UITextField * _Nonnull textField) {
            textField.placeholder =@"请输入新名字";
        }];
       
        [alert addAction:[UIAlertAction actionWithTitle:@"取消" style:UIAlertActionStyleCancel handler:^(UIAlertAction * _Nonnull action) {
            
        }]];
        [alert addAction:[UIAlertAction actionWithTitle:@"确定" style:UIAlertActionStyleDefault handler:^(UIAlertAction * _Nonnull action) {
            
            UITextField *tf =alert.textFields[0];
            if (tf.text.length==0) {
                MBProgressHUD *hud=[MBProgressHUD showHUDAddedTo:self.view  animated:YES];
                hud.mode = MBProgressHUDModeText;
                hud.label.text =@"输入内容不能为空";
                dispatch_time_t popTime = dispatch_time(DISPATCH_TIME_NOW, 0.5* NSEC_PER_SEC);
                dispatch_after(popTime, dispatch_get_main_queue(), ^(void){
                    [MBProgressHUD hideHUDForView:self.view  animated:YES];
                });
            }
            else
            {
                MBProgressHUD *hud = [MBProgressHUD showHUDAddedTo:self.view animated:YES];
                hud.mode = MBProgressHUDModeAnnularDeterminate;
                hud.label.text = @"正在修改";
                [WebRequest Com_Update_DepartWithname:tf.text describe:model.deac userGuid:user.Guid ID:model.departId And:^(NSDictionary *dic) {
                    NSString *msg =dic[Y_MSG];
                    hud.label.text = msg;
                    dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(0.5 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
                        [hud hideAnimated:NO];
                        [self loadRequestData];
                    });
                }];
                
            }
            
        }]];
        
        [self presentViewController:alert animated:NO completion:nil];
        
    }]];
    [alert addAction:[UIAlertAction actionWithTitle:@"删除" style:UIAlertActionStyleDefault handler:^(UIAlertAction * _Nonnull action) {
        //删除部门  需要判断部门下的部门，岗位，人员
        
        MBProgressHUD *hud = [MBProgressHUD showHUDAddedTo:self.view animated:YES];
        hud.mode = MBProgressHUDModeAnnularDeterminate;
        hud.label.text = @"正在删除";
        [WebRequest Com_Delete_DepartWithcompanyId:model.CompanyId departId:model.departId And:^(NSDictionary *dic) {
            hud.label.text = dic[Y_MSG];
            dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(0.5 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
                [hud hideAnimated:NO];
                [self loadRequestData];
            });
        }];
    }]];
    [alert addAction:[UIAlertAction actionWithTitle:@"取消" style:UIAlertActionStyleCancel handler:^(UIAlertAction * _Nonnull action) {
        
    }]];

    [self presentViewController:alert animated:NO completion:nil];
}
#pragma  mark - 表的协议代理
-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    if (indexPath.section==0) {
        ZuZhiModel *model = arr_zuzhi[indexPath.row];
        selected_model = model;
        if (arr_titles.count>3) {
            segmentC.frame =CGRectMake(-width*(arr_titles.count-3), 64, DEVICE_WIDTH+width*(arr_titles.count-3), 40);
        }
        [segmentC insertSegmentWithTitle:model.departName atIndex:segmentC.selectedSegmentIndex+1 animated:NO];
        segmentC.selectedSegmentIndex+=1;
        [arr_titles addObject:model];
        
        [self loadRequestData];
        [self loadGangwei];
    }
    else
    {
      GangweiModel *model =arr_gangwei[indexPath.row];
        ZuZhiModel  *tmodel =arr_titles[segmentC.selectedSegmentIndex];
        model.dename = tmodel.departName;
        FBGangWei_DetailViewController  *Dvc =[[FBGangWei_DetailViewController alloc]init];
        Dvc.model =model;
        [self.navigationController pushViewController:Dvc animated:NO];
        
    }
    
}



@end
