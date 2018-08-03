//
//  Add_phoneContactViewController.m
//  EQD
//
//  Created by 梁新帅 on 2018/5/18.
//  Copyright © 2018年 FitBoy. All rights reserved.
//

#import "Add_phoneContactViewController.h"
#import <Contacts/Contacts.h>
#import "FBPeople.h"
#import "FBOneImg_yyLabelTableViewCell.h"
@interface Add_phoneContactViewController ()<UITableViewDelegate,UITableViewDataSource>
{
    UITableView *tableV;
    NSMutableArray *arr_person;
    NSMutableArray *tarr;
    UserModel *user;
    NSMutableArray *arr_model;
}

@end

@implementation Add_phoneContactViewController
-(void)getContact{
    
    CNContactStore *store = [[CNContactStore alloc] init];
    [store requestAccessForEntityType:CNEntityTypeContacts completionHandler:^(BOOL granted, NSError * _Nullable error) {
        if (granted) {
            [arr_person removeAllObjects];
            [tarr removeAllObjects];
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
                        [tarr addObject:person];
                        [arr_person addObject:person];
                    }
                    
                }
              
                
                
            }];
            
            dispatch_async(dispatch_get_main_queue(), ^{
                ///网络请求，重新拿到联系人的注册信息状态
                [self loadRequestData];
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
-(void)viewWillAppear:(BOOL)animated{
    [super viewWillAppear:animated];
   
}
-(void)loadRequestData{
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
- (BOOL)prefersHomeIndicatorAutoHidden{
    return NO;
}
- (void)viewDidLoad {
    [super viewDidLoad];
    self.navigationItem.title = @"批量添加好友";
    arr_person = [NSMutableArray arrayWithCapacity:0];
    arr_model = [NSMutableArray arrayWithCapacity:0];
    tarr = [NSMutableArray arrayWithCapacity:0];
    user = [WebRequest GetUserInfo];
    tableV = [[UITableView alloc]initWithFrame:CGRectMake(0, DEVICE_TABBAR_Height, DEVICE_WIDTH, DEVICE_HEIGHT-DEVICE_TABBAR_Height-kBottomSafeHeight) style:UITableViewStylePlain];
    adjustsScrollViewInsets_NO(tableV, self);
    tableV.delegate=self;
    tableV.dataSource=self;
    [self.view addSubview:tableV];
    tableV.rowHeight=60;

    [self getContact];
    
    UIBarButtonItem *right = [[UIBarButtonItem alloc]initWithTitle:@"确定" style:UIBarButtonItemStylePlain target:self action:@selector(QueDingClick)];
    [self.navigationItem setRightBarButtonItem:right];
    
}
-(void)QueDingClick
{
    //
    UIAlertController  *alert = [UIAlertController alertControllerWithTitle:@"统一的备注信息" message:nil preferredStyle:UIAlertControllerStyleAlert];
    [alert addTextFieldWithConfigurationHandler:^(UITextField * _Nonnull textField) {
        textField.placeholder = @"我是……";
    }];
    [alert addAction:[UIAlertAction actionWithTitle:@"取消" style:UIAlertActionStyleCancel handler:^(UIAlertAction * _Nonnull action) {
        
    }]];
    [alert addAction:[UIAlertAction actionWithTitle:@"确定" style:UIAlertActionStyleDefault handler:^(UIAlertAction * _Nonnull action) {
        MBProgressHUD *hud = [MBProgressHUD showHUDAddedTo:self.view animated:YES];
        hud.mode = MBProgressHUDModeAnnularDeterminate;
        hud.label.text = @"正在发送";
        NSMutableString  *friendGuid = [NSMutableString string];
        for (int i=0; i<arr_model.count; i++) {
            FBPeople *person =arr_model[i];
            if (person.isChoose ==YES) {
                [friendGuid appendFormat:@"%@;",person.userGuid];
            }
        }
  NSString *friendGuid2= [friendGuid  substringWithRange:NSMakeRange(0, friendGuid.length-1)];
        
        [WebRequest Friend_Add_BatchFriendWithuserGuid:user.Guid friendGuid:friendGuid2 content:alert.textFields[0].text And:^(NSDictionary *dic) {
            hud.label.text =dic[Y_MSG];
            dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(0.7 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
                [hud hideAnimated:NO];
                if ([dic[Y_STATUS] integerValue]==200) {
                    [self.navigationController popViewControllerAnimated:NO];
                }
            });
        }];
        
    }]];
    dispatch_async(dispatch_get_main_queue(), ^{
        [self presentViewController:alert animated:NO completion:nil];
    });
}
#pragma  mark - 表的数据源
-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return arr_model.count;
}
-(UITableViewCell*)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    static NSString *cellId=@"cellID";
    FBOneImg_yyLabelTableViewCell *cell =[tableView dequeueReusableCellWithIdentifier:cellId];
    if (!cell) {
        cell = [[FBOneImg_yyLabelTableViewCell alloc]initWithStyle:UITableViewCellStyleDefault reuseIdentifier:cellId];
        cell.accessoryType = UITableViewCellAccessoryNone;
        cell.textLabel.font = [UIFont systemFontOfSize:18];
    }
    FBPeople  *person = arr_model[indexPath.row];
    NSMutableAttributedString  *name = [[NSMutableAttributedString alloc]initWithString:person.EQDNickname attributes:@{NSFontAttributeName:[UIFont systemFontOfSize:17]}];
    NSMutableAttributedString *contents = [[NSMutableAttributedString alloc]initWithString:[NSString stringWithFormat:@"\n[手机联系人]%@",person.localNickname] attributes:@{NSFontAttributeName:[UIFont systemFontOfSize:13],NSForegroundColorAttributeName:[UIColor grayColor]}];
    [name appendAttributedString:contents];
    name.yy_lineSpacing = 6;
    
    [cell setImg:person.headImage Context:name isChoose:person.isChoose isShow:YES];
    return cell;
}

#pragma  mark - 表的协议代理
-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    FBPeople *model =arr_model[indexPath.row];
    model.isChoose = !model.isChoose;
    [tableV reloadRowsAtIndexPaths:@[indexPath] withRowAnimation:UITableViewRowAnimationNone];
}



@end
