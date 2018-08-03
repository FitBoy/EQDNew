//
//  FX_riZhiAddViewController.m
//  EQD
//
//  Created by 梁新帅 on 2018/4/16.
//  Copyright © 2018年 FitBoy. All rights reserved.
//

#import "FX_riZhiAddViewController.h"
#import "FBButton.h"
#import "FX_riZhiSectionAddViewController.h"
#import "FBTextVViewController.h"
#import "EQDR_labelTableViewCell.h"
#import <AMapLocationKit/AMapLocationKit.h>
#import "RiZhiModel.h"
@interface FX_riZhiAddViewController ()<UITableViewDataSource,UITableViewDelegate,FBTextVViewControllerDelegate>

{
    UITableView *tableV;
    UserModel *user;
    NSArray *arr_titles;
    NSInteger temp;
    
    GNmodel  *model_time1;
    GNmodel *model_time2;
    
    NSMutableArray *arr_model0;
    NSMutableArray *arr_model1;
    NSMutableArray *arr_model2;
    NSMutableArray *arr_model3;
     AMapLocationManager *locationManager;
    NSString *address;
    NSString *type;
    
    ///修改的位置
    NSInteger  isXiuGai;
    NSIndexPath *indexpath_selected;

}

@end

@implementation FX_riZhiAddViewController
#pragma  mark - 各种计划
-(void)getarr_json:(NSArray*)arr_json
{
    if (isXiuGai==1) {
        if (temp==0) {
            [arr_model0 replaceObjectAtIndex:indexpath_selected.row withObject:arr_json];
        }else if (temp==1)
        {
            [arr_model1 replaceObjectAtIndex:indexpath_selected.row withObject:arr_json];
        }else if (temp==3)
        {
            [arr_model3 replaceObjectAtIndex:indexpath_selected.row withObject:arr_json];
        }else
        {
            
        }
    }else
    {
    if (temp==0) {
        [arr_model0 addObject:arr_json];
    }else if (temp==1)
    {
        [arr_model1 addObject:arr_json];
    }else if (temp==3)
    {
        [arr_model3 addObject:arr_json];
    }else
    {
        
    }
    }
    [tableV reloadSections:[NSIndexSet indexSetWithIndex:temp] withRowAnimation:UITableViewRowAnimationNone];
}
#pragma  mark - 今日感悟
-(void)textVtext:(NSString *)text indexPath:(NSIndexPath *)indexPath
{
    if (text.length<300) {
        MBProgressHUD *hud=[MBProgressHUD showHUDAddedTo:self.view  animated:YES];
        hud.mode = MBProgressHUDModeText;
        hud.label.text =@"建议300~500个字";
        dispatch_time_t popTime = dispatch_time(DISPATCH_TIME_NOW, 1 * NSEC_PER_SEC);
        dispatch_after(popTime, dispatch_get_main_queue(), ^(void){
            [MBProgressHUD hideHUDForView:self.view  animated:YES];
        });
        
    }
    [arr_model2 replaceObjectAtIndex:0 withObject:text];
    [tableV reloadSections:[NSIndexSet indexSetWithIndex:2] withRowAnimation:UITableViewRowAnimationNone];
    
}
-(void)viewWillAppear:(BOOL)animated{
    [super viewWillAppear:animated];
    [self loadRequestData];
   
    [self dingwei];
     address =[USERDEFAULTS objectForKey:Y_AMAP_address];
}

//高德地图定位
-(void)dingwei{
    
    [locationManager requestLocationWithReGeocode:YES completionBlock:^(CLLocation *location, AMapLocationReGeocode *regeocode, NSError *error) {
        //地址   regeocode.formattedAddress  经纬度 location.coordinate
        NSString* jinwei =[NSString stringWithFormat:@"%f,%f",location.coordinate.latitude,location.coordinate.longitude];
        NSString*  address =regeocode.formattedAddress;
        if(address.length==0)
        {
            
            [self dingwei];
        }else
        {
            NSArray  *tarr = @[regeocode.province,regeocode.city];
            [USERDEFAULTS setObject:jinwei forKey:Y_AMAP_coordation];
            [USERDEFAULTS setObject:address forKey:Y_AMAP_address];
            [USERDEFAULTS setObject:tarr forKey:Y_AMAP_cityProvince];
            [USERDEFAULTS synchronize];
        }
        
    }];
}
-(void)loadRequestData{
    
}

- (BOOL)prefersHomeIndicatorAutoHidden{
    return NO;
}
- (void)viewDidLoad {
    [super viewDidLoad];
    temp =0;
    isXiuGai =0;
    arr_model0 = [NSMutableArray arrayWithCapacity:0];
    arr_model1 = [NSMutableArray arrayWithCapacity:0];
    NSString *ganwu = [USERDEFAULTS objectForKey:Y_ganWu];
    if (ganwu ==nil) {
        ganwu = @"请输入";
    }
    arr_model2 =[NSMutableArray arrayWithArray:@[ganwu]];
    arr_model3 = [NSMutableArray arrayWithCapacity:0];
    
    NSDictionary *dic = [USERDEFAULTS objectForKey:Y_jsonPara];
    ///缓存的临时事项
    NSArray *tarr1 =dic[@"matter"];
    for (int i=0; i<tarr1.count; i++) {
        NSMutableArray *smallArr = [NSMutableArray arrayWithCapacity:0];
        GNmodel *model1 = [[GNmodel alloc]init];
        GNmodel *model2 = [[GNmodel alloc]init];
        GNmodel *model3 = [[GNmodel alloc]init];
        GNmodel *model4 = [[GNmodel alloc]init];
        NSDictionary *tdic = tarr1[i];
        NSString *time = tdic[@"timeSlot"];
        NSArray *tarr2 =[time componentsSeparatedByString:@"-"];
        model1.biaoji =3;
        model1.content = tarr2[0];
        model1.name=@"开始时间";
        model2.biaoji =3;
        model2.content = tarr2[1];
        model2.name=@"结束时间";
        NSString *content = tdic[@"content"];
        model3.name = @"今日临时事项";
        model3.content = content;
        model3.biaoji = 2;
        NSString *status = tdic[@"status"];
        model4.biaoji =4;
        model4.name =@"今日完成结果";
        model4.content = status;
        [smallArr addObjectsFromArray:@[model1,model2,model3,model4]];
        [arr_model1 addObject:smallArr];
    }
  
    ///缓存的明日计划事项
    NSArray *tarr2 =dic[@"tomorrowMatter"];
    for (int i=0; i<tarr2.count; i++) {
        NSMutableArray *smallArr = [NSMutableArray arrayWithCapacity:0];
        GNmodel *model1 = [[GNmodel alloc]init];
        GNmodel *model2 = [[GNmodel alloc]init];
        GNmodel *model3 = [[GNmodel alloc]init];
       
        NSDictionary *tdic = tarr2[i];
        NSString *time = tdic[@"timeSlot"];
        NSArray *tarr2 =[time componentsSeparatedByString:@"-"];
        model1.biaoji =3;
        model1.content = tarr2[0];
        model1.name=@"开始时间";
        model2.biaoji =3;
        model2.content = tarr2[1];
        model2.name=@"结束时间";
        NSString *content = tdic[@"content"];
        model3.name = @"明日计划事项";
        model3.content = content;
        model3.biaoji = 2;
        
        [smallArr addObjectsFromArray:@[model1,model2,model3]];
        [arr_model3 addObject:smallArr];
    }
    
    
    user = [WebRequest GetUserInfo];
    self.navigationItem.title = @"增加工作日志";
    tableV = [[UITableView alloc]initWithFrame:CGRectMake(0, DEVICE_TABBAR_Height, DEVICE_WIDTH, DEVICE_HEIGHT-DEVICE_TABBAR_Height-kBottomSafeHeight) style:UITableViewStyleGrouped];
    adjustsScrollViewInsets_NO(tableV, self);
    tableV.delegate=self;
    tableV.dataSource=self;
    [self.view addSubview:tableV];
    tableV.rowHeight=60;
   
   
    arr_titles = @[@"今日计划事项",@"今日临时事项",@"今日感悟",@"明日计划事项"];
    
    model_time1 = [[GNmodel alloc]init];
    model_time1.biaoji = 3;
    model_time1.name = @"开始时间";
    model_time1.content = @"请选择";
    model_time2 = [[GNmodel alloc]init];
    model_time2.biaoji = 3;
    model_time2.name = @"结束时间";
    model_time2.content = @"请选择";
    NSDateFormatter  *formatter=[[NSDateFormatter alloc]init];
    [formatter setDateFormat:@"yyyy-MM-dd"];
    NSDate *tdate = [NSDate date];
   
//    NSString  *date_str = [formatter stringFromDate:[tdate dateByAddingTimeInterval:24*60*60] ];
    NSString  *date_str = [formatter stringFromDate:tdate];

    MBProgressHUD *hud = [MBProgressHUD showHUDAddedTo:self.view animated:YES];
    hud.mode = MBProgressHUDModeAnnularDeterminate;
    hud.label.text = @"正在处理";
    [WebRequest daily_Get_DailyPlanWithuserGuid:user.Guid date:date_str And:^(NSDictionary *dic) {
        hud.label.text = dic[Y_MSG];
        dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(0.7 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
            [hud hideAnimated:NO];
            if ([dic[Y_STATUS] integerValue]==200) {
                [arr_model0 removeAllObjects];
                NSArray *tarr = dic[Y_ITEMS];
                for (int i=0; i<tarr.count; i++) {
                    RiZhiModel  *model = [RiZhiModel mj_objectWithKeyValues:tarr[i]];
                    [arr_model0 addObject:model];
                }
                [tableV reloadSections:[NSIndexSet indexSetWithIndex:0] withRowAnimation:UITableViewRowAnimationNone];
            }else
            {
                [self.navigationController popViewControllerAnimated:NO];
            }
        });
        
    }];
    
    
    UIBarButtonItem *right = [[UIBarButtonItem alloc]initWithTitle:@"发送日志" style:UIBarButtonItemStylePlain target:self action:@selector(tijiaoCLick)];
    [self.navigationItem setRightBarButtonItem:right];
    
    //    高德地图定位
    locationManager =[[AMapLocationManager alloc]init];
    [locationManager setDesiredAccuracy:kCLLocationAccuracyBest];
    //   定位超时时间，最低2s，此处设置为10s
    locationManager.locationTimeout =10;
    //   逆地理请求超时时间，最低2s，此处设置为10s
    locationManager.reGeocodeTimeout = 10;
    
    type = @"仅自己和领导可见";
}
#pragma  mark - 发送日志
-(void)tijiaoCLick{
    /*
     { "plan":[{"Id":1,"status":"ok"},{"Id":2,"status":"ok"}],"matter":[{"timeSlot":"9:00-12:00","content":"写代码","status":"ok"},{"timeSlot":"13:00-18:00","content":"写代码","status":"ok"}],"tomorrowMatter":[{"timeSlot":"9:00-12:00","content":"写代码"},{"timeSlot":"13:00-18:00","content":"写代码"}]}
     */
    NSMutableDictionary  *jsonPara = [NSMutableDictionary dictionary];
    if (arr_model0.count==0) {
        [jsonPara setObject:@[] forKey:@"plan"];
    }else
    {
        NSMutableArray  *tarr = [NSMutableArray arrayWithCapacity:0];
        for (int i=0; i<arr_model0.count; i++) {
            RiZhiModel *model =arr_model0[i];
            NSMutableDictionary *tdic =[NSMutableDictionary dictionary];
            [tdic setObject:model.Id forKey:@"Id"];
            NSString *tstr = model.result ==nil?@" ":model.result;
            [tdic setObject:tstr forKey:@"status"];
            [tarr addObject:tdic];
        }
        
         [jsonPara setObject:tarr forKey:@"plan"];
    }
    
    if(arr_model1.count==0)
    {
        [jsonPara setObject:@[] forKey:@"matter"];
    }else
    {
        NSMutableArray *tarr_big=[NSMutableArray arrayWithCapacity:0];
        for (int i=0; i<arr_model1.count; i++) {
            NSMutableDictionary  *tdic =[NSMutableDictionary dictionary];
            NSArray *tarr =arr_model1[i];
             NSMutableString *tstr_time = [NSMutableString string];
            for (int j=0; j<tarr.count; j++) {
                GNmodel *model =tarr[j];
               
                if (model.biaoji ==3 && j==0) {
                    [tstr_time appendString:model.content];
                }else if (model.biaoji ==3 && j==1)
                {
                    [tstr_time appendFormat:@"-%@",model.content];
                    [tdic setObject:tstr_time forKey:@"timeSlot"];
                }else if(j==2 && model.biaoji ==2)
                {
                    [tdic setObject:model.content forKey:@"content"];
                }else if (j==3 && model.biaoji==4)
                {
                    [tdic setObject:model.content forKey:@"status"];
                }else
                {
                    
                }
            }
            [tarr_big addObject:tdic];
        }
        [jsonPara setObject:tarr_big forKey:@"matter"];
        
    }
    
   
    
    if(arr_model3.count==0)
    {
        [jsonPara setObject:@[] forKey:@"tomorrowMatter"];
    }else
    {
        NSMutableArray *tarr_big=[NSMutableArray arrayWithCapacity:0];
        for (int i=0; i<arr_model3.count; i++) {
            NSMutableDictionary  *tdic =[NSMutableDictionary dictionary];
            NSArray *tarr =arr_model3[i];
            NSMutableString *tstr_time = [NSMutableString string];
            for (int j=0; j<tarr.count; j++) {
                GNmodel *model =tarr[j];
                
                if (model.biaoji ==3 && j==0) {
                    [tstr_time appendString:model.content];
                }else if (model.biaoji ==3 && j==1)
                {
                    [tstr_time appendFormat:@"-%@",model.content];
                    [tdic setObject:tstr_time forKey:@"timeSlot"];
                }else if(j==2 && model.biaoji ==2)
                {
                    [tdic setObject:model.content forKey:@"content"];
                }else
                {
                    
                }
            }
            
            [tarr_big addObject:tdic];
        }
        [jsonPara setObject:tarr_big forKey:@"tomorrowMatter"];
        
    }
    
    NSData *data = [NSJSONSerialization dataWithJSONObject:jsonPara options:NSJSONWritingPrettyPrinted error:nil];
    NSString *jsonPara_str =[[NSString alloc]initWithData:data encoding:NSUTF8StringEncoding];
    
    NSString  *type2 =[type isEqualToString:@"仅自己和领导可见"]?@"0":([type isEqualToString:@"所在部门可见"]?@"1":@"2");
    if(address==nil)
    {
        address = @" ";
    }
    MBProgressHUD *hud = [MBProgressHUD showHUDAddedTo:self.view animated:YES];
    hud.mode = MBProgressHUDModeAnnularDeterminate;
    hud.label.text = @"正在提交";
    [WebRequest daily_Add_DailyWithuserGuid:user.Guid companyId:user.companyId departmentId:user.departId location:address jsonPara:jsonPara_str feeling:arr_model2[0] displayType:type2 And:^(NSDictionary *dic) {
        hud.label.text = dic[Y_MSG];
        dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(0.7 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
            [hud hideAnimated:NO];
            if ([dic[Y_STATUS] integerValue]==200) {
                [USERDEFAULTS removeObjectForKey:Y_jsonPara];
                [USERDEFAULTS removeObjectForKey:Y_ganWu];
                [USERDEFAULTS synchronize];
                [self.navigationController popViewControllerAnimated:NO];
            }
        });
    }];
    
    
}


-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    if (indexPath.section==2) {
        
        NSMutableAttributedString *con = [[NSMutableAttributedString alloc]initWithString:arr_model2[0] attributes:@{NSFontAttributeName:[UIFont systemFontOfSize:18]}];
        con.yy_lineSpacing =8;
        CGSize size = [con boundingRectWithSize:CGSizeMake(DEVICE_WIDTH-30, MAXFLOAT) options:NSStringDrawingUsesLineFragmentOrigin context:nil].size;
        return size.height+40;
    }else if(indexPath.section==0)
    {
        RiZhiModel  *model= arr_model0[indexPath.row];
        return model.cellHeight;
    }else if (indexPath.section==1)
    {
        NSArray *tarr = arr_model1[indexPath.row];
        return [self getHeightWitharr:tarr];
    }else if (indexPath.section==3)
    {
        NSArray *tarr = arr_model3[indexPath.row];
        return [self getHeightWitharr:tarr];
    }
    else{
        return 60;
    }
  
}

-(CGFloat)getHeightWitharr:(NSArray*)tarr{
    NSMutableAttributedString  *title = [[NSMutableAttributedString alloc]initWithString:@""];
    NSMutableAttributedString *time = [[NSMutableAttributedString alloc]initWithString:@"时间："  attributes:@{NSFontAttributeName:[UIFont systemFontOfSize:18]}];
    for (int i=0; i<tarr.count; i++) {
        GNmodel *model =tarr[i];
        if (model.biaoji ==3 && i==0) {
            NSMutableAttributedString  *tstr =[[NSMutableAttributedString alloc]initWithString:model.content attributes:@{NSFontAttributeName:[UIFont systemFontOfSize:15],NSForegroundColorAttributeName:[UIColor grayColor]}];
            [time appendAttributedString:tstr];
        }else if (model.biaoji ==3 && i>0)
        {
            NSMutableAttributedString  *tstr =[[NSMutableAttributedString alloc]initWithString:[NSString stringWithFormat:@" ~ %@\n",model.content]  attributes:@{NSFontAttributeName:[UIFont systemFontOfSize:15],NSForegroundColorAttributeName:[UIColor grayColor]}];
            [time appendAttributedString:tstr];
            [title appendAttributedString:time];
        }else
        {
            NSMutableAttributedString *other = [[NSMutableAttributedString alloc]initWithString:[NSString stringWithFormat:@"%@：",model.name] attributes:@{NSFontAttributeName:[UIFont systemFontOfSize:18]}];
            NSMutableAttributedString *other2 =[[NSMutableAttributedString alloc]initWithString:[NSString stringWithFormat:@"%@\n",model.content] attributes:@{NSFontAttributeName:[UIFont systemFontOfSize:15],NSForegroundColorAttributeName:[UIColor grayColor]}];
            [other appendAttributedString:other2];
            [title appendAttributedString:other];
        }
    }
    
    time.yy_lineSpacing =8;
    CGSize size = [title boundingRectWithSize:CGSizeMake(DEVICE_WIDTH-30, MAXFLOAT) options:NSStringDrawingUsesLineFragmentOrigin context:nil].size;
    return size.height+40;
}
#pragma  mark - 表的数据源

-(NSString*)tableView:(UITableView *)tableView titleForHeaderInSection:(NSInteger)section
{
    if (section >3) {
        return nil;
    }else
    {
    return arr_titles[section];
    }
}
-(CGFloat)tableView:(UITableView *)tableView heightForFooterInSection:(NSInteger)section
{
    if (section==0|| section==2 || section==4 || section ==5) {
        return 1;
    }else
    {
        return 50;
    }
}
-(UIView*)tableView:(UITableView *)tableView viewForFooterInSection:(NSInteger)section
{
    if (section==0|| section==2 || section==4 || section ==5) {
        return nil;
    }else
    {
    FBButton  *tbtn = [FBButton buttonWithType:UIButtonTypeSystem];
    [tbtn setTitle:[NSString stringWithFormat:@"+增加%@",arr_titles[section]] titleColor:EQDCOLOR backgroundColor:[UIColor whiteColor] font:[UIFont systemFontOfSize:19]];
    tbtn.temp = section;
    [tbtn addTarget:self action:@selector(AddClick:) forControlEvents:UIControlEventTouchUpInside];
    
    return tbtn;
    }
}
#pragma  mark - 增加的按钮点击事件
-(void)AddClick:(FBButton*)tbtn{
    temp = tbtn.temp;
    if (tbtn.temp ==0) {
        // 今日计划事项
        
        FX_riZhiSectionAddViewController  *ZSvc = [[FX_riZhiSectionAddViewController alloc]init];
        GNmodel *model1 = [[GNmodel alloc]init];
        model1.biaoji =4;
        model1.name = @"今日完成结果";
        model1.content = @"请选择";
        ZSvc.arr_json=[NSMutableArray arrayWithArray:@[model1]];
        ZSvc.navigationItem.title = @"今日计划事项";
        ZSvc.delegate_riZhi =self;
        [self.navigationController pushViewController:ZSvc animated:NO];
        
    }else if (tbtn.temp ==1)
    {
        //今日临时事项
        isXiuGai =0;
        FX_riZhiSectionAddViewController  *ZSvc = [[FX_riZhiSectionAddViewController alloc]init];
         ZSvc.navigationItem.title = @"今日临时事项";
        GNmodel *model1 = [[GNmodel alloc]init];
        model1.biaoji =4;
        model1.name = @"今日完成结果";
        model1.content = @"请选择";
        
        GNmodel *model2 = [[GNmodel alloc]init];
        model2.biaoji =2;
        model2.name = @"今日临时事项";
        model2.content = @"请输入";
        ZSvc.arr_json=[NSMutableArray arrayWithArray:@[model_time1,model_time2,model2,model1]];
        ZSvc.delegate_riZhi =self;
        [self.navigationController pushViewController:ZSvc animated:NO];
    }else if (tbtn.temp ==2 )
    {
     //今日感悟
        FBTextVViewController *TVvc =[[FBTextVViewController alloc]init];
//        TVvc.indexpath =indexPath;
        TVvc.delegate =self;
        TVvc.contentTitle=@"今日感悟";
//        TVvc.content =arr_contents[indexPath.row];
        [self.navigationController pushViewController:TVvc animated:NO];
        
    }else if(tbtn.temp ==3 )
    {
        //明日计划
        isXiuGai =0;
        FX_riZhiSectionAddViewController  *ZSvc = [[FX_riZhiSectionAddViewController alloc]init];
        ZSvc.navigationItem.title = @"明日计划";
        GNmodel *model1 = [[GNmodel alloc]init];
        model1.biaoji =2;
        model1.name = @"明日工作计划";
        model1.content = @"请输入";
        ZSvc.delegate_riZhi =self;
        ZSvc.arr_json=[NSMutableArray arrayWithArray:@[model_time1,model_time2,model1]];
        [self.navigationController pushViewController:ZSvc animated:NO];
        
    }else
    {
        
    }
    
}
-(NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return 6;
}
-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    if (section==2) {
        return 1;
    }else if(section==0)
    {
        return arr_model0.count;
    }else if (section==1)
    {
        return arr_model1.count;
    }else if (section==3)
    {
        return arr_model3.count;
    }
    {
    return 1;
    }
}
-(UITableViewCell*)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    static NSString *cellId=@"cellID";
     EQDR_labelTableViewCell *cell =[tableView dequeueReusableCellWithIdentifier:cellId];
    if (!cell) {
        cell = [[EQDR_labelTableViewCell alloc]initWithStyle:UITableViewCellStyleDefault reuseIdentifier:cellId];
        cell.accessoryType = UITableViewCellAccessoryDisclosureIndicator;
    }
    if(indexPath.section==2)
    {
        NSString  *tstr = arr_model2[indexPath.row];
        [cell setContents:tstr];
    }else if (indexPath.section==0){
        RiZhiModel *model = arr_model0[indexPath.row];
        [cell setModel_rizhi:model];
    }else if (indexPath.section==1)
    {
        NSArray *tarr = arr_model1[indexPath.row];
        [cell setArr_json:tarr];
    }else if (indexPath.section==3)
    {
        NSArray *tarr = arr_model3[indexPath.row];
        [cell setArr_json:tarr];
    }else if(indexPath.section==4)
    {
        [cell setAddress:address];
    }else if (indexPath.section == 5)
    {
        [cell setContents:type];
    }else
    {
        
    }
    return cell;
}

-(void)viewWillDisappear:(BOOL)animated
{
    [super viewWillDisappear:animated];
    
    NSMutableDictionary  *jsonPara = [NSMutableDictionary dictionary];
    if (arr_model0.count==0) {
        [jsonPara setObject:@[] forKey:@"plan"];
    }else
    {
        NSMutableArray  *tarr = [NSMutableArray arrayWithCapacity:0];
        for (int i=0; i<arr_model0.count; i++) {
            RiZhiModel *model =arr_model0[i];
            NSMutableDictionary *tdic =[NSMutableDictionary dictionary];
            [tdic setObject:model.Id forKey:@"Id"];
            NSString *tstr = model.result ==nil?@" ":model.result;
            [tdic setObject:tstr forKey:@"status"];
            [tarr addObject:tdic];
        }
        
        [jsonPara setObject:tarr forKey:@"plan"];
    }
    
    if(arr_model1.count==0)
    {
        [jsonPara setObject:@[] forKey:@"matter"];
    }else
    {
        NSMutableArray *tarr_big=[NSMutableArray arrayWithCapacity:0];
        for (int i=0; i<arr_model1.count; i++) {
            NSMutableDictionary  *tdic =[NSMutableDictionary dictionary];
            NSArray *tarr =arr_model1[i];
            NSMutableString *tstr_time = [NSMutableString string];
            for (int j=0; j<tarr.count; j++) {
                GNmodel *model =tarr[j];
                
                if (model.biaoji ==3 && j==0) {
                    [tstr_time appendString:model.content];
                }else if (model.biaoji ==3 && j==1)
                {
                    [tstr_time appendFormat:@"-%@",model.content];
                    [tdic setObject:tstr_time forKey:@"timeSlot"];
                }else if(j==2 && model.biaoji ==2)
                {
                    [tdic setObject:model.content forKey:@"content"];
                }else if (j==3 && model.biaoji==4)
                {
                    [tdic setObject:model.content forKey:@"status"];
                }else
                {
                    
                }
            }
            [tarr_big addObject:tdic];
        }
        [jsonPara setObject:tarr_big forKey:@"matter"];
        
    }
    
    
    
    if(arr_model3.count==0)
    {
        [jsonPara setObject:@[] forKey:@"tomorrowMatter"];
    }else
    {
        NSMutableArray *tarr_big=[NSMutableArray arrayWithCapacity:0];
        for (int i=0; i<arr_model3.count; i++) {
            NSMutableDictionary  *tdic =[NSMutableDictionary dictionary];
            NSArray *tarr =arr_model3[i];
            NSMutableString *tstr_time = [NSMutableString string];
            for (int j=0; j<tarr.count; j++) {
                GNmodel *model =tarr[j];
                
                if (model.biaoji ==3 && j==0) {
                    [tstr_time appendString:model.content];
                }else if (model.biaoji ==3 && j==1)
                {
                    [tstr_time appendFormat:@"-%@",model.content];
                    [tdic setObject:tstr_time forKey:@"timeSlot"];
                }else if(j==2 && model.biaoji ==2)
                {
                    [tdic setObject:model.content forKey:@"content"];
                }else
                {
                    
                }
            }
            
            [tarr_big addObject:tdic];
        }
        [jsonPara setObject:tarr_big forKey:@"tomorrowMatter"];
        
    }
    [USERDEFAULTS setObject:arr_model2[0] forKey:Y_ganWu];
    [USERDEFAULTS setObject:jsonPara forKey:Y_jsonPara];
    [USERDEFAULTS synchronize];
}
#pragma  mark - 表的协议代理
-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    indexpath_selected = indexPath;
    temp = indexPath.section;
    if (indexPath.section==0) {
        UIAlertController  *alert = [UIAlertController alertControllerWithTitle:@"今日计划的完成结果" message:nil preferredStyle:UIAlertControllerStyleActionSheet];
        NSArray *tarr = @[@"已完成",@"未完成",@"取消"];
        for (int i=0; i<tarr.count; i++) {
            [alert addAction:[UIAlertAction actionWithTitle:tarr[i] style:UIAlertActionStyleDefault handler:^(UIAlertAction * _Nonnull action) {
                RiZhiModel  *model = arr_model0[indexPath.row];
                model.result = tarr[i];
                [tableV reloadRowsAtIndexPaths:@[indexPath] withRowAnimation:UITableViewRowAnimationNone];
            }]];
            
        }
        dispatch_async(dispatch_get_main_queue(), ^{
            [self presentViewController:alert animated:NO completion:nil];
        });
    }
    if(indexPath.section==2)
    {
        FBTextVViewController *TVvc =[[FBTextVViewController alloc]init];
        TVvc.indexpath =indexPath;
        TVvc.delegate =self;
        TVvc.contentTitle=@"今日感悟";
        TVvc.S_maxnum = @"500";
        TVvc.content =arr_model2[0];
        [self.navigationController pushViewController:TVvc animated:NO];
    }else if (indexPath.section==4)
    {
        //地址刷新
        [self dingwei];
        [tableView reloadRowsAtIndexPaths:@[indexPath] withRowAnimation:UITableViewRowAnimationNone];
    }else if (indexPath.section == 5)
    {
        UIAlertController  *alert = [[UIAlertController alloc]init];
        NSArray *tarr = @[@"仅自己和领导可见",@"所在部门可见",@"全公司可见"];
        for(int i=0;i<tarr.count;i++)
        {
            [alert addAction:[UIAlertAction actionWithTitle:tarr[i] style:UIAlertActionStyleDefault handler:^(UIAlertAction * _Nonnull action) {
                type = tarr[i];
                [tableView reloadRowsAtIndexPaths:@[indexPath] withRowAnimation:UITableViewRowAnimationNone];
            }]];
        }
        dispatch_async(dispatch_get_main_queue(), ^{
            [self presentViewController:alert animated:NO completion:nil];
        });
    }else if (indexPath.section==1)
    {
        isXiuGai =1;
        NSArray *tarr = arr_model1[indexPath.row];
        FX_riZhiSectionAddViewController *RZvc = [[FX_riZhiSectionAddViewController alloc]init];
        RZvc.delegate_riZhi =self;
        RZvc.navigationItem.title = @"今日临时事项";
        RZvc.arr_json = [NSMutableArray arrayWithArray:tarr];
        [self.navigationController pushViewController:RZvc animated:NO];
        
        
    }else if (indexPath.section ==3)
    {
        isXiuGai=1;
        NSArray *tarr = arr_model3[indexPath.row];
        FX_riZhiSectionAddViewController *RZvc = [[FX_riZhiSectionAddViewController alloc]init];
        RZvc.delegate_riZhi =self;
        RZvc.navigationItem.title = @"明日计划事项";
        RZvc.arr_json = [NSMutableArray arrayWithArray:tarr];
        [self.navigationController pushViewController:RZvc animated:NO];
    }else
    {
        
    }
}

-(BOOL)tableView:(UITableView *)tableView canEditRowAtIndexPath:(NSIndexPath *)indexPath
{
    return YES;
}

-(UITableViewCellEditingStyle)tableView:(UITableView *)tableView editingStyleForRowAtIndexPath:(NSIndexPath *)indexPath
{
    if(indexPath.section ==1 || indexPath.section ==3)
    {
    return UITableViewCellEditingStyleDelete;
    }else
    {
        return  UITableViewCellEditingStyleNone;
    }
    
}
-(void)tableView:(UITableView *)tableView commitEditingStyle:(UITableViewCellEditingStyle)editingStyle forRowAtIndexPath:(NSIndexPath *)indexPath
{
    
    if (editingStyle == UITableViewCellEditingStyleDelete) {
        //删除
        if (indexPath.section==1) {
            [arr_model1 removeObjectAtIndex:indexPath.row];
            [tableV reloadSections:[NSIndexSet indexSetWithIndex:indexPath.section] withRowAnimation:UITableViewRowAnimationNone];
        }else if (indexPath.section==3)
        {
            [arr_model3 removeObjectAtIndex:indexPath.row];
            [tableV reloadSections:[NSIndexSet indexSetWithIndex:indexPath.section] withRowAnimation:UITableViewRowAnimationNone];
        }else
        {
            
        }
    }
}

-(NSString*)tableView:(UITableView *)tableView titleForDeleteConfirmationButtonForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return @"删除";
}


@end
