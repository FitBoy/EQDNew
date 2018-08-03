//
//  SC_productModel.h
//  EQD
//
//  Created by 梁新帅 on 2018/7/3.
//  Copyright © 2018年 FitBoy. All rights reserved.
//
/*
 产品供方信息详情
 {
 CompanyId = 46;
 GuoBiaoCode = ISO9001;
 Id = 93;
 ProductDesc = "\U9ad8\U5f3a\U5ea6\U65e0\U6bd2\U5851\U6599";
 ProductId = 67;
 ProductName = "\U5851\U6599";
 ProductType = "\U5851\U6599\U52a0\U5de5\U4e13\U7528\U8bbe\U5907\U5236\U9020";
 createTime = "2018/7/26 15:46:58";
 indexList =             (
 {
 CompanyId = 46;
 Id = 104;
 IndexImage = "https://www.eqid.top:8009/image/20180726/2018072615465620300.jpg";
 IndexTypeKey = "\U6bd2\U6027\U548c\U7c7b\U4f3c\U5371\U9669";
 IndexTypeValue = 0;
 ProductId = 67;
 ProductSupplyId = 93;
 createTime = "2018/7/26 15:46:58";
 }
 );
 }
 //收藏的产品信息
 {
 Id = 14;
 comLogo = "https://www.eqid.top:8009/image/com/46/1804085749logo.png";
 company = "\U90d1\U5dde\U6613\U4f01\U70b9\U4fe1\U606f\U79d1\U6280\U6709\U9650\U516c\U53f8";
 companyId = 46;
 productImage = "https://www.eqid.top:8009/image/ComSpace/20180719/201807191524485487.png";
 productName = "\U624b\U673a";
 productPrice = 5799;
 },
 */

#import <Foundation/Foundation.h>
#import "SC_maiMaiModel.h"
@interface SC_productModel : NSObject
@property (nonatomic,copy) NSString* Id;
@property (nonatomic,copy) NSString* ProductName;
@property (nonatomic,copy) NSString* productName;
@property (nonatomic,copy) NSString* ProductPrice;
@property (nonatomic,copy) NSString* productPrice;

@property (nonatomic,copy) NSString* ProductType;
@property (nonatomic,copy) NSString* area;
@property (nonatomic,copy) NSString* browseCount;
@property (nonatomic,copy) NSString* image;
@property (nonatomic,assign) float cell_height;
@property (nonatomic,copy) NSString* ProductInfo;
@property (nonatomic,copy) NSString* CompanyId;
@property (nonatomic,copy) NSString* ProductId;
@property (nonatomic,copy) NSString* productId;
///产品的型号
@property (nonatomic,copy) NSString* productModel;
@property (nonatomic,copy) NSString* ProductModel;
///详情多出来的字段
@property (nonatomic,copy) NSString* DeliveryCycle;
@property (nonatomic,copy) NSString* DeliveryCycle2;
@property (nonatomic,copy) NSString* ProductMsg;
@property (nonatomic,copy) NSString* ProductDesc;
@property (nonatomic,copy) NSString* Stock;
@property (nonatomic,strong)  NSArray *images;
@property (nonatomic,copy) NSString* company;
///国际代码
@property (nonatomic,copy) NSString* GuoBiaoCode;
@property (nonatomic,copy) NSString* createTime;
@property (nonatomic,strong)  NSArray *indexList;
@property (nonatomic,copy) NSString* comLogo;
@property (nonatomic,copy) NSString* productImage;
-(NSString*)createTime;
@end
