//
//  KQDaKaView.h
//  EQD
//
//  Created by 梁新帅 on 2017/6/28.
//  Copyright © 2017年 FitBoy. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "CalendarModel.h"
@interface KQDaKaView : UIView
@property (nonatomic,strong)  CalendarModel *model;
@property (nonatomic,copy)  NSString *weeks_week;
-(void)setModel:(CalendarModel *)model Withweeks:(NSString*)weeks;

@end
