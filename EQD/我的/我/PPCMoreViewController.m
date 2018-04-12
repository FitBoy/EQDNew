//
//  PPCMoreViewController.m
//  EQD
//
//  Created by 梁新帅 on 2018/4/11.
//  Copyright © 2018年 FitBoy. All rights reserved.
//

#import "PPCMoreViewController.h"
#import "FBTextFieldViewController.h"
@interface PPCMoreViewController ()<UITableViewDataSource,UITableViewDelegate,FBTextFieldViewControllerDelegate>
{
    UITableView *tableV;
    NSArray *arr_names;
    NSMutableArray *arr_contents;
    UserModel *user;
}

@end

@implementation PPCMoreViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.navigationItem.title = @"备注信息";
    user = [WebRequest GetUserInfo];
    arr_names = @[@"备注名"];
    arr_contents = [NSMutableArray arrayWithArray:@[@" "]];
    tableV = [[UITableView alloc]initWithFrame:CGRectMake(0, DEVICE_TABBAR_Height, DEVICE_WIDTH, DEVICE_HEIGHT-DEVICE_TABBAR_Height-kBottomSafeHeight) style:UITableViewStylePlain];
    adjustsScrollViewInsets_NO(tableV, self);
    tableV.delegate=self;
    tableV.dataSource=self;
    [self.view addSubview:tableV];
    tableV.rowHeight=60;
   
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
        cell.textLabel.font = [UIFont systemFontOfSize:17];
    }
    cell.textLabel.text = arr_names[indexPath.row];
    cell.detailTextLabel.text = arr_contents[indexPath.row];
    return cell;
}

#pragma  mark - 表的协议代理
-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    if (indexPath.row==0) {
    //备注
        FBTextFieldViewController *TFvc =[[FBTextFieldViewController alloc]init];
        TFvc.delegate =self;
        TFvc.indexPath =indexPath;
        TFvc.content =arr_contents[indexPath.row];
        TFvc.contentTitle =arr_names[indexPath.row];
        [self.navigationController pushViewController:TFvc animated:NO];
        
    }else if (indexPath.row==1)
    {
     //标签
        
    }else
    {
        
    }
}
-(void)content:(NSString*)content WithindexPath:(NSIndexPath*)indexPath
{
    MBProgressHUD *hud = [MBProgressHUD showHUDAddedTo:self.view animated:YES];
    hud.mode = MBProgressHUDModeAnnularDeterminate;
    hud.label.text = @"正在修改";
    [WebRequest Friend_Update_FriendRemarksWithuserGuid:user.Guid friendGuid:self.friendGuid remarks:content And:^(NSDictionary *dic) {
        [hud hideAnimated:NO];
        if ([dic[Y_STATUS] integerValue]==200) {
            [arr_contents replaceObjectAtIndex:0 withObject:content];
            [tableV reloadRowsAtIndexPaths:@[indexPath] withRowAnimation:UITableViewRowAnimationNone];
        }
    }];
}


@end
