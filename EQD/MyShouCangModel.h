//
//  MyShouCangModel.h
//  EQD
//
//  Created by 梁新帅 on 2017/10/28.
//  Copyright © 2017年 FitBoy. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "CollectionModel.h"
#import "sourceOwnerModel.h"
@interface MyShouCangModel : NSObject
@property (nonatomic,strong) CollectionModel *Collection;
@property (nonatomic,strong)  sourceOwnerModel *sourceOwner;

/**易企阅 易企学 易企创专有的字段*/
@property (nonatomic,copy) NSString* Id;
@property (nonatomic,copy) NSString* articleurl;
@property (nonatomic,copy) NSString* avatar;
@property (nonatomic,copy) NSString* content;
@property (nonatomic,copy) NSString* createTime;
@property (nonatomic,copy) NSString* group;
@property (nonatomic,copy) NSString* nickname;
@property (nonatomic,copy) NSString* owner;
@property (nonatomic,copy) NSString* picurl;
@property (nonatomic,copy) NSString* position;
@property (nonatomic,copy) NSString* source;
@property (nonatomic,copy) NSString* sourceOwner2;
@property (nonatomic,copy) NSString* title;
@property (nonatomic,copy) NSString* type;
@property (nonatomic,copy) NSString* articleId;
-(NSString*)createTime;
@end


