//
//  EQDR_JuBaoViewController.m
//  EQD
//
//  Created by 梁新帅 on 2017/12/28.
//  Copyright © 2017年 FitBoy. All rights reserved.
//
#define DEVICE_HEIGHT  [UIScreen mainScreen].bounds.size.height
#define DEVICE_WIDTH   [UIScreen mainScreen].bounds.size.width
#import "EQDR_JuBaoViewController.h"
#import "FBOneChooseTableViewCell.h"
#import "FBTextFieldTableViewCell.h"
#import "FBTwoButtonView.h"
#import "UITextField+Tool.h"
@interface EQDR_JuBaoViewController ()<UITableViewDelegate,UITableViewDataSource>
{
    UITableView *tableV;
    float height_table;
    NSMutableArray *arr_model;
    NSArray *arr_placeHoder;
    FBBaseModel *slectedModel;
}
@property (nonatomic,strong) UILabel *L_title;
@property (nonatomic,strong) FBTwoButtonView *TB_btn;

@end


@implementation EQDR_JuBaoViewController

-(UILabel*)L_title
{
    if (!_L_title) {
        _L_title = [[UILabel alloc]initWithFrame:CGRectMake(0, 0, DEVICE_WIDTH*0.8, 40)];
        _L_title.text = @"请选择举报类型";
        _L_title.font = [UIFont systemFontOfSize:16];
        _L_title.textAlignment = NSTextAlignmentCenter;
        _L_title.textColor = [UIColor orangeColor];
    }
    return _L_title;
}
-(FBTwoButtonView*)TB_btn
{
    if (!_TB_btn) {
        _TB_btn = [[FBTwoButtonView alloc]initWithFrame:CGRectMake(0, 0, DEVICE_WIDTH*0.8, 50)];
        [_TB_btn setleftname:@"取消" rightname:@"确定"];
        [_TB_btn.B_left addTarget:self action:@selector(leftClick) forControlEvents:UIControlEventTouchUpInside];
        [_TB_btn.B_right addTarget:self action:@selector(rightClick) forControlEvents:UIControlEventTouchUpInside];
        
    }
    return _TB_btn;
}
-(void)leftClick
{
    [self dismissViewControllerAnimated:NO completion:nil];
}
-(void)rightClick
{
    //确定
    FBTextFieldTableViewCell *cell = [tableV cellForRowAtIndexPath:[NSIndexPath indexPathForRow:arr_model.count inSection:0]];
    if ([self.delegate respondsToSelector:@selector(getJuBaoType:text:)]) {
        [self.delegate getJuBaoType:slectedModel.left0 text:cell.TF_text.text];
    }
    
    [self dismissViewControllerAnimated:NO completion:nil];
}
- (void)viewDidLoad {
    [super viewDidLoad];
    arr_model = [NSMutableArray arrayWithCapacity:0];
    FBBaseModel  *model0 = [[FBBaseModel alloc]init];
    model0.ischoose =YES;
    model0.left0 = @"广告或垃圾信息";
    [arr_model addObject:model0];
    slectedModel = model0;
    if (self.type==0) {
        FBBaseModel *model1 = [[FBBaseModel alloc]init];
        model1.ischoose =NO;
        model1.left0 =@"抄袭或转载";
        [arr_model addObject:model1];
        arr_placeHoder = @[@"请输入举报原因",@"请输入举报原因和原文链接",@"请输入举报原因"];
    }else
    {
         arr_placeHoder = @[@"请输入举报原因",@"请输入举报原因"];
    }
    FBBaseModel *model2 =[[FBBaseModel alloc]init];
    model2.ischoose =NO;
    model2.left0 = @"其他";
    [arr_model addObject:model2];
    self.providesPresentationContextTransitionStyle = YES;
    self.definesPresentationContext = YES;
    self.modalPresentationStyle = UIModalPresentationOverCurrentContext;
    
    height_table =self.type==0? 60*4+90:60*3+90;
    tableV = [[UITableView alloc]initWithFrame:CGRectMake(DEVICE_WIDTH*0.1, (DEVICE_HEIGHT-height_table)/2.0, DEVICE_WIDTH*0.8, height_table) style:UITableViewStylePlain];
    tableV.delegate=self;
    tableV.dataSource=self;
    [self.view addSubview:tableV];
    tableV.layer.masksToBounds =YES;
    tableV.layer.cornerRadius =6;
    tableV.rowHeight=60;
     self.view.backgroundColor = [[UIColor darkGrayColor] colorWithAlphaComponent:0.4];
    
    NSNotificationCenter *center = [NSNotificationCenter defaultCenter];
    // 键盘将出现事件监听
    [center addObserver:self selector:@selector(keyboardWillShow:)
                   name:UIKeyboardWillShowNotification
                 object:nil];
    // 键盘将隐藏事件监听
    [center addObserver:self selector:@selector(keyboardWillHide:)
                   name:UIKeyboardWillHideNotification
                 object:nil];
  
    
    
}
-(CGFloat)tableView:(UITableView *)tableView heightForFooterInSection:(NSInteger)section
{
    return 50;
}
-(CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section
{
    return 40;
}
//当键盘出现
- (void)keyboardWillShow:(NSNotification *)notification
{
    //获取键盘的高度
    NSDictionary *userInfo = [notification userInfo];
    NSValue *value = [userInfo objectForKey:UIKeyboardFrameEndUserInfoKey];
    CGRect keyboardRect = [value CGRectValue];
    int height = keyboardRect.size.height;
    CGRect  rect =tableV.frame;
    rect.origin.y = DEVICE_HEIGHT-height_table-height;
    tableV.frame =rect;
    
}

//当键退出
- (void)keyboardWillHide:(NSNotification *)notification
{
    tableV.frame =CGRectMake(DEVICE_WIDTH*0.1, (DEVICE_HEIGHT-height_table)/2.0, DEVICE_WIDTH*0.8, height_table);
}
#pragma  mark - 表的数据源
-(UIView*)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section
{
    return self.L_title;
}
-(UIView*)tableView:(UITableView *)tableView viewForFooterInSection:(NSInteger)section
{
    return self.TB_btn;
}
-(void)touchesBegan:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event
{
    [self dismissViewControllerAnimated:NO completion:nil];
}
-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return arr_model.count+1;
}
-(UITableViewCell*)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    if (indexPath.row==arr_model.count) {
        static NSString *cellId=@"cellID1";
        FBTextFieldTableViewCell *cell =[tableView dequeueReusableCellWithIdentifier:cellId];
        if (!cell) {
            cell = [[FBTextFieldTableViewCell alloc]initWithStyle:UITableViewCellStyleDefault reuseIdentifier:cellId];
            cell.accessoryType = UITableViewCellAccessoryNone;
            cell.selectionStyle = UITableViewCellSelectionStyleNone;
        }
        cell.TF_text.placeholder = arr_placeHoder[0];
        [cell.TF_text setTextFieldInputAccessoryView];
        [cell.TF_text becomeFirstResponder];
        return cell;
    }else
    {
        static NSString *cellId=@"cellID0";
        FBOneChooseTableViewCell *cell =[tableView dequeueReusableCellWithIdentifier:cellId];
        if (!cell) {
            cell = [[FBOneChooseTableViewCell alloc]initWithStyle:UITableViewCellStyleDefault reuseIdentifier:cellId];
            cell.accessoryType = UITableViewCellAccessoryNone;
            cell.selectionStyle = UITableViewCellSelectionStyleNone;
        }
        FBBaseModel *model =arr_model[indexPath.row];
        [cell setModel:model];
        cell.L_left0.textColor = [UIColor grayColor];
        return cell;
    }
    
}

#pragma  mark - 表的协议代理
-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    if (indexPath.row<arr_model.count) {
        FBBaseModel *model =arr_model[indexPath.row];
        slectedModel.ischoose =NO;
        model.ischoose =YES;
        slectedModel =model;
        [tableV reloadData];
        FBTextFieldTableViewCell *cell = [tableV cellForRowAtIndexPath:[NSIndexPath indexPathForRow:arr_model.count inSection:0]];
        cell.TF_text.placeholder =arr_placeHoder[indexPath.row];
    }
}



@end
