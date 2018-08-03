//
//  FileManagerTool.h
//  EQD
//
//  Created by 梁新帅 on 2018/5/9.
//  Copyright © 2018年 FitBoy. All rights reserved.
//
/* 谓词的条件指令
 1.比较运算符 > 、< 、== 、>= 、<= 、!=
 例：@"number >= 99"
 
 2.范围运算符：IN 、BETWEEN
 例：@"number BETWEEN {1,5}"
 @"address IN {'shanghai','nanjing'}"
 
 3.字符串本身:SELF
 例：@"SELF == 'APPLE'"
 
 4.字符串相关：BEGINSWITH、ENDSWITH、CONTAINS
 例：  @"name CONTAIN[cd] 'ang'"  //包含某个字符串
 @"name BEGINSWITH[c] 'sh'"    //以某个字符串开头
 @"name ENDSWITH[d] 'ang'"    //以某个字符串结束
 
 5.通配符：LIKE
 例：@"name LIKE[cd] '*er*'"   //代表通配符,Like也接受[cd].
 @"name LIKE[cd] '???er*'"
 
 *注*: 星号 "*" : 代表0个或多个字符
 问号 "?" : 代表一个字符
 
 6.正则表达式：MATCHES
 例：NSString *regex = @"^A.+e$"; //以A开头，e结尾
 @"name MATCHES %@",regex
 
 注:[c]*不区分大小写 , [d]不区分发音符号即没有重音符号, [cd]既不区分大小写，也不区分发音符号。
 
 7. 合计操作
 ANY，SOME：指定下列表达式中的任意元素。比如，ANY children.age < 18。
 ALL：指定下列表达式中的所有元素。比如，ALL children.age < 18。
 NONE：指定下列表达式中没有的元素。比如，NONE children.age < 18。它在逻辑上等于NOT (ANY ...)。
 IN：等于SQL的IN操作，左边的表达必须出现在右边指定的集合中。比如，name IN { 'Ben', 'Melissa', 'Nick' }。
 
 提示:
 1. 谓词中的匹配指令关键字通常使用大写字母
 2. 谓词中可以使用格式字符串
 3. 如果通过对象的key
 path指定匹配条件，需要使用%K
 
 */
#import <Foundation/Foundation.h>
#import "FileManager+CoreDataClass.h"
#import <CoreData/CoreData.h>
@interface FileManagerTool : NSObject

@property (nonatomic,strong)  NSManagedObjectContext *context;
@property (nonatomic,copy) NSString* fileManagerName;
@property (nonatomic,copy) NSString* fileModelName;
-(NSString*)fileManagerName;
-(NSString*)fileModelName;
-(NSManagedObjectContext*)context;
///根据正则表达式来查询
-(NSArray*)getDataWithReg:(NSPredicate*)reg;
///插入数据
- (void)insertDataWithfileData:(NSDictionary*)dic;
///删除数据
- (void)deleteDataWithreg:(NSPredicate*)reg;
//更新，修改数据
- (void)updateDataWithreg:(NSPredicate*)reg filedata:(FileManager*)filedata;
///获取所有数据库的数据
-(NSArray*)getAllData;
@end
