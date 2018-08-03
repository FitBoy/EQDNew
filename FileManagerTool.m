//
//  FileManagerTool.m
//  EQD
//
//  Created by 梁新帅 on 2018/5/9.
//  Copyright © 2018年 FitBoy. All rights reserved.
//
#import "FileManagerTool.h"
#import "MBFadeAlertView.h"
@implementation FileManagerTool
-(NSString*)fileManagerName
{
    return @"FileManagerModel";
}
-(NSString*)fileModelName
{
    return @"FileManager";

}
-(NSManagedObjectContext*)context
{
    if(!_context)
    {
     
        
        //1、创建模型对象
        //获取模型路径
        NSURL *modelURL = [[NSBundle mainBundle] URLForResource:self.fileManagerName withExtension:@"momd"];
        //根据模型文件创建模型对象
        NSManagedObjectModel *model = [[NSManagedObjectModel alloc] initWithContentsOfURL:modelURL];
        
        //2、创建持久化存储助理：数据库
        //利用模型对象创建助理对象
    NSPersistentStoreCoordinator   *store = [[NSPersistentStoreCoordinator alloc] initWithManagedObjectModel:model];
        ///获取数据库的路径
        NSString *docStr = [NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES) lastObject];
        NSString *sqlPath = [docStr stringByAppendingPathComponent:@"coreData.sqlite"];
        
        NSError *error = nil;
        NSURL *sqlUrl = [NSURL fileURLWithPath:sqlPath];
        [store addPersistentStoreWithType:NSSQLiteStoreType configuration:nil URL:sqlUrl options:nil error:&error];
        
        if (error) {
            NSLog(@"添加数据库失败:%@",error);
          /*  MBFadeAlertView *alert = [[MBFadeAlertView alloc]init];
            [alert showAlertWith:@"添加数据失败"];*/
        } else {
          /*  MBFadeAlertView *alert = [[MBFadeAlertView alloc]init];
            [alert showAlertWith:@"添加数据成功"];*/
            NSLog(@"添加数据库成功");
        }
        NSManagedObjectContext *context = [[NSManagedObjectContext alloc] initWithConcurrencyType:NSMainQueueConcurrencyType];
        context.persistentStoreCoordinator = store;
        _context = context;
        
    }
    return _context;
}
-(NSArray*)getDataWithReg:(NSPredicate*)reg
{
    //创建查询请求
    NSFetchRequest *request = [NSFetchRequest fetchRequestWithEntityName:@"FileManager"];
    request.predicate = reg;
    // 从第几页开始显示
    // 通过这个属性实现分页
    //request.fetchOffset = 0;
    
    // 每页显示多少条数据
    //request.fetchLimit = 6;
    
    NSError *error = nil;
    //发送查询请求,并返回结果
    NSArray *resArray = [self.context executeFetchRequest:request error:&error];
    if (error) {
        return nil;
    }else{
    return resArray;
    }
}

//插入数据
- (void)insertDataWithfileData:(NSDictionary*)dic{
   FileManager *fileM = [NSEntityDescription insertNewObjectForEntityForName:self.fileModelName inManagedObjectContext:self.context];
    NSDateFormatter  *dateFormatter = [[NSDateFormatter alloc]init];
    [dateFormatter setDateFormat:@"yyyy-MM-dd HH:mm:ss"];
    NSString *time = [dateFormatter stringFromDate:[NSDate date]];
    fileM.creatTime = time;
    fileM.deleteTime = @" ";
    fileM.isDelete = NO;
    fileM.type = dic[@"type"];
    fileM.url = dic[@"url"];
    fileM.userGuid = dic[@"userGuid"];
    
    //查询所有数据的请求
    NSFetchRequest *request = [NSFetchRequest fetchRequestWithEntityName:self.fileModelName];
    NSArray *resArray = [self.context executeFetchRequest:request error:nil];
    
    //   3.保存插入的数据
    NSError *error = nil;
    if ([self.context save:&error]) {
     /*   MBFadeAlertView *alert = [[MBFadeAlertView alloc]init];
        [alert showAlertWith:@"数据保存成功"];*/
    }else{
       /* MBFadeAlertView *alert = [[MBFadeAlertView alloc]init];
        [alert showAlertWith:@"数据保存失败"];*/
    }
    
}

-(NSArray*)getAllData
{
    NSFetchRequest *request = [NSFetchRequest fetchRequestWithEntityName:self.fileModelName];
    return [self.context executeFetchRequest:request error:nil];
}
//删除
- (void)deleteDataWithreg:(NSPredicate*)reg{
    
    //创建删除请求
    NSFetchRequest *deleRequest = [NSFetchRequest fetchRequestWithEntityName:self.fileModelName];
    
    //删除条件
    deleRequest.predicate = reg;
    
    //返回需要删除的对象数组
    NSArray *deleArray = [self.context executeFetchRequest:deleRequest error:nil];
    
    //从数据库中删除
    for (FileManager *stu in deleArray) {
        [self.context deleteObject:stu];
    }
    
    //没有任何条件就是读取所有的数据
    NSFetchRequest *request = [NSFetchRequest fetchRequestWithEntityName:self.fileModelName];
    
    
    NSError *error = nil;
    //保存--记住保存
    if ([self.context save:&error]) {
        MBFadeAlertView *alert = [[MBFadeAlertView alloc]init];
        [alert showAlertWith:@"删除成功"];
    }else{
        MBFadeAlertView *alert = [[MBFadeAlertView alloc]init];
        [alert showAlertWith:@"删除失败"];
    }
    
}

//更新，修改
- (void)updateDataWithreg:(NSPredicate*)reg filedata:(FileManager*)filedata{
    
    //创建查询请求
    NSFetchRequest *request = [NSFetchRequest fetchRequestWithEntityName:self.fileModelName];
    
    
    request.predicate = reg;
    
    //发送请求
    NSArray *resArray = [self.context executeFetchRequest:request error:nil];
    
    //修改
    for (FileManager *stu in resArray) {
        stu.creatTime = filedata.creatTime;
        stu.deleteTime= filedata.deleteTime;
        stu.isDelete = filedata.isDelete ;
        stu.type = filedata.type;
        stu.url = filedata.url;
        stu.userGuid = filedata.userGuid;
    }
    

    
    //保存
    NSError *error = nil;
    if ([self.context save:&error]) {
        MBFadeAlertView *alert = [[MBFadeAlertView alloc]init];
        [alert showAlertWith:@"更新数据成功"];
    }else{
        MBFadeAlertView *alert = [[MBFadeAlertView alloc]init];
        [alert showAlertWith:@"更新数据失败"];
    }
    
    
}
@end
