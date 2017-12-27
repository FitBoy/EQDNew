//
//  FBIVLView.h
//  EQD
//
//  Created by 梁新帅 on 2017/3/21.
//  Copyright © 2017年 FitBoy. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface FBIVLView : UIView
@property (nonatomic,strong) UIImageView *IV_img;
@property (nonatomic,strong) UILabel *L_name;
-(instancetype)initWithimg:(NSString*)img andName:(NSString*)name;
@end
