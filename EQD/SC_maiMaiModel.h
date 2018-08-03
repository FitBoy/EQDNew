//
//  SC_maiMaiModel.h
//  EQD
//
//  Created by 梁新帅 on 2018/7/18.
//  Copyright © 2018年 FitBoy. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface SC_maiMaiModel : NSObject
@property (nonatomic,copy) NSString* ComIndustry;
@property (nonatomic,copy) NSString* ComNature;
@property (nonatomic,copy) NSString* CompanyId;
@property (nonatomic,copy) NSString* Id;
@property (nonatomic,copy) NSString* IndexImage;
@property (nonatomic,copy) NSString* IndexTypeKey;
@property (nonatomic,copy) NSString* IndexTypeValue;
@property (nonatomic,copy) NSString* ProductId;
@property (nonatomic,copy) NSString* ProductSupplyId;
@property (nonatomic,copy) NSString* createTime;
-(NSString*)createTime;
@end
