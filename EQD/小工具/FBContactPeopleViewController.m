//
//  FBContactPeopleViewController.m
//  EQD
//
//  Created by 梁新帅 on 2017/10/18.
//  Copyright © 2017年 FitBoy. All rights reserved.
//

#import "FBContactPeopleViewController.h"
#import <Contacts/Contacts.h>
#import "FBPeople.h"
@interface FBContactPeopleViewController ()<UITableViewDelegate,UITableViewDataSource,UISearchBarDelegate>
{
    UITableView *tableV;
    NSMutableArray *arr_person;
    NSMutableArray *tarr;
}

@end

@implementation FBContactPeopleViewController
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
                dispatch_async(dispatch_get_main_queue(), ^{
                     [tableV reloadData];
                });
             
                
            }];
        } else {
            UIAlertController *alert  =[UIAlertController alertControllerWithTitle:nil message:@"请前往-设置-隐私-通讯录-易企点 修改权限" preferredStyle:UIAlertControllerStyleAlert];
            [alert addAction:[UIAlertAction actionWithTitle:@"确定" style:UIAlertActionStyleDefault handler:^(UIAlertAction * _Nonnull action) {
                
            }]];
            [self presentViewController:alert animated:NO completion:nil];
        }
        
        
        
    }];
    
}


- (void)viewDidLoad {
    [super viewDidLoad];
    self.navigationItem.title =@"通讯录";
    arr_person =[NSMutableArray arrayWithCapacity:0];
    tarr = [NSMutableArray arrayWithCapacity:0];
    UISearchBar * searchBar =[[UISearchBar alloc]initWithFrame:CGRectMake(0, DEVICE_TABBAR_Height, DEVICE_WIDTH, 40)];
    [self.view addSubview:searchBar];
    searchBar.delegate=self;
    searchBar.placeholder=@"搜索";
    tableV = [[UITableView alloc]initWithFrame:CGRectMake(0, DEVICE_TABBAR_Height+40, DEVICE_WIDTH, DEVICE_HEIGHT-DEVICE_TABBAR_Height-40) style:UITableViewStylePlain];
    adjustsScrollViewInsets_NO(tableV, self);
    tableV.delegate=self;
    tableV.dataSource=self;
    [self.view addSubview:tableV];
    tableV.rowHeight=50;
    [self getContact];
}
#pragma  mark - 表的数据源
- (void)searchBar:(UISearchBar *)searchBar textDidChange:(NSString *)searchText{
    
    if (searchText.length==0) {
        arr_person =[NSMutableArray arrayWithArray:tarr];
    }
    else{
        NSPredicate *predicate =[NSPredicate predicateWithFormat:@"name CONTAINS[cd] %@",searchText];
        arr_person = [NSMutableArray arrayWithArray:[tarr filteredArrayUsingPredicate:predicate]];
    }
    [tableV reloadData];
    
    
}

-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return arr_person.count;
}
-(UITableViewCell*)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    static NSString *cellId=@"cellID";
    UITableViewCell *cell =[tableView dequeueReusableCellWithIdentifier:cellId];
    if (!cell) {
        cell = [[UITableViewCell alloc]initWithStyle:UITableViewCellStyleValue1 reuseIdentifier:cellId];
        cell.accessoryType = UITableViewCellAccessoryNone;
        cell.textLabel.font = [UIFont systemFontOfSize:17];
        cell.detailTextLabel.font = [UIFont systemFontOfSize:15];
    }
    FBPeople *model =arr_person[indexPath.row];
    cell.textLabel.text =model.name;
    cell.detailTextLabel.text =model.number;
    return cell;
}

#pragma  mark - 表的协议代理
-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    if ([self.delegate respondsToSelector:@selector(contactName:phone:)]) {
        FBPeople *model =arr_person[indexPath.row];
        [self.delegate contactName:model.name phone:model.number];
    }
    [self.navigationController popViewControllerAnimated:NO];
}




@end
