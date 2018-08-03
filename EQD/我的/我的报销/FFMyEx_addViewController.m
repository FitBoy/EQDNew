//
//  FFMyEx_addViewController.m
//  EQD
//
//  Created by 梁新帅 on 2018/3/19.
//  Copyright © 2018年 FitBoy. All rights reserved.
//

#import "FFMyEx_addViewController.h"
#import "GNmodel.h"
#import "ImgScrollTableViewCell.h"
#import "EQDR_labelTableViewCell.h"
#import "FBLabel_segmentTableViewCell.h"
#import "FBButton.h"
#import <Masonry.h>
#import "FBTextVViewController.h"
#import "FBTextFieldViewController.h"
#import "FBBaoXiaoLeiBieViewController.h"
#import "FBShowimg_moreViewController.h"
@interface FFMyEx_addViewController ()<UITableViewDelegate,UITableViewDataSource,UIImagePickerControllerDelegate,UINavigationControllerDelegate,FBTextVViewControllerDelegate,FBTextFieldViewControllerDelegate,FBBaoXiaoLeiBieViewControllerDelegate,FBImgsScrollViewDelegate>
{
    UITableView *tableV;
    UserModel *user;
    NSMutableArray *arr_big;
    NSString *thethem;
    NSString *demand;
    float height;
    UIImagePickerController  *picker;
    NSIndexPath *indexPath_selected;
}

@end

@implementation FFMyEx_addViewController
#pragma  mark - 报销科目点击
-(void)getBaoXiaoLeiBieModel:(OptionModel *)model_baoxiao indexPath:(NSIndexPath *)indexPath
{
    NSArray *tarr = arr_big[indexPath.section-1];
    GNmodel *model =tarr[indexPath.row];
    model.content = model_baoxiao.name;
    NSMutableArray *tarr2 = [NSMutableArray arrayWithArray:tarr];
    [tarr2 replaceObjectAtIndex:indexPath.row withObject:model];
    [arr_big replaceObjectAtIndex:indexPath.section-1 withObject:tarr2];
    [tableV reloadRowsAtIndexPaths:@[indexPath] withRowAnimation:UITableViewRowAnimationNone];
}
#pragma  mark - 一行文本
-(void)content:(NSString *)content WithindexPath:(NSIndexPath *)indexPath
{
    if (indexPath.section==0) {
        thethem = content;
    }else
    {
        NSArray *tarr = arr_big[indexPath.section-1];
        NSMutableArray *tarr2 = [NSMutableArray arrayWithArray:tarr];
        GNmodel *model = tarr[indexPath.row];
        model.content = content;
        [tarr2 replaceObjectAtIndex:indexPath.row withObject:model];
        [arr_big replaceObjectAtIndex:indexPath.section-1 withObject:tarr2];
    }
    [tableV reloadRowsAtIndexPaths:@[indexPath] withRowAnimation:UITableViewRowAnimationNone];
    
}
#pragma  mark - 多行文本
-(void)textVtext:(NSString *)text indexPath:(NSIndexPath *)indexPath
{
    if (indexPath.section==arr_big.count+1) {
        demand = text;
    }else
    {
        NSArray *tarr = arr_big[indexPath.section-1];
        NSMutableArray *tarr2 = [NSMutableArray arrayWithArray:tarr];
        GNmodel *model = tarr[indexPath.row];
        model.content = text;
        [tarr2 replaceObjectAtIndex:indexPath.row withObject:model];
        [arr_big replaceObjectAtIndex:indexPath.section-1 withObject:tarr2];
    }
    [tableV reloadRowsAtIndexPaths:@[indexPath] withRowAnimation:UITableViewRowAnimationNone];
}
- (void)viewDidLoad {
    [super viewDidLoad];
    self.navigationItem.title = @"添加报销";
    user = [WebRequest GetUserInfo];
    arr_big = [NSMutableArray arrayWithCapacity:0];
     [arr_big addObject:[self setbaseData]];
    tableV = [[UITableView alloc]initWithFrame:CGRectMake(0, DEVICE_TABBAR_Height, DEVICE_WIDTH, DEVICE_HEIGHT-DEVICE_TABBAR_Height-kBottomSafeHeight) style:UITableViewStyleGrouped];
    adjustsScrollViewInsets_NO(tableV, self);
    tableV.delegate=self;
    tableV.dataSource=self;
    [self.view addSubview:tableV];
    tableV.rowHeight=60;
    tableV.contentInset = UIEdgeInsetsMake(15, 0, 0, 0);
    thethem=@"请输入";
    demand =@"请输入";
    height =60;
    picker = [[UIImagePickerController alloc]init];
    picker.delegate =self;
    if ([UIImagePickerController availableMediaTypesForSourceType:(UIImagePickerControllerSourceTypeCamera)]) {
        picker.sourceType = UIImagePickerControllerSourceTypeCamera;
    }
    picker.allowsEditing = NO;
    
    UIBarButtonItem *right = [[UIBarButtonItem alloc]initWithTitle:@"提交" style:UIBarButtonItemStylePlain target:self action:@selector(tijiaoCLick)];
    [self.navigationItem setRightBarButtonItem:right];
}
-(void)tijiaoCLick{
    NSInteger temp = 0;
    NSMutableArray *tarr0 = [NSMutableArray arrayWithCapacity:0];
    NSInteger total =0;
    if ([thethem isEqualToString:@"请输入"] || [demand isEqualToString:@"请输入"]) {
        temp =1;
    }else
    {
        for (int i=0; i<arr_big.count; i++) {
            if (temp==1) {
                break;
            }
            NSArray *tarr = arr_big[i];
            NSMutableDictionary *tdic = [[NSMutableDictionary alloc]initWithDictionary:@{@"billImage":@[],@"Enclosure":@[]}];
            for (int i=0; i<tarr.count; i++) {
                GNmodel *model = tarr[i];
                if (model.biaoji ==0 && ![model.content isEqualToString:@"请输入"]) {
                    [tdic setObject:model.content forKey:@"money"];
                    total = [model.content integerValue]+total;
                }else if (model.biaoji==1 && ![model.content isEqualToString:@"请输入"])
                {
                       [tdic setObject:model.content forKey:@"reimburseType"];
                }else if (model.biaoji==2 )
                {
                    [tdic setObject:model.number_red forKey:@"isBudget"];
                }else if (model.biaoji==8)
                {
                    NSMutableArray *tarr = [NSMutableArray arrayWithCapacity:0];
                    for (int i=0;i<model.arr_imgs.count; i++) {
                        NSString *tstr = model.arr_imgs[i];
                     [tarr addObject:[tstr substringWithRange:NSMakeRange(tstr.length-44, 44)] ];
                    }
                    [tdic setObject:tarr forKey:@"billImage"];
                }else if (model.biaoji==9)
                {
                    [tdic setObject:@[] forKey:@"Enclosure"];
                }else if (model.biaoji==5 && ![model.content isEqualToString:@"请输入"])
                {
                    [tdic setObject:model.content forKey:@"explain"];
                }else if (model.biaoji==6 && ![model.content isEqualToString:@"请输入"])
                {
                    [tdic setObject:model.content forKey:@"budgetMoney"];
                }else if (model.biaoji==7 && ![model.content isEqualToString:@"请输入"])
                {
                    [tdic setObject:model.content forKey:@"remainderMoney"];
                }else if (model.biaoji==3 || model.biaoji==4)
                {
                    
                }else
                {
                    temp=1;
                    break;
                }
                }
            [tarr0 addObject:tdic];
            }
        }
    
    if (temp ==0) {
        NSData *data = [NSJSONSerialization dataWithJSONObject:tarr0 options:(NSJSONWritingPrettyPrinted) error:nil];
        NSString *tstr = [[NSString alloc]initWithData:data encoding:NSUTF8StringEncoding];
        MBProgressHUD *hud = [MBProgressHUD showHUDAddedTo:self.view animated:YES];
        hud.mode = MBProgressHUDModeAnnularDeterminate;
        hud.label.text = @"正在提交";
        [WebRequest Reimburse_Add_ReimburseWithuserGuid:user.Guid reimbursetitle:thethem remarks:demand jsonPara:tstr companyId:user.companyId totalMoney:[NSString stringWithFormat:@"%ld",total] detailCount:[NSString stringWithFormat:@"%ld",arr_big.count] And:^(NSDictionary *dic) {
            hud.label.text =dic[Y_MSG];
            dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(0.7 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
                [hud hideAnimated:NO];
                if ([dic[Y_STATUS] integerValue]==200) {
                    [self.navigationController popViewControllerAnimated:NO];
                }
            });
        }];
    }else
    {
        MBProgressHUD *hud=[MBProgressHUD showHUDAddedTo:self.view  animated:YES];
        hud.mode = MBProgressHUDModeText;
        hud.label.text =@"带*是必填,钱财必须纯数字";
        dispatch_time_t popTime = dispatch_time(DISPATCH_TIME_NOW, 1 * NSEC_PER_SEC);
        dispatch_after(popTime, dispatch_get_main_queue(), ^(void){
            [MBProgressHUD hideHUDForView:self.view  animated:YES];
        });
    }
}
-(void)imagePickerController:(UIImagePickerController *)picker didFinishPickingMediaWithInfo:(NSDictionary<NSString *,id> *)info
{
    NSArray *tarr =arr_big[indexPath_selected.section-1];
    
    GNmodel *model = tarr[indexPath_selected.row+1];
    NSMutableArray *tarr2 = [NSMutableArray arrayWithArray:tarr];
    NSMutableArray *arr_imgs=nil;
    if (model.biaoji==8) {
        //有图片
        arr_imgs = [NSMutableArray arrayWithArray:model.arr_imgs];
    }else{
        GNmodel *model2 = [[GNmodel alloc]init];
        model2.biaoji =8;
        arr_imgs = [NSMutableArray arrayWithCapacity:0];
        model2.arr_imgs =arr_imgs;
        [tarr2 insertObject:model2 atIndex:indexPath_selected.row+1];
        model = model2;
    }
    
    
    UIImage *image = [info objectForKey:UIImagePickerControllerOriginalImage];
    MBProgressHUD *hud = [MBProgressHUD showHUDAddedTo:self.view animated:YES];
    hud.mode = MBProgressHUDModeAnnularDeterminate;
    hud.label.text = @"正在处理";
    [WebRequest  Articles_CommitImageWithimg:image And:^(NSDictionary *dic) {
        [hud hideAnimated:NO];
        if ([dic[Y_STATUS] integerValue]==200) {
            NSString *tstr = dic[Y_ITEMS];
            [arr_imgs addObject:tstr];
            model.arr_imgs = arr_imgs;
            [tarr2 replaceObjectAtIndex:indexPath_selected.row+1 withObject:model];
            [arr_big replaceObjectAtIndex:indexPath_selected.section-1 withObject:tarr2];
            [tableV reloadSections:[NSIndexSet indexSetWithIndex:indexPath_selected.section] withRowAnimation:UITableViewRowAnimationNone];
        }
    }];
    [self dismissViewControllerAnimated:NO completion:nil];
   
    
}

-(NSArray*)setbaseData{
    //,@"预算金额"6,@"剩余金额"7,@"图片"8@"附件"9,
    NSArray *nameTarr = @[@"*报销金额(元)",@"*报销科目",@"*是否有预算",@"上传票据",@"上传附件",@"*费用说明"];
    NSArray *contentTarr =@[@"请输入",@"请选择",@"是否",@"拍照上传",@"添加文件",@"请输入"];
    NSMutableArray *tarr = [NSMutableArray arrayWithCapacity:0];
    for (int i=0; i<nameTarr.count; i++) {
        GNmodel  *model = [[GNmodel alloc]init];
        model.content=contentTarr[i];
        model.name=nameTarr[i];
        model.biaoji = i;
        model.number_red = @"0";
        [tarr addObject:model];
    }
    return tarr;
}
#pragma  mark - 区头的定义
-(void)baoxiaoAddClick{
    [arr_big addObject:[self setbaseData]];
    [tableV reloadData];
}
-(CGFloat)tableView:(UITableView *)tableView heightForFooterInSection:(NSInteger)section
{
    if (section==arr_big.count) {
        return 50;
    }else
    {
        return 1;
    }
}
-(UIView*)tableView:(UITableView *)tableView viewForFooterInSection:(NSInteger)section
{
    if (section == arr_big.count) {
        FBButton *tbtn = [FBButton buttonWithType:UIButtonTypeSystem];
        [tbtn setTitle:@"+增加报销明细" titleColor:nil backgroundColor:nil font:[UIFont systemFontOfSize:18]];
        [tbtn addTarget:self action:@selector(baoxiaoAddClick) forControlEvents:UIControlEventTouchUpInside];
        return tbtn;
    }
    return nil;
}
-(UIView*)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section
{
    if (section==0 || section==arr_big.count+1) {
        return nil;
    }else
    {
        UIView *tview = [[UIView alloc]initWithFrame:CGRectMake(0, 0, DEVICE_WIDTH, 40)];
        tview.userInteractionEnabled = YES;
        UILabel *talbel = [[UILabel alloc]initWithFrame:CGRectMake(15, 0, 100, 40)];
        talbel.font = [UIFont systemFontOfSize:15];
        talbel.textColor = [UIColor grayColor];
        talbel.text = [NSString stringWithFormat:@"报销明细%ld",section];
        [tview addSubview:talbel];
        
       
        if (section==1) {
            
        }else
        {
            FBButton  *tbtn = [FBButton buttonWithType:UIButtonTypeSystem];
            [tbtn setTitle:@"删除" titleColor:[UIColor redColor] backgroundColor:[UIColor clearColor] font:[UIFont systemFontOfSize:15]];
            tbtn.frame = CGRectMake(DEVICE_WIDTH-55, 0, 50, 40);
            tbtn.tag = section-1;
            [tbtn addTarget:self action:@selector(deleteCLick:) forControlEvents:UIControlEventTouchUpInside];
        [tview addSubview:tbtn];
        }
        

     
        return tview;
    }
   
}
-(void)deleteCLick:(FBButton*)tbtn{
    [arr_big removeObjectAtIndex:tbtn.tag];
    [tableV reloadData];
}
-(CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section
{
    if (section==0 || section ==arr_big.count+1) {
        return 5;
    }else
    {
        return 40;
    }
}
-(NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return arr_big.count+2;
}
-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    if (indexPath.section==0) {
        return 60;
    }else if (indexPath.section==arr_big.count+1)
    {
        return 60;
    }else
    {
        NSArray *tarr = arr_big[indexPath.section-1];
        GNmodel *model =tarr[indexPath.row];
        if (model.biaoji ==5 && ![model.content isEqualToString:@"请输入"])
        {
            return model.cellHeight;
        }else
        {
           return 60;
        }
       
    }
   
}
#pragma  mark - 表的数据源
-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    if (section==0) {
        return 1;
    }else if (section==arr_big.count+1)
    {
        return 1;
    }else
    {
        NSArray *tarr = arr_big[section-1];
        return  tarr.count;
    }
   
}
-(UITableViewCell*)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    if (indexPath.section==0) {
        static NSString *cellId=@"cellID0";
        UITableViewCell *cell =[tableView dequeueReusableCellWithIdentifier:cellId];
        if (!cell) {
            cell = [[UITableViewCell alloc]initWithStyle:UITableViewCellStyleValue1 reuseIdentifier:cellId];
            cell.accessoryType = UITableViewCellAccessoryDisclosureIndicator;
            cell.textLabel.font = [UIFont systemFontOfSize:18];
        }
        cell.textLabel.text = @"*报销名称";
        cell.detailTextLabel.text = thethem;
        return cell;
    }else if (indexPath.section==arr_big.count+1)
    {
        if ([demand isEqualToString:@"请输入"]) {
            static NSString *cellId=@"cellID1";
            UITableViewCell *cell =[tableView dequeueReusableCellWithIdentifier:cellId];
            if (!cell) {
                cell = [[UITableViewCell alloc]initWithStyle:UITableViewCellStyleValue1 reuseIdentifier:cellId];
                cell.accessoryType = UITableViewCellStyleValue1;
                cell.textLabel.font = [UIFont systemFontOfSize:18];
            }
            cell.textLabel.text = @"*备注";
            cell.detailTextLabel.text = @"请输入";
            return cell;
        }else{
            EQDR_labelTableViewCell *cell = [[EQDR_labelTableViewCell alloc]init];
            NSMutableAttributedString *name = [[NSMutableAttributedString alloc]initWithString:demand attributes:@{NSFontAttributeName:[UIFont systemFontOfSize:17]}];
            name.yy_lineSpacing = 5;
            cell.YL_label.attributedText = name;
            CGSize size = [name boundingRectWithSize:CGSizeMake(DEVICE_WIDTH-30, MAXFLOAT) options:NSStringDrawingUsesLineFragmentOrigin context:nil].size;
            [cell.YL_label mas_makeConstraints:^(MASConstraintMaker *make) {
                make.height.mas_equalTo(size.height+10);
                make.left.mas_equalTo(cell.mas_left).mas_offset(15);
                make.right.mas_equalTo(cell.mas_right).mas_offset(-15);
                make.centerY.mas_equalTo(cell.mas_centerY);
            }];
            height = size.height+10;
            return cell;
        }
       
    }else
    {
      
        NSArray *tarr = arr_big[indexPath.section-1];
        GNmodel  *model =tarr[indexPath.row];
        if (model.biaoji ==2) {
            //预算
            FBLabel_segmentTableViewCell *cell = [[FBLabel_segmentTableViewCell alloc]init];
            cell.L_name.text = model.name;
            cell.SC_choose.indexPath = indexPath;
            [cell.SC_choose setSelectedSegmentIndex:[model.number_red integerValue]];
            [cell.SC_choose addTarget:self action:@selector(segmentClick:) forControlEvents:UIControlEventValueChanged];
            return cell;
        }else if (model.biaoji ==8)
        {
            //图片
            ImgScrollTableViewCell *cell = [[ImgScrollTableViewCell alloc]init];
            [cell setarr_stringimgs:model.arr_imgs WithHeight:60];
            cell.imgScrollV.indexPath = indexPath;
            cell.imgScrollV.delegate_imgviews =self;
            return cell;
            
        }else if (model.biaoji==9)
        {
           //附件
            return nil;
        }
        else
        {
            if (model.biaoji ==5 && ![model.content isEqualToString:@"请输入"]) {
                EQDR_labelTableViewCell  *cell = [[EQDR_labelTableViewCell alloc]init];
                NSMutableAttributedString *name = [[NSMutableAttributedString alloc]initWithString:model.content attributes:@{NSFontAttributeName:[UIFont systemFontOfSize:17]}];
                CGSize size = [name boundingRectWithSize:CGSizeMake(DEVICE_WIDTH-30, MAXFLOAT) options:NSStringDrawingUsesLineFragmentOrigin context:nil].size;
                model.cellHeight = size.height+10;
                [cell.YL_label mas_makeConstraints:^(MASConstraintMaker *make) {
                    make.height.mas_equalTo(size.height+10);
                    make.left.mas_equalTo(cell.mas_left).mas_offset(15);
                    make.right.mas_equalTo(cell.mas_right).mas_offset(-15);
                    make.centerY.mas_equalTo(cell.mas_centerY);
                }];
                cell.YL_label.attributedText = name;
                return cell;
                
                
            }else
            {
                
                static NSString *cellId=@"cellID2";
                UITableViewCell *cell =[tableView dequeueReusableCellWithIdentifier:cellId];
                if (!cell) {
                    cell = [[UITableViewCell alloc]initWithStyle:UITableViewCellStyleValue1 reuseIdentifier:cellId];
                    cell.accessoryType = UITableViewCellAccessoryDisclosureIndicator;
                    cell.textLabel.font = [UIFont systemFontOfSize:18];
                    cell.detailTextLabel.font = [UIFont systemFontOfSize:15];
                }
                
                cell.textLabel.text = model.name;
                cell.detailTextLabel.text = model.content;
                
                
                return cell;
               
            }
        }
    }
   
}

#pragma  mark - 图片点击的
-(void)getImgsScrollViewSelectedViewWithtag:(NSInteger)tag indexPath:(NSIndexPath *)indexPath
{
    NSArray *tarr = arr_big[indexPath.section-1];
    GNmodel *model =tarr[indexPath.row];
    UIAlertController  *alert = [[UIAlertController alloc]init];
    [alert addAction:[UIAlertAction actionWithTitle:@"查看" style:UIAlertActionStyleDefault handler:^(UIAlertAction * _Nonnull action) {
        FBShowimg_moreViewController *Svc = [[FBShowimg_moreViewController alloc]init];
        Svc.index =tag;
        Svc.arr_imgs =model.arr_imgs;
        [self.navigationController pushViewController:Svc animated:NO];
    }]];
    [alert addAction:[UIAlertAction actionWithTitle:@"删除" style:UIAlertActionStyleDestructive handler:^(UIAlertAction * _Nonnull action) {
        NSMutableArray *arr_imgs = [NSMutableArray arrayWithArray:model.arr_imgs];
        [arr_imgs removeObjectAtIndex:tag];
        model.arr_imgs = arr_imgs;
        NSMutableArray *tarr2 = [NSMutableArray arrayWithArray:tarr];
        [tarr2 replaceObjectAtIndex:indexPath.row withObject:model];
        [tableV reloadRowsAtIndexPaths:@[indexPath] withRowAnimation:UITableViewRowAnimationNone];
    }]];
    
    [alert addAction:[UIAlertAction actionWithTitle:@"取消" style:UIAlertActionStyleCancel handler:^(UIAlertAction * _Nonnull action) {
        
    }]];
    dispatch_async(dispatch_get_main_queue(), ^{
        [self presentViewController:alert animated:NO completion:nil];

    });
    
}
#pragma  mark - 表的协议代理
-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    if (indexPath.section==0) {
        FBTextFieldViewController *TFvc =[[FBTextFieldViewController alloc]init];
        TFvc.delegate =self;
        TFvc.indexPath =indexPath;
        TFvc.content =thethem;
        TFvc.contentTitle =@"报销名称";
        [self.navigationController pushViewController:TFvc animated:NO];
    }else if(indexPath.section == arr_big.count+1)
    {
        FBTextVViewController *TVvc =[[FBTextVViewController alloc]init];
        TVvc.indexpath =indexPath;
        TVvc.delegate =self;
        TVvc.contentTitle=@"备注";
        TVvc.content =demand;
        [self.navigationController pushViewController:TVvc animated:NO];
    }else
    {
        NSArray *tarr = arr_big[indexPath.section-1];
        GNmodel *model =tarr[indexPath.row];
        if (model.biaoji ==0 || model.biaoji==6 || model.biaoji==7 ) {
            //报销金额
            FBTextFieldViewController *TFvc =[[FBTextFieldViewController alloc]init];
            TFvc.delegate =self;
            TFvc.indexPath =indexPath;
            TFvc.content = model.content ;
            TFvc.contentTitle =model.name;
            [self.navigationController pushViewController:TFvc animated:NO];
        }else if(model.biaoji ==1)
        {
           //报销科目
            FBBaoXiaoLeiBieViewController *BXvc =[[FBBaoXiaoLeiBieViewController alloc]init];
            BXvc.delegate =self;
            BXvc.indexPath =indexPath;
            [self.navigationController pushViewController:BXvc animated:NO];
        }else if (model.biaoji==2)
        {
            //是否有预算
            
        }else if (model.biaoji ==3)
        {
            //上传票据
            indexPath_selected = indexPath;
            dispatch_async(dispatch_get_main_queue(), ^{
                [self presentViewController:picker animated:NO completion:nil];

            });
        }else if (model.biaoji ==4)
        {
            //上传附件
            indexPath_selected = indexPath;
            MBProgressHUD *hud=[MBProgressHUD showHUDAddedTo:self.view  animated:YES];
            hud.mode = MBProgressHUDModeText;
            hud.label.text =@"iOS暂不支持此功能";
            dispatch_time_t popTime = dispatch_time(DISPATCH_TIME_NOW, 1 * NSEC_PER_SEC);
            dispatch_after(popTime, dispatch_get_main_queue(), ^(void){
                [MBProgressHUD hideHUDForView:self.view  animated:YES];
            });
        }else if (model.biaoji ==5)
        {
            //费用说明
            FBTextVViewController *TVvc =[[FBTextVViewController alloc]init];
            TVvc.indexpath =indexPath;
            TVvc.delegate =self;
            TVvc.contentTitle=model.name;
            TVvc.content =model.content;
            [self.navigationController pushViewController:TVvc animated:NO];
        }
    }
}

#pragma  mark - 是否选择
-(void)segmentClick:(FBSegmentedControl*)SC_control{
    NSArray *tarr = arr_big[SC_control.indexPath.section-1];
    GNmodel *model = tarr[SC_control.indexPath.row];
    NSMutableArray *tarr2 = [NSMutableArray arrayWithArray:tarr];
    if (SC_control.selectedSegmentIndex==0) {
        model.number_red = @"0";
        for (int i=0; i<tarr.count; i++) {
            GNmodel *model =tarr[i];
            if (model.biaoji==6 || model.biaoji ==7) {
                [tarr2 removeObject:model];
            }
        }
        
    }else
    {
        
        model.number_red = @"1";
        GNmodel *model = [[GNmodel alloc]init];
        model.biaoji =6;
        model.name =@"*预算金额";
        model.content = @"请输入";
        [tarr2 insertObject:model atIndex:SC_control.indexPath.row+1];
        GNmodel *model2 = [[GNmodel alloc]init];
        model2.biaoji =7;
        model2.name =@"*剩余金额";
        model2.content = @"请输入";
        [tarr2 insertObject:model2 atIndex:SC_control.indexPath.row+2];
        
    }
    [arr_big replaceObjectAtIndex:SC_control.indexPath.section-1 withObject:tarr2];
    [tableV reloadData];
}



@end
