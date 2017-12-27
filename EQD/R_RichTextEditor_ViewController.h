//
//  R_RichTextEditor_ViewController.h
//  EQD
//
//  Created by 梁新帅 on 2017/12/9.
//  Copyright © 2017年 FitBoy. All rights reserved.
// 富文本编辑框

#import "ZSSRichTextEditor.h"
#import "EQDR_articleListModel.h"
@interface R_RichTextEditor_ViewController : ZSSRichTextEditor
///0 创客空间  1企业空间
@property (nonatomic,copy) NSString* source;
///编辑过来的
@property (nonatomic,strong)  EQDR_articleListModel *model;

//从文集过来的
@property (nonatomic,copy) NSString* articleName;
@property (nonatomic,copy) NSString* menuid;
@end
