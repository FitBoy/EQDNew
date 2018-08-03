//
//  SC_MaiMaiViewController.m
//  EQD
//
//  Created by 梁新帅 on 2018/7/18.
//  Copyright © 2018年 FitBoy. All rights reserved.
//  temp  0 是供方  1是买方 

#import "SC_MaiMaiViewController.h"
#import "SC_productModel.h"
#import "SC_maiMaiAddViewController.h"
#import "SC_productTableViewCell.h"
#import "FBLabel_YYAddTableViewCell.h"
#import <Masonry.h>
@interface SC_MaiMaiViewController ()<UITableViewDelegate,UITableViewDataSource>
{
    UITableView *tableV;
    NSMutableArray *arr_model;
    UserModel *user;
}

@end

@implementation SC_MaiMaiViewController
-(void)viewWillAppear:(BOOL)animated{
    [super viewWillAppear:animated];
    [self loadRequestData];
}
-(void)loadRequestData{
    if (self.temp ==0) {
        
    [WebRequest ComSpace_ComSpaceProduct_ProductSupply_Get_ProductSupplyWithproductId:self.productId And:^(NSDictionary *dic) {
        if([dic[Y_STATUS] integerValue]==200)
        {
            NSArray *tarr =  dic[Y_ITEMS];
            [arr_model removeAllObjects];
            for (int i=0; i<tarr.count; i++) {
                SC_productModel  *model = [SC_productModel mj_objectWithKeyValues:tarr[i]];
                model.cell_height =60;
                [arr_model addObject:model];
            }
            [tableV reloadData];
        }
    }];
    }else
    {
        [WebRequest ComSpace_ComSpaceProduct_ProductBuyer_Get_ProductBuyerWithproductId:self.productId And:^(NSDictionary *dic) {
            if([dic[Y_STATUS] integerValue]==200)
            {
                NSArray *tarr =  dic[Y_ITEMS];
                [arr_model removeAllObjects];
                for (int i=0; i<tarr.count; i++) {
                    SC_productModel  *model = [SC_productModel mj_objectWithKeyValues:tarr[i]];
                    model.cell_height =60;
                    [arr_model addObject:model];
                }
                [tableV reloadData];
            }
        }];
    }
}
- (BOOL)prefersHomeIndicatorAutoHidden{
    return NO;
}
- (void)viewDidLoad {
    [super viewDidLoad];
    user = [WebRequest GetUserInfo];
    self.navigationItem.title =self.temp ==0? @"供方信息列表":@"买方信息列表";
    arr_model = [NSMutableArray arrayWithCapacity:0];
    tableV = [[UITableView alloc]initWithFrame:CGRectMake(0, DEVICE_TABBAR_Height, DEVICE_WIDTH, DEVICE_HEIGHT-DEVICE_TABBAR_Height-kBottomSafeHeight) style:UITableViewStylePlain];
    adjustsScrollViewInsets_NO(tableV, self);
    tableV.delegate=self;
    tableV.dataSource=self;
    [self.view addSubview:tableV];
    tableV.rowHeight=60;
   
 UIBarButtonItem *right =[[UIBarButtonItem alloc]initWithImage:[[UIImage imageNamed:@"add_eqd2"] imageWithRenderingMode:UIImageRenderingModeAlwaysOriginal] style:UIBarButtonItemStyleDone target:self action:@selector(tianjiaClick)];
    [self.navigationItem setRightBarButtonItem:right];
}

-(void)tianjiaClick
{
    SC_maiMaiAddViewController  *Avc = [[SC_maiMaiAddViewController alloc]init];
    Avc.temp = self.temp;
    Avc.productId =self.productId;
    [self.navigationController pushViewController:Avc animated:NO];
    
}
#pragma  mark - 表的数据源
-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return arr_model.count;
}
-(UITableViewCell*)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    static NSString *cellId=@"cellID";
    FBLabel_YYAddTableViewCell *cell =[tableView dequeueReusableCellWithIdentifier:cellId];
    if (!cell) {
        cell = [[FBLabel_YYAddTableViewCell alloc]initWithStyle:UITableViewCellStyleDefault reuseIdentifier:cellId];
        cell.accessoryType = UITableViewCellAccessoryNone;
    }
    SC_productModel  *model = arr_model[indexPath.row];
    NSMutableAttributedString *name = [[NSMutableAttributedString alloc]initWithString:[NSString stringWithFormat:@"%@\n",model.ProductName] attributes:@{NSFontAttributeName:[UIFont systemFontOfSize:15]}];
    NSMutableAttributedString *time = [[NSMutableAttributedString alloc]initWithString:[NSString stringWithFormat:@"%@\n",model.createTime] attributes:@{NSFontAttributeName:[UIFont systemFontOfSize:13],NSForegroundColorAttributeName:[UIColor grayColor]}];
    time.yy_alignment =NSTextAlignmentRight;
    [name appendAttributedString:time];
    name.yy_lineSpacing =6;
    CGSize size = [name boundingRectWithSize:CGSizeMake(DEVICE_WIDTH-30, MAXFLOAT) options:NSStringDrawingUsesLineFragmentOrigin context:nil].size;
    model.cell_height =size.height+15;
    cell.YL_content.attributedText = name;
    [cell.YL_content mas_makeConstraints:^(MASConstraintMaker *make) {
        make.height.mas_equalTo(size.height+10);
        make.centerY.mas_equalTo(cell.mas_centerY);
        make.left.mas_equalTo(cell.mas_left).mas_offset(15);
        make.right.mas_equalTo(cell.mas_right).mas_offset(-15);
    }];
    
    return cell;
}
-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    SC_productModel  *model = arr_model[indexPath.row];
    return model.cell_height;
}
#pragma  mark - 表的协议代理
-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
  SC_productModel  *model = arr_model[indexPath.row];
    SC_maiMaiAddViewController  *Dvc =[[SC_maiMaiAddViewController alloc]init];
    Dvc.temp = self.temp +2;
    Dvc.productId = self.productId;
    Dvc.demandId = model.Id;
    [self.navigationController pushViewController:Dvc animated:NO];
}

-(BOOL)tableView:(UITableView *)tableView canEditRowAtIndexPath:(NSIndexPath *)indexPath
{
    return YES;
}

-(UITableViewCellEditingStyle)tableView:(UITableView *)tableView editingStyleForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return UITableViewCellEditingStyleDelete;
    
}
-(void)tableView:(UITableView *)tableView commitEditingStyle:(UITableViewCellEditingStyle)editingStyle forRowAtIndexPath:(NSIndexPath *)indexPath
{
    
    if (editingStyle == UITableViewCellEditingStyleDelete) {
        //删除
        SC_productModel  *model = arr_model[indexPath.row];
        if (self.temp ==0) {
            [WebRequest  ComSpace_ComSpaceProduct_ProductSupply_Delete_productSupplyWithcompanyId:user.companyId userGuid:user.Guid buyerId:model.Id And:^(NSDictionary *dic) {
                MBFadeAlertView *alert = [[MBFadeAlertView alloc]init];
                if ([dic[Y_STATUS] integerValue]==200) {
                    [alert showAlertWith:@"删除成功"];
                    [arr_model removeObject:model];
                    [tableV reloadData];
                }else
                {
                    [alert showAlertWith:@"服务器错误，请重试"];
                }
            }];
        }else if (self.temp ==1)
        {
            [WebRequest ComSpace_ComSpaceProduct_ProductBuyer_Delete_ProductBuyerWithuserGuid:user.Guid buyerId:model.Id productId:self.productId And:^(NSDictionary *dic) {
                 MBFadeAlertView *alert = [[MBFadeAlertView alloc]init];
                if ([dic[Y_STATUS] integerValue]==200) {
                    [alert showAlertWith:@"删除成功"];
                    [arr_model removeObject:model];
                    [tableV reloadData];
                }else
                {
                    [alert showAlertWith:@"服务器错误，请重试"];
                }
            }];
        }else
        {
            
        }
    }
}

-(NSString*)tableView:(UITableView *)tableView titleForDeleteConfirmationButtonForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return @"删除";
}




@end
