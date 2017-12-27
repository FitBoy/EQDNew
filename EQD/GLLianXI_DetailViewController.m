//
//  GLLianXI_DetailViewController.m
//  EQD
//
//  Created by 梁新帅 on 2017/10/18.
//  Copyright © 2017年 FitBoy. All rights reserved.
//

#import "GLLianXI_DetailViewController.h"
#import "FBTextFieldViewController.h"
#import "FBTextVViewController.h"
@interface GLLianXI_DetailViewController ()<UITableViewDelegate,UITableViewDataSource,FBTextVViewControllerDelegate,FBTextFieldViewControllerDelegate>
{
    UITableView *tableV;
    NSMutableArray *arr_names;
    NSMutableArray *arr_contents;
    UserModel *user;
    GLLianXiModel  *model_detail;
    NSArray *arr_key;
}

@end

@implementation GLLianXI_DetailViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    user =[WebRequest GetUserInfo];
    arr_names =[NSMutableArray arrayWithArray:@[@"姓名",@"部门",@"职务",@"手机",@"QQ",@"微信",@"邮箱",@"备注",@"添加时间"]];
    [WebRequest crmModule_Get_cuscontactsWithowner:user.Guid contactsid:self.model.ID And:^(NSDictionary *dic) {
        model_detail = [GLLianXiModel mj_objectWithKeyValues:dic[Y_ITEMS]];
        arr_contents = [NSMutableArray arrayWithArray:@[model_detail.name,model_detail.dep,model_detail.post,model_detail.cellphone,model_detail.conqq,model_detail.conwx,model_detail.email,model_detail.remark,model_detail.createTime]];
       
        [tableV reloadData];
    }];
     arr_key= @[@"name",@"dep",@"post",@"cellphone",@"conqq",@"conwx",@"email",@"remark"];
    self.navigationItem.title =@"联系人详情";
    tableV = [[UITableView alloc]initWithFrame:CGRectMake(0, DEVICE_TABBAR_Height, DEVICE_WIDTH, DEVICE_HEIGHT-DEVICE_TABBAR_Height) style:UITableViewStylePlain];
    adjustsScrollViewInsets_NO(tableV, self);
    tableV.delegate=self;
    tableV.dataSource=self;
    [self.view addSubview:tableV];
    tableV.rowHeight=50;
   

}
#pragma  mark - 表的数据源
-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return arr_contents.count;
}
-(UITableViewCell*)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    static NSString *cellId=@"cellID";
    UITableViewCell *cell =[tableView dequeueReusableCellWithIdentifier:cellId];
    if (!cell) {
        cell = [[UITableViewCell alloc]initWithStyle:UITableViewCellStyleValue1 reuseIdentifier:cellId];
        cell.accessoryType = UITableViewCellAccessoryDisclosureIndicator;
        cell.textLabel.font = [UIFont systemFontOfSize:17];
        cell.detailTextLabel.font = [UIFont systemFontOfSize:15];
    }
    cell.textLabel.text=arr_names[indexPath.row];
    cell.detailTextLabel.text =arr_contents[indexPath.row];
    if (indexPath.row==8) {
        cell.accessoryType = UITableViewCellAccessoryNone;
    }else
    {
        cell.accessoryType = UITableViewCellAccessoryDisclosureIndicator;
    }
    return cell;
}

#pragma  mark - 表的协议代理
-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    if(indexPath.row==7)
    {
        FBTextVViewController *Tvvc =[[FBTextVViewController alloc]init];
        Tvvc.indexpath =indexPath;
        Tvvc.delegate =self;
        Tvvc.content =arr_contents[indexPath.row];
        Tvvc.contentTitle =arr_names[indexPath.row];
        [self.navigationController pushViewController:Tvvc animated:NO];
        
    }else if (indexPath.row==8)
    {
    }else
    {
        FBTextFieldViewController *TFvc =[[FBTextFieldViewController alloc]init];
        TFvc.indexPath =indexPath;
        TFvc.delegate =self;
        TFvc.contentTitle =arr_names[indexPath.row];
        TFvc.content=arr_contents[indexPath.row];
        [self.navigationController pushViewController:TFvc animated:NO];
    }
}

#pragma  mark - delegate
-(void)textVtext:(NSString *)text indexPath:(NSIndexPath *)indexPath
{
    
    [self  xiugaiWithdata:text indexPath:indexPath];
}
-(void)content:(NSString *)content WithindexPath:(NSIndexPath *)indexPath
{
    [self xiugaiWithdata:content indexPath:indexPath];
}
-(void)xiugaiWithdata:(NSString*)data indexPath:(NSIndexPath*)indexPath
{
    NSString *data2 = [NSString stringWithFormat:@"{'%@':'%@'}",arr_key[indexPath.row],data];
    MBProgressHUD *hud = [MBProgressHUD showHUDAddedTo:self.view animated:YES];
    hud.mode = MBProgressHUDModeAnnularDeterminate;
    hud.label.text = @"正在修改";
    [WebRequest crmModule_Update_cuscontactsWithowner:user.Guid contactsid:model_detail.ID data:data2 And:^(NSDictionary *dic) {
        hud.label.text =dic[Y_MSG];
        if ([dic[Y_STATUS] integerValue]==200) {
            [arr_contents replaceObjectAtIndex:indexPath.row withObject:data];
            [tableV reloadRowsAtIndexPaths:@[indexPath] withRowAnimation:UITableViewRowAnimationNone];
            
        }
        dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(0.7 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
            [hud hideAnimated:NO];
        });
    }];
}


@end
