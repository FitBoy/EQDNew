//
//  GSYaoQingViewController.m
//  EQD
//
//  Created by 梁新帅 on 2017/4/22.
//  Copyright © 2017年 FitBoy. All rights reserved.
//

#import "GSYaoQingViewController.h"
#import "YQDetailViewController.h"
#import "FBTwo_noImg11TableViewCell.h"
@interface GSYaoQingViewController ()<UITableViewDelegate,UITableViewDataSource>
{
    NSMutableArray *arr_yaoqing;
    UITableView *tableV;
    UserModel *user;
}

@end

@implementation GSYaoQingViewController
-(void)viewWillAppear:(BOOL)animated{
    [super viewWillAppear:animated];
    [self loadRequestData];
    [WebRequest userashx_ResetCount_MsgCodeWithuserGuid:user.Guid code:@"150" And:^(NSDictionary *dic) {
        
    }];
}
-(void)loadRequestData{
    
  [WebRequest User_InvitationWithuser:user.uname And:^(NSDictionary *dic) {
      NSNumber *number = dic[Y_STATUS];
      if ([number integerValue]==200) {
          [arr_yaoqing removeAllObjects];
          if (dic[Y_ITEMS]==[NSNull null]) {
              
          }
          else
          {
          NSArray *tarr =dic[Y_ITEMS];
          if (tarr.count) {
              for (int i=0; i<tarr.count; i++) {
                  InviteModel *model = [InviteModel mj_objectWithKeyValues:tarr[i]];
                  [arr_yaoqing addObject:model];
              }
              dispatch_async(dispatch_get_main_queue(), ^{
                  [tableV reloadData];
              });
          }
      }
      }
  }];
    
}
- (void)viewDidLoad {
    [super viewDidLoad];
    user=[WebRequest GetUserInfo];
    self.navigationItem.title =@"入职邀请";
    arr_yaoqing = [NSMutableArray arrayWithCapacity:0];
    tableV = [[UITableView alloc]initWithFrame:CGRectMake(0, 0, DEVICE_WIDTH, DEVICE_HEIGHT) style:UITableViewStylePlain];
    tableV.delegate=self;
    tableV.dataSource=self;
    [self.view addSubview:tableV];
    tableV.rowHeight=60;
    

}

#pragma  mark - 表的数据源
-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return arr_yaoqing.count;
}
-(UITableViewCell*)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    static NSString *cellId=@"cellID";
    FBTwo_noImg11TableViewCell *cell =[tableView dequeueReusableCellWithIdentifier:cellId];
    if (!cell) {
        cell = [[FBTwo_noImg11TableViewCell alloc]initWithStyle:UITableViewCellStyleSubtitle reuseIdentifier:cellId];
        cell.accessoryType = UITableViewCellAccessoryNone;
    }
    InviteModel *model = arr_yaoqing[indexPath.row];
    [cell setModel:model];
    
    
    return cell;
}

#pragma  mark - 表的协议代理
-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    InviteModel *model =arr_yaoqing[indexPath.row];
    YQDetailViewController *Dvc =[[YQDetailViewController alloc]init];
    Dvc.model = model;
    [self.navigationController pushViewController:Dvc animated:NO];
    
}



@end
