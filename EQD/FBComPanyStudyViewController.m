//
//  FBComPanyStudyViewController.m
//  EQD
//
//  Created by 梁新帅 on 2018/2/5.
//  Copyright © 2018年 FitBoy. All rights reserved.
//

#import "FBComPanyStudyViewController.h"

@interface FBComPanyStudyViewController ()<UITableViewDelegate,UITableViewDataSource>
{
    UITableView *tableV;
    NSArray  *arr_names;
}

@end

@implementation FBComPanyStudyViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.navigationItem.title = @"企业商学院";
    arr_names = @[@"入职培训课程库",@"岗位综合技能课程库",@"岗位技能进阶课程库",@"关键业务技能课程库",@"师资顾问库",@"内部资料库",@"现场培训",@"学习看板",@"易企学"];
    tableV = [[UITableView alloc]initWithFrame:CGRectMake(0, DEVICE_TABBAR_Height, DEVICE_WIDTH, DEVICE_HEIGHT-DEVICE_TABBAR_Height-kBottomSafeHeight) style:UITableViewStylePlain];
    adjustsScrollViewInsets_NO(tableV, self);
    tableV.delegate=self;
    tableV.dataSource=self;
    [self.view addSubview:tableV];
    tableV.rowHeight=55;
}
#pragma  mark - 表的数据源
-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return arr_names.count;
}
-(UITableViewCell*)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    static NSString *cellId=@"cellID";
    UITableViewCell *cell =[tableView dequeueReusableCellWithIdentifier:cellId];
    if (!cell) {
        cell = [[UITableViewCell alloc]initWithStyle:UITableViewCellStyleDefault reuseIdentifier:cellId];
        cell.accessoryType = UITableViewCellAccessoryDisclosureIndicator;
        cell.textLabel.font = [UIFont systemFontOfSize:18];
    }
    cell.textLabel.text = arr_names[indexPath.row];
    return cell;
}

#pragma  mark - 表的协议代理
-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    switch (indexPath.row) {
        case 0:
            {
             // 入职培训课程库
            }
            break;
        case 1:
        {
            //岗位综合技能课程库
        }
            break;
        case 2:
        {
            //岗位技能进阶课程库
        }
            break;
        case 3:
        {
            //关键业务技能课程库
        }
            break;
        case 4:
        {
            //师资顾问库
        }
            break;
        case 5:
        {
            // 内部资料库
        }
            break;
        case 6:
        {
            //现场培训
        }
            break;
        case 7:
        {
           //学习看板
        }
            break;
            
        case 8:
        {
            //易企学
        }
            break;
            
        default:
            break;
    }
}



@end
