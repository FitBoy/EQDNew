//
//  FBRight_showViewController.m
//  EQD
//
//  Created by 梁新帅 on 2018/4/8.
//  Copyright © 2018年 FitBoy. All rights reserved.
//
// 状态栏和导航栏总高度
#define YYISiPhoneX  [[UIScreen mainScreen] bounds].size.width >=375.0f && [[UIScreen mainScreen] bounds].size.height >=812.0f&& YYIS_IPHONE
#define YYIS_IPHONE (UI_USER_INTERFACE_IDIOM() == UIUserInterfaceIdiomPhone)
#define kNavBarHAbove7  (CGFloat)(YYISiPhoneX?(88):(64))
#define DEVICE_HEIGHT  [UIScreen mainScreen].bounds.size.height
#define DEVICE_WIDTH   [UIScreen mainScreen].bounds.size.width
#import "FBRight_showViewController.h"

@interface FBRight_showViewController ()<UITableViewDelegate,UITableViewDataSource>

{
    UITableView  *tableV;
}

@end

@implementation FBRight_showViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    tableV = [[UITableView alloc]initWithFrame:CGRectMake(DEVICE_WIDTH*0.5-20,kNavBarHAbove7, DEVICE_WIDTH*0.5, 50*self.arr_names.count) style:UITableViewStylePlain];
    tableV.delegate =self;
    tableV.dataSource=self;
    [self.view addSubview:tableV];
    tableV.rowHeight=50;
    tableV.layer.masksToBounds = YES;
    tableV.layer.cornerRadius =6;
     self.view.backgroundColor = [[UIColor darkGrayColor] colorWithAlphaComponent:0.4];

}
#pragma  mark - 表的数据源
-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return self.arr_names.count;
}
-(UITableViewCell*)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    static NSString *cellId=@"cellID";
    UITableViewCell *cell =[tableView dequeueReusableCellWithIdentifier:cellId];
    if (!cell) {
        cell = [[UITableViewCell alloc]initWithStyle:UITableViewCellStyleDefault reuseIdentifier:cellId];
        cell.accessoryType = UITableViewCellAccessoryDisclosureIndicator;
        cell.textLabel.font = [UIFont systemFontOfSize:21];
        cell.textLabel.textAlignment = NSTextAlignmentCenter;
    }
    cell.textLabel.text = self.arr_names[indexPath.row];
    return cell;
}

#pragma  mark - 表的协议代理
-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
     [self dismissViewControllerAnimated:NO completion:nil];
    if ([self.delegate_right respondsToSelector:@selector(getSlectedindex:)]) {
        [self.delegate_right getSlectedindex:indexPath.row];
    }
}

-(void)touchesBegan:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event
{
    [self dismissViewControllerAnimated:NO completion:nil];
}


@end
