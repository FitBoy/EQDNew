//
//  EQDR_webviewTableViewCell.m
//  EQD
//
//  Created by 梁新帅 on 2017/12/19.
//  Copyright © 2017年 FitBoy. All rights reserved.
//

#import "EQDR_webviewTableViewCell.h"

@implementation EQDR_webviewTableViewCell
-(UIWebView*)webView
{
    if (!_webView) {
        _webView = [[UIWebView alloc]init];
        _webView.scrollView.scrollEnabled = NO;
        [self addSubview:_webView];
    }
    return _webView;
}
- (void)awakeFromNib {
    [super awakeFromNib];
    // Initialization code
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end
