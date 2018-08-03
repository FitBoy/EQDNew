//
//  SC_maiMaiAddViewController.m
//  EQD
//
//  Created by 梁新帅 on 2018/7/18.
//  Copyright © 2018年 FitBoy. All rights reserved.
//

#import "SC_maiMaiAddViewController.h"
#import "FBHangYeViewController.h"
#import "FBTextFieldViewController.h"
#import "FBTextVViewController.h"
#import "MM_zhiBiaoAddViewController.h"
#import "SC_productTableViewCell.h"
#import <Masonry.h>
#import "Image_textModel.h"
#import <UIImageView+WebCache.h>
#import "FBButton.h"
#import "SC_productDetailViewController.h"
#import "SC_needPiPeiViewController.h"
@interface SC_maiMaiAddViewController ()<UITableViewDataSource,UITableViewDelegate,FBTextVViewControllerDelegate,FBTextFieldViewControllerDelegate,FBHangYeViewControllerDelegate,MM_zhiBiaoAddViewControllerDelegate>
{
    UITableView *tableV;
    NSArray *arr_names;
    NSMutableArray *arr_contents;
    NSMutableArray *arr_model;
    UserModel *user;
    SC_productModel  *model_detail;
    NSMutableArray *arr_product;
}

@end

@implementation SC_maiMaiAddViewController
-(void)viewWillAppear:(BOOL)animated{
    [super viewWillAppear:animated];
   
}
-(void)loadRequestData{
   if (self.temp >1)
    {
        ///买方详情
        
        [WebRequest ComSpace_ComSpaceOther_Get_ComSpaceDemandByIdWithdemandId:self.demandId And:^(NSDictionary *dic) {
            if ([dic[Y_STATUS] integerValue]==200) {
                model_detail = [SC_productModel mj_objectWithKeyValues:dic[Y_ITEMS]];
                arr_contents = [NSMutableArray arrayWithArray:@[model_detail.ProductName,model_detail.GuoBiaoCode,model_detail.ProductType,model_detail.ProductDesc,@"点我添加"]];
                [arr_model removeAllObjects];
                for (int i=0; i<model_detail.indexList.count; i++) {
                    SC_maiMaiModel *model  = [SC_maiMaiModel mj_objectWithKeyValues:model_detail.indexList[i]];
                    [arr_model addObject:model];
                }
                [tableV reloadData];
            }
        }];
        
        if (self.temp ==2) {
        //  供方需求 产品匹配
            [WebRequest ComSpace_ComSpaceOther_Demand_MatchingWithdemandId:self.demandId page:@"0" count:@"10" And:^(NSDictionary *dic) {
                if ([dic[Y_STATUS] integerValue]==200) {
                    NSArray *tarr  = dic[Y_ITEMS];
                    [arr_product removeAllObjects];
                    for (int i=0; i<tarr.count; i++) {
                        SC_productModel *model = [SC_productModel mj_objectWithKeyValues:tarr[i]];
                        [arr_product addObject:model];
                    }
                    [tableV reloadSections:[NSIndexSet indexSetWithIndex:2] withRowAnimation:UITableViewRowAnimationNone];
                }
            }];
        }else if (self.temp ==3)
        {
            // 买方需求 产品匹配
            
            [WebRequest ComSpace_ComSpaceOther_Supply_MatchingWithSupplyId:self.demandId page:@"0" count:@"10" And:^(NSDictionary *dic) {
                if ([dic[Y_STATUS] integerValue]==200) {
                    NSArray *tarr  = dic[Y_ITEMS];
                    [arr_product removeAllObjects];
                    for (int i=0; i<tarr.count; i++) {
                        SC_productModel *model = [SC_productModel mj_objectWithKeyValues:tarr[i]];
                        [arr_product addObject:model];
                    }
                    [tableV reloadSections:[NSIndexSet indexSetWithIndex:2] withRowAnimation:UITableViewRowAnimationNone];
                }
            }];
        }
        
    }else
    {
        
    }
}

- (BOOL)prefersHomeIndicatorAutoHidden{
    return NO;
}
#pragma  mark - 指标
-(void)getZhibiao:(NSString *)zhibiao valueZhibiao:(NSString *)valuezhibiao imageUrl:(NSString *)imageUrl
{
    if(self.temp >1)
    {
        SC_maiMaiModel *model = [[SC_maiMaiModel alloc]init];
        model.IndexImage = [NSString stringWithFormat:@"%@%@",HTTP_PATH,imageUrl];
        model.IndexTypeKey = zhibiao;
        model.IndexTypeValue = valuezhibiao;
        
        MBProgressHUD *hud = [MBProgressHUD showHUDAddedTo:self.view animated:YES];
        hud.mode = MBProgressHUDModeAnnularDeterminate;
        hud.label.text = @"正在添加指标";
        if (self.temp ==2) {
            //供方
            [WebRequest ComSpace_ComSpaceProduct_ProductSupply_Add_ProductSupplyIndexWithuserGuid:user.Guid companyId:user.companyId productId:self.productId productBuyerId:model_detail.Id indexTypeKey:zhibiao indexTypeValue:valuezhibiao indexImage:imageUrl And:^(NSDictionary *dic) {
                hud.label.text = dic[Y_MSG];
                dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(0.6 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
                    [hud hideAnimated:NO];
                    if ([dic[Y_STATUS] integerValue]==200) {
                        [arr_model addObject:model];
                        [tableV reloadData];
                    }
                });
            }];
        }else if (self.temp ==3)
        {
            //买方
            [WebRequest ComSpace_ComSpaceProduct_ProductBuyer_Add_ProductBuyerIndexWithuserGuid:user.Guid companyId:user.companyId productId:self.productId productBuyerId:model_detail.Id indexTypeKey:zhibiao indexTypeValue:valuezhibiao indexImage:model.IndexImage And:^(NSDictionary *dic) {
                hud.label.text = dic[Y_MSG];
                dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(0.6 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
                    [hud hideAnimated:NO];
                    if ([dic[Y_STATUS] integerValue]==200) {
                        [arr_model addObject:model];
                        [tableV reloadData];
                    }
                });
            }];
        }
      
        
      
    }else
    {
    Image_textModel  *model = [[Image_textModel alloc]init];
    model.imgUrl = imageUrl;
    model.title = zhibiao;
    model.sort = valuezhibiao;
    [arr_model addObject:model];
     [tableV reloadData];
    }
}
#pragma  mark -  单行
-(void)content:(NSString *)content WithindexPath:(NSIndexPath *)indexPath
{
    if (self.temp >1) {
        if (indexPath.row ==0) {
            [self updateDataWithPara:[NSString stringWithFormat:@"%@='%@'",@"productName",content] indexpath:indexPath key:content];
        }else if(indexPath.row ==1)
        {
            [self updateDataWithPara:[NSString stringWithFormat:@"%@='%@'",@"GuoBiaoCode",content] indexpath:indexPath key:content];
        }
    }else
    {
        [arr_contents replaceObjectAtIndex:indexPath.row withObject:content];
        [tableV reloadRowsAtIndexPaths:@[indexPath] withRowAnimation:UITableViewRowAnimationNone];
    }
   
}
#pragma  mark - 多行
-(void)textVtext:(NSString *)text indexPath:(NSIndexPath *)indexPath
{
    if (self.temp >1) {
        [self updateDataWithPara:[NSString stringWithFormat:@"%@='%@'",@"productDesc",text] indexpath:indexPath key:text];
    }else
    {
        [arr_contents replaceObjectAtIndex:indexPath.row withObject:text];
        [tableV reloadRowsAtIndexPaths:@[indexPath] withRowAnimation:UITableViewRowAnimationNone];
    }
   
}
#pragma  mark - 行业
-(void)hangye:(NSString *)hangye Withindexpath:(NSIndexPath *)indexpath
{
    NSArray *tarr = [hangye componentsSeparatedByString:@"-"];
    if (self.temp >1) {
        [self updateDataWithPara:[NSString stringWithFormat:@"%@='%@'",@"productType",tarr[0]] indexpath:indexpath key:tarr[0]];
    }else
    {
    [arr_contents replaceObjectAtIndex:indexpath.row withObject:tarr[0]];
    [tableV reloadRowsAtIndexPaths:@[indexpath] withRowAnimation:UITableViewRowAnimationNone];
    }
}

-(void)updateDataWithPara:(NSString*)para  indexpath:(NSIndexPath*)indexptah key:(NSString*)key{
    [WebRequest ComSpace_ComSpaceProduct_ProductSupply_Update_ProductSupplyWithcompanyId:user.companyId userGuid:user.Guid buyerId:model_detail.Id para:para And:^(NSDictionary *dic) {
        MBFadeAlertView *alert = [[MBFadeAlertView alloc]init];
        if ([dic[Y_STATUS] integerValue]==200) {
            [alert showAlertWith:@"修改成功"];
            [arr_contents replaceObjectAtIndex:indexptah.row withObject:key];
            [tableV reloadData];
        }else
        {
            [alert showAlertWith:@"网络错误，请重试"];
        }
    }];
}
- (void)viewDidLoad {
    [super viewDidLoad];
     [self loadRequestData];
    arr_product = [NSMutableArray arrayWithCapacity:0];
    user = [WebRequest GetUserInfo];
    NSString *Ttitle = nil;
    if (self.temp == 0) {
        Ttitle = @"添加供方信息";
    }else if (self.temp ==1)
    {
        Ttitle =@"添加买方信息";
    }else if (self.temp ==2)
    {
        Ttitle = @"产品供方详情";
    }else if (self.temp ==3)
    {
        Ttitle = @"产品买方详情";
    }else
    {
        
    }
    self.navigationItem.title =Ttitle;
    arr_names = @[@"产品名称",@"国际代码",@"产品类型",@"产品描述",@"添加产品指标特性"];
    arr_contents = [NSMutableArray arrayWithArray:@[@"请输入",@"请输入",@"请选择",@"请输入",@"点我添加"]];
    tableV = [[UITableView alloc]initWithFrame:CGRectMake(0, DEVICE_TABBAR_Height, DEVICE_WIDTH, DEVICE_HEIGHT-DEVICE_TABBAR_Height-kBottomSafeHeight) style:UITableViewStyleGrouped];
    adjustsScrollViewInsets_NO(tableV, self);
    tableV.delegate=self;
    tableV.dataSource=self;
    [self.view addSubview:tableV];
    tableV.rowHeight=60;
   
    arr_model = [NSMutableArray arrayWithCapacity:0];
    if(self.temp>1)
    {
        
    }else
    {
    UIBarButtonItem *right = [[UIBarButtonItem alloc]initWithTitle:@"提交" style:UIBarButtonItemStylePlain target:self action:@selector(quedingClick)];
    [self.navigationItem setRightBarButtonItem:right];
    }
    
}
-(void)loadMoreProduct
{
    ///查看更多的产品信息
    SC_needPiPeiViewController  *PPvc = [[SC_needPiPeiViewController alloc]init];
    PPvc.Id = self.demandId;
    PPvc.temp = self.temp %2;
    [self.navigationController pushViewController:PPvc animated:NO];
    
}
-(void)quedingClick
{
    NSInteger  temp =0;
    for (int i=0; i<arr_contents.count; i++) {
        if ([arr_contents[i] isEqualToString:@"请输入"] || [arr_contents[i] isEqualToString:@"请选择"]) {
            temp =1;
            break;
        }
    }
    
    NSMutableArray *tarr = [NSMutableArray arrayWithCapacity:0];
    for (int i=0; i<arr_model.count; i++) {
        Image_textModel  *model = arr_model[i];
        NSDictionary *tdic =@{
                              @"indexTypeKey":model.title,
                              @"indexTypeValue":model.sort,
                              @"indexImage":model.imgUrl
                              };
        [tarr addObject:tdic];
    }
    NSString *tstr = nil;
    if (tarr.count ==0) {
        tstr =@"[]";
    }else
    {
        NSData *tdata = [NSJSONSerialization dataWithJSONObject:tarr options:NSJSONWritingPrettyPrinted error:nil];
        tstr = [[NSString alloc]initWithData:tdata encoding:NSUTF8StringEncoding];
    }
    
    if(self.temp ==0 )
    {
        MBProgressHUD *hud = [MBProgressHUD showHUDAddedTo:self.view animated:YES];
        hud.mode = MBProgressHUDModeAnnularDeterminate;
        hud.label.text = @"正在提交";
        [WebRequest ComSpace_ComSpaceProduct_ProductSupply_Add_ProductSupplyWithuserGuid:user.Guid companyId:user.companyId productId:self.productId productName:arr_contents[0] GuoBiaoCode:arr_contents[1] productType:arr_contents[2] productDesc:arr_contents[3] indexJson:tstr And:^(NSDictionary *dic) {
            if ([dic[Y_STATUS] integerValue]==200) {
                hud.label.text =dic[Y_MSG];
                dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(0.6 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
                    [hud hideAnimated:NO];
                    if ([dic[Y_STATUS] integerValue]==200) {
                        [self.navigationController popViewControllerAnimated:NO];
                    }
                });
            }
        }];
    }else if (self.temp ==1)
    {
        MBProgressHUD *hud = [MBProgressHUD showHUDAddedTo:self.view animated:YES];
        hud.mode = MBProgressHUDModeAnnularDeterminate;
        hud.label.text = @"正在提交";
        [WebRequest ComSpace_ComSpaceProduct_ProductBuyer_Add_ProductBuyerWithuserGuid:user.Guid companyId:user.companyId productId:self.productId productName:arr_contents[0] GuoBiaoCode:arr_contents[1] productType:arr_contents[2] productDesc:arr_contents[3] indexJson:tstr And:^(NSDictionary *dic) {
            if ([dic[Y_STATUS] integerValue]==200) {
                hud.label.text =dic[Y_MSG];
                dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(0.6 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
                    [hud hideAnimated:NO];
                    if ([dic[Y_STATUS] integerValue]==200) {
                        [self.navigationController popViewControllerAnimated:NO];
                    }
                });
            }
        }];
    }else
    {
        
    }
}
-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    if (indexPath.section ==0) {
        return 60;
    }else if(indexPath.section ==1)
    {
        return 110;
    }else
    {
        return 110;
    }
}
#pragma  mark - 表的数据源
-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    if (section ==0) {
        return  arr_contents.count;
    }else if(section ==1)
    {
        return arr_model.count;
    }else
    {
        return arr_product.count;
    }
  
}
-(UITableViewCell*)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    if (indexPath.section ==0) {
        static NSString *cellId=@"cellID0";
        UITableViewCell *cell =[tableView dequeueReusableCellWithIdentifier:cellId];
        if (!cell) {
            cell = [[UITableViewCell alloc]initWithStyle:UITableViewCellStyleValue1 reuseIdentifier:cellId];
            cell.accessoryType = UITableViewCellAccessoryDisclosureIndicator;
            cell.textLabel.font = [UIFont systemFontOfSize:18];
        }
        cell.textLabel.text = arr_names[indexPath.row];
        cell.detailTextLabel.text = arr_contents[indexPath.row];
        return cell;
    }else if(indexPath.section==1)
    {
        static NSString *cellId=@"cellID1";
        SC_productTableViewCell *cell =[tableView dequeueReusableCellWithIdentifier:cellId];
        if (!cell) {
            cell = [[SC_productTableViewCell alloc]initWithStyle:UITableViewCellStyleValue1 reuseIdentifier:cellId];
            cell.accessoryType = UITableViewCellAccessoryNone;
        }
        if (self.temp >1) {
            SC_maiMaiModel  *model = arr_model[indexPath.row];
            [cell.IV_img sd_setImageWithURL:[NSURL URLWithString:model.IndexImage] placeholderImage:[UIImage imageNamed:@"imageerro"]];
            NSMutableAttributedString *tstr = [[NSMutableAttributedString alloc]initWithString:[NSString stringWithFormat:@"指标：%@\n指标值：%@",model.IndexTypeKey,model.IndexTypeValue] attributes:@{NSFontAttributeName:[UIFont systemFontOfSize:17],NSForegroundColorAttributeName:[UIColor grayColor]}];
            
            cell.yl_contents.attributedText =tstr;
        }else
        {
           
        }
        
        return cell;
    }else if (indexPath.section ==2)
    {
        static NSString *cellId=@"cellID2";
        SC_productTableViewCell *cell =[tableView dequeueReusableCellWithIdentifier:cellId];
        if (!cell) {
            cell = [[SC_productTableViewCell alloc]initWithStyle:UITableViewCellStyleValue1 reuseIdentifier:cellId];
            cell.accessoryType = UITableViewCellAccessoryNone;
        }
        SC_productModel *model = arr_product[indexPath.row];
        [cell setModel_product:model];
        return cell;
    }else
    {
    return nil;
    }
}

-(NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    if (self.temp >1) {
        return 3;
    }else
    {
        return 2;
    }
}
-(CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section
{
        if (section==0) {
            return 2;
        }else
        {
            return 30 ;
        }
   
}
-(NSString*)tableView:(UITableView *)tableView titleForHeaderInSection:(NSInteger)section
{
    if (section ==2) {
        return @"根据需求匹配的产品";
    }else if (section ==1)
    {
        return @"指标";
    }
    else
    {
        return nil;
    }
}
#pragma  mark - 表的协议代理
-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    if (indexPath.section ==0) {
    if (indexPath.row ==0 || indexPath.row ==1) {
        FBTextFieldViewController *TFvc =[[FBTextFieldViewController alloc]init];
        TFvc.delegate =self;
        TFvc.indexPath =indexPath;
        TFvc.content =arr_contents[indexPath.row];
        TFvc.contentTitle =arr_names[indexPath.row];
        [self.navigationController pushViewController:TFvc animated:NO];
    }else if (indexPath.row ==2)
    {
        FBHangYeViewController  *HYvc = [[FBHangYeViewController alloc]init];
        HYvc.delegate =self;
        HYvc.indexPath =indexPath;
        [self.navigationController pushViewController:HYvc animated:NO];
    }else if (indexPath.row ==3)
    {
        FBTextVViewController *TVvc =[[FBTextVViewController alloc]init];
        TVvc.indexpath =indexPath;
        TVvc.delegate =self;
        TVvc.contentTitle=arr_names[indexPath.row];
        TVvc.content =arr_contents[indexPath.row];
        [self.navigationController pushViewController:TVvc animated:NO];
    }else if (indexPath.row ==4)
    {
        //产品指标特性
        MM_zhiBiaoAddViewController  *Avc = [[MM_zhiBiaoAddViewController alloc]init];
        Avc.delegate_zhibiao =self;
        [self.navigationController pushViewController:Avc animated:NO];
    }else
    {
        
    }
    }else if (indexPath.section ==2)
    {
        SC_productModel *model = arr_product[indexPath.row];
        SC_productDetailViewController  *Dvc =[[SC_productDetailViewController alloc]init];
        Dvc.equipmentId = model.Id;
        [self.navigationController pushViewController:Dvc animated:NO];
        
    }else
    {
        
    }
}

-(CGFloat)tableView:(UITableView *)tableView heightForFooterInSection:(NSInteger)section
{
    if (section ==2) {
        return 40;
    }else
    {
        return 1;
    }
}
-(UIView*)tableView:(UITableView *)tableView viewForFooterInSection:(NSInteger)section
{
    if (section ==2 && arr_product.count>0) {
        FBButton *tbtn = [FBButton buttonWithType:UIButtonTypeSystem];
        [tbtn setTitle:@"查看更多匹配产品" titleColor:[UIColor whiteColor] backgroundColor:EQDCOLOR font:[UIFont systemFontOfSize:21]];
        [tbtn addTarget:self action:@selector(loadMoreProduct) forControlEvents:UIControlEventTouchUpInside];
        
        return tbtn;
    }else
    {
        return nil;
    }
}

-(BOOL)tableView:(UITableView *)tableView canEditRowAtIndexPath:(NSIndexPath *)indexPath
{
    return YES;
}

-(UITableViewCellEditingStyle)tableView:(UITableView *)tableView editingStyleForRowAtIndexPath:(NSIndexPath *)indexPath
{
    
    if (indexPath.section ==1 && self.temp >1) {
        return UITableViewCellEditingStyleDelete;
    }else
    {
        return UITableViewCellEditingStyleNone;
    }
    
    
}
-(void)tableView:(UITableView *)tableView commitEditingStyle:(UITableViewCellEditingStyle)editingStyle forRowAtIndexPath:(NSIndexPath *)indexPath
{
    
    if (editingStyle == UITableViewCellEditingStyleDelete) {
        //删除指标
        SC_productModel *model = arr_model[indexPath.row];
        if (self.temp ==2) {
            //供方指标
            [WebRequest ComSpace_ComSpaceProduct_ProductSupply_Delete_ProductSupplyIndexWithuserGuid:user.Guid companyId:user.companyId buyerIndexId:model.Id And:^(NSDictionary *dic) {
                MBFadeAlertView *alert = [[MBFadeAlertView alloc]init];
                
                if ([dic[Y_STATUS] integerValue]==200) {
                    [alert showAlertWith:@"删除成功"];
                    [arr_model removeObject:model];
                    [tableV reloadSections:[NSIndexSet indexSetWithIndex:1] withRowAnimation:UITableViewRowAnimationNone];
                }else
                {
                    [alert showAlertWith:@"服务器错误，请重试！"];
                }
            }];
        }else if (self.temp ==3)
        {
            //买方指标
            
            [WebRequest ComSpace_ComSpaceProduct_ProductBuyer_Delete_ProductBuyerIndexWithuserGuid:user.Guid companyId:user.companyId buyerIndexId:model.Id And:^(NSDictionary *dic) {
                MBFadeAlertView *alert = [[MBFadeAlertView alloc]init];
                
                if ([dic[Y_STATUS] integerValue]==200) {
                    [alert showAlertWith:@"删除成功"];
                    [arr_model removeObject:model];
                    [tableV reloadSections:[NSIndexSet indexSetWithIndex:1] withRowAnimation:UITableViewRowAnimationNone];
                }else
                {
                    [alert showAlertWith:@"服务器错误，请重试！"];
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
