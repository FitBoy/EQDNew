//
//  FBTextFieldTableViewCell.h
//  EQD
//
//  Created by 梁新帅 on 2017/7/15.
//  Copyright © 2017年 FitBoy. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface FBTextFieldTableViewCell : UITableViewCell
@property (nonatomic,strong)  UITextField *TF_text;
-(void)setPlaceHolder:(NSString*)placeholder;
@end
