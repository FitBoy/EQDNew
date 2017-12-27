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
@end


