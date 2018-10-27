//
//  CKHD_detailViewController.m
//  EQD
//
//  Created by 梁新帅 on 2018/10/11.
//  Copyright © 2018年 FitBoy. All rights reserved.
//

#import "CKHD_detailViewController.h"
#import "CKHD_detailModel.h"
#import <Masonry.h>
#import "FBButton.h"
#import <YYText.h>
#import "EQDR_labelTableViewCell.h"
#import <UIImageView+WebCache.h>
#import "FBImg_label_yyLabelTableViewCell.h"
#import "FBTwoButtonView.h"
#import "FBRight_showViewController.h"
#import "FB_ShareEQDViewController.h"
#import "EQD_HtmlTool.h"
#import "CKHD_erWeiMaViewController.h"
#import "CKHD_LIstBaomingViewController.h"
@interface CKHD_detailViewController ()<FBRight_showViewControllerDelegate,UITableViewDataSource,UITableViewDelegate>
{
    UITableView *tableV;
    NSMutableArray *arr_model;
    NSMutableArray  *arr_height;
    CKHD_detailModel *model_detail;
    UserModel *user;
}

@end

@implementation CKHD_detailViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    user = [WebRequest GetUserInfo];
    self.navigationItem.title = @"活动详情";
    arr_height =[NSMutableArray arrayWithArray:@[@"60",@"60",@"60"]];
    arr_model = [NSMutableArray arrayWithCapacity:0];
    tableV = [[UITableView alloc]initWithFrame:CGRectMake(0, DEVICE_TABBAR_Height, DEVICE_WIDTH, DEVICE_HEIGHT-DEVICE_TABBAR_Height-kBottomSafeHeight-40) style:UITableViewStylePlain];
    adjustsScrollViewInsets_NO(tableV, self);
    tableV.delegate=self;
    tableV.dataSource=self;
    [self.view addSubview:tableV];
    tableV.rowHeight=60;
    FBTwoButtonView *twoV = [[FBTwoButtonView alloc]initWithFrame:CGRectMake(0, DEVICE_HEIGHT-kBottomSafeHeight-40, DEVICE_WIDTH, 40)];
    [self.view addSubview:twoV];
//    [twoV setleftname:@"报名情况" rightname:@"签到情况"];
    [twoV.B_left setTitle:@"报名情况" titleColor:[UIColor blackColor] backgroundColor:[UIColor whiteColor] font:[UIFont systemFontOfSize:17]];
      [twoV.B_right setTitle:@"签到情况" titleColor:[UIColor blackColor] backgroundColor:[UIColor whiteColor] font:[UIFont systemFontOfSize:17]];
    [twoV.B_left addTarget:self action:@selector(baomingDetailClick) forControlEvents:UIControlEventTouchUpInside];
    [twoV.B_right addTarget:self action:@selector(qiandaoClick) forControlEvents:UIControlEventTouchUpInside];
    twoV.B_left.layer.borderWidth =1;
    twoV.B_left.layer.borderColor = [UIColor grayColor].CGColor;
    twoV.B_right.layer.borderWidth =1;
    twoV.B_right.layer.borderColor = [UIColor grayColor].CGColor;
 
    [WebRequest Activity_Get_ActivityByIdWithactivityId:self.Id And:^(NSDictionary *dic) {
        if ([dic[Y_STATUS] integerValue]==200) {
            model_detail = [CKHD_detailModel mj_objectWithKeyValues:dic[Y_ITEMS]];
            [tableV reloadData];
          
            [WebRequest Activity_Get_ActivityBySearchWithpage:@"0" para:@" " isCharge:@"2" activeType:model_detail.activeType province:@" " activeClassify:@" " And:^(NSDictionary *dic) {
                if ([dic[Y_STATUS] integerValue]==200) {
                    [arr_model removeAllObjects];
                    NSArray *tarr = dic[Y_ITEMS];
                    for (int i=0; i<tarr.count; i++) {
                        CK_huoDongModel  *model = [CK_huoDongModel mj_objectWithKeyValues:tarr[i]];
                        [arr_model addObject:model];
                    }
                    [tableV reloadData];
                }
            }];
        
            
        }else
        {
            MBFadeAlertView  *alert  = [[MBFadeAlertView alloc]init];
            [alert showAlertWith:@"活动没找到，请联系平台"];
            [self.navigationController popViewControllerAnimated:NO];
        }
    }];
    
    
    UIBarButtonItem  *right = [[UIBarButtonItem alloc]initWithImage:[[UIImage imageNamed:@"EQD_more"] imageWithRenderingMode:UIImageRenderingModeAlwaysOriginal] style:UIBarButtonItemStylePlain target:self action:@selector(moreClick)];
    [self.navigationItem setRightBarButtonItem:right];
}
#pragma  mark - 更多
-(void)moreClick
{
    FBRight_showViewController *Rvc = [[FBRight_showViewController alloc]init];
    Rvc.delegate_right = self;
    Rvc.arr_names = @[@"分享链接",@"报名二维码",@"签到二维码",@"报名情况",@"签到情况"];
    Rvc.providesPresentationContextTransitionStyle = YES;
    Rvc.definesPresentationContext = YES;
    Rvc.modalPresentationStyle = UIModalPresentationOverCurrentContext;
    [self presentViewController:Rvc animated:NO completion:nil];

}
#pragma  mark - more的点击事件
-(void)getSlectedindex:(NSInteger)index
{
    switch (index) {
        case 0:
        {
           //分享链接
            FB_ShareEQDViewController  *Svc = [[FB_ShareEQDViewController alloc]init];
            Svc.EQD_ShareType = EQD_ShareTypeLink;
            Svc.Stitle = model_detail.activeTitle;
         
            Svc.text = model_detail.activeDesc;
            Svc.url =[EQD_HtmlTool getHuodongDetailWithId:model_detail.Id];
            Svc.imageURL =model_detail.activeImg;
            Svc.source = @"金师库";
            Svc.sourceOwner = user.Guid;
            Svc.articleId = model_detail.Id;
            Svc.type2 = 1;
            
            Svc.providesPresentationContextTransitionStyle = YES;
            Svc.definesPresentationContext = YES;
            Svc.modalPresentationStyle = UIModalPresentationOverCurrentContext;
            [self presentViewController:Svc animated:NO completion:nil];
        }
            break;
        case 1:
        {
         //报名二维码
            CKHD_erWeiMaViewController  *EWvc = [[CKHD_erWeiMaViewController alloc]init];
            EWvc.temp =1;
            EWvc.model_detail = model_detail;
            [self.navigationController pushViewController:EWvc animated:NO];
        }
            break;
        case 2:
        {
           //签到二维码
            CKHD_erWeiMaViewController  *EWvc = [[CKHD_erWeiMaViewController alloc]init];
            EWvc.temp =2;
            EWvc.model_detail = model_detail;
            [self.navigationController pushViewController:EWvc animated:NO];
        }
            break;
        case 3:
        {
           ///报名情况
            [self baomingDetailClick];
        }
            break;
        case 4:
        {
           ///签到情况
            [self qiandaoClick];
        }
            break;
        default:
            break;
    }
}
#pragma  mark - 报名情况
-(void)baomingDetailClick
{
    
    CKHD_LIstBaomingViewController  *Bvc = [[CKHD_LIstBaomingViewController alloc]init];
    Bvc.activeId = model_detail.Id;
    Bvc.temp =0;
    [self.navigationController pushViewController:Bvc animated:NO];
}
#pragma  mark - 签到情况
-(void)qiandaoClick
{
    CKHD_LIstBaomingViewController  *Bvc = [[CKHD_LIstBaomingViewController alloc]init];
    Bvc.activeId = model_detail.Id;
    Bvc.temp =1;
    [self.navigationController pushViewController:Bvc animated:NO];
}
-(NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    if (model_detail) {
        return 2;
    }else{
    return 0;
    }
}

-(NSString*)tableView:(UITableView *)tableView titleForHeaderInSection:(NSInteger)section
{
    switch (section) {
        case 0:
        {
            return nil;
        }
            break;
        case 1:
        {
            return @"同类型的其他活动";
        }
            break;
            
        default:
            return nil;
            break;
    }
}
-(CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section
{
    if (section==0) {
        return 1;
    }else
    {
        
        return 30;
    }
}
-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    if (indexPath.section ==0) {
        return [arr_height[indexPath.row] floatValue];
    }else
    {
//        CK_huoDongModel *model = arr_model[indexPath.row];
        return 110;
    }
}

#pragma  mark - 表的数据源
-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    if(section==0)
    {
        return 3;
    }else
    {
        return arr_model.count;
    }
}
-(void)baomingClick
{
    NSString *feiyong = [model_detail.price integerValue]==0?@"免费\n到场支付":[NSString stringWithFormat:@"￥%@元\n到场支付",model_detail.price];
    //报名
    UIAlertController *alert  = [UIAlertController alertControllerWithTitle:[NSString stringWithFormat:@"您确定报名该活动？"] message:feiyong preferredStyle:UIAlertControllerStyleAlert];
    [alert addAction:[UIAlertAction actionWithTitle:@"取消" style:UIAlertActionStyleCancel handler:^(UIAlertAction * _Nonnull action) {
        
    }]];
    [alert addAction:[UIAlertAction actionWithTitle:@"确定" style:UIAlertActionStyleDefault handler:^(UIAlertAction * _Nonnull action) {
        if (model_detail) {
        MBProgressHUD *hud = [MBProgressHUD showHUDAddedTo:self.view animated:YES];
        hud.mode = MBProgressHUDModeAnnularDeterminate;
        hud.label.text = @"正在报名";
            [WebRequest Activity_Add_ActivityRegWithuserGuid:user.Guid activityId:model_detail.Id username:user.username phone:user.uname And:^(NSDictionary *dic) {
                if ([dic[Y_STATUS] integerValue]==200) {
                    hud.label.text =@"报名成功";
                }else
                {
                    hud.label.text = @"重复报名，或服务器错误";
                }
                dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(0.7 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
                    [hud hideAnimated:NO];
                });
                
            }];
        }else
        {
            MBFadeAlertView *talert = [[MBFadeAlertView alloc]init];
            [talert showAlertWith:@"等待活动加载完重试！"];
        }
        
    }]];
    
    [self presentViewController:alert animated:NO completion:nil];
}
-(UITableViewCell*)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
        
    switch (indexPath.section) {
        case 0:
        {
            if (indexPath.row ==0) {
                static NSString *cellId=@"cellID00";
                UITableViewCell *cell =[tableView dequeueReusableCellWithIdentifier:cellId];
                if (!cell) {
                    cell = [[UITableViewCell alloc]initWithStyle:UITableViewCellStyleDefault reuseIdentifier:cellId];
                    cell.accessoryType = UITableViewCellAccessoryNone;
                    cell.textLabel.font = [UIFont systemFontOfSize:18];
                    cell.selectionStyle = UITableViewCellSelectionStyleNone;
                    UIImageView *IV_img = [[UIImageView alloc]initWithFrame:CGRectMake(15, 5, 100, 100)];
                    [cell addSubview:IV_img];
                    [IV_img sd_setImageWithURL:[NSURL URLWithString:model_detail.activeImg]];
                    UILabel *L_name = [[UILabel alloc]init];
                    L_name.numberOfLines =2;
                    L_name.text = model_detail.activeTitle;
                    L_name.font = [UIFont systemFontOfSize:17];
                    [cell addSubview:L_name];
                    [L_name mas_makeConstraints:^(MASConstraintMaker *make) {
                        make.height.mas_equalTo(40);
                        make.left.mas_equalTo(IV_img.mas_right).mas_offset(5);
                        make.right.mas_equalTo(cell.mas_right).mas_offset(-15);
                        make.top.mas_equalTo(IV_img.mas_top);
                    }];
                    FBButton  *baoming = [FBButton buttonWithType:UIButtonTypeSystem];
                    [baoming setTitle:@"报名" titleColor:[UIColor whiteColor] backgroundColor:EQDCOLOR font:[UIFont systemFontOfSize:20]];
                    [cell addSubview:baoming];
                    [baoming mas_makeConstraints:^(MASConstraintMaker *make) {
                        make.size.mas_equalTo(CGSizeMake(70, 35));
                        make.bottom.mas_equalTo(IV_img.mas_bottom);
                        make.centerX.mas_equalTo(cell.mas_centerX).mas_offset(50);
                    }];
                    [baoming addTarget:self action:@selector(baomingClick) forControlEvents:UIControlEventTouchUpInside];
                    YYLabel  *YL_label = [[YYLabel alloc]init];
                    [cell addSubview:YL_label];
                    NSMutableAttributedString *name = [[NSMutableAttributedString alloc]initWithString:[NSString stringWithFormat:@"活动类型：%@\n活动分类：%@\n参会对象：%@\n参会人数：%@\n参会规模：%@\n活动地点：%@\n活动时间：%@",model_detail.activeType,model_detail.activeClassify,model_detail.activeObject,model_detail.activeNum,model_detail.activeScale,model_detail.activeAddress,model_detail.activeStartTime] attributes:@{NSFontAttributeName:[UIFont systemFontOfSize:13],NSForegroundColorAttributeName:[UIColor grayColor]}];
                    name.yy_lineSpacing =6;
                    CGSize size = [name boundingRectWithSize:CGSizeMake(DEVICE_WIDTH-30, MAXFLOAT) options:NSStringDrawingUsesLineFragmentOrigin context:nil].size;
                    YL_label.attributedText = name;
                    [cell addSubview:YL_label];
                    YL_label.numberOfLines=0;
                    [YL_label mas_remakeConstraints:^(MASConstraintMaker *make) {
                        make.height.mas_equalTo(size.height+10);
                        make.left.mas_equalTo(cell.mas_left).mas_offset(15);
                        make.right.mas_equalTo(cell.mas_right).mas_offset(-15);
                        make.bottom.mas_equalTo(cell.mas_bottom).mas_offset(-2);
                    }];
                   [arr_height replaceObjectAtIndex:0 withObject:[NSString stringWithFormat:@"%.2f",110+size.height+15]];
                }else
                {
                }
            
                return cell;
            }else if(indexPath.row ==1)
            {
                ///活动简介
                static NSString *cellId=@"cellID01";
                EQDR_labelTableViewCell *cell =[tableView dequeueReusableCellWithIdentifier:cellId];
                if (!cell) {
                    cell = [[EQDR_labelTableViewCell alloc]initWithStyle:UITableViewCellStyleDefault reuseIdentifier:cellId];
                    cell.accessoryType = UITableViewCellAccessoryNone;
                    
                }else
                {
                }
                NSMutableAttributedString  *name = [[NSMutableAttributedString alloc]initWithString:@"活动简介\n" attributes:@{NSFontAttributeName:[UIFont systemFontOfSize:17]}];
                [name setYy_textUnderline:[YYTextDecoration decorationWithStyle:YYTextLineStyleSingle]];
         
              
                NSString * htmlString =[NSString stringWithFormat:@"<html><body style = \"font-size:13px;color:gray\">%@</body></html>",model_detail.activeDesc] ;
                NSAttributedString * attrStr = [[NSAttributedString alloc] initWithData:[htmlString dataUsingEncoding:NSUnicodeStringEncoding] options:@{ NSDocumentTypeDocumentAttribute: NSHTMLTextDocumentType } documentAttributes:nil error:nil];
                [name appendAttributedString:attrStr];
                name.yy_lineSpacing =6;
                cell.YL_label.attributedText = name;
                CGSize size = [name boundingRectWithSize:CGSizeMake(DEVICE_WIDTH-30, MAXFLOAT) options:NSStringDrawingUsesLineFragmentOrigin context:nil].size;;
                [arr_height replaceObjectAtIndex:1 withObject:[NSString stringWithFormat:@"%.2f",size.height+10]];
                [cell.YL_label mas_remakeConstraints:^(MASConstraintMaker *make) {
                    make.height.mas_equalTo(size.height +5);
                    make.left.mas_equalTo(cell.mas_left).mas_offset(15);
                    make.right.mas_equalTo(cell.mas_right).mas_offset(-15);
                    make.centerY.mas_equalTo(cell.mas_centerY);
                }];
                
                return cell;
            }else if (indexPath.row ==2)
            {
                static NSString *cellId=@"cellID02";
                EQDR_labelTableViewCell *cell =[tableView dequeueReusableCellWithIdentifier:cellId];
                if (!cell) {
                    cell = [[EQDR_labelTableViewCell alloc]initWithStyle:UITableViewCellStyleDefault reuseIdentifier:cellId];
                    cell.accessoryType = UITableViewCellAccessoryNone;
                    cell.textLabel.font = [UIFont systemFontOfSize:18];
                    
                }else
                {
                }
                NSMutableAttributedString  *name = [[NSMutableAttributedString alloc]initWithString:@"活动日程\n" attributes:@{NSFontAttributeName:[UIFont systemFontOfSize:17]}];
                [name setYy_textUnderline:[YYTextDecoration decorationWithStyle:YYTextLineStyleSingle]];
                
                NSString * htmlString =[NSString stringWithFormat:@"<html><body style = \"font-size:13px;color:gray\">%@</body></html>",model_detail.activeSchedule] ;
                NSAttributedString * attrStr = [[NSAttributedString alloc] initWithData:[htmlString dataUsingEncoding:NSUnicodeStringEncoding] options:@{ NSDocumentTypeDocumentAttribute: NSHTMLTextDocumentType } documentAttributes:nil error:nil];
                [name appendAttributedString:attrStr];
                
                name.yy_lineSpacing =6;
                cell.YL_label.attributedText = name;
                CGSize size = [name boundingRectWithSize:CGSizeMake(DEVICE_WIDTH-30, MAXFLOAT) options:NSStringDrawingUsesLineFragmentOrigin context:nil].size;;
                [arr_height replaceObjectAtIndex:2 withObject:[NSString stringWithFormat:@"%.2f",size.height+10]];
                [cell.YL_label mas_remakeConstraints:^(MASConstraintMaker *make) {
                    make.height.mas_equalTo(size.height +5);
                    make.left.mas_equalTo(cell.mas_left).mas_offset(15);
                    make.right.mas_equalTo(cell.mas_right).mas_offset(-15);
                    make.centerY.mas_equalTo(cell.mas_centerY);
                }];
                
                return cell;
            }else
            {
                return nil;
            }
        }
            break;
          case 1:
        {
            static NSString *cellId=@"cellID10";
            FBImg_label_yyLabelTableViewCell *cell =[tableView dequeueReusableCellWithIdentifier:cellId];
            if (!cell) {
                cell = [[FBImg_label_yyLabelTableViewCell alloc]initWithStyle:UITableViewCellStyleDefault reuseIdentifier:cellId];
                cell.accessoryType = UITableViewCellAccessoryNone;
                cell.textLabel.font = [UIFont systemFontOfSize:18];
            }
            CK_huoDongModel *model = arr_model[indexPath.row];
            [cell setModel_huodong:model];
            return cell;
        }
            break;
        default:
            return nil;
            break;
    }
    
    static NSString *cellId=@"cellID";
    UITableViewCell *cell =[tableView dequeueReusableCellWithIdentifier:cellId];
    if (!cell) {
        cell = [[UITableViewCell alloc]initWithStyle:UITableViewCellStyleDefault reuseIdentifier:cellId];
        cell.accessoryType = UITableViewCellAccessoryDisclosureIndicator;
        cell.textLabel.font = [UIFont systemFontOfSize:18];
    }
    return cell;
}

#pragma  mark - 表的协议代理
-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
  if(indexPath.section ==1)
  {
      CK_huoDongModel  *model = arr_model[indexPath.row];
      CKHD_detailViewController *Dvc = [[CKHD_detailViewController alloc]init];
      Dvc.Id = model.Id;
      [self.navigationController pushViewController:Dvc animated:NO];
  }
}




@end
