//
//  FBCalendarViewController.h
//  EQD
//
//  Created by 梁新帅 on 2017/5/16.
//  Copyright © 2017年 FitBoy. All rights reserved.
//

#import "FBBaseViewController.h"
#import "FBCalendarCollectionViewCell.h"
typedef void (^tapOnCalender)(NSIndexPath *indexPath);
/// date 是日期
typedef void (^MonthClick)(NSDate *date);
@interface FBCalendarViewController : FBBaseViewController
@property (nonatomic,weak)id delegate;
@property (nonatomic,strong) MonthClick monthTwoclick;
@property (nonatomic,strong)  tapOnCalender  tapOnindexPath;
@property (nonatomic,strong)   CalendarModel *selected_model;
-(CalendarModel*)selected_model;
@property (nonatomic,strong)  NSMutableArray  *arr_dataSource;
@property (nonatomic,strong)  UICollectionView *CollectionV;
@end
@protocol FBCalendarViewControllerDelegate <NSObject>
///选中的日期
-(void)CalendaslectedModel:(CalendarModel*)model;
///colletionV的高度
-(void)collectionVWithheight:(NSInteger)height;

@end
