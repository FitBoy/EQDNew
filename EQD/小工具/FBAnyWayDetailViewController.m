//
//  FBAnyWayDetailViewController.m
//  EQD
//
//  Created by 梁新帅 on 2018/1/15.
//  Copyright © 2018年 FitBoy. All rights reserved.
//

#import "FBAnyWayDetailViewController.h"
#import "EQDR_labelTableViewCell.h"
#import <Masonry.h>
@interface FBAnyWayDetailViewController ()<UITableViewDelegate,UITableViewDataSource>
{
    UITableView *tableV;
}

@end

@implementation FBAnyWayDetailViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.navigationItem.title = self.Dtitle;
    tableV = [[UITableView alloc]initWithFrame:CGRectMake(0, DEVICE_TABBAR_Height, DEVICE_WIDTH, DEVICE_HEIGHT-DEVICE_TABBAR_Height-kBottomSafeHeight) style:UITableViewStylePlain];
    adjustsScrollViewInsets_NO(tableV, self);
    tableV.delegate=self;
    tableV.dataSource=self;
    [self.view addSubview:tableV];
    
}
-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    AnyWayModel *model =_arr_json[indexPath.row];
    return model.cellHeight;
}
#pragma  mark - 表的数据源
-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return self.arr_json.count;
}
-(UITableViewCell*)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    static NSString *cellId=@"cellID";
    EQDR_labelTableViewCell *cell =[tableView dequeueReusableCellWithIdentifier:cellId];
    if (!cell) {
        cell = [[EQDR_labelTableViewCell alloc]initWithStyle:UITableViewCellStyleDefault reuseIdentifier:cellId];
        cell.accessoryType = UITableViewCellAccessoryNone;
    }
    AnyWayModel *model =self.arr_json[indexPath.row];
   
    NSMutableAttributedString  *name =[[NSMutableAttributedString alloc]initWithString:[NSString stringWithFormat:@"%@:",model.name] attributes:@{NSFontAttributeName:[UIFont systemFontOfSize:15],NSForegroundColorAttributeName:[UIColor grayColor]}];
    NSMutableAttributedString *content = [[NSMutableAttributedString alloc]initWithString:model.contents attributes:@{NSFontAttributeName:[UIFont systemFontOfSize:17]}];
    [name appendAttributedString:content];
//name.yy_lineSpacing =6;
    cell.YL_label.attributedText = name;
    CGSize size = [name boundingRectWithSize:CGSizeMake(DEVICE_WIDTH-30, MAXFLOAT) options:NSStringDrawingUsesLineFragmentOrigin context:nil].size;
    model.cellHeight = size.height+15;
    [cell.YL_label mas_remakeConstraints:^(MASConstraintMaker *make) {
        make.height.mas_equalTo(size.height+5);
        make.centerY.mas_equalTo(cell.mas_centerY);
        make.left.mas_equalTo(cell.mas_left).mas_offset(15);
        make.right.mas_equalTo(cell.mas_right).mas_offset(-15);
    }];
    return cell;
}

@end
