//
//  MM_zhiBiaoAddViewController.m
//  EQD
//
//  Created by 梁新帅 on 2018/7/19.
//  Copyright © 2018年 FitBoy. All rights reserved.
//

#import "MM_zhiBiaoAddViewController.h"
#import "FBTextFieldViewController.h"
#import "ZhiBiao_SearchViewController.h"
#import "FBOne_img2TableViewCell.h"
@interface MM_zhiBiaoAddViewController ()<UITableViewDelegate,UITableViewDataSource,FBTextFieldViewControllerDelegate,ZhiBiao_SearchViewControllerDelegate,UINavigationControllerDelegate, UIImagePickerControllerDelegate>
{
    UITableView *tableV;
    NSArray *arr_names;
    NSMutableArray *arr_contents;
    UIImage  *image_zhibiao;
    UIImagePickerController  *picker;
    NSString *image_url;
}

@end

@implementation MM_zhiBiaoAddViewController
#pragma  mark - 指标
-(void)getZhibiao:(NSString *)zhiBiao
{
    [arr_contents replaceObjectAtIndex:0 withObject:zhiBiao];
    [tableV reloadRowsAtIndexPaths:@[[NSIndexPath indexPathForRow:0 inSection:0]] withRowAnimation:UITableViewRowAnimationNone];
}
-(void)content:(NSString *)content WithindexPath:(NSIndexPath *)indexPath
{
    [arr_contents replaceObjectAtIndex:indexPath.row withObject:content];
    [tableV reloadRowsAtIndexPaths:@[indexPath] withRowAnimation:UITableViewRowAnimationNone];
}
-(void)viewWillAppear:(BOOL)animated{
    [super viewWillAppear:animated];
    [self loadRequestData];
}
-(void)loadRequestData{
    
}
- (BOOL)prefersHomeIndicatorAutoHidden{
    return NO;
}
- (void)viewDidLoad {
    [super viewDidLoad];
    arr_names = @[@"指标",@"指标值",@"指标示例图"];
    arr_contents = [NSMutableArray arrayWithArray:@[@"请选择",@"请输入",@"请选择"]];
    self.navigationItem.title =@"添加指标";
    tableV = [[UITableView alloc]initWithFrame:CGRectMake(0, DEVICE_TABBAR_Height, DEVICE_WIDTH, DEVICE_HEIGHT-DEVICE_TABBAR_Height-kBottomSafeHeight) style:UITableViewStylePlain];
    adjustsScrollViewInsets_NO(tableV, self);
    tableV.delegate=self;
    tableV.dataSource=self;
    [self.view addSubview:tableV];
    tableV.rowHeight=60;
    image_zhibiao = nil;

    picker = [[UIImagePickerController alloc]init];
    picker.delegate =self;
    picker.allowsEditing =YES;
    
    UIBarButtonItem *right = [[UIBarButtonItem alloc]initWithTitle:@"确定" style:UIBarButtonItemStylePlain target:self action:@selector(quedingClick)];
    [self.navigationItem setRightBarButtonItem:right];
    
}
-(void)quedingClick
{
    if([self.delegate_zhibiao respondsToSelector:@selector(getZhibiao:valueZhibiao:imageUrl:)])
    {
        [self.navigationController popViewControllerAnimated:NO];
        [self.delegate_zhibiao getZhibiao:arr_contents[0] valueZhibiao:arr_contents[1] imageUrl:image_url];
    }
}
-(void)imagePickerController:(UIImagePickerController *)picker didFinishPickingMediaWithInfo:(NSDictionary<NSString *,id> *)info
{
    image_zhibiao = [info objectForKey:UIImagePickerControllerEditedImage];
    [self dismissViewControllerAnimated:NO completion:nil];
   
    [WebRequest Reimburse_Upload_FilesWithimages:@[image_zhibiao] And:^(NSDictionary *dic) {
        if ([dic[Y_STATUS] integerValue]==200) {
            NSString *tstr = dic[Y_ITEMS];
            NSArray *tarr = [tstr componentsSeparatedByString:@";"];
          
            dispatch_async(dispatch_get_main_queue(), ^{
                  image_url = tarr[0];
                [tableV reloadRowsAtIndexPaths:@[[NSIndexPath indexPathForRow:2 inSection:0]] withRowAnimation:UITableViewRowAnimationNone];
            });
        }
    }];
}
#pragma  mark - 表的数据源
-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return arr_contents.count;
}
-(UITableViewCell*)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    if (indexPath.row ==2) {
        static NSString *cellId=@"cellID2";
        FBOne_img2TableViewCell *cell =[tableView dequeueReusableCellWithIdentifier:cellId];
        if (!cell) {
            cell = [[FBOne_img2TableViewCell alloc]initWithStyle:UITableViewCellStyleValue1 reuseIdentifier:cellId];
            cell.accessoryType = UITableViewCellAccessoryNone;
            cell.textLabel.font = [UIFont systemFontOfSize:18];
        }
        cell.L_left0.text = arr_names[indexPath.row];
        cell.IV_img.image = image_zhibiao == nil? nil:image_zhibiao;
        return cell;
    }else
    {
    static NSString *cellId=@"cellID";
    UITableViewCell *cell =[tableView dequeueReusableCellWithIdentifier:cellId];
    if (!cell) {
        cell = [[UITableViewCell alloc]initWithStyle:UITableViewCellStyleValue1 reuseIdentifier:cellId];
        cell.accessoryType = UITableViewCellAccessoryDisclosureIndicator;
        cell.textLabel.font = [UIFont systemFontOfSize:18];
    }
    cell.textLabel.text = arr_names[indexPath.row];
    cell.detailTextLabel.text = arr_contents[indexPath.row];
    return cell;
    }
}

#pragma  mark - 表的协议代理
-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    if (indexPath.row ==0) {
        //指标名称
        ZhiBiao_SearchViewController  *Svc = [[ZhiBiao_SearchViewController alloc]init];
        Svc.delegate_zhiBiao = self;
        [self.navigationController pushViewController:Svc animated:NO];
    }else if(indexPath.row ==1)
    {
        FBTextFieldViewController *TFvc =[[FBTextFieldViewController alloc]init];
        TFvc.delegate =self;
        TFvc.indexPath =indexPath;
        TFvc.content =arr_contents[indexPath.row];
        TFvc.contentTitle =arr_names[indexPath.row];
        [self.navigationController pushViewController:TFvc animated:NO];
    }else if (indexPath.row ==2)
    {
        UIAlertController  *alert = [[UIAlertController alloc]init];
        NSArray *tarr = @[@"相机",@"相册"];
        for(int i=0;i<tarr.count;i++)
        {
            [alert addAction:[UIAlertAction actionWithTitle:tarr[i] style:UIAlertActionStyleDefault handler:^(UIAlertAction * _Nonnull action) {
                MBFadeAlertView * Falert = [[MBFadeAlertView alloc]init];
                if (i==0) {
                    if ([UIImagePickerController availableMediaTypesForSourceType:UIImagePickerControllerSourceTypeCamera]) {
                        picker.sourceType = UIImagePickerControllerSourceTypeCamera;
                        [self presentViewController:picker animated:NO completion:nil];
                    }else
                    {
                        [Falert showAlertWith:@"暂不支持相机"];
                    }
                }else if (i==1)
                {
                    if ([UIImagePickerController availableMediaTypesForSourceType:UIImagePickerControllerSourceTypePhotoLibrary]) {
                        picker.sourceType = UIImagePickerControllerSourceTypePhotoLibrary;
                        [self presentViewController:picker animated:NO completion:nil];
                    }else
                    {
                        [Falert showAlertWith:@"暂不支持访问相册"];
                    }
                }else
                {
                    
                }
            }]];
            
        }
        [alert addAction:[UIAlertAction actionWithTitle:@"取消" style:UIAlertActionStyleCancel handler:^(UIAlertAction * _Nonnull action) {
            
        }]];
        [self presentViewController:alert animated:NO completion:nil];
    }else
    {
        
    }
}




@end
