//
//  ImgScrollTableViewCell.h
//  EQD
//
//  Created by 梁新帅 on 2018/3/8.
//  Copyright © 2018年 FitBoy. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "FBImgsScrollView.h"
@interface ImgScrollTableViewCell : UITableViewCell
@property (nonatomic,strong)  FBImgsScrollView *imgScrollV; 
-(void)setarr_stringimgs:(NSArray*)arr_stringImgs WithHeight:(float)height;
@end
