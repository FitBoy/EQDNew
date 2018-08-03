//
//  WS_ComDetailModel.h
//  EQD
//
//  Created by 梁新帅 on 2018/6/29.
//  Copyright © 2018年 FitBoy. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "WS_contactModel.h"
#import "SC_TeamModel.h"
#import "Image_textModel.h"
#import "WS_equipmentModel.h"
@interface WS_ComDetailModel : NSObject
@property (nonatomic,copy) NSString* companyId;
///组织机构
@property (nonatomic,strong)  NSArray *ComOrganization;
///组织团队
@property (nonatomic,strong)  NSArray *ComTeam;
///联系方式
@property (nonatomic,strong)  WS_contactModel *ComCotact;
//设备信息
@property (nonatomic,strong) NSArray *ComEquipment;
///企业图片
@property (nonatomic,strong) NSArray *ComImage;

@property (nonatomic,copy) NSString* comDesc;

@end
