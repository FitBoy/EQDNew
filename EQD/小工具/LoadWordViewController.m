//
//  LoadWordViewController.m
//  EQD
//
//  Created by 梁新帅 on 2017/8/2.
//  Copyright © 2017年 FitBoy. All rights reserved.
//

#import "LoadWordViewController.h"

@interface LoadWordViewController ()
{
    UIScrollView *scrollV;
}

@end

@implementation LoadWordViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.navigationItem.title =self.contentTitle==nil?@"详情":self.contentTitle;
    
    scrollV =[[UIScrollView alloc]initWithFrame:self.view.frame];
    [self.view addSubview:scrollV];
    CGSize size =[self.contentTitle boundingRectWithSize:CGSizeMake(DEVICE_WIDTH-30, MAXFLOAT) options:NSStringDrawingUsesLineFragmentOrigin attributes:@{NSFontAttributeName:[UIFont systemFontOfSize:17]} context:nil].size;
    UILabel *tlabel =[[UILabel alloc]initWithFrame:CGRectMake(15, 5, DEVICE_WIDTH-30, size.height+20)];
    tlabel.numberOfLines=0;
    [scrollV addSubview:tlabel];
    tlabel.text =self.content;
    tlabel.font =[UIFont systemFontOfSize:17];
    scrollV.contentSize =CGSizeMake(DEVICE_WIDTH, size.height+40>DEVICE_HEIGHT?size.height+40:DEVICE_HEIGHT);
    
}


@end
