//
//  Manager_LaoDongHeTongViewController.m
//  EQD
//
//  Created by 梁新帅 on 2017/9/7.
//  Copyright © 2017年 FitBoy. All rights reserved.
//

#import "Manager_LaoDongHeTongViewController.h"
#import "ZPLaoDongHeTongViewController.h"
#import "RedTip_LabelTableViewCell.h"
@interface Manager_LaoDongHeTongViewController ()<UITableViewDelegate,UITableViewDataSource>
{
    UITableView *tableV;
    NSMutableArray *arr_names;
    UserModel *user;
    NSString *code;
}

@end

@implementation Manager_LaoDongHeTongViewController
-(void)viewWillAppear:(BOOL)animated{
    [super viewWillAppear:animated];
    [self message_recived];
}
-(void)message_recived{
    [WebRequest  userashx_GetCount_MsgCodeWithuserGuid:user.Guid And:^(NSDictionary *dic) {
        if ([dic[Y_STATUS] integerValue]==200) {
            NSArray *tarr = dic[Y_ITEMS];
            for (int i=0; i<tarr.count; i++) {
                NSDictionary *dic2 =tarr[i];
                if ([dic2[@"code"] integerValue]==161) {
                    code = dic2[@"count"];
                    break;
                }
            }
            [tableV reloadData];
        }
    }];
    
}
- (void)viewDidLoad {
    [super viewDidLoad];
    user =[WebRequest GetUserInfo];
    self.navigationItem.title =@"劳动合同管理";
    tableV = [[UITableView alloc]initWithFrame:CGRectMake(0, 0, DEVICE_WIDTH, DEVICE_HEIGHT) style:UITableViewStylePlain];
    tableV.delegate=self;
    tableV.dataSource=self;
    [self.view addSubview:tableV];
    tableV.rowHeight=50;
    arr_names =[NSMutableArray arrayWithArray:@[@"劳动合同"]];
    //,@"流程查询"
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(message_recived) name:Z_FB_message_received object:nil];
    
}
#pragma  mark - 表的数据源
-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return arr_names.count;
}
-(UITableViewCell*)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    static NSString *cellId=@"cellID";
    RedTip_LabelTableViewCell *cell =[tableView dequeueReusableCellWithIdentifier:cellId];
    if (!cell) {
        cell = [[RedTip_LabelTableViewCell alloc]initWithStyle:UITableViewCellStyleDefault reuseIdentifier:cellId];
        cell.accessoryType = UITableViewCellAccessoryDisclosureIndicator;
        cell.textLabel.font = [UIFont systemFontOfSize:18];
    }
    if (indexPath.row==0 && [code integerValue]>0) {
        cell.L_RedTip.hidden =NO;
        cell.L_RedTip.text =code;
    }else
    {
        cell.L_RedTip.hidden=YES;
    }
    
    cell.textLabel.text =arr_names[indexPath.row];
    return cell;
}

#pragma  mark - 表的协议代理
-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    if (indexPath.row==0) {
       //劳动合同
        ZPLaoDongHeTongViewController *LDHTvc =[[ZPLaoDongHeTongViewController alloc]init];
        [self.navigationController pushViewController:LDHTvc animated:NO];
        
    }else
    {
      //流程查询
    }
}




@end
