//
//  CarManagerModel.h
//  EQD
//
//  Created by 梁新帅 on 2017/12/2.
//  Copyright © 2017年 FitBoy. All rights reserved.
//

#import "FBBaseModel.h"

@interface CarManagerModel : FBBaseModel
@property (nonatomic,copy) NSString* Id;
@property (nonatomic,copy) NSString* pic1;
@property (nonatomic,copy) NSString* plateNumber;
@property (nonatomic,copy) NSString* seats;
@property (nonatomic,copy) NSString* vehicleType;

-(NSString*)img_header;
-(NSString*)left0;
-(NSString*)left1;
-(NSString*)right0;

@end
