//
//  FBindexpathLongPressGestureRecognizer.h
//  EQD
//
//  Created by 梁新帅 on 2017/4/27.
//  Copyright © 2017年 FitBoy. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface FBindexpathLongPressGestureRecognizer : UILongPressGestureRecognizer
@property (nonatomic,strong)  NSIndexPath *indexPath;
@property (nonatomic,assign) NSInteger index;
@end
