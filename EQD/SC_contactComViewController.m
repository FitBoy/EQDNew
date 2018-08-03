//
//  SC_contactComViewController.m
//  EQD
//
//  Created by 梁新帅 on 2018/6/25.
//  Copyright © 2018年 FitBoy. All rights reserved.
//

#import "SC_contactComViewController.h"
#import <YYText.h>
#import <Masonry.h>
@interface SC_contactComViewController ()
{
    UserModel *user;
    NSArray *arr_names;
    NSArray *arr_contents;
    YYLabel *YL_contents;
}

@end

@implementation SC_contactComViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.navigationItem.title = @"企业联系方式";
    user = [WebRequest GetUserInfo];
    YL_contents = [[YYLabel alloc]init];
    YL_contents.numberOfLines =0;
    [self.view addSubview:YL_contents];
    [WebRequest ComSpace_ComSpace_Contact_Get_ComSpaceContactWithcompanyId:user.companyId And:^(NSDictionary *dic) {
        if([dic[Y_STATUS] integerValue]==200)
        {
            NSDictionary  *tdic = dic[Y_ITEMS];
            if (tdic ==nil) {
                UIAlertController  *alert = [UIAlertController alertControllerWithTitle:@"暂无，请去企业空间添加" message:nil preferredStyle:UIAlertControllerStyleAlert];
                [alert addAction:[UIAlertAction actionWithTitle:@"确定" style:UIAlertActionStyleCancel handler:^(UIAlertAction * _Nonnull action) {
                    
                }]];
                [self presentViewController:alert animated:NO completion:nil];
                
            }else
            {
                NSMutableAttributedString *contents = [[NSMutableAttributedString alloc]initWithString:[NSString stringWithFormat:@"企业邮箱：%@\n联系电话：%@  %@\n 联系人：%@\n企业地址：%@",tdic[@"Email"],tdic[@"ContactNumber"],tdic[@"SeatMachine"],tdic[@"Contacts"],tdic[@"Address"]] attributes:@{NSFontAttributeName:[UIFont systemFontOfSize:16],NSForegroundColorAttributeName:[UIColor grayColor]}];
                contents.yy_lineSpacing =7;
//                contents.yy_alignment = NSTextAlignmentCenter;
                CGSize size = [contents boundingRectWithSize:CGSizeMake(DEVICE_WIDTH-30, MAXFLOAT) options:NSStringDrawingUsesLineFragmentOrigin context:nil].size;
                
                YL_contents.attributedText = contents;
                [YL_contents mas_remakeConstraints:^(MASConstraintMaker *make) {
                    make.centerY.mas_equalTo(self.view.mas_centerY);
                    make.height.mas_equalTo(size.height+10);
                    make.left.mas_equalTo(self.view.mas_left).mas_offset(15);
                    make.right.mas_equalTo(self.view.mas_right).mas_offset(-15);
                }];
            }
        }
    }];
}



@end
