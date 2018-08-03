//
//  SZQunGuanLiViewController.m
//  EQD
//
//  Created by 梁新帅 on 2017/7/10.
//  Copyright © 2017年 FitBoy. All rights reserved.
//

#import "SZQunGuanLiViewController.h"
#import "WebRequest.h"
#import "GLTiRenViewController.h"
@interface SZQunGuanLiViewController ()<UITableViewDelegate,UITableViewDataSource>
{
    UITableView *tableV;
    NSMutableArray *arr_big;
    UserModel *user;
}

@end

@implementation SZQunGuanLiViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    user =[WebRequest GetUserInfo];
    arr_big =[NSMutableArray arrayWithArray:@[@[@"踢人"],@[@"解散该群"]]];
    
    tableV = [[UITableView alloc]initWithFrame:CGRectMake(0, 0, DEVICE_WIDTH, DEVICE_HEIGHT) style:UITableViewStyleGrouped];
    tableV.delegate=self;
    tableV.dataSource=self;
    [self.view addSubview:tableV];
    tableV.rowHeight=60;
}
#pragma  mark - 表的数据源
-(NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return arr_big.count;
}
-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    NSArray *tarr = arr_big[section];
    return tarr.count;
}
-(UITableViewCell*)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    static NSString *cellId=@"cellID";
    UITableViewCell *cell =[tableView dequeueReusableCellWithIdentifier:cellId];
    if (!cell) {
        cell = [[UITableViewCell alloc]initWithStyle:UITableViewCellStyleDefault reuseIdentifier:cellId];
        cell.accessoryType = UITableViewCellAccessoryDisclosureIndicator;
        cell.textLabel.font = [UIFont systemFontOfSize:18];
    }
    NSArray *tarr =arr_big[indexPath.section];
    cell.textLabel.text =tarr[indexPath.row];
    return cell;
}

#pragma  mark - 表的协议代理
-(CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section
{
    return 10;
}
-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    switch (indexPath.section) {
        case 0:
        {
            //踢人
            GLTiRenViewController *TRvc =[[GLTiRenViewController alloc]init];
            TRvc.model =self.model;
            [self.navigationController pushViewController:TRvc animated:NO];
            
        }
            break;
            case 1:
        {
            //解散该群
            UIAlertController *alert = [UIAlertController alertControllerWithTitle:nil message:@"您确定解散该群，解散后，该群成员全部退出" preferredStyle:UIAlertControllerStyleActionSheet];
            [alert addAction:[UIAlertAction actionWithTitle:@"解散" style:UIAlertActionStyleDefault handler:^(UIAlertAction * _Nonnull action) {
                MBProgressHUD *hud = [MBProgressHUD showHUDAddedTo:self.view animated:YES];
                hud.mode = MBProgressHUDModeAnnularDeterminate;
                hud.label.text = @"正在解散";
                [WebRequest User_DismissgroupWithuserGuid:user.Guid Groupid:self.model.groupid And:^(NSDictionary *dic) {
                    NSString *msg = dic[Y_MSG];
                    NSNumber *number = dic[Y_STATUS];
                    hud.label.text =msg;
                    dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(0.5 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
                        [hud hideAnimated:NO];
                    });
                    if ([number integerValue]==200) {
                        [self.navigationController popToRootViewControllerAnimated:NO];
                    }
                }];
                
                
            }]];
            [alert addAction:[UIAlertAction actionWithTitle:@"取消" style:UIAlertActionStyleCancel handler:^(UIAlertAction * _Nonnull action) {
                
            }]];
            dispatch_async(dispatch_get_main_queue(), ^{
                [self presentViewController:alert animated:NO completion:nil];
            });
            
            
        }
            break;
        default:
            break;
    }
}



@end
