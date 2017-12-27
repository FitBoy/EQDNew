//
//  ZZXiuGaiViewController.m
//  EQD
//
//  Created by 梁新帅 on 2017/4/28.
//  Copyright © 2017年 FitBoy. All rights reserved.
//

#import "ZZXiuGaiViewController.h"
#import "FBTextFieldViewController.h"
#import "FBJobViewController.h"
@interface ZZXiuGaiViewController ()<UITableViewDataSource,UITableViewDelegate,FBTextFieldViewControllerDelegate,FBJobViewControllerDelegate>
{
    UITableView *tableV;
    NSMutableArray *arr_gangwei;
    NSMutableArray *arr_contents;
    UserModel *user;
}


@end

@implementation ZZXiuGaiViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    user =[WebRequest GetUserInfo];
   
    
    self.navigationItem.title = @"修改岗位";
    arr_gangwei =[NSMutableArray arrayWithArray:@[@"所属部门",@"岗位",@"岗位类别"]];
    arr_contents=[NSMutableArray arrayWithArray:@[self.bumenName,self.model.name,self.model.type]];
    tableV = [[UITableView alloc]initWithFrame:CGRectMake(0, DEVICE_TABBAR_Height, DEVICE_WIDTH, DEVICE_HEIGHT-DEVICE_TABBAR_Height) style:UITableViewStylePlain];
     adjustsScrollViewInsets_NO(tableV, self);
    tableV.delegate=self;
    tableV.dataSource=self;
    [self.view addSubview:tableV];
    tableV.rowHeight=50;
    UIBarButtonItem *left = [[UIBarButtonItem alloc]initWithTitle:@"返回" style:UIBarButtonItemStylePlain target:self action:@selector(editCancelClick)];
    [self.navigationItem setLeftBarButtonItem:left];
}

#pragma  mark - 表的数据源
-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return arr_gangwei.count;
}
-(UITableViewCell*)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    static NSString *cellId=@"cellID";
    UITableViewCell *cell =[tableView dequeueReusableCellWithIdentifier:cellId];
    if (!cell) {
        cell = [[UITableViewCell alloc]initWithStyle:UITableViewCellStyleValue1 reuseIdentifier:cellId];
        cell.accessoryType = UITableViewCellAccessoryDisclosureIndicator;
    }
    if (indexPath.row==0) {
        cell.accessoryType=UITableViewCellAccessoryNone;
    }
    cell.textLabel.text =arr_gangwei[indexPath.row];
    cell.detailTextLabel.text =arr_contents[indexPath.row];
    
    return cell;
}

#pragma  mark - 表的协议代理
-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    if (indexPath.row==1) {
        FBTextFieldViewController *TFvc =[[FBTextFieldViewController alloc]init];
        TFvc.delegate =self;
        TFvc.indexPath=indexPath;
        TFvc.contentTitle =arr_gangwei[indexPath.row];
        TFvc.content =arr_contents[indexPath.row];
        [self.navigationController pushViewController:TFvc animated:NO];
        
    }
    if (indexPath.row==2) {
        FBJobViewController *Jvc =[[FBJobViewController alloc]init];
        Jvc.delegate=self;
        Jvc.indexPath =indexPath;
        [self.navigationController pushViewController:Jvc animated:NO];
        
    }
}

-(void)content:(NSString *)content WithindexPath:(NSIndexPath *)indexPath
{
    [arr_contents replaceObjectAtIndex:indexPath.row withObject:content];
        //修改岗位名称
  
    [self xiugaiWithname:content type:self.model.type];
    
    
   
}

-(void)xiugaiWithname:(NSString*)name  type:(NSString*)type
{
    MBProgressHUD *hud = [MBProgressHUD showHUDAddedTo:self.view animated:YES];
    hud.mode = MBProgressHUDModeAnnularDeterminate;
    hud.label.text = @"正在修改";
    [WebRequest Com_Update_PostWithname:name type:type desc:_model.desc userGuid:user.Guid ID:_model.ID And:^(NSDictionary *dic) {
        hud.label.text =dic[Y_MSG];
        dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(1 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
            [hud hideAnimated:NO];
            [self.navigationController popViewControllerAnimated:NO];
        });
    }];
    
}
-(void)model:(AllModel *)model indexPath:(NSIndexPath *)indexpath
{
    [arr_contents replaceObjectAtIndex:indexpath.row withObject:model.child_name];
    
    [self xiugaiWithname:self.model.name type:model.child_name];
    
}
@end
