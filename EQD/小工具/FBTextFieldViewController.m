//
//  FBTextFieldViewController.m
//  EQD
//
//  Created by 梁新帅 on 2017/3/25.
//  Copyright © 2017年 FitBoy. All rights reserved.
//

#import "FBTextFieldViewController.h"

@interface FBTextFieldViewController ()<UITextFieldDelegate,UITableViewDelegate,UITableViewDataSource>
{
    UITextField *TF_content;
    UITableView *tableV;
    NSMutableArray *arr_model;
}

@end

@implementation FBTextFieldViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    arr_model = [NSMutableArray arrayWithCapacity:0];
    TF_content = [[UITextField alloc]initWithFrame:CGRectMake(0, DEVICE_TABBAR_Height+5, DEVICE_WIDTH, 45)];
    [self.view addSubview:TF_content];
    TF_content.clearButtonMode = UITextFieldViewModeAlways;
    TF_content.borderStyle = UITextBorderStyleRoundedRect;
    TF_content.text = self.content;
    self.navigationItem.title =self.contentTitle;
    TF_content.delegate =self;
    TF_content.keyboardType = self.keyBoardType;
    
    
    if (self.contentTishi.length>0) {
        
        
        NSMutableParagraphStyle *para =[[NSMutableParagraphStyle alloc]init];
        para.lineSpacing =8;
        NSMutableAttributedString  *attrstr =[[NSMutableAttributedString alloc]initWithString:self.contentTishi attributes:@{NSFontAttributeName:[UIFont systemFontOfSize:13],NSParagraphStyleAttributeName:para}];
        CGSize size =[attrstr boundingRectWithSize:CGSizeMake(DEVICE_WIDTH-30, MAXFLOAT) options:NSStringDrawingUsesLineFragmentOrigin context:nil].size;
        
        UILabel *tlabel =[[ UILabel alloc]initWithFrame:CGRectMake(15, DEVICE_TABBAR_Height+50, DEVICE_WIDTH-30, size.height)];
        [self.view addSubview:tlabel];
        tlabel.numberOfLines =0;
        tlabel.textColor = [UIColor grayColor];
        tlabel.attributedText = attrstr;
    }
    
    UIBarButtonItem *right =[[UIBarButtonItem alloc]initWithTitle:@"确定" style:UIBarButtonItemStylePlain target:self action:@selector(quedingClick)];
    
    [self.navigationItem setRightBarButtonItem:right];
    [TF_content becomeFirstResponder];
    
    tableV = [[UITableView alloc]initWithFrame:CGRectMake(0, DEVICE_TABBAR_Height+50, DEVICE_WIDTH, DEVICE_HEIGHT-DEVICE_TABBAR_Height-kBottomSafeHeight-50) style:UITableViewStylePlain];
    adjustsScrollViewInsets_NO(tableV, self);
    tableV.delegate=self;
    tableV.dataSource=self;
    [self.view addSubview:tableV];
    tableV.rowHeight=50;
    tableV.hidden =YES;
   }
-(void)quedingClick{
    
    if (TF_content.text.length==0) {
        MBProgressHUD *hud=[MBProgressHUD showHUDAddedTo:self.view  animated:YES];
        hud.mode = MBProgressHUDModeText;
        hud.label.text =@"输入内容不能为空";
        dispatch_time_t popTime = dispatch_time(DISPATCH_TIME_NOW, 1 * NSEC_PER_SEC);
        dispatch_after(popTime, dispatch_get_main_queue(), ^(void){
            [MBProgressHUD hideHUDForView:self.view  animated:YES];
        });
    }
    else
    {
    ///确定修改内容
    if ([self.delegate respondsToSelector:@selector(content:WithindexPath:)]) {
        [self.delegate content:TF_content.text WithindexPath:self.indexPath];
    }
    [self.navigationController popViewControllerAnimated:NO];
    }
    
}
-(void)textFieldDidBeginEditing:(UITextField *)textField
{
    if ([textField.text isEqualToString:@"请输入"]) {
        textField.text = nil;
    }
}


- (BOOL)textField:(UITextField *)textField shouldChangeCharactersInRange:(NSRange)range replacementString:(NSString *)string
{
    NSString *searchText = [textField.text stringByReplacingCharactersInRange:range withString:string];
    NSLog(@"=最终的字=%@",searchText);
    if (self.temp==1) {
        /// 客户名称的搜索
        [WebRequest getKehuNameFromTianyanChaWithKey:searchText And:^(NSDictionary *dic) {
            if([dic[@"state"] isEqualToString:@"ok"])
            {
                [arr_model removeAllObjects];
                NSArray *tarr = dic[@"data"];
                for (int i=0; i<tarr.count; i++) {
                    NSDictionary *tdic = tarr[i];
                    [arr_model addObject:tdic];
                }
                
                dispatch_async(dispatch_get_main_queue(), ^{
                    tableV.hidden = NO;
                  [tableV reloadData];
                });
               
            }
        }];
    }
    
    
    return YES;
}

#pragma  mark - 表的数据源
-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return arr_model.count;
}
-(UITableViewCell*)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    static NSString *cellId=@"cellID";
    UITableViewCell *cell =[tableView dequeueReusableCellWithIdentifier:cellId];
    if (!cell) {
        cell = [[UITableViewCell alloc]initWithStyle:UITableViewCellStyleDefault reuseIdentifier:cellId];
        cell.accessoryType = UITableViewCellAccessoryDisclosureIndicator;
        cell.textLabel.font = [UIFont systemFontOfSize:18];
    }
    NSDictionary *tdic = arr_model[indexPath.row];
    cell.textLabel.text = tdic[@"name"];
    return cell;
}

#pragma  mark - 表的协议代理
-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    tableView.hidden = YES;
    NSDictionary *tdic = arr_model[indexPath.row];
    TF_content.text =tdic[@"name"];
}

@end
