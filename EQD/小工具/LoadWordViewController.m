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
   
    if (self.html) {
        NSString * htmlString = [NSString stringWithFormat:@"<html><body style = \"font-size:17px\">%@</body></html>",self.html];
      CGSize  size = [htmlString boundingRectWithSize:CGSizeMake(DEVICE_WIDTH-30, MAXFLOAT) options:NSStringDrawingUsesLineFragmentOrigin attributes:@{NSFontAttributeName:[UIFont systemFontOfSize:17]} context:nil].size;
        NSAttributedString * attrStr = [[NSAttributedString alloc] initWithData:[htmlString dataUsingEncoding:NSUnicodeStringEncoding] options:@{ NSDocumentTypeDocumentAttribute: NSHTMLTextDocumentType } documentAttributes:nil error:nil];
        UILabel *tlabel =[[UILabel alloc]initWithFrame:CGRectMake(15, 5, DEVICE_WIDTH-30, size.height+20)];
        tlabel.numberOfLines=0;
        [scrollV addSubview:tlabel];
        tlabel.attributedText =attrStr;
        scrollV.contentSize =CGSizeMake(DEVICE_WIDTH, size.height+40>DEVICE_HEIGHT?size.height+40:DEVICE_HEIGHT);
      
    }
    else
    {
    CGSize size =[self.content boundingRectWithSize:CGSizeMake(DEVICE_WIDTH-30, MAXFLOAT) options:NSStringDrawingUsesLineFragmentOrigin attributes:@{NSFontAttributeName:[UIFont systemFontOfSize:17]} context:nil].size;
    UILabel *tlabel =[[UILabel alloc]initWithFrame:CGRectMake(15, 5, DEVICE_WIDTH-30, size.height+20)];
    tlabel.numberOfLines=0;
    [scrollV addSubview:tlabel];
    tlabel.text =self.content;
    tlabel.font =[UIFont systemFontOfSize:17];
    scrollV.contentSize =CGSizeMake(DEVICE_WIDTH, size.height+40>DEVICE_HEIGHT?size.height+40:DEVICE_HEIGHT);
    }
    
}


@end
