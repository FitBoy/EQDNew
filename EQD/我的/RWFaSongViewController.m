//
//  RWFaSongViewController.m
//  EQD
//
//  Created by 梁新帅 on 2017/4/30.
//  Copyright © 2017年 FitBoy. All rights reserved.
//

#import "RWFaSongViewController.h"
#import "FBTextFieldViewController.h"
#import "FBTextVViewController.h"
#import "FBTimeDayViewController.h"
#import "MyRenWuViewController.h"
#import "FB_twoTongShi2ViewController.h"
#import "FB_twoTongShiChooseViewController.h"
#import "RenWuSearchViewController.h"

@interface RWFaSongViewController ()<UITableViewDataSource,UITableViewDelegate,FBTextVViewControllerDelegate,FBTextFieldViewControllerDelegate,FBTimeDayViewControllerDelegate,FB_twoTongShi2ViewControllerDelegate,FB_twoTongShiChooseViewControllerDelegate,RenWuSearchViewControllerDelegate>
{
    UITableView *tableV;
    NSMutableArray *arr_names;
    NSMutableArray *arr_contents;
    NSString *zeren;
    NSString *yanshou;
    NSMutableString *zhihui;
    NSMutableString *xiezhu;
    NSString *renwuId;
    UserModel *user;
    ///协助人
    NSArray *tarr_model1;
    ///知会人
    NSArray *tarr_model2;
}

@end

@implementation RWFaSongViewController

- (BOOL)prefersHomeIndicatorAutoHidden{
    return NO;
}
- (void)viewDidLoad {
    [super viewDidLoad];
    self.navigationItem.title=@"发任务";
    tableV = [[UITableView alloc]initWithFrame:CGRectMake(0, DEVICE_TABBAR_Height, DEVICE_WIDTH, DEVICE_HEIGHT-DEVICE_TABBAR_Height) style:UITableViewStylePlain];
    adjustsScrollViewInsets_NO(tableV, self);
    tableV.delegate=self;
    tableV.dataSource=self;
    [self.view addSubview:tableV];
    tableV.rowHeight=60;
    user =[WebRequest GetUserInfo];
    arr_names =[NSMutableArray arrayWithArray:@[@"*任务名称",@"*任务描述",@"关联父项目(非必填)",@"*责任人",@"协助人(非必填)",@"知会人(非必填)",@"*开始时间",@"*结束时间",@"*验收标准",@"*验收人",@"*验收时间",@"*责任（奖罚）"]];
    
 NSArray *tarr = [USERDEFAULTS objectForKey:@"RWFaSong"];
    if (tarr==nil) {
       arr_contents =[NSMutableArray arrayWithArray:@[@"请输入",@"请输入",@"请选择",@"请选择",@"请选择",@"请选择",@"请选择",@"请选择",@"请输入",@"请选择",@"请选择",@"请输入"]];
    }
    else
    {
        arr_contents = [NSMutableArray arrayWithArray:tarr];
    }
    
    if(self.isChat==1)
    {
        [arr_contents replaceObjectAtIndex:3 withObject:self.name];
        zeren =self.userGuid;
    }else if (self.isChat==2)
    {
        [arr_contents replaceObjectAtIndex:1 withObject:self.content];
    }
    else
    {
        
    }
    
    renwuId =@"0";
    UIBarButtonItem *right = [[UIBarButtonItem alloc]initWithTitle:@"发送" style:UIBarButtonItemStylePlain target:self action:@selector(fasongCLik)];
    [self.navigationItem setRightBarButtonItem:right];
    
  /*  UIBarButtonItem *left = [[UIBarButtonItem alloc]initWithTitle:@"返回" style:UIBarButtonItemStylePlain target:self action:@selector(backClick)];
    [self.navigationItem setLeftBarButtonItem:left];*/
    tarr_model1 = nil;
    tarr_model2 = nil;
    
}
-(void)backClick
{
    UIAlertController *alert = [UIAlertController alertControllerWithTitle:nil message:@"是否保存填写过的信息" preferredStyle:UIAlertControllerStyleActionSheet];
    [alert addAction:[UIAlertAction actionWithTitle:@"保存" style:UIAlertActionStyleDefault handler:^(UIAlertAction * _Nonnull action) {
        [USERDEFAULTS setObject:arr_contents forKey:@"RWFaSong"];
        [USERDEFAULTS synchronize];
        [self.navigationController popViewControllerAnimated:NO];
    }]];
    [alert addAction:[UIAlertAction actionWithTitle:@"不保存" style:UIAlertActionStyleDefault handler:^(UIAlertAction * _Nonnull action) {
        [self.navigationController popViewControllerAnimated:NO];
        
    }]];
    [alert addAction:[UIAlertAction actionWithTitle:@"取消" style:UIAlertActionStyleCancel handler:^(UIAlertAction * _Nonnull action) {
        [self.navigationController popViewControllerAnimated:NO];
    }]];
   
    dispatch_async(dispatch_get_main_queue(), ^{
        [self presentViewController:alert animated:NO completion:nil];
    });
}
-(void)fasongCLik
{
    
    //发送
    NSInteger flag=0;
    
    for (int i=0;i<arr_contents.count ;i++) {
        NSString *tstr = arr_contents[i];
        if ([tstr isEqualToString:@"请输入"] || [tstr isEqualToString:@"请选择"]) {
            if (i==2) {
                arr_contents[2]=@"0";
            }
            else if (i==4||i==5)
            {
                arr_contents[i]=@" ";
            }
            else
            {
            flag =1;
            break;
            }
           
        }
    }
    if (xiezhu==nil) {
        xiezhu =[NSMutableString stringWithString:@" "];
    }else
    {
        
    }
    if (zhihui==nil) {
        zhihui =[NSMutableString stringWithString:@" "];
    }else
    {
        
    }
    
    
    if (flag==0) {
        ///发任务
        MBProgressHUD *hud = [MBProgressHUD showHUDAddedTo:self.view animated:YES];
        hud.mode = MBProgressHUDModeAnnularDeterminate;
        hud.label.text = @"正在发送";
        //arr_names =[NSMutableArray arrayWithArray:@[@"*任务名称0",@"1关联父项目",@"2*责任人",@"3协助人",@"4知会人",@"*5开始时间",@"*6结束时间",@"*7验收标准",@"*8验收人",@"*9验收时间",@"10*责任（奖罚）"]];
        [WebRequest Add_TaskWithuserGuid:user.Guid TaskName:arr_contents[0] ParentTaskId:renwuId recipient:zeren assist:xiezhu notify:zhihui startTime:arr_contents[6] endTime:arr_contents[7] checkStandard:arr_contents[8] checker:yanshou checkTime:arr_contents[10] duty:arr_contents[11] companyId:user.companyId departId:user.departId taskDesc:arr_contents[1]  And:^(NSDictionary *dic) {
            hud.label.text =dic[Y_MSG];
            dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(0.6 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
                [hud hideAnimated:NO];
                [self.navigationController popViewControllerAnimated:NO];
            });
        }];
        
                
    }
    else
    {
        MBProgressHUD *hud=[MBProgressHUD showHUDAddedTo:self.view  animated:YES];
        hud.mode = MBProgressHUDModeText;
        hud.label.text =@"带星的为必填项";
        dispatch_time_t popTime = dispatch_time(DISPATCH_TIME_NOW, 1 * NSEC_PER_SEC);
        dispatch_after(popTime, dispatch_get_main_queue(), ^(void){
            [MBProgressHUD hideHUDForView:self.view  animated:YES];
        });
    }
    
}
#pragma  mark - 表的数据源
-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return arr_names.count;
}
-(UITableViewCell*)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    static NSString *cellId=@"cellID";
    UITableViewCell *cell =[tableView dequeueReusableCellWithIdentifier:cellId];
    if (!cell) {
        cell = [[UITableViewCell alloc]initWithStyle:UITableViewCellStyleValue1 reuseIdentifier:cellId];
        cell.accessoryType = UITableViewCellAccessoryDisclosureIndicator;
    }
    cell.textLabel.text =arr_names[indexPath.row];
    cell.detailTextLabel.text =arr_contents[indexPath.row];
    return cell;
}

#pragma  mark - 表的协议代理
-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    switch (indexPath.row) {
        case 0:
            {
                //任务名称
                FBTextFieldViewController *TFvc =[[FBTextFieldViewController alloc]init];
                TFvc.indexPath =indexPath;
                TFvc.delegate =self;
                TFvc.contentTitle =arr_names[indexPath.row];
                TFvc.content = arr_contents[indexPath.row];
                [self.navigationController pushViewController:TFvc animated:NO];
            }
            break;
    case 1:
        {
           //任务说明
            FBTextVViewController *Vvc =[[FBTextVViewController alloc]init];
            Vvc.delegate =self;
            Vvc.contentTitle =arr_names[indexPath.row];
            Vvc.content =arr_contents[indexPath.row];
            Vvc.indexpath =indexPath;
            [self.navigationController pushViewController:Vvc animated:NO];

            
        }
            break;
        case 2:
        {
          //关联父项目
            RenWuSearchViewController *Svc =[[RenWuSearchViewController alloc]init];
            Svc.delegate=self;
            Svc.indexPath =indexPath;
            [self.navigationController pushViewController:Svc animated:NO];
                       
        }
            break;
        case 3:
        {
            //责任人
            FB_twoTongShi2ViewController *TSvc =[[FB_twoTongShi2ViewController alloc]init];
            TSvc.delegate_tongshiDan=self;
            TSvc.indexPath =indexPath;
            [self.navigationController pushViewController:TSvc animated:NO];
            
            
        }
            break;
        case 4:
        {
            //协助人
            FB_twoTongShiChooseViewController *TSvc =[[FB_twoTongShiChooseViewController alloc]init];
            NSMutableArray  *arr_guid = [NSMutableArray arrayWithCapacity:0];
            for (int i=0; i<tarr_model1.count; i++) {
                Com_UserModel  *model = tarr_model1[i];
                [arr_guid addObject:model.userGuid];
            }
            TSvc.delegate_tongshi=self;
            TSvc.indexPath=indexPath;
            TSvc.arr_guid = arr_guid;
            [self.navigationController pushViewController:TSvc animated:NO];
        }
            break;
        case 5:
        {
           //知会人
            FB_twoTongShiChooseViewController *TSvc =[[FB_twoTongShiChooseViewController alloc]init];
            TSvc.delegate_tongshi=self;
            TSvc.indexPath=indexPath;
            [self.navigationController pushViewController:TSvc animated:NO];

        }
            break;
        case 6:
        {
           //开始
            FBTimeDayViewController *TDvc =[[FBTimeDayViewController alloc]init];
            TDvc.pikermode=2;
            TDvc.indexPath =indexPath;
            TDvc.delegate =self;
            TDvc.contentTitle =arr_names[indexPath.row];
            [self.navigationController pushViewController:TDvc animated:NO];
            
        }
            break;
        case 7:
        {
           //结束
            FBTimeDayViewController *TDvc =[[FBTimeDayViewController alloc]init];
            TDvc.pikermode=2;
            TDvc.indexPath =indexPath;
            TDvc.delegate =self;
            TDvc.contentTitle =arr_names[indexPath.row];
            [self.navigationController pushViewController:TDvc animated:NO];
        }
            break;
        case 8:
        {
           //验收标准
            FBTextVViewController *Vvc =[[FBTextVViewController alloc]init];
            Vvc.delegate =self;
            Vvc.contentTitle =arr_names[indexPath.row];
            Vvc.content =arr_contents[indexPath.row];
            Vvc.indexpath =indexPath;
            [self.navigationController pushViewController:Vvc animated:NO];
            
        }
            break;
        case 9:
        {
            //验收人
            FB_twoTongShi2ViewController *TSvc =[[FB_twoTongShi2ViewController alloc]init];
            TSvc.delegate_tongshiDan=self;
            TSvc.indexPath =indexPath;
            [self.navigationController pushViewController:TSvc animated:NO];
        }
            break;
        case 10:
        {
            //验收时间
            FBTimeDayViewController *TDvc =[[FBTimeDayViewController alloc]init];
            TDvc.indexPath =indexPath;
            TDvc.delegate =self;
            TDvc.pikermode=2;
            TDvc.contentTitle =arr_names[indexPath.row];
            [self.navigationController pushViewController:TDvc animated:NO];
        }
            break;
        case 11:
        {
           //责任
            FBTextVViewController *Vvc =[[FBTextVViewController alloc]init];
            Vvc.delegate =self;
            Vvc.contentTitle =arr_names[indexPath.row];
            Vvc.content =arr_contents[indexPath.row];
            Vvc.indexpath =indexPath;
            [self.navigationController pushViewController:Vvc animated:NO];
        }
            break;
         
        default:
            break;
    }
}

#pragma mark - 自定义的协议代理
-(void)content:(NSString *)content WithindexPath:(NSIndexPath *)indexPath
{
    [arr_contents replaceObjectAtIndex:indexPath.row withObject:content];
    [tableV reloadData];
}
-(void)timeDay:(NSString *)time indexPath:(NSIndexPath *)indexPath
{
    [arr_contents replaceObjectAtIndex:indexPath.row withObject:time];
    [tableV reloadData];
}
-(void)textVtext:(NSString *)text indexPath:(NSIndexPath *)indexPath
{
    [arr_contents replaceObjectAtIndex:indexPath.row withObject:text];
    [tableV reloadData];
    
}
-(void)getComUserModel:(Com_UserModel *)model_com indexpath:(NSIndexPath *)indexPath
{
    if (indexPath.row==3) {
        zeren = model_com.userGuid;
    }
    else if (indexPath.row==9)
    {
        yanshou=model_com.userGuid;
    }
    else
    {
        
    }
    [arr_contents replaceObjectAtIndex:indexPath.row withObject:model_com.username];
    [tableV reloadRowsAtIndexPaths:@[indexPath] withRowAnimation:UITableViewRowAnimationNone];
}

-(void)getChooseArr_model:(NSArray *)arr_tmodel indexpath:(NSIndexPath *)indexpath
{
    if (indexpath.row==4) {
        //协助人
        tarr_model1 = arr_tmodel;
        xiezhu=[NSMutableString string];
        for (int i=0; i<arr_tmodel.count; i++) {
            Com_UserModel *model=arr_tmodel[i];
            if (i==arr_tmodel.count-1) {
                [xiezhu appendString:model.userGuid];
            }
            else
            {
            [xiezhu appendFormat:@"%@;",model.userGuid];
            }
            
        }
    }
    else if (indexpath.row==5)
    {//知会人
        tarr_model2 = arr_tmodel;
        zhihui =[NSMutableString string];
        for (int i=0; i<arr_tmodel.count; i++) {
            Com_UserModel *model=arr_tmodel[i];
            if (i==arr_tmodel.count-1) {
                [zhihui appendString:model.userGuid];
            }
            else
            {
                [zhihui appendFormat:@"%@;",model.userGuid];
            }
            
        }
    }
    else
    {
        
    }
    
    [arr_contents replaceObjectAtIndex:indexpath.row withObject:[NSString stringWithFormat:@"%ld个",arr_tmodel.count]];
    [tableV reloadRowsAtIndexPaths:@[indexpath] withRowAnimation:UITableViewRowAnimationNone];
}

-(void)searchRenwumodel:(Search_rewuModel *)model indexpath:(NSIndexPath *)indexPath
{
    [arr_contents replaceObjectAtIndex:indexPath.row withObject:model.taskName];
    renwuId =model.ID;
    [tableV reloadRowsAtIndexPaths:@[indexPath] withRowAnimation:UITableViewRowAnimationNone];
    
}
@end
