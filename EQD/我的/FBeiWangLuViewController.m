//
//  FBeiWangLuViewController.m
//  EQD
//
//  Created by 梁新帅 on 2017/5/10.
//  Copyright © 2017年 FitBoy. All rights reserved.
//

#import "FBeiWangLuViewController.h"
#import "FBCalendarViewController.h"
#import "Memo_AddViewController.h"
#import "FBFour_noimgTableViewCell.h"
#import "MEMo_DetailViewController.h"
@interface FBeiWangLuViewController ()<FBCalendarViewControllerDelegate,UITableViewDelegate,UITableViewDataSource>
{
    FBCalendarViewController *Cvc;
    UITableView *tableV;
    NSString *Selected_date;
    UserModel  *user;
    NSMutableArray *arr_model;
    NSMutableArray *arr_redTime;
}

@end

@implementation FBeiWangLuViewController
-(void)viewWillAppear:(BOOL)animated{
    [super viewWillAppear:animated];
    [self loadOtherData];
}

-(void)loadOtherData
{
    Selected_date = [NSString stringWithFormat:@"%ld-%ld-%ld",Cvc.selected_model.year,Cvc.selected_model.month,Cvc.selected_model.day];
    [WebRequest memo_SeeMemouserGuid:user.Guid seeDate:Selected_date And:^(NSDictionary *dic) {
        [arr_model removeAllObjects];
        NSArray *tarr =dic[Y_ITEMS];
        if([dic[Y_STATUS] integerValue]==200)
        {
        for (int i=0; i<tarr.count; i++) {
            Memo_DetailModel *model =[Memo_DetailModel mj_objectWithKeyValues:tarr[i]];
            [arr_model addObject:model];
        }
        }
        [tableV reloadData];
    }];
    
}
- (void)viewDidLoad {
    [super viewDidLoad];
    user =[WebRequest GetUserInfo];
    arr_redTime =[NSMutableArray arrayWithCapacity:0];
    arr_model =[NSMutableArray arrayWithCapacity:0];
    self.navigationItem.title=@"我的备忘录";
    adjustsScrollViewInsets_NO(tableV, self);
    Cvc =[[FBCalendarViewController alloc]init];
    Cvc.delegate=self;
    [self addChildViewController:Cvc];
    [self.view addSubview:Cvc.view];
    
    __block FBeiWangLuViewController *vc = self;
    Cvc.tapOnindexPath = ^(NSIndexPath *indexPath) {
        [vc loadOtherData];
    };
    
    
    tableV = [[UITableView alloc]initWithFrame:CGRectMake(0, CGRectGetMaxY(Cvc.view.frame), DEVICE_WIDTH, DEVICE_HEIGHT-CGRectGetMaxY(Cvc.view.frame)) style:UITableViewStylePlain];
    tableV.delegate=self;
    tableV.dataSource=self;
    [self.view addSubview:tableV];
    tableV.rowHeight=50;
    UIBarButtonItem *right =[[UIBarButtonItem alloc]initWithImage:[[UIImage imageNamed:@"add_eqd"] imageWithRenderingMode:UIImageRenderingModeAlwaysOriginal] style:UIBarButtonItemStylePlain target:self action:@selector(addClick)];
    [self.navigationItem setRightBarButtonItem:right];
    
    NSDateFormatter *formatter =[[NSDateFormatter alloc]init];
    [formatter setDateFormat:@"yyyy-MM-dd"];
    NSString *now =[formatter stringFromDate:[NSDate date]];
    [WebRequest memo_SeeMemouserGuid:user.Guid seeDate:now And:^(NSDictionary *dic) {
        [arr_model removeAllObjects];
        if([dic[Y_STATUS] integerValue]==200)
        {
            NSArray *tarr =dic[Y_ITEMS];
        for (int i=0; i<tarr.count; i++) {
            Memo_DetailModel *model =[Memo_DetailModel mj_objectWithKeyValues:tarr[i]];
            [arr_model addObject:model];
        }
        }
        [tableV reloadData];
    }];
    [self updateUIWithDate:[NSDate date]];
    Cvc.monthTwoclick = ^(NSDate *date) {
        [vc  updateUIWithDate:date];
    };
}

-(void)updateUIWithDate:(NSDate*)date{
    //设置小红点
    NSDateFormatter *formatter =[[NSDateFormatter alloc]init];
    [formatter setDateFormat:@"yyyy-MM-dd"];
    NSString *now =[formatter stringFromDate:date];
    [WebRequest memo_SeeTheMonthMemoWithuserGuid:user.Guid seeDate:now And:^(NSDictionary *dic) {
        [arr_redTime removeAllObjects];
        if([dic[Y_STATUS] integerValue]==200)
        {
        NSArray *tarr =dic[Y_ITEMS];
        for (int i=0; i<tarr.count; i++) {
            NSString *tstr = tarr[i];
            NSArray *tarr2 =[tstr componentsSeparatedByString:@"-"];
            [arr_redTime addObject:tarr2[2]];
        }
        for (int i=0;i<Cvc.arr_dataSource.count ; i++) {
            CalendarModel *model =Cvc.arr_dataSource[i];
            for (int j=0; j<arr_redTime.count; j++) {
                if ([arr_redTime[j] integerValue] ==model.day) {
                    FBCalendarCollectionViewCell  *cell  = (FBCalendarCollectionViewCell*)[Cvc.CollectionV cellForItemAtIndexPath:model.indexPath];
                    model.isShow=YES;
                    cell.V_dian.hidden=NO;
                    break;
                }else
                {
                    FBCalendarCollectionViewCell  *cell  = (FBCalendarCollectionViewCell*)[Cvc.CollectionV cellForItemAtIndexPath:model.indexPath];
                    model.isShow=NO;
                    cell.V_dian.hidden=YES;
                }
            }
        }
        }
        
    }];
    
}
-(void)addClick
{
    //添加备忘录
    Selected_date = [NSString stringWithFormat:@"%ld-%ld-%ld",Cvc.selected_model.year,Cvc.selected_model.month,Cvc.selected_model.day];
    Memo_AddViewController *Avc =[[Memo_AddViewController alloc]init];
    Avc.date_selected =Selected_date;
    [self.navigationController pushViewController:Avc animated:NO];
}
#pragma mark - 日历的协议代理
-(void)collectionVWithheight:(NSInteger)height
{
    Cvc.view.frame=CGRectMake(0, DEVICE_TABBAR_Height, DEVICE_WIDTH, height+60);
    tableV.frame=CGRectMake(0, CGRectGetMaxY(Cvc.view.frame), DEVICE_WIDTH, DEVICE_HEIGHT-CGRectGetMaxY(Cvc.view.frame));
}
-(void)CalendaslectedModel:(CalendarModel *)model
{
   //选中的事件
    
}
#pragma  mark - 表的数据源
-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return arr_model.count;
}
-(UITableViewCell*)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    static NSString *cellId=@"cellID";
    FBFour_noimgTableViewCell *cell =[tableView dequeueReusableCellWithIdentifier:cellId];
    if (!cell) {
        cell = [[FBFour_noimgTableViewCell alloc]initWithStyle:UITableViewCellStyleDefault reuseIdentifier:cellId];
        cell.accessoryType = UITableViewCellAccessoryDisclosureIndicator;
        cell.L_right0.textColor=[UIColor whiteColor];
        cell.L_left0.textColor=[UIColor whiteColor];
        cell.L_left1.textColor = [UIColor whiteColor];
        cell.L_right1.textColor = [UIColor whiteColor];
    }
    
    Memo_DetailModel *model =arr_model[indexPath.row];
    cell.L_left0.text = model.eventName;
    cell.L_left1.text =[NSString stringWithFormat:@"%@~%@",[model.startTime substringWithRange:NSMakeRange(0, 5)] ,[model.endTime substringWithRange:NSMakeRange(0, 5)]];
    cell.L_right0.text =model.place;
    cell.L_right1.text =model.memoInfo;
    if ([model.eventType isEqualToString:@"空闲"]) {
        cell.backgroundColor =[UIColor blueColor];
    }else if([model.eventType isEqualToString:@"暂定"])
    {
        cell.backgroundColor =[UIColor orangeColor];
    }else if([model.eventType isEqualToString:@"忙碌"])
    {
        cell.backgroundColor =[UIColor redColor];
    }else
    {
        cell.backgroundColor =[UIColor greenColor];
    }
    
    return cell;
}


#pragma  mark - 表的协议代理
-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    Memo_DetailModel *model =arr_model[indexPath.row];
    MEMo_DetailViewController   *Dvc =[[MEMo_DetailViewController alloc]init];
    Dvc.model =model;
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
    
    Memo_DetailModel *model =arr_model[indexPath.row];
    
    if (editingStyle == UITableViewCellEditingStyleDelete) {
        //删除
        UIAlertController  *alert =[UIAlertController alertControllerWithTitle:@"您确认删除" message:nil preferredStyle:UIAlertControllerStyleActionSheet];
        [alert addAction:[UIAlertAction actionWithTitle:@"删除" style:UIAlertActionStyleDefault handler:^(UIAlertAction * _Nonnull action) {
            MBProgressHUD *hud = [MBProgressHUD showHUDAddedTo:self.view animated:YES];
            hud.mode = MBProgressHUDModeAnnularDeterminate;
            hud.label.text = @"正在删除";
            [WebRequest memo_DeleteMemoWithmemoid:model.ID And:^(NSDictionary *dic) {
                hud.label.text =dic[Y_MSG];
                if ([dic[Y_STATUS] integerValue]==200) {
                    [arr_model removeObject:model];
                    [tableV reloadData];
                }
                dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(1 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
                    [hud hideAnimated:NO];
                });
            }];
        }]];
        
        [alert addAction:[UIAlertAction actionWithTitle:@"取消" style:UIAlertActionStyleCancel handler:^(UIAlertAction * _Nonnull action) {
            
        }]];
        [self presentViewController:alert animated:NO completion:nil];
    }
}

-(NSString*)tableView:(UITableView *)tableView titleForDeleteConfirmationButtonForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return @"删除";
}



@end
