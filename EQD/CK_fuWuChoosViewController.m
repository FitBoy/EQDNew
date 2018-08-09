//
//  CK_fuWuChoosViewController.m
//  EQD
//
//  Created by 梁新帅 on 2018/8/4.
//  Copyright © 2018年 FitBoy. All rights reserved.
//

#import "CK_fuWuChoosViewController.h"
#import <Masonry.h>
#import "FBunderLineTextField.h"
@interface CK_fuWuChoosViewController ()
{
    UIView *view_center;
    UISegmentedControl *segmentC;
    FBunderLineTextField *textfield1;
    FBunderLineTextField *textfield2;
}
@end

@implementation CK_fuWuChoosViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.navigationItem.title = @"服务方式";
    view_center = [[UIView alloc]init];
    [self.view addSubview:view_center];
    view_center.userInteractionEnabled = YES;
    
    view_center .frame = CGRectMake(0, DEVICE_TABBAR_Height+5, DEVICE_WIDTH, 130);
  
    
    segmentC =[[UISegmentedControl alloc]initWithItems:@[@"线下服务",@"电话服务",@"线上服务"]];
    segmentC.frame =CGRectMake(15, 0, DEVICE_WIDTH-30, 40);
    segmentC.selectedSegmentIndex=0;
    [view_center addSubview:segmentC];
    [segmentC addTarget:self action:@selector(loadRequestData) forControlEvents:UIControlEventValueChanged];
    
    textfield1 = [[FBunderLineTextField alloc]initWithFrame:CGRectMake(15, 45, 80, 40)];
    UILabel *tlabel1 = [[UILabel alloc]initWithFrame:CGRectMake(100, 45, 50, 40)];
    tlabel1.text =@"元/天";
    textfield2 = [[FBunderLineTextField alloc]initWithFrame:CGRectMake(15, 90, 80, 40)];
    UILabel *tlabel2 = [[UILabel alloc]initWithFrame:CGRectMake(100, 90, 60, 40)];
    tlabel2.text =@"元/小时";
    
    [view_center addSubview:textfield1];
    [view_center addSubview:textfield2];
    [view_center addSubview:tlabel1];
    [view_center addSubview:tlabel2];
    
    UIBarButtonItem *right = [[UIBarButtonItem alloc]initWithTitle:@"确定" style:UIBarButtonItemStylePlain target:self action:@selector(quedingClick)];
    [self.navigationItem setRightBarButtonItem:right];
}
-(void)quedingClick
{
    NSArray *tarr = @[@"线下服务",@"电话服务",@"线上服务"];
    NSString *fuwu = tarr[segmentC.selectedSegmentIndex];
    if ([self.delegate_fuwu respondsToSelector:@selector(getFuwu:dayTime:hourTime:index:)]) {
        [self.navigationController popViewControllerAnimated:NO];
        [self.delegate_fuwu getFuwu:fuwu dayTime:textfield1.text hourTime:textfield2.text index:[NSString stringWithFormat:@"ld",segmentC.selectedSegmentIndex]];
    }
}
-(void)loadRequestData
{
    
}



@end
