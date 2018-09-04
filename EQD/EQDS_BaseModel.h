//
//  EQDS_BaseModel.h
//  EQD
//
//  Created by 梁新帅 on 2018/8/30.
//  Copyright © 2018年 FitBoy. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface EQDS_BaseModel : NSObject
/**最新的文章**/
@property (nonatomic,copy) NSString* Id;
@property (nonatomic,copy) NSString* title;
@property (nonatomic,copy) NSString* upname;
@property (nonatomic,copy) NSString* createTime;
-(NSString*)createTime;
@property (nonatomic,assign)  float cellHeight;
/**最新的文章    最新的课程**/
@property (nonatomic,copy) NSString* courseTheme;
@property (nonatomic,copy) NSString* lectureName;
@property (nonatomic,copy) NSString* staffName;
/**最新的课程**/

@end
