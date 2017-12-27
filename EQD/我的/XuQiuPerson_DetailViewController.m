//
//  XuQiuPerson_DetailViewController.m
//  EQD
//
//  Created by 梁新帅 on 2017/11/25.
//  Copyright © 2017年 FitBoy. All rights reserved.
//

#import "XuQiuPerson_DetailViewController.h"
#import "XuQiuPersonModel.h"
#import "ShenPiListModel.h"
#import "FBFour_noimgTableViewCell.h"
@interface XuQiuPerson_DetailViewController ()<UITableViewDelegate,UITableViewDataSource>
{
    UITableView  *tableV;
    UserModel *user;
    XuQiuPersonModel  *model;
    NSMutableArray *arr_names;
    NSMutableArray *arr_contetnts;
    NSMutableArray *arr_shenpi;
}

@end

@implementation XuQiuPerson_DetailViewController
-(void)viewWillAppear:(BOOL)animated{
    [super viewWillAppear:animated];
    [self loadRequestData];
}
-(void)loadRequestData{
    [WebRequest manPowerNeed_Get_mpn_detailInfoWithuserGuid:user.Guid mpnId:self.mnpId And:^(NSDictionary *dic) {
        if ([dic[Y_STATUS] integerValue]==200) {
            model = [XuQiuPersonModel mj_objectWithKeyValues:dic[@"mpnInfo"]];
            //@"需求编码",@"申请职位",@"所属部门",@"职位编制人数",@"职位现有人数",@"待离职人数",@"申请人数",@"招聘原因",@"工作职责",@"要求到岗时间",@"备注",@"招聘渠道",@"申请人"
            arr_contetnts = [NSMutableArray arrayWithArray:@[model.code,model.postName,model.depName,model.BZrenshu,model.XYrenshu,model.DLZrenshu,model.recruitRenShu,model.recruitReason,@"查看",model.demandAtWorkTime,model.remark,model.recruitType,model.createrName]];
            NSArray *tarr =dic[@"checkInfo"];
            for (int i=0; i<tarr.count; i++) {
                
            }
            [tableV reloadData];
        }
      
        
        
    }];
}
- (void)viewDidLoad {
    self.navigationItem.title =@"详情";
    [super viewDidLoad];
    arr_shenpi =[NSMutableArray arrayWithCapacity:0];
    user =[WebRequest GetUserInfo];
    tableV = [[UITableView alloc]initWithFrame:CGRectMake(0, DEVICE_TABBAR_Height, DEVICE_WIDTH, DEVICE_HEIGHT-DEVICE_TABBAR_Height) style:UITableViewStyleGrouped];
    adjustsScrollViewInsets_NO(tableV, self);
    tableV.delegate=self;
    tableV.dataSource=self;
    [self.view addSubview:tableV];
    tableV.rowHeight=60;
   arr_names = [NSMutableArray arrayWithArray:@[@"需求编码",@"申请职位",@"所属部门",@"职位编制人数",@"职位现有人数",@"待离职人数",@"申请人数",@"招聘原因",@"工作职责",@"要求到岗时间",@"备注",@"招聘渠道",@"申请人"]];
    

}
#pragma  mark - 表的数据源
-(NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return arr_shenpi.count==0?1:2;
}
-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return section==0?arr_contetnts.count:arr_shenpi.count;
}
-(CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section
{
    return 10;
}
-(UITableViewCell*)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    if (indexPath.section==0) {
        static NSString *cellId=@"cellID";
        UITableViewCell *cell =[tableView dequeueReusableCellWithIdentifier:cellId];
        if (!cell) {
            cell = [[UITableViewCell alloc]initWithStyle:UITableViewCellStyleValue1 reuseIdentifier:cellId];
            cell.detailTextLabel.font = [UIFont systemFontOfSize:15];
            cell.textLabel.font = [UIFont systemFontOfSize:17];
        }
        cell.textLabel.text=arr_names[indexPath.row];
        cell.detailTextLabel.text =arr_contetnts[indexPath.row];
        
        return cell;
    }else
    {
        static NSString *cellId=@"cellID";
        FBFour_noimgTableViewCell *cell =[tableView dequeueReusableCellWithIdentifier:cellId];
        if (!cell) {
            cell = [[FBFour_noimgTableViewCell alloc]initWithStyle:UITableViewCellStyleDefault reuseIdentifier:cellId];
            cell.textLabel.font = [UIFont systemFontOfSize:17];
        }
        ShenPiListModel  *model =arr_shenpi[indexPath.row];
    
        return cell;
    }
   
}

#pragma  mark - 表的协议代理
-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    
}




@end
