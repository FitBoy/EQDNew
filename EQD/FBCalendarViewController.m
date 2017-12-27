//
//  FBCalendarViewController.m
//  EQD
//
//  Created by 梁新帅 on 2017/5/16.
//  Copyright © 2017年 FitBoy. All rights reserved.
//
#define DEVICE_HEIGHT  [UIScreen mainScreen].bounds.size.height
#define DEVICE_WIDTH   [UIScreen mainScreen].bounds.size.width
#import "FBCalendarViewController.h"

@interface FBCalendarViewController ()<UICollectionViewDelegate,UICollectionViewDataSource>
{
    int width;
    NSMutableArray *arr_weeks;
    NSCalendar *calendar_yangli;
    NSCalendar *calendar_yinli;
    NSMutableArray *arr_tianshu;
    UILabel *L_YearM;
    UIButton *B_next;
    UIButton *B_pre;
    NSDate *D_slected;
    FBCalendarCollectionViewCell *cell_selectd;
}

@end

@implementation FBCalendarViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    width =DEVICE_WIDTH/7;
    calendar_yinli = [NSCalendar calendarWithIdentifier:NSCalendarIdentifierChinese];
    calendar_yangli = [NSCalendar calendarWithIdentifier:NSCalendarIdentifierGregorian];
    arr_tianshu = [NSMutableArray arrayWithArray:@[@"31",@"28",@"31",@"30",@"31",@"30",@"31",@"31",@"30",@"31",@"30",@"31"]];
    self.arr_dataSource = [NSMutableArray arrayWithCapacity:0];
    arr_weeks = [NSMutableArray arrayWithArray:@[@"日",@"一",@"二",@"三",@"四",@"五",@"六"]];
    UIView *tview =[[UIView alloc]initWithFrame:CGRectMake(0, 40, DEVICE_WIDTH, 20)];
    [self.view addSubview:tview];
    NSDateComponents  *componet1 =[[NSCalendar calendarWithIdentifier:NSCalendarIdentifierChinese] components:NSCalendarUnitEra|NSCalendarUnitYear|NSCalendarUnitMonth|NSCalendarUnitDay|NSCalendarUnitWeekday fromDate:[NSDate date]];
    
//    tview.backgroundColor =[UIColor grayColor];
    float width1 =DEVICE_WIDTH/7.0;
    for (int i=0; i<7; i++) {
        UILabel *tlabel = [[UILabel alloc]initWithFrame:CGRectMake(width1*i, 0, width1, 20)];
        [tview addSubview:tlabel];
        if (i==0||i==6) {
            tlabel.textColor=[UIColor grayColor];
        }
        tlabel.font = [UIFont systemFontOfSize:15];
        tlabel.text = arr_weeks[i];
        tlabel.textAlignment=NSTextAlignmentCenter;
    }
    

    [self initYearMonthDay];
    [self initCollectionView];
    [self setDataSourceWithDate:[NSDate date]];
    
}
//根据日期返回星期几
-(NSInteger)weekWithdate:(NSDate*)date
{
    NSDateComponents *componet = [calendar_yangli components:NSCalendarUnitMonth|NSCalendarUnitDay|NSCalendarUnitWeekday fromDate:date];
    return componet.weekday;
}
///把date的时间分成年月日
-(NSDateComponents*)dateComponentWithdate:(NSDate*)date{
     NSDateComponents *componet = [calendar_yangli components:NSCalendarUnitYear|NSCalendarUnitMonth|NSCalendarUnitDay|NSCalendarUnitWeekday fromDate:date];
    return componet;
}


///设置数据源
-(void)setDataSourceWithDate:(NSDate*)date
{
    D_slected = date;
    [self.arr_dataSource removeAllObjects];
    NSDateComponents *componet = [self dateComponentWithdate:date];
    NSDateComponents *now = [self dateComponentWithdate:[NSDate date]];
    
   L_YearM.text = [NSString stringWithFormat:@"%ld年%ld月",(long)componet.year,(long)componet.month];
    
    if (componet.month==2) {
        NSDateComponents *tcomponent =[[NSDateComponents alloc]init];
        [tcomponent setValue:componet.year forComponent:NSCalendarUnitYear];
        [tcomponent setValue:componet.month forComponent:NSCalendarUnitMonth];
        [tcomponent setValue:29 forComponent:NSCalendarUnitDay];
        if ([tcomponent isValidDateInCalendar:calendar_yangli]) {
            [arr_tianshu replaceObjectAtIndex:1 withObject:@"29"];
        }
    }
    
    NSString *str_now =[NSString stringWithFormat:@"%ld-%ld-%ld",(long)now.year,(long)now.month,(long)now.day];
    NSString *str_num = arr_tianshu[componet.month-1];
    NSString *str_date1 =[NSString stringWithFormat:@"%ld-%ld-%d",(long)componet.year,(long)componet.month,1];
      NSDate *date1 = [self dateWithString:str_date1];
   
    NSInteger  all_tianshu = [str_num integerValue]+ [self weekWithdate:date1]-1;
    NSInteger height = all_tianshu>35? width*6:width*5;
    if ([self.delegate respondsToSelector:@selector(collectionVWithheight:)]) {
        [self.delegate collectionVWithheight:height];
        
    }
    //测试
    self.CollectionV.frame= CGRectMake(0, 60, DEVICE_WIDTH, height);
    
    for (int i=0; i<[str_num integerValue]; i++) {
        NSString *str_date =[NSString stringWithFormat:@"%ld-%ld-%d",(long)componet.year,(long)componet.month,(i+1)];
        NSDate *date = [self dateWithString:str_date];
        CalendarModel *model = [[CalendarModel alloc]initWithDate:date];
        
        if ([str_now isEqualToString:str_date]) {
            model.isNow=YES;
        }
        [self.arr_dataSource addObject:model];
}
  
    [self.CollectionV reloadData];
    
}
///根据字符串返回时间
-(NSDate*)dateWithString:(NSString*)string
{
    NSDateFormatter *datematter  =[[NSDateFormatter alloc]init];
    [datematter setDateFormat:@"yyyy-M-d"];
    NSDate *date = [datematter dateFromString:string];
    return date;
}

-(void)initYearMonthDay
{
    L_YearM = [[UILabel alloc]initWithFrame:CGRectMake((DEVICE_WIDTH-150)/2.0,5, 150, 30)];
    L_YearM.textAlignment=NSTextAlignmentCenter;
    [self.view addSubview:L_YearM];
    B_pre = [UIButton buttonWithType:UIButtonTypeSystem];
    B_pre.frame = CGRectMake(15, 5, 50, 30);
    [B_pre setTitle:@"上月" forState:UIControlStateNormal];
    [B_pre addTarget:self action:@selector(preClick) forControlEvents:UIControlEventTouchUpInside];
    
    B_next =[UIButton buttonWithType:UIButtonTypeSystem];
    B_next.frame = CGRectMake(DEVICE_WIDTH-50-15, 5, 50, 30);
    [B_next setTitle:@"下月" forState:UIControlStateNormal];
    [B_next addTarget:self action:@selector(nextClick) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:B_pre];
    [self.view addSubview:B_next];
    
}
-(void)preClick
{
    //上月
    NSDateComponents *componet = [self dateComponentWithdate:D_slected];
    
    _selected_model = [[CalendarModel alloc]initWithDate:D_slected];
    
    NSDate *date;
    if (componet.month==1) {
        date = [self dateWithString:[NSString stringWithFormat:@"%d-%d-%d",componet.year-1,12,1]];
    }
    else
    {
  date= [self dateWithString:[NSString stringWithFormat:@"%ld-%d-%d",(long)componet.year,componet.month-1,1]];
    }
    [self setDataSourceWithDate:date];
    self.monthTwoclick(date);
}
-(void)nextClick
{
    //下月
    NSDateComponents *componet = [self dateComponentWithdate:D_slected];
    _selected_model = [[CalendarModel alloc]initWithDate:D_slected];
    NSDate *date;
    if (componet.month==12) {
        date =[self dateWithString:[NSString stringWithFormat:@"%d-%d-%d",componet.year+1,1,1]];
    }
    else
    {
    date= [self dateWithString:[NSString stringWithFormat:@"%ld-%d-%d",(long)componet.year,componet.month+1,1]];
    }
    [self setDataSourceWithDate:date];
    self.monthTwoclick(date);
}
-(void)initCollectionView{
    UICollectionViewFlowLayout  *flowL =[[UICollectionViewFlowLayout alloc]init];
    flowL.itemSize =CGSizeMake(width, width);
    flowL.minimumLineSpacing=0.0;
    flowL.minimumInteritemSpacing=0.0;
    //flowL.sectionInset = UIEdgeInsetsMake(0, 0, 0, 0);
    self.CollectionV =[[UICollectionView alloc]initWithFrame:CGRectMake(0, 60, DEVICE_WIDTH, DEVICE_HEIGHT-60) collectionViewLayout:flowL];
    self.CollectionV.delegate=self;
    self.CollectionV.dataSource=self;
    [self.view addSubview:self.CollectionV];
    [self.CollectionV registerClass:[FBCalendarCollectionViewCell class] forCellWithReuseIdentifier:@"CalendarCollectionViewCell"];
    self.CollectionV.backgroundColor = [UIColor whiteColor];
    //为collectionV增加手势
    UISwipeGestureRecognizer *left =[[UISwipeGestureRecognizer alloc]initWithTarget:self action:@selector(preClick)];
    left.direction = UISwipeGestureRecognizerDirectionRight;
    [self.CollectionV addGestureRecognizer:left];
    
    UISwipeGestureRecognizer *right = [[UISwipeGestureRecognizer alloc]initWithTarget:self action:@selector(nextClick)];
    right.direction = UISwipeGestureRecognizerDirectionLeft;
    [self.CollectionV addGestureRecognizer:right];
    
}



#pragma mark - collection 数据源与代理

-(NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section{
    if (self.arr_dataSource.count) {
        CalendarModel *model = self.arr_dataSource[0];
        return self.arr_dataSource.count-1+ [self weekWithdate:model.date];
    }
    
    return 0;
}
- ( UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath{
    
    FBCalendarCollectionViewCell *cell= [collectionView dequeueReusableCellWithReuseIdentifier:@"CalendarCollectionViewCell" forIndexPath:indexPath];
    if (self.arr_dataSource.count) {
        CalendarModel  *model =self.arr_dataSource[0];
        if (indexPath.row<[self weekWithdate:model.date]-1) {
            [cell setModel:nil];
        }
        else
        {
            CalendarModel *model1  =self.arr_dataSource[indexPath.row+1-[self  weekWithdate:model.date]];
            model1.indexPath =indexPath;
            [cell setModel:model1];
        }
        
    }
    return cell;
}
-(void)collectionView:(UICollectionView *)collectionView didSelectItemAtIndexPath:(NSIndexPath *)indexPath{
    
    if (self.arr_dataSource.count) {
        CalendarModel  *model =self.arr_dataSource[0];
        if (indexPath.row<[self weekWithdate:model.date]-1) {
            //点了没有日期的不做日和逻辑
        }
        else
        {
            FBCalendarCollectionViewCell *cell = (FBCalendarCollectionViewCell*)[collectionView cellForItemAtIndexPath:indexPath];
            [self slectedOneCell:cell];
        }
    }
    
  
}
-(void)slectedOneCell:(FBCalendarCollectionViewCell*)cell
{
    
    if (cell==cell_selectd) {
        return;
    }
    else
    {
    if (cell_selectd!=nil) {
        NSIndexPath *indexpath =[self.CollectionV indexPathForCell:cell_selectd];
        [self.CollectionV reloadItemsAtIndexPaths:@[indexpath]];
    }
   cell.V_bg.backgroundColor =[UIColor blueColor];
    cell.L_name.textColor=[UIColor whiteColor];
    cell.L_num.textColor = [UIColor whiteColor];
        cell_selectd=nil;
    cell_selectd=cell;
        _selected_model = cell.model;
        NSIndexPath *indexpath =[self.CollectionV indexPathForCell:cell_selectd];
        self.tapOnindexPath(indexpath);

        if ([self.delegate respondsToSelector:@selector(CalendaslectedModel:)]) {
            [self.delegate CalendaslectedModel:cell.model];
        }
    }
    
}



-(CalendarModel*)selected_model
{
    if (_selected_model==nil) {
        CalendarModel *model = [[CalendarModel alloc]initWithDate:D_slected];
        
        return model;
    }
    return _selected_model;
}

@end
