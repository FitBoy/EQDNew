//
//  Car_ChooseByTimeViewController.h
//  EQD
//
//  Created by 梁新帅 on 2017/12/7.
//  Copyright © 2017年 FitBoy. All rights reserved.
// 根据时间来选取车辆

#import "FBBaseViewController.h"
#import "CarManagerModel.h"
@interface Car_ChooseByTimeViewController : FBBaseViewController
@property (nonatomic,copy) NSString* startTime;
@property (nonatomic,copy) NSString* endTime;
@property (nonatomic,weak) id delegate;
@end
@protocol Car_ChooseByTimeViewControllerDelegate <NSObject>
-(void)getCarmodel:(CarManagerModel*)Cmodel startTime:(NSString*)startTime endTime:(NSString*)endTime;
@end;
