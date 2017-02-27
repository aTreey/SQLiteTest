//
//  PPStudentDBTool.m
//  SQLiteTest
//
//  Created by Hongpeng Yu on 2017/2/27.
//  Copyright © 2017年 Hongpeng Yu. All rights reserved.
//

#import "PPStudentDBTool.h"
#import <FMDB.h>
#import "PPStudent.h"

@implementation PPStudentDBTool

// static 修饰全局变量，静态全局变量，外部不能访问，只能是从定义的位置到文件结尾，更加的安全
static FMDatabase *_db;

/**
 先于main 方法调用
 */
+ (void)load {
    
}


/**
 第一次使用该类的时候调用，只调用一次
 创建初始化数据库对象
 */
+ (void)initialize {
    // 创建数据库路径
    NSString *dbPath = [[NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES) lastObject] stringByAppendingPathComponent:@"student.db"];
    
    // 创建数据库对象并打开
    _db = [FMDatabase databaseWithPath:dbPath];
    BOOL isOpen = [_db open];
    if (isOpen) {
        // creat
        BOOL isCreate = [_db executeUpdate:@"create table if not exists t_student (id integer primay key,name text not null,age integer not null);"];
        if (isCreate) {
            NSLog(@"create table success");
        }
    }
}


+ (void)insertWithStudent:(PPStudent *)student {
    
}


@end
