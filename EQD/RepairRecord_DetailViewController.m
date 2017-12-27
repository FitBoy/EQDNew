//
//  RepairRecord_DetailViewController.m
//  EQD
//
//  Created by 梁新帅 on 2017/12/5.
//  Copyright © 2017年 FitBoy. All rights reserved.
//

#import "RepairRecord_DetailViewController.h"
#import "FBShowImg_TextViewController.h"
#import "FBTextFieldViewController.h"
@interface RepairRecord_DetailViewController ()<UITableViewDelegate,UITableViewDataSource>
{
    UITableView *tableV;
}


@end

@implementation RepairRecord_DetailViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.navigationItem.title =@"详情";
    tableV = [[UITableView alloc]initWithFrame:CGRectMake(0, DEVICE_TABBAR_Height, DEVICE_WIDTH, DEVICE_HEIGHT-DEVICE_TABBAR_Height) style:UITableViewStylePlain];
    adjustsScrollViewInsets_NO(tableV, self);
    tableV.delegate=self;
    tableV.dataSource=self;
    [self.view addSubview:tableV];
    tableV.rowHeight=60;
   


}
#pragma  mark - 表的数据源
-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return self.arr_json.count;
}
-(UITableViewCell*)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    static NSString *cellId=@"cellID";
    UITableViewCell *cell =[tableView dequeueReusableCellWithIdentifier:cellId];
    if (!cell) {
        cell = [[UITableViewCell alloc]initWithStyle:UITableViewCellStyleValue1 reuseIdentifier:cellId];
        cell.accessoryType = UITableViewCellAccessoryNone;
        cell.detailTextLabel.font = [UIFont systemFontOfSize:15];
        cell.textLabel.font = [UIFont systemFontOfSize:17];
    }
    GNmodel  *model =_arr_json[indexPath.row];
    cell.textLabel.text =model.name;
    cell.detailTextLabel.text =model.content;
    return cell;
}

#pragma  mark - 表的协议代理
-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
  GNmodel  *model =_arr_json[indexPath.row];
    if(model.biaoji==3)
    {
        FBShowImg_TextViewController  *Svc =[[FBShowImg_TextViewController alloc]init];
        Svc.arr_imgs = model.arr_imgs;
        Svc.contents =model.content;
        Svc.contentTitle =model.name;
        [self.navigationController pushViewController:Svc animated:NO];
    }else if (model.biaoji==1)
    {
        FBTextFieldViewController  *tfvc =[[FBTextFieldViewController alloc]init];
        tfvc.contentTitle =model.name;
        tfvc.content =model.content;
        [self.navigationController pushViewController:tfvc animated:NO];
    }
}




@end
