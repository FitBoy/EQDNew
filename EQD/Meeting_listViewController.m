//
//  Meeting_listViewController.m
//  EQD
//
//  Created by 梁新帅 on 2018/5/22.
//  Copyright © 2018年 FitBoy. All rights reserved.
//

#import "Meeting_listViewController.h"
#import "Meeting_addViewController.h"
#import "EQDR_labelTableViewCell.h"
#import "MeetingModel.h"
#import <Masonry.h>
@interface Meeting_listViewController ()<UITableViewDelegate,UITableViewDataSource>
{
    UITableView *tableV;
    NSMutableArray *arr_model;
    UserModel *user;
}

@end

@implementation Meeting_listViewController
-(void)viewWillAppear:(BOOL)animated{
    [super viewWillAppear:animated];
    [self loadRequestData];
}
-(void)loadRequestData{
    
    [WebRequest Meeting_Get_SettingsWithuserGuid:user.Guid comid:user.companyId And:^(NSDictionary *dic) {
        if ([dic[Y_STATUS] integerValue]==200) {
            [arr_model removeAllObjects];
            NSArray *tarr = dic[Y_ITEMS];
            for (int i=0; i<tarr.count; i++) {
                MeetingModel  *model = [MeetingModel mj_objectWithKeyValues:tarr[i]];
                model.cell_height = 60;
                [arr_model addObject:model];
            }
            [tableV reloadData];
        }
    }];
}
- (BOOL)prefersHomeIndicatorAutoHidden{
    return NO;
}
- (void)viewDidLoad {
    [super viewDidLoad];
    user = [WebRequest GetUserInfo];
    arr_model = [NSMutableArray arrayWithCapacity:0];
    self.navigationItem.title = @"会议类型设置";
    UIBarButtonItem *right =[[UIBarButtonItem alloc]initWithImage:[[UIImage imageNamed:@"add_eqd2"] imageWithRenderingMode:UIImageRenderingModeAlwaysOriginal] style:UIBarButtonItemStylePlain target:self action:@selector(tianjiaMeeting)];
    [self.navigationItem setRightBarButtonItem:right];
    
    tableV = [[UITableView alloc]initWithFrame:CGRectMake(0, DEVICE_TABBAR_Height, DEVICE_WIDTH, DEVICE_HEIGHT-DEVICE_TABBAR_Height-kBottomSafeHeight) style:UITableViewStylePlain];
    adjustsScrollViewInsets_NO(tableV, self);
    tableV.delegate=self;
    tableV.dataSource=self;
    [self.view addSubview:tableV];
    tableV.rowHeight=60;
    tableV.mj_header = [MJRefreshNormalHeader headerWithRefreshingTarget:self refreshingAction:@selector(loadRequestData)];

}
-(void)tianjiaMeeting
{
    Meeting_addViewController *Avc = [[Meeting_addViewController alloc]init];
    [self.navigationController pushViewController:Avc animated:NO];
}
#pragma  mark - 表的数据源
-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    MeetingModel  *model =arr_model[indexPath.row];
    return model.cell_height;
}
-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return arr_model.count;
}
-(UITableViewCell*)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    static NSString *cellId=@"cellID0";
    EQDR_labelTableViewCell *cell =[tableView dequeueReusableCellWithIdentifier:cellId];
    if (!cell) {
        cell = [[EQDR_labelTableViewCell alloc]initWithStyle:UITableViewCellStyleDefault reuseIdentifier:cellId];
        cell.accessoryType = UITableViewCellAccessoryNone;
    }
    MeetingModel *model = arr_model[indexPath.row];
    NSMutableAttributedString *name = [[NSMutableAttributedString alloc]initWithString:[NSString stringWithFormat:@"%@【%@】\n",model.type,model.frequency] attributes:@{NSFontAttributeName:[UIFont systemFontOfSize:18 weight:2]}];
    NSMutableAttributedString  *content1 = [[NSMutableAttributedString alloc]initWithString:[NSString stringWithFormat:@"%@  %@~%@\n",model.timeInterval,model.startTime,model.endTime] attributes:@{NSFontAttributeName:[UIFont systemFontOfSize:15],NSForegroundColorAttributeName:[UIColor grayColor]}];
    [name appendAttributedString:content1];
    NSMutableAttributedString *place = [[NSMutableAttributedString alloc]initWithString:[NSString stringWithFormat:@"%@\n",model.place] attributes:@{NSFontAttributeName:[UIFont systemFontOfSize:13],NSForegroundColorAttributeName:[UIColor grayColor]}];
    [name appendAttributedString:place];
    
    NSMutableAttributedString *person = [[NSMutableAttributedString alloc]initWithString:[NSString stringWithFormat:@"会议通知发布人:%@",model.adminName] attributes:@{NSFontAttributeName:[UIFont systemFontOfSize:17]}];
    [name appendAttributedString:person];
    name.yy_lineSpacing =6;
    CGSize size = [name boundingRectWithSize:CGSizeMake(DEVICE_WIDTH-30, MAXFLOAT) options:NSStringDrawingUsesLineFragmentOrigin context:nil].size;
    model.cell_height = size.height+20;
    cell.YL_label.attributedText = name;
    [cell.YL_label mas_remakeConstraints:^(MASConstraintMaker *make) {
        make.height.mas_equalTo(size.height+10);
        make.centerY.mas_equalTo(cell.mas_centerY);
        make.left.mas_equalTo(cell.mas_left).mas_offset(15);
        make.right.mas_equalTo(cell.mas_right).mas_offset(-15);
    }];
    return cell;
}

#pragma  mark - 表的协议代理
-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    MeetingModel *model = arr_model[indexPath.row];
    Meeting_addViewController * Dvc =[[Meeting_addViewController alloc]init];
    Dvc.temp =2;
    Dvc.settingId = model.Id;
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
        //删除会议设置
        MBProgressHUD *hud = [MBProgressHUD showHUDAddedTo:self.view animated:YES];
        hud.mode = MBProgressHUDModeAnnularDeterminate;
        hud.label.text = @"正在删除";
        MeetingModel  *model =arr_model[indexPath.row];
        [WebRequest Meeting_Delete_settingWithuserGuid:user.Guid companyId:user.companyId settingId:model.Id And:^(NSDictionary *dic) {
            hud.label.text = dic[Y_MSG];
            dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(0.6 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
                [hud hideAnimated:NO];
                if ([dic[Y_STATUS] integerValue]==200) {
                    [arr_model removeObject:model];
                    [tableV reloadData];
                }
            });
        }];
    }
}

-(NSString*)tableView:(UITableView *)tableView titleForDeleteConfirmationButtonForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return @"删除";
}



@end
