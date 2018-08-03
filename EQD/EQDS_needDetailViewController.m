//
//  EQDS_needDetailViewController.m
//  EQD
//
//  Created by 梁新帅 on 2018/3/10.
//  Copyright © 2018年 FitBoy. All rights reserved.
//

#import "EQDS_needDetailViewController.h"
#import "EQDR_labelTableViewCell.h"
#import <Masonry.h>
#import "FBButton.h"
@interface EQDS_needDetailViewController ()<UITableViewDelegate,UITableViewDataSource>
{
    UITableView *tableV;
    NSArray *arr_titles;
    NSMutableArray *arr_height;
    UserModel *user;
}

@end

@implementation EQDS_needDetailViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    user = [WebRequest GetUserInfo];
    self.navigationItem.title = @"培训需求详情";
    arr_titles = @[@"培训需求",@"基本情况",@"要求说明"];
    arr_height = [NSMutableArray arrayWithArray:@[@"60",@"60",@"60"]];
    tableV = [[UITableView alloc]initWithFrame:CGRectMake(0, DEVICE_TABBAR_Height, DEVICE_WIDTH, DEVICE_HEIGHT-DEVICE_TABBAR_Height-kBottomSafeHeight) style:UITableViewStyleGrouped];
    adjustsScrollViewInsets_NO(tableV, self);
    tableV.delegate=self;
    tableV.dataSource=self;
    [self.view addSubview:tableV];
    tableV.rowHeight=60;
    tableV.contentInset = UIEdgeInsetsMake(15, 0, 0, 0);
    UIBarButtonItem *right = [[UIBarButtonItem alloc]initWithTitle:@"联系方式" style:UIBarButtonItemStylePlain target:self action:@selector(tbtnClick)];
    [self.navigationItem setRightBarButtonItem:right];

}
#pragma  mark - 表的数据源
-(CGFloat)tableView:(UITableView *)tableView heightForFooterInSection:(NSInteger)section
{
    if (section==2) {
        return 50;
    }else
    {
        return 0;
    }
}
#pragma  mark - 按钮的点击事件
-(void)tbtnClick
{
    
    [WebRequest Training_Get_TrainDemandCTWWithuserGuid:user.Guid tdid:_model.Id And:^(NSDictionary *dic) {
       
        if ([dic[Y_STATUS] integerValue]==200) {
            NSDictionary *tdic = dic[Y_ITEMS];
            UIAlertController *alert = [UIAlertController alertControllerWithTitle:nil message:[NSString stringWithFormat:@"负责人:%@\n 手机：%@\n固话：%@\nqq:%@\n 联系地址:%@",tdic[@"contactsName"],tdic[@"handset"],tdic[@"phone"],tdic[@"qq"],_model.theplace] preferredStyle:UIAlertControllerStyleAlert];
            [alert addAction:[UIAlertAction actionWithTitle:@"取消" style:UIAlertActionStyleCancel handler:^(UIAlertAction * _Nonnull action) {
                
            }]];
            [alert addAction:[UIAlertAction actionWithTitle:@"联系需求方" style:UIAlertActionStyleDefault handler:^(UIAlertAction * _Nonnull action) {
                NSMutableString *str = [[NSMutableString alloc] initWithFormat:@"tel:%@",tdic[@"handset"]];
                UIWebView *callWebView = [[UIWebView alloc] init];
                [callWebView loadRequest:[NSURLRequest requestWithURL:[NSURL URLWithString:str]]];
                [self.view addSubview:callWebView];
            }]];
            dispatch_async(dispatch_get_main_queue(), ^{
                [self presentViewController:alert animated:NO completion:nil];
            });
        }else
        {
            MBProgressHUD *hud=[MBProgressHUD showHUDAddedTo:self.view  animated:YES];
            hud.mode = MBProgressHUDModeText;
            hud.label.text =@"您没有权限查看";
            dispatch_time_t popTime = dispatch_time(DISPATCH_TIME_NOW, 1 * NSEC_PER_SEC);
            dispatch_after(popTime, dispatch_get_main_queue(), ^(void){
                [MBProgressHUD hideHUDForView:self.view  animated:YES];
            });
        }
    }];
}
-(UIView*)tableView:(UITableView *)tableView viewForFooterInSection:(NSInteger)section
{
    if (section==2) {
        FBButton *tbtn = [FBButton buttonWithType:UIButtonTypeSystem];
        [tbtn setTitle:@"查看需求方联系方式" titleColor:[UIColor whiteColor] backgroundColor:EQDCOLOR  font:[UIFont systemFontOfSize:21]];
        [tbtn addTarget:self action:@selector(tbtnClick) forControlEvents:UIControlEventTouchUpInside];
        return tbtn;
    }else
    {
        return nil;
    }
}
-(NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return 3;
}
-(NSString*)tableView:(UITableView *)tableView titleForHeaderInSection:(NSInteger)section
{
    
    return arr_titles[section];
}
-(CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section
{
    return 25;
}
-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return [arr_height[indexPath.section] integerValue];
}
-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return 1;
}
-(UITableViewCell*)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    static NSString *cellId=@"cellID";
    EQDR_labelTableViewCell *cell =[tableView dequeueReusableCellWithIdentifier:cellId];
    if (!cell) {
        cell = [[EQDR_labelTableViewCell alloc]initWithStyle:UITableViewCellStyleDefault reuseIdentifier:cellId];
        cell.accessoryType = UITableViewCellAccessoryNone;
    }
    if (indexPath.section==0) {
        NSMutableAttributedString *thehteme = [[NSMutableAttributedString alloc]initWithString:_model.theTheme attributes:@{NSFontAttributeName:[UIFont systemFontOfSize:18]}];
        
        NSMutableAttributedString *type = [[NSMutableAttributedString alloc]initWithString:@"\n"];
        NSArray *tarr = [_model.theCategory componentsSeparatedByString:@","];
        for (int i=0; i<tarr.count; i++) {
            NSMutableAttributedString *ttype =[[NSMutableAttributedString alloc]initWithString:[NSString stringWithFormat:@" %@ ",tarr[i]] attributes:@{NSFontAttributeName:[UIFont systemFontOfSize:13],NSForegroundColorAttributeName:[UIColor orangeColor]}];
            [ttype yy_setTextBackgroundBorder:[YYTextBorder borderWithLineStyle:YYTextLineStyleSingle lineWidth:1 strokeColor:[UIColor orangeColor]] range:ttype.yy_rangeOfAll];
            [type appendAttributedString:ttype];
            NSMutableAttributedString *kong = [[NSMutableAttributedString alloc]initWithString:@"   "];
            [type appendAttributedString:kong];
        }
        type.yy_alignment = NSTextAlignmentCenter;
        [thehteme appendAttributedString:type];
    thehteme.yy_lineSpacing =6;
        CGSize size = [thehteme boundingRectWithSize:CGSizeMake(DEVICE_WIDTH-30, MAXFLOAT) options:NSStringDrawingUsesLineFragmentOrigin context:nil].size;
        
        [arr_height  replaceObjectAtIndex:0 withObject:[NSString stringWithFormat:@"%f",size.height+10]];
        cell.YL_label.attributedText = thehteme;
        [cell.YL_label mas_remakeConstraints:^(MASConstraintMaker *make) {
            make.height.mas_equalTo(size.height+10);
            make.left.mas_equalTo(cell.mas_left).mas_offset(15);;
            make.right.mas_equalTo(cell.mas_right).mas_offset(-15);
            make.centerY.mas_equalTo(cell.mas_centerY);
        }];
        
        
        
    }else if (indexPath.section==1)
    {
        
        NSMutableAttributedString *key = [[NSMutableAttributedString alloc]initWithString:[NSString stringWithFormat:@"\n关键字：%@\n预算：",_model.keywords] attributes:@{NSFontAttributeName:[UIFont systemFontOfSize:15]}];
        NSMutableAttributedString *money = [[NSMutableAttributedString alloc]initWithString:[NSString stringWithFormat:@"%@元",_model.budgetedExpense] attributes:@{NSFontAttributeName:[UIFont systemFontOfSize:15],NSForegroundColorAttributeName:[UIColor redColor]}];
        [key  appendAttributedString:money];
        NSMutableAttributedString  *NTime =[[NSMutableAttributedString alloc]initWithString:[NSString stringWithFormat:@"\n预计培训日期：%@ ~ %@\n发布日期:%@",_model.thedateStart,_model.thedateEnd,_model.createTime] attributes:@{NSFontAttributeName:[UIFont systemFontOfSize:13],NSForegroundColorAttributeName:[UIColor grayColor]}];
        [key appendAttributedString:NTime];
        key.yy_lineSpacing = 6;
        CGSize size = [key boundingRectWithSize:CGSizeMake(DEVICE_WIDTH-30, MAXFLOAT) options:NSStringDrawingUsesLineFragmentOrigin context:nil].size;
        cell.YL_label.attributedText = key;
        [arr_height replaceObjectAtIndex:1 withObject:[NSString stringWithFormat:@"%f",size.height+10]];
        [cell.YL_label mas_remakeConstraints:^(MASConstraintMaker *make) {
            make.height.mas_equalTo(size.height+10);
            make.left.mas_equalTo(cell.mas_left).mas_offset(15);
            make.right.mas_equalTo(cell.mas_right).mas_offset(-15);
            make.centerY.mas_equalTo(cell.mas_centerY);
        }];
        
        
    }else
    {
        NSMutableAttributedString *OtherMand = [[NSMutableAttributedString alloc]initWithString:[NSString stringWithFormat:@"%@",_model.otherDemand] attributes:@{NSFontAttributeName:[UIFont systemFontOfSize:15]}];
        OtherMand.yy_lineSpacing =6;
        CGSize  size = [OtherMand boundingRectWithSize:CGSizeMake(DEVICE_WIDTH-30, MAXFLOAT) options:NSStringDrawingUsesLineFragmentOrigin context:nil].size;
        [arr_height replaceObjectAtIndex:2 withObject:[NSString stringWithFormat:@"%f",size.height+10]];
        cell.YL_label.attributedText = OtherMand;
        [cell.YL_label mas_remakeConstraints:^(MASConstraintMaker *make) {
            make.height.mas_equalTo(size.height+10);
            make.left.mas_equalTo(cell.mas_left).mas_offset(15);
            make.right.mas_equalTo(cell.mas_right).mas_offset(-15);
            make.centerY.mas_equalTo(cell.mas_centerY);
        }];
        
        
    }
    return cell;
}

#pragma  mark - 表的协议代理
-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    
}




@end
