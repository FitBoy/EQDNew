//
//  LXRAddViewController.m
//  EQD
//
//  Created by 梁新帅 on 2017/5/24.
//  Copyright © 2017年 FitBoy. All rights reserved.
//

#import "LXRAddViewController.h"
#import "FBTextFieldViewController.h"
#import "FBTextVViewController.h"
#import "FBContactPeopleViewController.h"
@interface LXRAddViewController ()<UITableViewDataSource,UITableViewDelegate,FBTextVViewControllerDelegate,FBTextFieldViewControllerDelegate,FBContactPeopleViewControllerdelegate>
{
    UITableView *tableV;
    NSMutableArray *arr_names;
    NSMutableArray *arr_contents;
    UserModel *user;
    
}

@end

@implementation LXRAddViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    user =[WebRequest GetUserInfo];
    self.navigationItem.title =@"添加联系人";
    arr_names=[NSMutableArray arrayWithArray:@[@"*姓名",@"部门",@"*职务",@"*手机",@"QQ",@"微信",@"邮箱",@"备注"]];
     NSArray *tarr = [USERDEFAULTS objectForKey:@"LXRAdd"];
    if (tarr==nil) {
         arr_contents=[NSMutableArray arrayWithArray:@[@"请输入",@"请输入",@"请输入",@"请输入",@"请输入",@"请输入",@"请输入",@"请输入"]];
    }else
    {
        arr_contents = [NSMutableArray arrayWithArray:tarr];
    }
   
    tableV = [[UITableView alloc]initWithFrame:CGRectMake(0, 0, DEVICE_WIDTH, DEVICE_HEIGHT) style:UITableViewStylePlain];
    tableV.delegate=self;
    tableV.dataSource=self;
    [self.view addSubview:tableV];
    tableV.rowHeight=50;
    UIBarButtonItem *right = [[UIBarButtonItem alloc]initWithTitle:@"提交" style:UIBarButtonItemStylePlain target:self action:@selector(tijiaoClick)];
//    UIBarButtonItem *right2 =[[UIBarButtonItem alloc]initWithTitle:@"扫名片" style:UIBarButtonItemStylePlain target:self action:@selector(saoMingPianClick)];
//    [self.navigationItem setRightBarButtonItems:@[right,right2]];
    [self.navigationItem setRightBarButtonItem:right];
    
   }
-(void)saoMingPianClick
{
    
}
-(void)tijiaoClick
{
    NSInteger temp=0;
    for (int i=0; i<arr_contents.count; i++) {
        if (i==0||i==2||i==3) {
           if( [arr_contents[i] isEqualToString:@"请输入"])
           {
               temp =1;
               MBProgressHUD *hud=[MBProgressHUD showHUDAddedTo:self.view  animated:YES];
               hud.mode = MBProgressHUDModeText;
               hud.label.text =@"带*为必填项";
               dispatch_time_t popTime = dispatch_time(DISPATCH_TIME_NOW, 1 * NSEC_PER_SEC);
               dispatch_after(popTime, dispatch_get_main_queue(), ^(void){
                   [MBProgressHUD hideHUDForView:self.view  animated:YES];
               });
               break;
           }else
           {
           }
        }else
        {
        if ([arr_contents[i] isEqualToString:@"请输入"]) {
            arr_contents[i] = @" ";
        }
        }
    }
    //@[@"*姓名",@"部门",@"*职务",@"*手机",@"QQ",@"微信",@"邮箱",@"备注"]
    if (temp ==0) {
        MBProgressHUD *hud = [MBProgressHUD showHUDAddedTo:self.view animated:YES];
        hud.mode = MBProgressHUDModeAnnularDeterminate;
        hud.label.text = @"正在提交";
        [WebRequest crmModule_Create_cuscontactsWithname:arr_contents[0] dep:arr_contents[1] post:arr_contents[2] cellphone:arr_contents[3] conqq:arr_contents[4] conwx:arr_contents[5] email:arr_contents[6] remark:arr_contents[7] cusid:self.model.ID owner:user.Guid And:^(NSDictionary *dic) {
            hud.label.text =dic[Y_MSG];
            dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(0.8 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
                [hud hideAnimated:NO];
                [self.navigationController popViewControllerAnimated:NO];
            });
        }];
    }
    
    
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
        cell.textLabel.font =[UIFont systemFontOfSize:17];
        cell.detailTextLabel.font=[UIFont systemFontOfSize:15];
    }
    cell.textLabel.text=arr_names[indexPath.row];
    cell.detailTextLabel.text = arr_contents[indexPath.row];
    return cell;
}

#pragma  mark - 表的协议代理
-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    
    if (indexPath.row==7) {
        //备注
        FBTextVViewController *TVvc =[[FBTextVViewController alloc]init];
        TVvc.indexpath=indexPath;
        TVvc.delegate =self;
        TVvc.content =arr_contents[indexPath.row];
        TVvc.contentTitle =arr_names[indexPath.row];
        [self.navigationController pushViewController:TVvc animated:NO];
    }else if (indexPath.row==0 || indexPath.row==3)
    {
        UIAlertController *alert = [[UIAlertController alloc]init];
        [alert addAction:[UIAlertAction actionWithTitle:@"通讯录导入" style:UIAlertActionStyleDefault handler:^(UIAlertAction * _Nonnull action) {
            FBContactPeopleViewController *Pvc =[[FBContactPeopleViewController alloc]init];
            Pvc.delegate =self;
            [self.navigationController pushViewController:Pvc animated:NO];
            
        }]];
        [alert addAction:[UIAlertAction actionWithTitle:@"手动输入" style:UIAlertActionStyleDefault handler:^(UIAlertAction * _Nonnull action) {
            FBTextFieldViewController *TFvc =[[FBTextFieldViewController alloc]init];
            TFvc.delegate =self;
            TFvc.indexPath=indexPath;
            TFvc.contentTitle =arr_names[indexPath.row];
            TFvc.content =arr_contents[indexPath.row];
            [self.navigationController pushViewController:TFvc animated:NO];
        }]];
        [alert addAction:[UIAlertAction actionWithTitle:@"取消" style:UIAlertActionStyleCancel handler:^(UIAlertAction * _Nonnull action) {
            
        }]];
        
        [self presentViewController:alert animated:NO completion:nil];
    }
    else
    {
        FBTextFieldViewController *TFvc =[[FBTextFieldViewController alloc]init];
        TFvc.delegate =self;
        TFvc.indexPath=indexPath;
        TFvc.contentTitle =arr_names[indexPath.row];
        TFvc.content =arr_contents[indexPath.row];
        [self.navigationController pushViewController:TFvc animated:NO];
    }
}
#pragma  mark - 自定义的协议代理
-(void)content:(NSString *)content WithindexPath:(NSIndexPath *)indexPath
{
    [arr_contents replaceObjectAtIndex:indexPath.row withObject:content];
    [tableV reloadRowsAtIndexPaths:@[indexPath] withRowAnimation:UITableViewRowAnimationNone];
}
-(void)textVtext:(NSString *)text indexPath:(NSIndexPath *)indexPath
{
    [arr_contents replaceObjectAtIndex:indexPath.row withObject:text];
    [tableV reloadRowsAtIndexPaths:@[indexPath] withRowAnimation:UITableViewRowAnimationNone];
}
-(void)viewWillDisappear:(BOOL)animated
{
    [super viewWillDisappear:animated];
    [USERDEFAULTS setObject:arr_contents forKey:@"LXRAdd"];
    [USERDEFAULTS synchronize];
}
-(void)contactName:(NSString *)name phone:(NSString *)phone
{
    [arr_contents replaceObjectAtIndex:0 withObject:name];
    [arr_contents replaceObjectAtIndex:3 withObject:phone];
    [tableV reloadRowsAtIndexPaths:@[[NSIndexPath indexPathForRow:0 inSection:0],[NSIndexPath indexPathForRow:3 inSection:0]] withRowAnimation:UITableViewRowAnimationNone];
}

@end
