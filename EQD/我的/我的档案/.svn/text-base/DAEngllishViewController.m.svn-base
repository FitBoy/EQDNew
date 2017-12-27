//
//  DAEngllishViewController.m
//  EQD
//
//  Created by 梁新帅 on 2017/6/7.
//  Copyright © 2017年 FitBoy. All rights reserved.
//

#import "DAEngllishViewController.h"

@interface DAEngllishViewController ()<UITableViewDelegate,UITableViewDataSource>
{
    UITableView *tableV;
    NSMutableArray *arr_nameas;
    
}

@end

@implementation DAEngllishViewController

- (void)viewDidLoad {
    [super viewDidLoad];

    arr_nameas = [NSMutableArray arrayWithArray:@[@"PETS-1",@"PETS-2",@"PETS-3",@"PETS-4",@"PETS-5",@"大学英语二级",@"大学英语三级",@"成人英语三级",@"大学英语四级",@"大学英语六级",@"专业英语四级",@"专业英语八级",@"托福",@"雅思",@"GRE",@"其他"]];
    tableV = [[UITableView alloc]initWithFrame:CGRectMake(0, 0, DEVICE_WIDTH, DEVICE_HEIGHT) style:UITableViewStylePlain];
    tableV.delegate=self;
    tableV.dataSource=self;
    [self.view addSubview:tableV];
    tableV.rowHeight=40;
}
#pragma  mark - 表的数据源
-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return arr_nameas.count;
}
-(UITableViewCell*)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    static NSString *cellId=@"cellID";
    UITableViewCell *cell =[tableView dequeueReusableCellWithIdentifier:cellId];
    if (!cell) {
        cell = [[UITableViewCell alloc]initWithStyle:UITableViewCellStyleDefault reuseIdentifier:cellId];
        cell.accessoryType = UITableViewCellAccessoryNone;
    }
    cell.textLabel.text =arr_nameas[indexPath.row];
    cell.textLabel.font =[UIFont systemFontOfSize:21];
    return cell;
}

#pragma  mark - 表的协议代理
-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    
    if (indexPath.row<12) {
        
        if ([self.delegate respondsToSelector:@selector(english:indexPath:)]) {
            [self.delegate english:arr_nameas[indexPath.row] indexPath:self.indexPath];
            [self.navigationController popViewControllerAnimated:NO];
            
        }
    }
    else
    {
        
        UIAlertController *alert = [UIAlertController alertControllerWithTitle:nil message:[NSString stringWithFormat:@"请输入%@的说明",arr_nameas[indexPath.row]] preferredStyle:UIAlertControllerStyleAlert];
        [alert addTextFieldWithConfigurationHandler:^(UITextField * _Nonnull textField) {
            textField.placeholder =[NSString stringWithFormat:@"请输入%@的说明",arr_nameas[indexPath.row]];
            
        }];
        [alert addAction:[UIAlertAction actionWithTitle:@"取消" style:UIAlertActionStyleCancel handler:^(UIAlertAction * _Nonnull action) {
            
        }]];
        [alert addAction:[UIAlertAction actionWithTitle:@"确定" style:UIAlertActionStyleDefault handler:^(UIAlertAction * _Nonnull action) {
            
            if ([self.delegate respondsToSelector:@selector(english:indexPath:)]) {
                [self.delegate english:alert.textFields[0].text indexPath:self.indexPath];
                [self.navigationController popViewControllerAnimated:NO];
                
            }
            
        }]];
        
        [self presentViewController:alert animated:NO completion:nil];
        
        
    }
}



@end
