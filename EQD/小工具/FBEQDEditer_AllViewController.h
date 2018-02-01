//
//  FBEQDEditer_AllViewController.h
//  EQD
//
//  Created by 梁新帅 on 2018/1/22.
//  Copyright © 2018年 FitBoy. All rights reserved.
//

#import "ZSSRichTextEditor.h"

@interface FBEQDEditer_AllViewController : ZSSRichTextEditor
///1 是易企创  0是易企阅 10 是课程大纲，没有标题
@property (nonatomic,assign) NSInteger temp;
@property (nonatomic,copy) NSString* editor_title;
@property (nonatomic,copy) NSString* editor_htmlText;
@property (nonatomic,strong) NSData  *editor_data;
@property (nonatomic,weak) id delegate;
@end
@protocol FBEQDEditer_AllViewControllerDlegate <NSObject>
-(void)getEditerTitle:(NSString*)title html:(NSString*)html text:(NSString*)text imgurl:(NSString*)imgurl stringData:(NSData*)data;
@end

