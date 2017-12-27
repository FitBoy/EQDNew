//
//  CYShuRuViewController.m
//  EQD
//
//  Created by 梁新帅 on 2017/4/22.
//  Copyright © 2017年 FitBoy. All rights reserved.
//

#import "CYShuRuViewController.h"
#import <Contacts/Contacts.h>
#import "FBPeople.h"
#import "FBTwo_Button12TableViewCell.h"
#import "BMChineseSort.h"
@interface CYShuRuViewController ()<UITableViewDataSource,UITableViewDelegate,UISearchBarDelegate>
{
    UITableView *tableV;
    NSMutableArray *arr_person;
    NSMutableArray *tarr;
    UserModel *user;
    NSMutableArray *tarr_t;
   
}

@end

@implementation CYShuRuViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    tarr_t =[NSMutableArray arrayWithCapacity:0];
    user =[WebRequest GetUserInfo];
   
    arr_person = [NSMutableArray arrayWithCapacity:0];
    tarr = [NSMutableArray arrayWithCapacity:0];
    self.navigationItem.title =@"入职邀请";
      tableV = [[UITableView alloc]initWithFrame:CGRectMake(0, DEVICE_TABBAR_Height, DEVICE_WIDTH, DEVICE_HEIGHT-DEVICE_TABBAR_Height) style:UITableViewStylePlain];
    adjustsScrollViewInsets_NO(tableV, self);
    tableV.delegate=self;
    tableV.dataSource=self;
    [self.view addSubview:tableV];
    tableV.rowHeight=50;
    [self getContact];
    UIBarButtonItem *right = [[UIBarButtonItem alloc]initWithTitle:@"确定" style:UIBarButtonItemStylePlain target:self action:@selector(quedingClick)];
    [self.navigationItem setRightBarButtonItem:right];
}
-(void)quedingClick
{
    if ([self.delegate respondsToSelector:@selector(numberarr:shoudong:)]) {
        NSMutableArray *arr_temp=[NSMutableArray arrayWithCapacity:0];
        for (int i=0; i<arr_person.count; i++) {
            FBPeople *person =arr_person[i];
            if ([person.status integerValue]==5) {
                [arr_temp insertObject:person atIndex:0];
            }
            else
            {
                
            }
        }
        
        [self.delegate numberarr:arr_temp shoudong:self.arr_shoudong];
        [self.navigationController popViewControllerAnimated:NO];
    }
}


#pragma  mark - 表的数据源

-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
        return arr_person.count;
}
-(UITableViewCell*)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    static NSString *cellId=@"cellID";
    FBTwo_Button12TableViewCell *cell =[tableView dequeueReusableCellWithIdentifier:cellId];
    if (!cell) {
        cell = [[FBTwo_Button12TableViewCell alloc]initWithStyle:UITableViewCellStyleValue1 reuseIdentifier:cellId];
        cell.accessoryType = UITableViewCellAccessoryNone;
        cell.selectionStyle=UITableViewCellSelectionStyleNone;
    }
        FBPeople *person = arr_person[indexPath.row];
    NSPredicate *predicate =[NSPredicate predicateWithFormat:@"number CONTAINS[cd] %@",person.phone];
    NSArray *tarr1 = [NSMutableArray arrayWithArray:[tarr filteredArrayUsingPredicate:predicate]];
    if (tarr1.count) {
        FBPeople *person2 =tarr1[0];
        person.name=person2.name;
    }
    NSPredicate *predicate1 =[NSPredicate predicateWithFormat:@"phone CONTAINS[cd] %@",person.phone];
    NSArray *arr2 = [NSMutableArray arrayWithArray:[self.arr_pre filteredArrayUsingPredicate:predicate1]];
    if (arr2.count) {
        person.status=@"5";
    }
    
    cell.B_add.indexpath=indexPath;
    [cell.B_add addTarget:self action:@selector(btnClick:) forControlEvents:UIControlEventTouchUpInside];
    
    [cell setModel:person];
    
    return cell;
}
-(void)btnClick:(FBIndexPathButton*)tbtn
{
    FBPeople *person =arr_person[tbtn.indexpath.row];
    if ([person.status integerValue]==5) {
        NSPredicate *predicate1 =[NSPredicate predicateWithFormat:@"phone CONTAINS[cd] %@",person.phone];
        NSArray *arr2 = [NSMutableArray arrayWithArray:[self.arr_pre filteredArrayUsingPredicate:predicate1]];
        if (arr2.count) {
            FBPeople *person =arr2[0];
            [self.arr_pre  removeObject:person];
        }

        person.status =@"1";
    }
    else if([person.status integerValue]<2)
    {
        person.status=@"5";
    }
    else
    {
        
    }
    [tableV reloadData];

}
#pragma  mark - 表的协议代理
-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
   
    FBPeople *person =arr_person[indexPath.row];
    if ([person.status integerValue]==5) {
        person.status =@"1";
    }
    else if([person.status integerValue]<2)
    {
       person.status=@"5";
    }
    else
    {
        
    }
    [tableV reloadData];
    
}

-(void)getContact{
    [arr_person removeAllObjects];
    CNContactStore *store = [[CNContactStore alloc] init];
    [store requestAccessForEntityType:CNEntityTypeContacts completionHandler:^(BOOL granted, NSError * _Nullable error) {
        if (granted) {
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
                        [tarr_t addObject:person.number];
                        [tarr addObject:person];
                    }
                    
                }
                
                
                
            }];
        } else {
            NSLog(@"授权失败");
        }
        
        
        dispatch_async(dispatch_get_main_queue(), ^{
            [self getpeopleStatusWithphone:tarr_t];
        });
    }];
    
}

-(void)getpeopleStatusWithphone:(NSArray*)phoneArr
{
    [WebRequest user_phonesWithphoneArr:phoneArr companyId:user.companyId And:^(NSDictionary *dic) {
        NSNumber *number = dic[Y_STATUS];
        if ([number integerValue]==200) {
            NSArray *tarr1 = dic[Y_ITEMS];
            for (int i=0; i<tarr1.count; i++) {
                FBPeople *people = [FBPeople mj_objectWithKeyValues:tarr1[i]];
                [arr_person addObject:people];
            }
            dispatch_async(dispatch_get_main_queue(), ^{
                [tableV reloadData];
            });
            
        }
        else
        {
            MBProgressHUD *hud=[MBProgressHUD showHUDAddedTo:self.view  animated:YES];
            hud.mode = MBProgressHUDModeText;
            hud.label.text =@"服务器错误";
            dispatch_time_t popTime = dispatch_time(DISPATCH_TIME_NOW, 1 * NSEC_PER_SEC);
            dispatch_after(popTime, dispatch_get_main_queue(), ^(void){
                [MBProgressHUD hideHUDForView:self.view  animated:YES];
            });
        }
    }];
    
}


@end
