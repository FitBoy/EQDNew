//
//  FBTextFieldViewController.m
//  EQD
//
//  Created by 梁新帅 on 2017/3/25.
//  Copyright © 2017年 FitBoy. All rights reserved.
//

#import "FBTextFieldViewController.h"

@interface FBTextFieldViewController ()<UITextFieldDelegate>
{
    UITextField *TF_content;
}

@end

@implementation FBTextFieldViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    TF_content = [[UITextField alloc]initWithFrame:CGRectMake(15, DEVICE_TABBAR_Height, DEVICE_WIDTH-30, 45)];
    [self.view addSubview:TF_content];
    TF_content.clearButtonMode = UITextFieldViewModeAlways;
    TF_content.borderStyle = UITextBorderStyleRoundedRect;
    TF_content.text = self.content;
    self.navigationItem.title =self.contentTitle;
    TF_content.delegate =self;
    
    
    
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

@end
