//
//  EQDS_articleModel.h
//  EQD
//
//  Created by 梁新帅 on 2018/2/27.
//  Copyright © 2018年 FitBoy. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface EQDS_articleModel : NSObject
@property (nonatomic,copy) NSString* Id;
@property (nonatomic,copy) NSString* Label;
@property (nonatomic,copy) NSString* browseCount;
@property (nonatomic,copy) NSString* content;
@property (nonatomic,copy) NSString* createTime;
@property (nonatomic,copy) NSString* image;
@property (nonatomic,copy) NSString* iphoto;
@property (nonatomic,copy) NSString* textContent;
@property (nonatomic,copy) NSString* title;
@property (nonatomic,copy) NSString* upname;
@property (nonatomic,copy) NSString* userGuid;
@property (nonatomic,assign) float cellHeight;
/*详情多出来的字段*/
@property (nonatomic,copy) NSString* boutique;
@property (nonatomic,copy) NSString* collectionCount;
@property (nonatomic,copy) NSString* commentCount;
@property (nonatomic,copy) NSString* companyId;
@property (nonatomic,copy) NSString* homeImage;
@property (nonatomic,copy) NSString* hot;
@property (nonatomic,copy) NSString* reportCount;
@property (nonatomic,copy) NSString* reprintCount;
@property (nonatomic,copy) NSString* staffName;
@property (nonatomic,copy) NSString*  status;
///电话号码
@property (nonatomic,copy) NSString* uname;
@property (nonatomic,copy) NSString* zanCount;
-(NSString*)createTime;
@end
