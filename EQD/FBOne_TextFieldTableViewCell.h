//
//  FBOne_TextFieldTableViewCell.h
//  EQD
//
//  Created by 梁新帅 on 2017/7/18.
//  Copyright © 2017年 FitBoy. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "FBindexPathTextField.h"
/*带有名字有输入框的cell*/
@interface FBOne_TextFieldTableViewCell : UITableViewCell
@property (nonatomic,strong)  UIView *V_bg;
@property (nonatomic,strong)  UILabel *L_name;
@property (nonatomic,strong)  FBindexPathTextField *TF_contents;
@end
