//
//  SC_productDetailViewController.m
//  EQD
//
//  Created by 梁新帅 on 2018/7/4.
//  Copyright © 2018年 FitBoy. All rights reserved.
// 企业信息  联系方式 留言 

#import "SC_productDetailViewController.h"
#import "SC_productModel.h"
#import "FBScrollView.h"
#import "FBLabel_YYAddTableViewCell.h"
#import <Masonry.h>
#import "FBTwoButtonView.h"
#import "WS_comDetailViewController.h"
#import "WS_contactModel.h"
#import "FB_ShareEQDViewController.h"
#import "EQD_HtmlTool.h"
#import "SC_MaiMaiViewController.h"
#import "BottomMoreView.h"
#import "FB_OnlyForLiuYanViewController.h"
@interface SC_productDetailViewController ()<UITableViewDelegate,UITableViewDataSource,UIWebViewDelegate,FB_OnlyForLiuYanViewControllerDlegate>
{
    UITableView *tableV;
    SC_productModel *model_detail;
    float height_1;
    float height_2;
    BottomMoreView *btn_more;
    WS_contactModel *model_contact;
    UserModel *user;
    
    UITableView  *tableV1;
    NSArray *arr_names1;

}

@end

@implementation SC_productDetailViewController
-(void)viewWillAppear:(BOOL)animated{
    [super viewWillAppear:animated];
    [self loadRequestData];
}
-(void)loadRequestData{
    [WebRequest ComSpace_ComSpaceProduct_Get_ComSpaceProductByIdWithequipmentId:self.equipmentId And:^(NSDictionary *dic) {
        if ([dic[Y_STATUS] integerValue]==200) {
            model_detail = [SC_productModel mj_objectWithKeyValues:dic[Y_ITEMS]];
            [tableV reloadData];
            static dispatch_once_t onceToken;
            dispatch_once(&onceToken, ^{
                if (model_detail) {
                [WebRequest ComSpace_ComSpaceVisitor_Add_ComSpaceVisitorWithuserGuid:user.Guid userCompanyId:user.companyId mudular:@"产品信息" companyId:model_detail.CompanyId option:[NSString stringWithFormat:@"访问了产品：%@",model_detail.productName]  And:^(NSDictionary *dic) {
                    
                }];
                }
            });
        }
    }];
    
   
}

-(void)webViewDidFinishLoad:(UIWebView *)webView
{
    NSString *htmlHeight = [webView stringByEvaluatingJavaScriptFromString:@"document.body.scrollHeight"];
    height_2 = [htmlHeight floatValue]+5;
    webView.frame=CGRectMake(15, 0, DEVICE_WIDTH-30, height_2);
    [tableV reloadRowsAtIndexPaths:@[[NSIndexPath indexPathForRow:2 inSection:0]] withRowAnimation:UITableViewRowAnimationNone];
}
- (BOOL)prefersHomeIndicatorAutoHidden{
    return NO;
}
- (void)viewDidLoad {
    [super viewDidLoad];
    user = [WebRequest GetUserInfo];
    self.navigationItem.title = @"产品信息详情";
    height_1 =60;
    height_2=60;
    tableV = [[UITableView alloc]initWithFrame:CGRectMake(0, DEVICE_TABBAR_Height, DEVICE_WIDTH, DEVICE_HEIGHT-DEVICE_TABBAR_Height-kBottomSafeHeight-40) style:UITableViewStylePlain];
    adjustsScrollViewInsets_NO(tableV, self);
    tableV.delegate=self;
    tableV.dataSource=self;
    [self.view addSubview:tableV];
    tableV.rowHeight=60;
    
    btn_more = [[BottomMoreView alloc]initWithFrame:CGRectMake(0, DEVICE_HEIGHT-kBottomSafeHeight-40, DEVICE_WIDTH, 40)];
    [self.view addSubview:btn_more];
   
    [btn_more setMorename:@"更多" right:@"采购" center:@"打电话"        ];
    [btn_more.B_more addTarget:self action:@selector(btn_more) forControlEvents:UIControlEventTouchUpInside];
    [btn_more.B_center addTarget:self action:@selector(ContactClick) forControlEvents:UIControlEventTouchUpInside];
    [btn_more.B_right addTarget:self action:@selector(caigouClick) forControlEvents:UIControlEventTouchUpInside];
    
   
    
    UIBarButtonItem  *right = [[UIBarButtonItem alloc]initWithImage:[UIImage imageNamed:@"EQD_more"] style:UIBarButtonItemStyleDone target:self action:@selector(moreClick)];
    [self.navigationItem setRightBarButtonItem:right];
    
    ///弹出框
    arr_names1 = @[@"留言",@"收藏",@"企业信息"];
    tableV1 = [[UITableView alloc]initWithFrame:CGRectMake(0, DEVICE_HEIGHT-kBottomSafeHeight-40-arr_names1.count*50-2, DEVICE_WIDTH/3.0+10, arr_names1.count*50) style:UITableViewStylePlain];
    tableV1.backgroundColor = [UIColor redColor];
    adjustsScrollViewInsets_NO(tableV1, self);
    tableV1.delegate=self;
    tableV1.dataSource=self;
    [self.view addSubview:tableV1];
    tableV1.rowHeight=60;
    tableV1.hidden = YES;


}
#pragma  mark - 采购
-(void)caigouClick
{
    
}
-(void)scrollViewDidScroll:(UIScrollView *)scrollView
{
    tableV1.hidden = YES;
}
#pragma  mark - 底部的更多
-(void)btn_more
{
    tableV1.hidden = !tableV1.hidden;
}
-(void)moreClick
{
    UIAlertController  *alert = [[UIAlertController alloc]init];
    [alert addAction:[UIAlertAction actionWithTitle:@"分享" style:UIAlertActionStyleDefault handler:^(UIAlertAction * _Nonnull action) {
        
        /*String title;
         String content;
         String url;
         String imgUrl;
         String source;
         String sourceOwner;
         articleId
         type
         */
        FB_ShareEQDViewController  *Svc = [[FB_ShareEQDViewController alloc]init];
        Svc.EQD_ShareType = EQD_ShareTypeLink;
        Svc.Stitle = model_detail.ProductName;
        Svc.text = model_detail.ProductMsg;
        Svc.url =[EQD_HtmlTool getProductDetailWithId:model_detail.Id];
        Svc.imageURL =model_detail.images[0];
        Svc.source = @"企业空间";
        Svc.sourceOwner = user.Guid;
        Svc.articleId = model_detail.Id;
        Svc.type2 = 1;
        
        Svc.providesPresentationContextTransitionStyle = YES;
        Svc.definesPresentationContext = YES;
        Svc.modalPresentationStyle = UIModalPresentationOverCurrentContext;
        [self presentViewController:Svc animated:NO completion:nil];
        
        
    }]];
    if([user.companyId isEqualToString:model_detail.CompanyId])
    {
    [alert addAction:[UIAlertAction actionWithTitle:@"查看产品供方信息" style:UIAlertActionStyleDefault handler:^(UIAlertAction * _Nonnull action) {
        SC_MaiMaiViewController *MMvc = [[SC_MaiMaiViewController alloc]init];
        MMvc.temp =0;
        MMvc.productId = model_detail.Id;
        [self.navigationController pushViewController:MMvc animated:NO];
        
    }]];
    [alert addAction:[UIAlertAction actionWithTitle:@"查看产品买方信息" style:UIAlertActionStyleDefault handler:^(UIAlertAction * _Nonnull action) {
        SC_MaiMaiViewController *MMvc = [[SC_MaiMaiViewController alloc]init];
        MMvc.temp =1;
        MMvc.productId = model_detail.Id;
        [self.navigationController pushViewController:MMvc animated:NO];
        
    }]];
        [alert addAction:[UIAlertAction actionWithTitle:@"收藏" style:UIAlertActionStyleDefault handler:^(UIAlertAction * _Nonnull action) {
           
            if ([user.isAdmin integerValue] >0) {
                
            [WebRequest ComSpace_ComSpace_Collection_Add_ComSpaceCollectionWithuserGuid:user.Guid userCompanyId:user.companyId objectId:model_detail.Id objectType:@"1" objectCompanyId:model_detail.CompanyId And:^(NSDictionary *dic) {
                MBFadeAlertView *alertV = [[MBFadeAlertView alloc]init];
                if ([dic[Y_STATUS] integerValue]==200) {
                    [alertV showAlertWith:@"收藏成功"];
                }else
                {
                    [alertV showAlertWith:dic[Y_MSG]];
                }
            }];
            }
                [WebRequest Makerspacey_MakerCollection_Add_MakerCollectionWithuserCompanyId:user.companyId objectId:model_detail.Id objectType:@"1" objectGuid:@" " objectCompanyId:model_detail.CompanyId userGuid:user.Guid And:^(NSDictionary *dic) {
                    MBFadeAlertView *alertV = [[MBFadeAlertView alloc]init];
                    if ([dic[Y_STATUS] integerValue]==200) {
                        [alertV showAlertWith:@"收藏成功"];
                    }else
                    {
                    [alertV showAlertWith:dic[Y_MSG]];
                    }
                }];
            
                
        }]];
            
    }
    [alert addAction:[UIAlertAction actionWithTitle:@"取消" style:UIAlertActionStyleCancel handler:^(UIAlertAction * _Nonnull action) {
        
    }]];
    [self presentViewController:alert animated:NO completion:nil];
}
-(void)qiyeClick
{
    WS_comDetailViewController *Dvc = [[WS_comDetailViewController alloc]init];
    Dvc.comId = model_detail.CompanyId;
    [self.navigationController pushViewController:Dvc animated:NO];
}
-(void)ContactClick
{
    [WebRequest ComSpace_ComSpace_Contact_Get_ComSpaceContactWithcompanyId:model_detail.CompanyId And:^(NSDictionary *dic) {
        if ([dic[Y_STATUS] integerValue]==200) {
            model_contact = [WS_contactModel mj_objectWithKeyValues:dic[Y_ITEMS]];
            dispatch_async(dispatch_get_main_queue(), ^{
                NSMutableString *str = [[NSMutableString alloc] initWithFormat:@"tel:%@",model_contact.ContactNumber];
                UIWebView *callWebView = [[UIWebView alloc] init];
                [callWebView loadRequest:[NSURLRequest requestWithURL:[NSURL URLWithString:str]]];
                [self.view addSubview:callWebView];
            });
        }
    }];
}
-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    if (tableV1 ==tableView) {
        return 50;
    }else if(tableV == tableView)
    {
    if (indexPath.row ==0) {
        return 200;
    }else if (indexPath.row ==1)
    {
        return height_1;
    }else if (indexPath.row == 2)
    {
        return height_2+5;
    }
    else
    {
    return 60;
    }
    }else
    {
        return 0;
    }
}
#pragma  mark - 表的数据源
-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    if (tableV ==tableView) {
        if (model_detail) {
            return 3;
        }else
        {
            return 0;
        }
    }else if(tableV1 ==tableView)
    {
        return arr_names1.count;
    }else
    {
        return 0;
    }
  
}
-(UITableViewCell*)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    if (tableView ==tableV) {
    if (indexPath.row ==0) {
        static NSString *cellid = @"cellid0";
        
        UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:cellid];
        if (!cell) {
            cell = [[UITableViewCell alloc]initWithStyle:UITableViewCellStyleDefault reuseIdentifier:cellid];
            FBScrollView  *ScrollV =[[FBScrollView alloc]initWithFrame:CGRectMake(15, 0, DEVICE_WIDTH-30, 200)];
            [ScrollV setArr_urls:model_detail.images];
            [cell addSubview:ScrollV];
        }else
        {
            
        }
        return cell;
    }else if (indexPath.row ==1)
    {
        static NSString *cellid = @"cellid1";
        
        FBLabel_YYAddTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:cellid];
        if(!cell)
        {
        cell = [[FBLabel_YYAddTableViewCell alloc]initWithStyle:UITableViewCellStyleDefault reuseIdentifier:cellid];
        NSMutableAttributedString  *name =[[NSMutableAttributedString alloc]initWithString:[NSString stringWithFormat:@"%@(%@)\n国标代码：%@\n产品型号：%@\n单价：",model_detail.ProductName,model_detail.ProductType,model_detail.GuoBiaoCode,model_detail.productModel] attributes:@{NSFontAttributeName:  [UIFont systemFontOfSize:15]}];
        NSMutableAttributedString *price = [[NSMutableAttributedString alloc]initWithString:[NSString stringWithFormat:@"￥%@",model_detail.ProductPrice] attributes:@{NSFontAttributeName:[UIFont systemFontOfSize:15],NSForegroundColorAttributeName:[UIColor redColor]}];
        [name appendAttributedString:price];
        
        NSMutableAttributedString *Other = [[NSMutableAttributedString alloc]initWithString:[NSString stringWithFormat:@"元\n库存数：%@\n发货周期：%@ ~ %@天\n发货地址：%@",model_detail.Stock,model_detail.DeliveryCycle,model_detail.DeliveryCycle2,model_detail.area] attributes:@{NSFontAttributeName:[UIFont systemFontOfSize:15]}];
        [name appendAttributedString:Other];
        name.yy_lineSpacing =6;
        CGSize size = [name boundingRectWithSize:CGSizeMake(DEVICE_WIDTH-30, MAXFLOAT) options:NSStringDrawingUsesLineFragmentOrigin context:nil].size;
        height_1 =size.height+15;
        cell.YL_content.attributedText = name;
        [cell.YL_content mas_remakeConstraints:^(MASConstraintMaker *make) {
            make.height.mas_equalTo(size.height+10);
            make.left.mas_equalTo(cell.mas_left).mas_offset(15);
            make.right.mas_equalTo(cell.mas_right).mas_offset(-15);
            make.centerY.mas_equalTo(cell.mas_centerY);
        }];
        }else
        {
            
        }
        return cell;
        
    }else if (indexPath.row ==2)
    {
        static NSString *cellid = @"cellid0";
        
        UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:cellid];
        
        if(!cell)
        {
            
            cell = [[UITableViewCell alloc]initWithStyle:UITableViewCellStyleDefault reuseIdentifier:cellid];
        NSString * htmlString = [NSString stringWithFormat:@"<html><body style = \"font-size:17px\"> <p style = \"font-size:19px\">产品信息</p>%@</body></html>",model_detail.ProductInfo];
      
        height_2 =60;
        UIWebView *webView =[[UIWebView alloc]initWithFrame:CGRectMake(15, 0, DEVICE_WIDTH-30, 60)];
        webView.scrollView.scrollEnabled =NO;
        webView.delegate = self;
        [webView loadHTMLString:htmlString baseURL:nil];
        
        
        [cell addSubview:webView];
        
        }else
        {
            
        }
        return cell;
        
    }
    else
    {
        
        
        return nil;
    }
    }else if (tableV1 ==tableView)
    {
        static NSString *cellid = @"cellid11";
        
        UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:cellid];
        
        if(!cell)
        {
            cell = [[UITableViewCell alloc]initWithStyle:UITableViewCellStyleDefault reuseIdentifier:cellid];
            cell.textLabel.textAlignment = NSTextAlignmentCenter;
        }else
        {
            
        }
        cell.textLabel.text = arr_names1[indexPath.row];
        return cell;
    }else
    {
        return nil;
    }
   
}

#pragma  mark - 表的协议代理
-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
     tableV1.hidden = YES;
    
    if (tableView ==tableV1) {
       
        if (indexPath.row ==0) {
            //留言
            FB_OnlyForLiuYanViewController  *LYvc =[[FB_OnlyForLiuYanViewController alloc]init];
            LYvc.delegate =self;
            LYvc.providesPresentationContextTransitionStyle = YES;
            LYvc.definesPresentationContext = YES;
            LYvc.modalPresentationStyle = UIModalPresentationOverCurrentContext;
            LYvc.btnName = @"留言";
            LYvc.placeHolder =@"您对这个产品的兴趣点……";
            [self presentViewController:LYvc animated:NO completion:nil];
        }else if (indexPath.row ==1)
        {
            //收藏
            if(user.isAdmin >0)
            {
            [WebRequest ComSpace_ComSpace_Collection_Add_ComSpaceCollectionWithuserGuid:user.Guid userCompanyId:user.companyId objectId:model_detail.Id objectType:@"1" objectCompanyId:model_detail.CompanyId And:^(NSDictionary *dic) {
                MBFadeAlertView *alert = [[MBFadeAlertView alloc]init];
                if ([dic[Y_STATUS] integerValue]==200) {
                    [alert showAlertWith:@"收藏成功"];
                }else
                {
                    [alert showAlertWith:@"服务器错误，请重试！"];
                }
            }];
            }
            [WebRequest Makerspacey_MakerCollection_Add_MakerCollectionWithuserCompanyId:user.companyId objectId:model_detail.Id objectType:@"1" objectGuid:@" " objectCompanyId:model_detail.CompanyId userGuid:user.Guid And:^(NSDictionary *dic) {
                MBFadeAlertView *alert = [[MBFadeAlertView alloc]init];
                if ([dic[Y_STATUS] integerValue]==200) {
                    [alert showAlertWith:@"收藏成功"];
                }else
                {
                    [alert showAlertWith:@"服务器错误，请重试！"];
                }
            }];
            
        }else if (indexPath.row ==2)
        {
            //企业信息
            [self qiyeClick];
        }else
        {
            
        }
        
    }else
    {
        
    }
}

#pragma  mark - 留言
-(void)getPresnetText:(NSString *)text
{
    [WebRequest ComSpace_ComSpaceLeaveMessage_Add_ComSpaceLeaveMessageWithuserGuid:user.Guid userCompanyId:user.companyId message:text parentId:@"0" companyId:model_detail.CompanyId parentUserGuid:@" " firstCommentId:model_detail.Id And:^(NSDictionary *dic) {
        MBFadeAlertView *alert = [[MBFadeAlertView alloc]init];
        if ([dic[Y_STATUS] integerValue]==200) {
            [alert showAlertWith:@"留言成功"];
        }else
        {
            [alert showAlertWith:@"服务器错误，请重试！"];
        }
    }];
}



@end
