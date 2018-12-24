//
//  EQDS_courseNewModel.h
//  EQD
//
//  Created by 梁新帅 on 2018/12/18.
//  Copyright © 2018 FitBoy. All rights reserved.
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

@interface EQDS_courseNewModel : NSObject
@property (nonatomic,copy) NSString* Id;
@property (nonatomic,copy) NSString*courseImages;
@property (nonatomic,copy) NSString* courseObjecter;
@property (nonatomic,copy) NSString* coursePrice;
@property (nonatomic,copy) NSString* courseTheme;
@property (nonatomic,copy) NSString* courseTimes;
@property (nonatomic,copy) NSString* courseType;
@property (nonatomic,copy) NSString* coursetIndustry;
@property (nonatomic,copy) NSString* createTime;
@property (nonatomic,copy) NSString* lectureName;
@property (nonatomic,copy) NSString* pageViews;
@property (nonatomic,copy) NSString* userGuid;

@property (nonatomic,assign) float cell_height;

@end

NS_ASSUME_NONNULL_END
