//
//  FBindexTapGestureRecognizer.h
//  EQD
//
//  Created by 梁新帅 on 2017/5/25.
//  Copyright © 2017年 FitBoy. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface FBindexTapGestureRecognizer : UITapGestureRecognizer
@property (nonatomic,assign) NSInteger index;
///根据需要来用
@property (nonatomic,assign) NSInteger selected_obj;
@property (nonatomic,strong)  NSIndexPath *indexPath;
@end
