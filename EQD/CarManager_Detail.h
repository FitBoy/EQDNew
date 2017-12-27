//
//  CarManager_Detail.h
//  EQD
//
//  Created by 梁新帅 on 2017/12/2.
//  Copyright © 2017年 FitBoy. All rights reserved.
// 车辆的详细信息

#import <Foundation/Foundation.h>

@interface CarManager_Detail : NSObject
@property (nonatomic,copy) NSString* Id;
@property (nonatomic,copy) NSString* VIN;
///事故次数
@property (nonatomic,copy) NSString* accidentCount;
///年检日期
@property (nonatomic,copy) NSString* annInspectDate;
@property (nonatomic,copy) NSString* color;
@property (nonatomic,copy) NSString* comid;
@property (nonatomic,copy) NSString* createTime;
@property (nonatomic,copy) NSString* engineCode;
@property (nonatomic,copy) NSString* insurance;
///保险到期日期
@property (nonatomic,copy) NSString* insuranceEndDate;
/// 保养次数
@property (nonatomic,copy) NSString* maintainCount;
///违章次数
@property (nonatomic,copy) NSString* peccancyCount;
@property (nonatomic,copy) NSString* plateNumber;
@property (nonatomic,strong) NSArray *picAddr;
///购买日期
@property (nonatomic,copy) NSString* purchaseDate;
@property (nonatomic,copy) NSString* purchasePrice;
@property (nonatomic,copy) NSString* remark;
///维修次数
@property (nonatomic,copy) NSString* repairedCount;
@property (nonatomic,copy) NSString* seats;
@property (nonatomic,copy) NSString* vehicleType;

-(NSString*)purchaseDate;
-(NSString*)insuranceEndDate;
-(NSString*)annInspectDate;
@end
