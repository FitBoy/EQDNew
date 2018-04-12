//
//  FFMyExpenseDetailViewController.m
//  EQD
//
//  Created by 梁新帅 on 2018/3/21.
//  Copyright © 2018年 FitBoy. All rights reserved.
//

#import "FFMyExpenseDetailViewController.h"
#import "EQDR_labelTableViewCell.h"
#import "My_BaoXiaoModel.h"
#import <Masonry.h>
#import "ImgScrollTableViewCell.h"
#import "FBImgShowViewController.h"
#import "FBTwoButtonView.h"
#import "FB_OnlyForLiuYanViewController.h"
#import "ShenPiListModel.h"
@interface FFMyExpenseDetailViewController ()<UITableViewDelegate,UITableViewDataSource,FBImgsScrollViewDelegate,FB_OnlyForLiuYanViewControllerDlegate>
{
    UITableView *tableV;
    UserModel *user;
    My_BaoXiaoModel *model_detail;
    NSMutableDictionary *dic_height;
    NSMutableArray *arr_model;
}

@end

@implementation FFMyExpenseDetailViewController
#pragma  mark - 点击图片
-(void)getImgsScrollViewSelectedViewWithtag:(NSInteger)tag indexPath:(NSIndexPath*)indexPath
{
    FBImgShowViewController  *Svc = [[FBImgShowViewController alloc]init];
    BaoXiaoListDetailModel *model = model_detail.detailList[indexPath.section-1];
    Svc.imgstrs =model.billImageList;
    Svc.selected = tag;
    [self.navigationController pushViewController:Svc animated:NO];
}
-(void)viewWillAppear:(BOOL)animated{
    [super viewWillAppear:animated];
    [self loadRequestData];
}
-(void)loadRequestData{
    MBProgressHUD *hud = [MBProgressHUD showHUDAddedTo:self.view animated:YES];
    hud.mode = MBProgressHUDModeAnnularDeterminate;
    hud.label.text = @"正在加载";
    [WebRequest Reimburse_Get_Reimburse_ByIdWithreimburseId:self.Id userGuid:user.Guid And:^(NSDictionary *dic) {
        [hud hideAnimated:NO];
        if ([dic[Y_STATUS] integerValue]==200) {
            model_detail  = [My_BaoXiaoModel mj_objectWithKeyValues:dic[Y_ITEMS]];
            [tableV reloadData];
        }else
        {
            [self.navigationController popViewControllerAnimated:NO];
        }
    }];
    
    [WebRequest Reimburse_Get_Reimburse_CheckWithremiburseId:self.Id userGuid:user.Guid And:^(NSDictionary *dic) {
        if ([dic[Y_STATUS] integerValue]==200) {
            NSArray *tarr = dic[Y_ITEMS];
            [arr_model removeAllObjects];
            for (int i=0; i<tarr.count; i++) {
                ShenPiListModel *model = [ShenPiListModel mj_objectWithKeyValues:tarr[i]];
                model.cellHeight=60;
                [arr_model addObject:model];
            }
            [tableV reloadData];
        }
    }];
}
- (BOOL)prefersHomeIndicatorAutoHidden{
    return NO;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    arr_model = [NSMutableArray arrayWithCapacity:0];
    self.navigationItem.title = @"详情";
    dic_height = [NSMutableDictionary dictionaryWithCapacity:0];
    user = [WebRequest GetUserInfo];
    tableV = [[UITableView alloc]initWithFrame:CGRectMake(0, DEVICE_TABBAR_Height, DEVICE_WIDTH, DEVICE_HEIGHT-DEVICE_TABBAR_Height-kBottomSafeHeight) style:UITableViewStyleGrouped];
    adjustsScrollViewInsets_NO(tableV, self);
    tableV.delegate=self;
    tableV.dataSource=self;
    [self.view addSubview:tableV];
    tableV.rowHeight=60;
    if ([self.isShow integerValue]==2) {
        //审批
        FBTwoButtonView *TBv = [[FBTwoButtonView alloc]initWithFrame:CGRectMake(0, 0, DEVICE_WIDTH, 50)];
        [TBv setleftname:@"驳回" rightname:@"同意"];
        [TBv.B_left addTarget:self action:@selector(leftClcik) forControlEvents:UIControlEventTouchUpInside];
        [TBv.B_right addTarget:self action:@selector(rigthCLcik) forControlEvents:UIControlEventTouchUpInside];
        tableV.tableFooterView = TBv;
    }
    
    
}
#pragma  mark - 驳回
-(void)getPresnetText:(NSString *)text
{
    MBProgressHUD *hud = [MBProgressHUD showHUDAddedTo:self.view animated:YES];
    hud.mode = MBProgressHUDModeAnnularDeterminate;
    hud.label.text = @"正在驳回";
    [WebRequest Reimburse_Check_ReimburseWithuserGuid:user.Guid remiburseId:self.Id message:text type:@"2" And:^(NSDictionary *dic) {
        hud.label.text = dic[Y_MSG];
        dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(0.7 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
            [hud hideAnimated:NO];
            if ([dic[Y_STATUS] integerValue]==200) {
                [self.navigationController popViewControllerAnimated:NO];
            }
        });
    }];
}
-(void)leftClcik{
   //驳回
    
    FB_OnlyForLiuYanViewController *LYvc =[[FB_OnlyForLiuYanViewController alloc]init];
    LYvc.btnName = @"驳回";
    LYvc.delegate =self;
    LYvc.placeHolder = @"请输入驳回理由";
    LYvc.providesPresentationContextTransitionStyle = YES;
    LYvc.definesPresentationContext = YES;
    LYvc.modalPresentationStyle = UIModalPresentationOverCurrentContext;
    [self presentViewController:LYvc animated:NO completion:nil];
}
-(void)rigthCLcik{
    //同意
    MBProgressHUD *hud = [MBProgressHUD showHUDAddedTo:self.view animated:YES];
    hud.mode = MBProgressHUDModeAnnularDeterminate;
    hud.label.text = @"正在同意";
    [WebRequest Reimburse_Check_ReimburseWithuserGuid:user.Guid remiburseId:self.Id message:@" " type:@"1" And:^(NSDictionary *dic) {
        hud.label.text = dic[Y_MSG];
        dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(0.7 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
            [hud hideAnimated:NO];
            if ([dic[Y_STATUS] integerValue]==200) {
                [self.navigationController popViewControllerAnimated:NO];
            }
        });
    }];
    
    
}
#pragma  mark - 表的数据源

-(CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section
{
    return 20;
}
-(NSString*)tableView:(UITableView *)tableView titleForHeaderInSection:(NSInteger)section
{
    if(section==0)
    {
        return nil;
    }else if (section == [model_detail.detailCount integerValue]+1)
    {
        return @"审批";
    }
    else
    {
    return [NSString stringWithFormat:@"报销明细%ld",section];
    }
}
-(NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    if (model_detail) {
        return [model_detail.detailCount integerValue]+1+(arr_model.count>0?1:0);
    }else
    {
        return 0;
    }
   
}
-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    if (indexPath.section==0) {
        return [[dic_height objectForKey:@"0"] floatValue];
    }else if (indexPath.section == model_detail.detailList.count+1)
    {
        ShenPiListModel *model = arr_model[indexPath.row];
        return model.cellHeight;
    }
    else
    {
        if (indexPath.row==0) {
            return [[dic_height objectForKey:[NSString stringWithFormat:@"%ld",indexPath.section]] floatValue];
        }else
        {
            return 60;
        }
    }
}
-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    if (section==0) {
        return 1;
    }else if (section == model_detail.detailList.count+1)
    {
        return arr_model.count;
    }else{
        BaoXiaoListDetailModel *model =model_detail.detailList[section-1];
        if (model.billImageList.count>0) {
            return 2;
        }else{
            return 1;
        }
    }
}
-(UITableViewCell*)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    if (indexPath.section==0) {
        static NSString *cellId=@"cellID";
        EQDR_labelTableViewCell *cell =[tableView dequeueReusableCellWithIdentifier:cellId];
        if (!cell) {
            cell = [[EQDR_labelTableViewCell alloc]initWithStyle:UITableViewCellStyleDefault reuseIdentifier:cellId];
            cell.accessoryType = UITableViewCellAccessoryNone;
        }
        NSMutableAttributedString *thetheme = [[NSMutableAttributedString alloc]initWithString:[NSString stringWithFormat:@"%@\n",model_detail.remibursetitle] attributes:@{NSFontAttributeName:[UIFont systemFontOfSize:21]}];
        thetheme.yy_alignment = NSTextAlignmentCenter;
        NSMutableAttributedString *name = [[NSMutableAttributedString alloc]initWithString:[NSString stringWithFormat:@"%@  报销编码:%@\n",model_detail.createName,model_detail.code] attributes:@{NSFontAttributeName:[UIFont systemFontOfSize:13],NSForegroundColorAttributeName:[UIColor grayColor]}];
        name.yy_alignment =NSTextAlignmentCenter;
        [name yy_setTextUnderline:[YYTextDecoration decorationWithStyle:YYTextLineStyleSingle width:[NSNumber numberWithInteger:2] color:[UIColor redColor]] range:name.yy_rangeOfAll];
       
        [thetheme appendAttributedString:name];
        NSMutableAttributedString *money = [[NSMutableAttributedString alloc]initWithString:[NSString stringWithFormat:@"报销总金额：%@ 元\n报销人：%@\n备注：%@\n报销时间:%@",model_detail.totalMoney,model_detail.createName,model_detail.remarks,model_detail.createTime] attributes:@{NSFontAttributeName:[UIFont systemFontOfSize:17],NSForegroundColorAttributeName:[UIColor grayColor]}];
        [money yy_setColor:[UIColor redColor] range:NSMakeRange(6, model_detail.totalMoney.length)];
       
        [thetheme appendAttributedString:money];
        
        NSMutableAttributedString *time = [[NSMutableAttributedString alloc]initWithString:[NSString stringWithFormat:@"\n%@",model_detail.createTime] attributes:@{NSFontAttributeName:[UIFont systemFontOfSize:15],NSForegroundColorAttributeName:[UIColor grayColor]}];
        time.yy_alignment = NSTextAlignmentRight;
        
        thetheme.yy_lineSpacing =5;
        cell.YL_label.attributedText =thetheme;
        CGSize size =[thetheme boundingRectWithSize:CGSizeMake(DEVICE_WIDTH-30, MAXFLOAT) options:NSStringDrawingUsesLineFragmentOrigin context:nil].size;
        [dic_height setObject:[NSString stringWithFormat:@"%.2f",size.height+15] forKey:[NSString stringWithFormat:@"%ld",indexPath.section]];
        [cell.YL_label mas_remakeConstraints:^(MASConstraintMaker *make) {
            make.height.mas_equalTo(size.height+15);
            make.left.mas_equalTo(cell.mas_left).mas_offset(15);
            make.right.mas_equalTo(cell.mas_right).mas_offset(-15);
            make.centerY.mas_equalTo(cell.mas_centerY);
        }];
        
        return cell;
    }
    else if(indexPath.section == [model_detail.detailCount integerValue]+1)
    {
        static NSString *cellid = @"cellid3";
        EQDR_labelTableViewCell  *cell = [tableView dequeueReusableCellWithIdentifier:cellid];
        if(!cell)
        {
            cell = [[EQDR_labelTableViewCell alloc]initWithStyle:UITableViewCellStyleDefault reuseIdentifier:cellid];
            cell.accessoryType = UITableViewCellAccessoryNone;
        }
        ShenPiListModel *model =arr_model[indexPath.row];
        
        NSString *check = [model.status integerValue]==0?@"已同意":@"驳回";
        NSMutableAttributedString *Tstr = [[NSMutableAttributedString alloc]initWithString:[NSString stringWithFormat:@"%@  于  %@  %@\n%@",model.staffName,model.createTime,check,model.message] attributes:@{NSFontAttributeName:[UIFont systemFontOfSize:17],}];
        Tstr.yy_lineSpacing =5;
        CGSize size = [Tstr boundingRectWithSize:CGSizeMake(DEVICE_WIDTH-30, MAXFLOAT) options:NSStringDrawingUsesLineFragmentOrigin context:nil].size;
        model.cellHeight = size.height+15;
        cell.YL_label.attributedText = Tstr;
        [cell.YL_label mas_remakeConstraints:^(MASConstraintMaker *make) {
            make.height.mas_equalTo(size.height+15);
            make.left.mas_equalTo(cell.mas_left).mas_offset(15);
            make.right.mas_equalTo(cell.mas_right).mas_offset(-15);
            make.centerY.mas_equalTo(cell.mas_centerY);
        }];
        
        return cell;
    }
    else
    {
        if (indexPath.row==0) {
            BaoXiaoListDetailModel *model =model_detail.detailList[indexPath.section-1];
            EQDR_labelTableViewCell *cell = [[EQDR_labelTableViewCell alloc]init];
            NSMutableAttributedString *content = [[NSMutableAttributedString alloc]initWithString:[NSString stringWithFormat:@"报销金额:%@元\n报销科目:%@\n费用说明:%@\n",model.reimburseMoney,model.reimburseType,model.explain]  attributes:@{NSFontAttributeName:[UIFont systemFontOfSize:17]}];
            if ([model.isBudget integerValue]==0) {
                
            }else{
                NSMutableAttributedString *content2 = [[NSMutableAttributedString alloc]initWithString:[NSString stringWithFormat:@"预算金额:%@元\n剩余金额:%@元",model.budgetMoney,model.remainderMoney] attributes:@{NSFontAttributeName:[UIFont systemFontOfSize:17]}];
                [content appendAttributedString:content2];
                
            }
            [content yy_setColor:[UIColor redColor] range:NSMakeRange(5, model.reimburseMoney.length)];
            
            if (model.enclosureList.count>0) {
                NSMutableAttributedString *more = [[NSMutableAttributedString alloc]initWithString:@"\n查看附件" attributes:@{NSFontAttributeName:[UIFont systemFontOfSize:17]}];
                more.yy_alignment = NSTextAlignmentRight;
                [more yy_setTextHighlightRange:more.yy_rangeOfAll color:EQDCOLOR backgroundColor:[UIColor whiteColor] tapAction:^(UIView * _Nonnull containerView, NSAttributedString * _Nonnull text, NSRange range, CGRect rect) {
                    //查看附件，单独写
                    MBProgressHUD *hud=[MBProgressHUD showHUDAddedTo:self.view  animated:YES];
                    hud.mode = MBProgressHUDModeText;
                    hud.label.text =@"暂不支持附件查看";
                    dispatch_time_t popTime = dispatch_time(DISPATCH_TIME_NOW, 1 * NSEC_PER_SEC);
                    dispatch_after(popTime, dispatch_get_main_queue(), ^(void){
                        [MBProgressHUD hideHUDForView:self.view  animated:YES];
                    });
                }];
               
                [content appendAttributedString:more];
            }
            
            content.yy_lineSpacing =5;
            cell.YL_label.attributedText = content;
            CGSize size = [content boundingRectWithSize:CGSizeMake(DEVICE_WIDTH-30, MAXFLOAT) options:NSStringDrawingUsesLineFragmentOrigin context:nil].size;
            [dic_height setObject:[NSString stringWithFormat:@"%.2f",size.height+10] forKey:[NSString stringWithFormat:@"%ld",indexPath.section]];
            [cell.YL_label mas_remakeConstraints:^(MASConstraintMaker *make) {
                make.height.mas_equalTo(size.height+10);
                make.left.mas_equalTo(cell.mas_left).mas_offset(15);
                make.right.mas_equalTo(cell.mas_right).mas_offset(-15);
                make.centerY.mas_equalTo(cell.mas_centerY);
            }];
            return cell;
        }else
        {
            ImgScrollTableViewCell *cell = [[ImgScrollTableViewCell alloc]init];
            BaoXiaoListDetailModel *model =model_detail.detailList[indexPath.section-1];
            
            [cell setarr_stringimgs:model.billImageList WithHeight:60];
            cell.imgScrollV.delegate_imgviews =self;
            cell.imgScrollV.indexPath = indexPath;
            return cell;
            //相册
        }
      
    }
    
   
   
}

#pragma  mark - 表的协议代理
-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    
}




@end
