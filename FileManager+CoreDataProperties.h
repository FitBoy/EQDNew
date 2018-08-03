//
//  FileManager+CoreDataProperties.h
//  EQD
//
//  Created by 梁新帅 on 2018/5/9.
//  Copyright © 2018年 FitBoy. All rights reserved.
//
//

#import "FileManager+CoreDataClass.h"


NS_ASSUME_NONNULL_BEGIN

@interface FileManager (CoreDataProperties)

+ (NSFetchRequest<FileManager *> *)fetchRequest;

@property (nullable, nonatomic, copy) NSString *creatTime;
@property (nullable, nonatomic, copy) NSString *deleteTime;
@property (nonatomic) BOOL isDelete;
@property (nullable, nonatomic, copy) NSString *type;
@property (nullable, nonatomic, copy) NSString *url;
@property (nullable, nonatomic, copy) NSString *userGuid;

@end

NS_ASSUME_NONNULL_END
