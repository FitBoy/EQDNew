//
//  ASearchViewController.m
//  EQD
//
//  Created by 梁新帅 on 2017/3/31.
//  Copyright © 2017年 FitBoy. All rights reserved.
//

#import "ASearchViewController.h"
#import <Contacts/Contacts.h>
#import "FBPeople.h"
#import "SDetailViewController.h"
@interface ASearchViewController ()<UITableViewDelegate,UITableViewDataSource,UISearchBarDelegate>
{
    UITableView *tableV;
    NSMutableArray *arr_person;
    NSMutableArray *tarr;
    UISearchBar *searchB;
}

@end

@implementation ASearchViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.navigationItem.title = @"手机号/易企点号加好友";
    arr_person = [NSMutableArray arrayWithCapacity:0];
    tarr = [NSMutableArray arrayWithCapacity:0];
    UISearchBar * searchBar =[[UISearchBar alloc]initWithFrame:CGRectMake(0, DEVICE_TABBAR_Height, DEVICE_WIDTH, 40)];
    [self.view addSubview:searchBar];
    searchBar.delegate=self;
    searchBar.placeholder=@"搜索手机号/易企点号加好友";
    searchB = searchBar;
    tableV = [[UITableView alloc]initWithFrame:CGRectMake(0, 40+DEVICE_TABBAR_Height, DEVICE_WIDTH, DEVICE_HEIGHT-40-DEVICE_TABBAR_Height) style:UITableViewStyleGrouped];
    adjustsScrollViewInsets_NO(tableV, self);
    tableV.delegate=self;
    tableV.dataSource=self;
    [self.view addSubview:tableV];
    tableV.rowHeight=60;
    [self getContact];
    
    
}
- (void)searchBar:(UISearchBar *)searchBar textDidChange:(NSString *)searchText{
    
    
    if (searchText.length==0) {
        arr_person =[NSMutableArray arrayWithCapacity:0];
    }
    else{
        NSPredicate *predicate =[NSPredicate predicateWithFormat:@"number CONTAINS[cd] %@",searchText];
        arr_person = [NSMutableArray arrayWithArray:[tarr filteredArrayUsingPredicate:predicate]];
        if(arr_person.count==0)
        {
            NSPredicate *predicate =[NSPredicate predicateWithFormat:@"name CONTAINS[cd] %@",searchText];
            arr_person = [NSMutableArray arrayWithArray:[tarr filteredArrayUsingPredicate:predicate]];
            
        }
    }
    [tableV reloadData];
    
    
}
#pragma  mark - 表的数据源
-(NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    if (arr_person.count==0) {
        return 1;
    }
    else
    {
        return 2;
    }
}
-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    if (section==0) {
        return 1;
    }
    else
    {
        return arr_person.count;
    }
}
-(NSString*)tableView:(UITableView *)tableView titleForHeaderInSection:(NSInteger)section
{
    if (section==1) {
        return @"手机通讯录";
    }
    return nil;
}
-(CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section
{
    if (section==0) {
        return 1;
    }
    else
    {
        return 20;
    }
}
-(UITableViewCell*)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    static NSString *cellId=@"cellID";
    UITableViewCell *cell =[tableView dequeueReusableCellWithIdentifier:cellId];
    if (!cell) {
        cell = [[UITableViewCell alloc]initWithStyle:UITableViewCellStyleSubtitle reuseIdentifier:cellId];
        cell.textLabel.font = [UIFont systemFontOfSize:17];

    }
    
    if (indexPath.section==0) {

        cell.textLabel.text = [NSString stringWithFormat:@"搜索：%@",searchB.text];
        cell.detailTextLabel.text =nil;
    }
    else
    {
    FBPeople *person = arr_person[indexPath.row];
    cell.textLabel.text =person.name;
    cell.detailTextLabel.text = [NSString stringWithFormat:@"手机号：%@",person.number];
    }
    return cell;
}

#pragma  mark - 表的协议代理
-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    if (indexPath.section==0) {
        SDetailViewController *Dvc =[[SDetailViewController alloc]init];
        Dvc.friendID = searchB.text;
        [self.navigationController pushViewController:Dvc animated:NO];
    }
    else
    {
        FBPeople  *person =arr_person[indexPath.row];
        
        searchB.text = [person.number stringByReplacingOccurrencesOfString:@"-" withString:@""];
        [tableV reloadData];
    }
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
                        person.number =number.stringValue;
//                        [arr_person addObject:person];
                        [tarr addObject:person];
                    }
                    
                }
                
                
                
            }];
        } else {
            NSLog(@"授权失败");
            UIAlertController *alert  =[UIAlertController alertControllerWithTitle:nil message:@"请前往-设置-隐私-通讯录-易企点 修改 通讯录 权限" preferredStyle:UIAlertControllerStyleAlert];
            [alert addAction:[UIAlertAction actionWithTitle:@"确定" style:UIAlertActionStyleCancel handler:^(UIAlertAction * _Nonnull action) {
                
            }]];
            dispatch_async(dispatch_get_main_queue(), ^{
                [self presentViewController:alert animated:NO completion:nil];
            });
        }
        
        
        dispatch_async(dispatch_get_main_queue(), ^{
            [tableV reloadData];
        });
    }];
    
}

@end
