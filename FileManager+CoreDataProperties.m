//
//  FileManager+CoreDataProperties.m
//  EQD
//
//  Created by 梁新帅 on 2018/5/9.
//  Copyright © 2018年 FitBoy. All rights reserved.
//
//

#import "FileManager+CoreDataProperties.h"

@implementation FileManager (CoreDataProperties)

+ (NSFetchRequest<FileManager *> *)fetchRequest {
	return [[NSFetchRequest alloc] initWithEntityName:@"FileManager"];
}

@dynamic creatTime;
@dynamic deleteTime;
@dynamic isDelete;
@dynamic type;
@dynamic url;
@dynamic userGuid;

@end
