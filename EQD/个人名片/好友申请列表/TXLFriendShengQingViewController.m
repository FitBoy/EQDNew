//
//  TXLFriendShengQingViewController.m
//  YiQiDian
//
//  Created by 梁新帅 on 2017/2/27.
//  Copyright © 2017年 FitBoy. All rights reserved.
//

#import "TXLFriendShengQingViewController.h"
#import "WebRequest.h"
#import "FBHaoYouModel.h"
#import "FBNewFriendTableViewCell.h"
#import <UIImageView+AFNetworking.h>
#import "PPCMoreViewController.h"
#import <Contacts/Contacts.h>
#import "FBPeople.h"
#import "FBOneImg_yyLabelTableViewCell.h"
@interface TXLFriendShengQingViewController ()<UITableViewDataSource,UITableViewDelegate>
{
    UITableView *tableV;
    NSMutableArray *arr_friendShenqing;
    UserModel *user;
    NSMutableArray *arr_person;
    NSMutableArray *arr_model;
}

@end

@implementation TXLFriendShengQingViewController
-(void)viewWillAppear:(BOOL)animated{
    [super viewWillAppear:animated];
    self.navigationController.navigationBarHidden=NO;
    [self loadRequestData];
    [WebRequest  userashx_ResetCount_MsgCodeWithuserGuid:user.Guid code:@"200" And:^(NSDictionary *dic) {
        
    }];
}
-(void)loadRequestData{
    
    
    [WebRequest User_AddFriend_RequestWithuid:user.Guid And:^(NSDictionary *dic) {
        [arr_friendShenqing removeAllObjects];
        NSNumber *number =dic[Y_STATUS];
        NSString *msg =dic[Y_MSG];
        if ([number integerValue]==200 ) {
            NSArray *arr =dic[Y_ITEMS];
            if(arr.count)
            {
                for (NSDictionary *dic1 in arr) {
                    FBHaoYouModel  *model = [FBHaoYouModel mj_objectWithKeyValues:dic1];
                    if ([model.ORD isEqualToString:@"friend"]) {
                         [arr_friendShenqing addObject:model];
                    }
                    else
                    {
                        
                    }
                   
                    
                }
            }
            
        }
        else
        {
            MBProgressHUD *hud=[MBProgressHUD showHUDAddedTo:self.view  animated:YES];
            hud.mode = MBProgressHUDModeText;
            hud.label.text =@"没有好友申请";
            dispatch_time_t popTime = dispatch_time(DISPATCH_TIME_NOW, 1 * NSEC_PER_SEC);
            dispatch_after(popTime, dispatch_get_main_queue(), ^(void){
                [MBProgressHUD hideHUDForView:self.view  animated:YES];
            });
        }
        
        dispatch_async(dispatch_get_main_queue(), ^{
            [tableV.mj_header endRefreshing];
            [tableV reloadData];
        });
    }];
    
    
}

-(void)getContact{
    
    CNContactStore *store = [[CNContactStore alloc] init];
    [store requestAccessForEntityType:CNEntityTypeContacts completionHandler:^(BOOL granted, NSError * _Nullable error) {
        if (granted) {
            [arr_person removeAllObjects];
            NSLog(@"授权成功");
            // 2. 获取联系人仓库
            CNContactStore * store = [[CNContactStore alloc] init];
            
            // 3. 创建联系人信息的请求对象
            NSArray * keys = @[CNContactGivenNameKey, CNContactFamilyNameKey, CNContactPhoneNumbersKey];
            
            // 4. 根据请求Key, 创建请求对象
            CNContactFetchRequest * request = [[CNContactFetchRequest alloc] initWithKeysToFetch:keys];
            
            // 5. 发送请求
            [store enumerateContactsWithFetchRequest:request error:nil usingBlock:^(CNContact * _Nonnull contact, BOOL * _Nonnull stop) {
                
                // 6.1 获取姓名
                NSString * givenName = contact.givenName;
                NSString * familyName = contact.familyName;
                
                FBPeople *person =[[FBPeople alloc]init];
                person.name = [NSString stringWithFormat:@"%@%@",familyName,givenName];
                
                // 6.2 获取电话
                
                if (contact.phoneNumbers>0) {
                    
                    for (CNLabeledValue * labelValue in contact.phoneNumbers) {
                        CNPhoneNumber * number = labelValue.value;
                        
                        NSString *str1 = [number.stringValue  stringByReplacingOccurrencesOfString:@"-" withString:@""];
                        NSString *str2 =[str1 stringByReplacingOccurrencesOfString:@"(" withString:@""];
                        NSString *str3 =[str2 stringByReplacingOccurrencesOfString:@")" withString:@""];
                        NSString *str4 =[str3 stringByReplacingOccurrencesOfString:@" " withString:@""];
                        NSString *str5 = [str4 stringByReplacingOccurrencesOfString:@" " withString:@""];
                        
                        person.number=str5;
                        [arr_person addObject:person];
                    }
                    
                }
                
                
                
            }];
            
            dispatch_async(dispatch_get_main_queue(), ^{
                ///网络请求，重新拿到联系人的注册信息状态
                [self getTuijian];
            });
        } else {
            UIAlertController *alert  =[UIAlertController alertControllerWithTitle:nil message:@"请前往-设置-隐私-通讯录-易企点 修改 通讯录 权限" preferredStyle:UIAlertControllerStyleAlert];
            [alert addAction:[UIAlertAction actionWithTitle:@"确定" style:UIAlertActionStyleCancel handler:^(UIAlertAction * _Nonnull action) {
                
            }]];
            dispatch_async(dispatch_get_main_queue(), ^{
                [self presentViewController:alert animated:NO completion:nil];
            });
        }
        
        
        
    }];
    
}

-(void)getTuijian{
    NSMutableString  *para = [NSMutableString string];
    for(int i=0;i<arr_person.count;i++)
    {
        FBPeople *P = arr_person[i];
        if (i==arr_person.count-1) {
            [para appendFormat:@"%@-%@",P.number,P.name];
        }else
        {
            [para appendFormat:@"%@-%@;",P.number,P.name];
        }
    }
    if (para.length>0) {
        MBProgressHUD *hud = [MBProgressHUD showHUDAddedTo:self.view animated:YES];
        hud.mode = MBProgressHUDModeAnnularDeterminate;
        hud.label.text = @"正在加载";
        [WebRequest Friend_Get_MailListWithuserGuid:user.Guid para:para And:^(NSDictionary *dic) {
            [hud hideAnimated:NO];
            if ([dic[Y_STATUS] integerValue]==200) {
                [arr_model removeAllObjects];
                NSArray *tarr= dic[Y_ITEMS];
                for (int i=0; i<tarr.count; i++) {
                    FBPeople  *person = [FBPeople mj_objectWithKeyValues:tarr[i]];
                    if ([person.isFriend integerValue] ==-2 && [person.isZhuCe integerValue]>0) {
                        [arr_model addObject:person];
                    }
                    
                }
                [tableV reloadData];
            }
        }];
    }
}
- (void)viewDidLoad {
    [super viewDidLoad];
    user =[WebRequest GetUserInfo];
    
     self.view.backgroundColor =[UIColor whiteColor];
    arr_friendShenqing =[NSMutableArray arrayWithCapacity:0];
    self.navigationItem.title = @"新朋友";
    tableV = [[UITableView alloc]initWithFrame:CGRectMake(0, DEVICE_TABBAR_Height, DEVICE_WIDTH, DEVICE_HEIGHT-DEVICE_TABBAR_Height) style:UITableViewStyleGrouped];
    adjustsScrollViewInsets_NO(tableV, self);
    tableV.delegate=self;
    tableV.dataSource=self;
    [self.view addSubview:tableV];
    tableV.rowHeight=60;
    tableV.mj_header =[MJRefreshNormalHeader headerWithRefreshingTarget:self refreshingAction:@selector(loadRequestData)];
    [tableV.mj_header beginRefreshing];
}
-(NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return 2;
}
-(NSString*)tableView:(UITableView *)tableView titleForHeaderInSection:(NSInteger)section
{
    if (section ==0) {
        return nil;
    }else
    {
        return @"推荐好友";
    }
}
#pragma  mark - 表的数据源
-(CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section
{
    if (section==0) {
        return 1;
    }else
    {
        return 20;
    }
}
-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    if(section==0)
    {
    return arr_friendShenqing.count;
    }else
    {
        return 0;
    }
}
-(UITableViewCell*)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    static NSString *cellId=@"cellID";
    FBNewFriendTableViewCell *cell =[tableView dequeueReusableCellWithIdentifier:cellId];
    if (!cell) {
        cell = [[FBNewFriendTableViewCell alloc]initWithStyle:UITableViewCellStyleDefault reuseIdentifier:cellId];
        cell.selectionStyle=UITableViewCellSelectionStyleNone;
    }
    FBHaoYouModel *model =arr_friendShenqing[indexPath.row];
    
    cell.L_name.text=[NSString stringWithFormat:@"%@",model.upname];
    cell.L_date.text =[NSString stringWithFormat:@"备注：%@",model.Message] ;
    
    if ([model.Sign integerValue]==1) {
        [cell.B_btn setTitle:@"已添加" forState:UIControlStateNormal];
        [cell.B_btn setBackgroundColor:[UIColor whiteColor]];
        [cell.B_btn setTitleColor:[UIColor grayColor] forState:UIControlStateNormal];
        cell.B_btn.enabled=NO;
    }
    else if([model.Sign integerValue]==-1)
    {
        [cell.B_btn setTitle:@"已拒绝" forState:UIControlStateNormal];
        [cell.B_btn setBackgroundColor:[UIColor whiteColor]];
        [cell.B_btn setTitleColor:[UIColor grayColor] forState:UIControlStateNormal];
        cell.B_btn.enabled=NO;
    }
    else
    {
        [cell.B_btn addTarget:self action:@selector(tongyiClilck:) forControlEvents:UIControlEventTouchUpInside];
        cell.B_btn.indexPath=indexPath;
    }
    
   
    [cell.IV_headimg setImageWithURL:[NSURL URLWithString:model.iphoto] placeholderImage:[UIImage imageNamed:@"no_login_head"]];
    
    
    
    return cell;
}

///同意 拒绝 申请好友
-(void)agreeFriendWithtype:(NSString*)type Withguid:(NSString*)guid
{
    MBProgressHUD *hud = [MBProgressHUD showHUDAddedTo:self.view animated:YES];
    hud.mode = MBProgressHUDModeAnnularDeterminate;
    hud.label.text = @"正在处理";
    [WebRequest User_Friend_OptionWithuserGuid:user.Guid friendGuid:guid type:type And:^(NSDictionary *dic) {
        NSNumber *number = dic[Y_STATUS];
        NSString *msg = dic[Y_MSG];
        hud.label.text =msg;
        if ([number integerValue]==200) {
            dispatch_time_t popTime = dispatch_time(DISPATCH_TIME_NOW, 1 * NSEC_PER_SEC);
            dispatch_after(popTime, dispatch_get_main_queue(), ^(void){
                [hud hideAnimated:NO];
                 [self loadRequestData];
                UIAlertController  *alert = [UIAlertController alertControllerWithTitle:nil message:@"是否设置备注？" preferredStyle:UIAlertControllerStyleAlert];
                [alert addAction:[UIAlertAction actionWithTitle:@"取消" style:UIAlertActionStyleDefault handler:^(UIAlertAction * _Nonnull action) {
                    
                }]];
                [alert addAction:[UIAlertAction actionWithTitle:@"确定" style:UIAlertActionStyleDefault handler:^(UIAlertAction * _Nonnull action) {
                    PPCMoreViewController  *Mvc = [[PPCMoreViewController alloc]init];
                    Mvc.friendGuid = guid;
                    [self.navigationController pushViewController:Mvc animated:NO];
                }]];
                dispatch_async(dispatch_get_main_queue(), ^{
                    [self presentViewController:alert animated:NO completion:nil];
                });
            });
        }
       
    }];
    
}
-(void)tongyiClilck:(FBindexpathButton*)btn{
    FBHaoYouModel *model =arr_friendShenqing[btn.indexPath.row];
    [self agreeFriendWithtype:@"true" Withguid:model.Guid];
}
-(BOOL)tableView:(UITableView *)tableView canEditRowAtIndexPath:(NSIndexPath *)indexPath
{
    FBHaoYouModel *model = arr_friendShenqing[indexPath.row];
    if ([model.Sign integerValue]==1) {
        return NO;
    }
    else if([model.Sign integerValue]==-1)
    {
        return NO;
    }
    else
    {
      return YES;  
    }
    
}

-(UITableViewCellEditingStyle)tableView:(UITableView *)tableView editingStyleForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return UITableViewCellEditingStyleDelete;
    
}
-(void)tableView:(UITableView *)tableView commitEditingStyle:(UITableViewCellEditingStyle)editingStyle forRowAtIndexPath:(NSIndexPath *)indexPath
{
    FBHaoYouModel *model =arr_friendShenqing[indexPath.row];
    if (editingStyle == UITableViewCellEditingStyleDelete) {
        [self agreeFriendWithtype:@"false" Withguid:model.Guid];
    }
}

-(NSString*)tableView:(UITableView *)tableView titleForDeleteConfirmationButtonForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return @"拒绝";
}




@end
