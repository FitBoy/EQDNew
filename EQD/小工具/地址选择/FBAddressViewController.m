//
//  FBAddressViewController.m
//  EQD
//
//  Created by 梁新帅 on 2017/4/10.
//  Copyright © 2017年 FitBoy. All rights reserved.
//

#import "FBAddressViewController.h"
#import "FBAddressModel.h"
@interface FBAddressViewController ()<UITableViewDelegate,UITableViewDataSource>
{
    UITableView *tableV;
    NSMutableArray *arr_address;
    NSIndexPath *indexPath_one;
    NSIndexPath *indexPath_two;
    NSIndexPath *indexPath_three;
    UISegmentedControl *segmentC;
    UIBarButtonItem *right;
}

@end

@implementation FBAddressViewController
-(void)viewWillAppear:(BOOL)animated{
    [super viewWillAppear:animated];
    [self loadRequestData];
}
-(void)loadRequestData{
    [WebRequest Option_AreasAndWithtype:0 And:^(NSArray *arr) {
        [arr_address removeAllObjects];
        
            if (arr.count) {
                for (NSDictionary *dic1 in arr) {
                    FBAddressModel *model = [FBAddressModel mj_objectWithKeyValues:dic1];
                    [arr_address addObject:model];
                    
                }
                dispatch_async(dispatch_get_main_queue(), ^{
                    [tableV reloadData];
                });
            }
            
    }];
    
}

- (void)viewDidLoad {
    [super viewDidLoad];
     right =[[UIBarButtonItem alloc]initWithTitle:@"确定" style:UIBarButtonItemStylePlain target:self action:@selector(quedingClick)];
    [self.navigationItem setRightBarButtonItem:right];
    arr_address = [NSMutableArray arrayWithCapacity:0];
    
    self.navigationItem.title =@"详细地址";
    tableV = [[UITableView alloc]initWithFrame:CGRectMake(0, 40+DEVICE_TABBAR_Height, DEVICE_WIDTH, DEVICE_HEIGHT-40-DEVICE_TABBAR_Height) style:UITableViewStylePlain];
    adjustsScrollViewInsets_NO(tableV, self);
    tableV.delegate=self;
    tableV.dataSource=self;
    [self.view addSubview:tableV];
    tableV.rowHeight=60;
    segmentC =[[UISegmentedControl alloc]initWithItems:@[@"省"]];
    segmentC.frame =CGRectMake(0, DEVICE_TABBAR_Height, DEVICE_WIDTH, 40);
    segmentC.selectedSegmentIndex=0;
    [self.view addSubview:segmentC];
    [segmentC addTarget:self action:@selector(chooseClick) forControlEvents:UIControlEventValueChanged];
    right.enabled=NO;
}
-(void)quedingClick
{
    
    FBAddressModel *model =arr_address[indexPath_one.row];
    FBAddressModel *model1 =model.sub[indexPath_two.row];
    FBAddressModel *model2 =model1.sub[indexPath_three.row];
    NSString *address =nil;
    NSArray  *tarr = @[model.name,model1.name,model2.name];
    if ([model1.code integerValue]==0) {
        address = [NSString stringWithFormat:@"%@%@%@-%@",model.name,model1.name,model2.name,model2.qucode];
    }
    else
    {
       address = [NSString stringWithFormat:@"%@%@%@-%@",model.name,model1.name,model2.name,model1.code];
    }
    
    if (self.isXiangXi ==NO) {
        if ([self.delegate respondsToSelector:@selector(address:Withindexpath:arr_address:)]) {
            [self.delegate address:address Withindexpath:self.indexPath arr_address:tarr];
            [self.navigationController popViewControllerAnimated:NO];
        }
    }
    else
    {
        UIAlertController *alert =[UIAlertController alertControllerWithTitle:@"请输入详细地址" message:nil preferredStyle:UIAlertControllerStyleAlert];
        
        [alert addTextFieldWithConfigurationHandler:^(UITextField * _Nonnull textField) {
            textField.placeholder =@"请输入详细信息";
        }];
        [alert addAction:[UIAlertAction actionWithTitle:@"取消" style:UIAlertActionStyleCancel handler:^(UIAlertAction * _Nonnull action) {
            
        }]];
        [alert addAction:[UIAlertAction actionWithTitle:@"确定" style:UIAlertActionStyleDefault handler:^(UIAlertAction * _Nonnull action) {
            UITextField *tf_text = alert.textFields[0];
            if (tf_text.text.length==0) {
                MBProgressHUD *hud=[MBProgressHUD showHUDAddedTo:self.view  animated:YES];
                hud.mode = MBProgressHUDModeText;
                hud.label.text =@"详细地址不能为空";
                dispatch_time_t popTime = dispatch_time(DISPATCH_TIME_NOW, 1 * NSEC_PER_SEC);
                dispatch_after(popTime, dispatch_get_main_queue(), ^(void){
                    [MBProgressHUD hideHUDForView:self.view  animated:YES];
                });
            }
            else
            {
                NSArray *arr =[address componentsSeparatedByString:@"-"];
                
                NSString *str =[NSString stringWithFormat:@"%@%@-%@",arr[0],tf_text.text,arr[1]];
                if ([self.delegate respondsToSelector:@selector(address:Withindexpath:arr_address:)]) {
                    [self.delegate address:str Withindexpath:self.indexPath arr_address:tarr];
                    [self.navigationController popViewControllerAnimated:NO];
                }
            }
            
        }]];
        
        dispatch_async(dispatch_get_main_queue(), ^{
            [self presentViewController:alert animated:NO completion:nil];
        });
        
    }
    
    
    
    
}

-(void)chooseClick
{
    //选择
    if (segmentC.selectedSegmentIndex==0) {
        [segmentC removeSegmentAtIndex:2 animated:YES];
        [segmentC removeSegmentAtIndex:1 animated:YES];
        right.enabled=NO;
        [tableV reloadData];
    }
    else if(segmentC.selectedSegmentIndex ==1)
    {
        [segmentC removeSegmentAtIndex:2 animated:YES];
        right.enabled=NO;
        [tableV reloadData];
    }
    else
    {
        right.enabled=YES;
    }
    
}
#pragma  mark - 表的数据源
-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    if (segmentC.selectedSegmentIndex==0) {
        return arr_address.count;
    }
    else if(segmentC.selectedSegmentIndex==1)
    {
        FBAddressModel *model =arr_address[indexPath_one.row];
        return model.sub.count;
    }
    else
    {
       FBAddressModel *model =arr_address[indexPath_one.row];
        FBAddressModel *model1=model.sub[indexPath_two.row];
        return model1.sub.count;
    }
   
}
-(UITableViewCell*)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    static NSString *cellId=@"cellID";
    UITableViewCell *cell =[tableView dequeueReusableCellWithIdentifier:cellId];
    if (!cell) {
        cell = [[UITableViewCell alloc]initWithStyle:UITableViewCellStyleDefault reuseIdentifier:cellId];
        
        cell.accessoryType = UITableViewCellAccessoryNone;
        cell.selectionStyle = UITableViewCellSelectionStyleNone;
        
    }
    if (segmentC.selectedSegmentIndex==0) {
        FBAddressModel *model = arr_address[indexPath.row];
        cell.textLabel.text =model.name;
        
    }
    else if (segmentC.selectedSegmentIndex==1)
    {
        FBAddressModel *model = arr_address[indexPath_one.row];
        FBAddressModel *model1 = model.sub[indexPath.row];
        cell.textLabel.text =model1.name;
    }
    else
    {
        FBAddressModel *model = arr_address[indexPath_one.row];
        FBAddressModel *model1 = model.sub[indexPath_two.row];
        FBAddressModel *model2 =model1.sub[indexPath.row];
        cell.textLabel.text =model2.name;
    }
    
    return cell;
}

#pragma  mark - 表的协议代理
-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    if (segmentC.selectedSegmentIndex==0) {
        
        FBAddressModel *model =arr_address[indexPath.row];
        [segmentC setTitle:model.name forSegmentAtIndex:0];
        [segmentC insertSegmentWithTitle:@"市" atIndex:1 animated:YES];
        segmentC.selectedSegmentIndex=1;
        indexPath_one=indexPath;
        [tableV reloadData];
    }
    else if(segmentC.selectedSegmentIndex==1)
    {
        FBAddressModel *model = arr_address[indexPath_one.row];
        FBAddressModel *model1 =model.sub[indexPath.row];
        [segmentC setTitle:model1.name forSegmentAtIndex:1];
        [segmentC insertSegmentWithTitle:@"区" atIndex:2 animated:YES];
        indexPath_two =indexPath;
        segmentC.selectedSegmentIndex=2;
        [tableV reloadData];
    }
    else
    {
        FBAddressModel *model = arr_address[indexPath_one.row];
        FBAddressModel *model1 =model.sub[indexPath_two.row];
        FBAddressModel *model2 =model1.sub[indexPath.row];
        [segmentC setTitle:model2.name forSegmentAtIndex:2];
        indexPath_three =indexPath;
        segmentC.selectedSegmentIndex=2;
        right.enabled =YES;
    }
}


@end
