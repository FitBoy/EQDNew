//
//  CollectionModel.h
//  EQD
//
//  Created by 梁新帅 on 2017/10/28.
//  Copyright © 2017年 FitBoy. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface CollectionModel : NSObject
@property (nonatomic,copy) NSString* content;
@property (nonatomic,copy) NSString* createTime;
@property (nonatomic,copy) NSString* dataid;
@property (nonatomic,copy) NSString* group;
@property (nonatomic,copy) NSString* Id;
@property (nonatomic,copy) NSString* isdel;
@property (nonatomic,copy) NSString* owner;
@property (nonatomic,copy) NSString*  position;
@property (nonatomic,copy) NSString*  source;
@property (nonatomic,copy) NSString* sourceOwner;
@property (nonatomic,copy) NSString* tablename;
@property (nonatomic,copy) NSString* title;
@property (nonatomic,copy) NSString* type;
@property (nonatomic,copy) NSString* url;
@property (nonatomic,strong)  NSArray *arr_urls;
-(NSString*)createTime;
-(NSArray*)arr_urls;
@end
