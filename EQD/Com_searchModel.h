//
//  Com_searchModel.h
//  EQD
//
//  Created by 梁新帅 on 2018/12/20.
//  Copyright © 2018 FitBoy. All rights reserved.
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

@interface Com_searchModel : NSObject
@property (nonatomic,copy) NSString* com_name;
@property (nonatomic,copy) NSString* city;
@property (nonatomic,copy) NSString* com_type;
@property (nonatomic,copy) NSString* com_hangye;
@property (nonatomic,copy) NSString* com_adress;
@property (nonatomic,copy) NSString* staffnum;
@property (nonatomic,copy) NSString* com_logo;
@property (nonatomic,copy) NSString* Id;
@property (nonatomic,assign)float  cell_height;

@end

NS_ASSUME_NONNULL_END
