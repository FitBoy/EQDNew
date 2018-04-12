//
//  RSCW_baoXiaoAddViewController.m
//  EQD
//
//  Created by 梁新帅 on 2018/3/19.
//  Copyright © 2018年 FitBoy. All rights reserved.
//

#import "RSCW_baoXiaoAddViewController.h"
#import "EQDR_labelTableViewCell.h"
#import "FBPeople.h"
#import <Masonry.h>
#import "FBTextFieldViewController.h"
#import "DAYaoQingViewController.h"
#import "FBButton.h"
#import <YYText.h>
@interface RSCW_baoXiaoAddViewController ()<UITableViewDataSource,UITableViewDelegate,FBTextFieldViewControllerDelegate,DAYaoQingViewControllerDelegate>
{
    UITableView *tableV;
    NSMutableArray *arr_model;
    UserModel *user;
    
}

@end

@implementation RSCW_baoXiaoAddViewController
#pragma  mark -   点击金额
-(void)content:(NSString *)content WithindexPath:(NSIndexPath *)indexPath
{
    FBPeople *model =arr_model[indexPath.row];
    model.number = content;
    [tableV reloadRowsAtIndexPaths:@[indexPath] withRowAnimation:UITableViewRowAnimationNone];
    
}
#pragma  mark - 点击报销人
-(void)getGangWeiModel:(GangweiModel *)model_gangwei indexPath:(NSIndexPath *)indexPath
{
    FBPeople  *model =arr_model[indexPath.row];
    model.name = model_gangwei.name;
    model.user = model_gangwei.ID;
    [tableV reloadRowsAtIndexPaths:@[indexPath] withRowAnimation:UITableViewRowAnimationNone];
}
/*
 phone 是金额的最小
number 是金额的最大
 name  是选择的职位名字
 user 是postid
 */
- (void)viewDidLoad {
    [super viewDidLoad];
    self.navigationItem.title = @"报销人与金额的设置";
    user = [WebRequest GetUserInfo];
    arr_model = [NSMutableArray arrayWithCapacity:0];
    FBPeople  *P = [[FBPeople alloc]init];
    P.number = @"100";
    P.phone = @"0";
    P.name = @"请选择";
    P.cellHeight = 60;
    [arr_model addObject:P];
    tableV = [[UITableView alloc]initWithFrame:CGRectMake(0, DEVICE_TABBAR_Height, DEVICE_WIDTH, DEVICE_HEIGHT-DEVICE_TABBAR_Height-kBottomSafeHeight) style:UITableViewStylePlain];
    adjustsScrollViewInsets_NO(tableV, self);
    tableV.delegate=self;
    tableV.dataSource=self;
    [self.view addSubview:tableV];
    tableV.rowHeight=60;
    YYLabel *tylabel = [[YYLabel alloc]initWithFrame:CGRectMake(0, 0, DEVICE_WIDTH, 40)];
    NSMutableAttributedString  *name = [[NSMutableAttributedString alloc]initWithString:@"+增加报销设置" attributes:@{NSFontAttributeName:[UIFont systemFontOfSize:18]}];
    [name yy_setTextHighlightRange:name.yy_rangeOfAll color:EQDCOLOR backgroundColor:[UIColor whiteColor] tapAction:^(UIView * _Nonnull containerView, NSAttributedString * _Nonnull text, NSRange range, CGRect rect) {
        [self addClick];
    }];
    name.yy_alignment = NSTextAlignmentCenter;
    tylabel.attributedText = name;
    tableV.tableFooterView =tylabel;
    UIBarButtonItem *right = [[UIBarButtonItem alloc]initWithTitle:@"完成" style:UIBarButtonItemStylePlain target:self action:@selector(quedingClick)];
    [self.navigationItem setRightBarButtonItem:right];
}
-(void)quedingClick{
    NSInteger temp = 0;
    NSMutableArray *tarr = [NSMutableArray arrayWithCapacity:0];
    for (int i=0; i<arr_model.count; i++) {
        FBPeople *model =arr_model[i];
        
        if (model.user==nil) {
            temp=1;
            break;
        }else
        {
            NSDictionary *dic = @{
                                  @"minMoney":model.phone,
                                  @"maxMoney":model.number,
                                  @"postId":model.user
                                  };
            [tarr addObject:dic];
        }
    }
   // [{"minMoney":1,"maxMoney":100,"postId":105},{"minMoney":101,"maxMoney":300,"postId":103}]
   NSData *data =  [NSJSONSerialization dataWithJSONObject:tarr options:NSJSONWritingPrettyPrinted error:nil];
    NSString *Tstr = [[NSString alloc]initWithData:data encoding:NSUTF8StringEncoding];
    
    if (temp==0) {
        MBProgressHUD *hud = [MBProgressHUD showHUDAddedTo:self.view animated:YES];
        hud.mode = MBProgressHUDModeAnnularDeterminate;
        hud.label.text = @"正在设置";
        [WebRequest SetUp_Reimburse_Add_ReimburseCheckerWithuserGuid:user.Guid companyId:user.companyId parameter:Tstr And:^(NSDictionary *dic) {
            hud.label.text =dic[Y_MSG];
            dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(0.7 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
                [hud hideAnimated:NO];
                if ([dic[Y_STATUS] integerValue]==200) {
                    [self.navigationController popViewControllerAnimated:NO];
                }
            });
            
        }];
    }else
    {
        MBProgressHUD *hud=[MBProgressHUD showHUDAddedTo:self.view  animated:YES];
        hud.mode = MBProgressHUDModeText;
        hud.label.text =@"请把报销人填写完";
        dispatch_time_t popTime = dispatch_time(DISPATCH_TIME_NOW, 1 * NSEC_PER_SEC);
        dispatch_after(popTime, dispatch_get_main_queue(), ^(void){
            [MBProgressHUD hideHUDForView:self.view  animated:YES];
        });
    }
    
}
-(void)addClick
{
    FBPeople *model = arr_model[arr_model.count-1];
    FBPeople  *model2 = [[FBPeople alloc]init];
    model2.phone =[NSString stringWithFormat:@"%ld",[model.number integerValue]+1];
    model2.number =[NSString stringWithFormat:@"%ld",[model.number integerValue]+1000];
    model2.name = @"请选择";
    model2.cellHeight =60;
    [arr_model addObject:model2];
    [tableV reloadData];
}
-(BOOL)tableView:(UITableView *)tableView canEditRowAtIndexPath:(NSIndexPath *)indexPath
{
    return YES;
}
-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    FBPeople *model =arr_model[indexPath.row];
    return model.cellHeight;
}
-(UITableViewCellEditingStyle)tableView:(UITableView *)tableView editingStyleForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return UITableViewCellEditingStyleDelete;
    
}
-(void)tableView:(UITableView *)tableView commitEditingStyle:(UITableViewCellEditingStyle)editingStyle forRowAtIndexPath:(NSIndexPath *)indexPath
{
    
    if (editingStyle == UITableViewCellEditingStyleDelete) {
        //删除
        if(indexPath.row == arr_model.count-1)
        {
        [arr_model removeObjectAtIndex:indexPath.row];
        [tableV reloadData];
        }else
        {
            MBProgressHUD *hud=[MBProgressHUD showHUDAddedTo:self.view  animated:YES];
            hud.mode = MBProgressHUDModeText;
            hud.label.text =@"只能删除最后一个";
            dispatch_time_t popTime = dispatch_time(DISPATCH_TIME_NOW, 1 * NSEC_PER_SEC);
            dispatch_after(popTime, dispatch_get_main_queue(), ^(void){
                [MBProgressHUD hideHUDForView:self.view  animated:YES];
            });
        }
    }
}

-(NSString*)tableView:(UITableView *)tableView titleForDeleteConfirmationButtonForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return @"删除";
}

#pragma  mark - 表的数据源

-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return arr_model.count;
}
-(UITableViewCell*)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    static NSString *cellId=@"cellID";
    EQDR_labelTableViewCell *cell =[tableView dequeueReusableCellWithIdentifier:cellId];
    if (!cell) {
        cell = [[EQDR_labelTableViewCell alloc]initWithStyle:UITableViewCellStyleDefault reuseIdentifier:cellId];
    }
    FBPeople *model = arr_model[indexPath.row];
    NSMutableAttributedString  *name = [[NSMutableAttributedString alloc]initWithString:[NSString stringWithFormat:@"金额范围(元)：%@ —— ",model.phone] attributes:@{NSFontAttributeName:[UIFont systemFontOfSize:17],NSForegroundColorAttributeName:[UIColor grayColor]}];
    NSMutableAttributedString *money = [[NSMutableAttributedString alloc]initWithString:[NSString stringWithFormat:@"%@",model.number] attributes:@{NSFontAttributeName:[UIFont systemFontOfSize:18]}];
    [money yy_setTextHighlightRange:money.yy_rangeOfAll color:EQDCOLOR backgroundColor:[UIColor whiteColor] tapAction:^(UIView * _Nonnull containerView, NSAttributedString * _Nonnull text, NSRange range, CGRect rect) {
        if (indexPath.row==arr_model.count-1) {
            FBTextFieldViewController *TFvc =[[FBTextFieldViewController alloc]init];
            TFvc.delegate =self;
            TFvc.indexPath =indexPath;
            TFvc.content =model.number;
            TFvc.contentTitle =@"最大金额/元";
            [self.navigationController pushViewController:TFvc animated:NO];
        }else
        {
            MBProgressHUD *hud=[MBProgressHUD showHUDAddedTo:self.view  animated:YES];
            hud.mode = MBProgressHUDModeText;
            hud.label.text =@"只能修改最后一个";
            dispatch_time_t popTime = dispatch_time(DISPATCH_TIME_NOW, 1 * NSEC_PER_SEC);
            dispatch_after(popTime, dispatch_get_main_queue(), ^(void){
                [MBProgressHUD hideHUDForView:self.view  animated:YES];
            });
        }
        
    }];
    [name appendAttributedString:money];
    
    NSMutableAttributedString *post = [[NSMutableAttributedString alloc]initWithString:@"\n最终报销审核人:" attributes:@{NSFontAttributeName:[UIFont systemFontOfSize:17],NSForegroundColorAttributeName:[UIColor grayColor]}];
    [name appendAttributedString:post];
    NSMutableAttributedString *people = [[NSMutableAttributedString alloc]initWithString:[NSString stringWithFormat:@"%@",model.name] attributes:@{NSFontAttributeName:[UIFont systemFontOfSize:17]}];
    people.yy_alignment  = NSTextAlignmentRight;
    [people yy_setTextHighlightRange:people.yy_rangeOfAll color:EQDCOLOR backgroundColor:[UIColor whiteColor] tapAction:^(UIView * _Nonnull containerView, NSAttributedString * _Nonnull text, NSRange range, CGRect rect) {
        DAYaoQingViewController *YQvc =[[DAYaoQingViewController alloc]init];
        YQvc.delegate =self;
        YQvc.indexPath = indexPath;
        [self.navigationController pushViewController:YQvc animated:NO];
    }];
    [name appendAttributedString:people];
    name.yy_lineSpacing = 6;
    cell.YL_label.attributedText = name;
    CGSize size = [name boundingRectWithSize:CGSizeMake(DEVICE_WIDTH-30, MAXFLOAT) options:NSStringDrawingUsesLineFragmentOrigin context:nil].size;
    model.cellHeight = size.height+20;
    [cell.YL_label mas_makeConstraints:^(MASConstraintMaker *make) {
        make.height.mas_equalTo(size.height+20);
        make.left.mas_equalTo(cell.mas_left).mas_offset(15);
        make.right.mas_equalTo(cell.mas_right).mas_offset(-15);
        make.centerY.mas_equalTo(cell.mas_centerY);
    }];
    
    return cell;
}

#pragma  mark - 表的协议代理
-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    
}




@end
