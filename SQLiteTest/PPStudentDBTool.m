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
        BOOL isCreate = [_db executeUpdate:@"create table if not exists t_student (id integer primary key,name text not null,age integer not null);"];
        if (isCreate) {
            NSLog(@"create table success");
        }
    }
}

// 插入数据
+ (void)insertWithStudent:(PPStudent *)student {
    BOOL isInsert = [_db executeUpdateWithFormat:@"insert into t_student (name,age) values (%@, %@);", student.name, student.age];
    if (isInsert) NSLog(@"insert success");
}

// 修改数据
+ (void)updateStudent:(PPStudent *)student {
    BOOL isUpdate = [_db executeUpdateWithFormat:@"update t_student set name = %@, age = %@ where id = 2;", student.name, student.age];
    if (isUpdate) {
        NSLog(@"update success");
    }
}

+ (void)queryAllStudent {
    FMResultSet *result = [_db executeQuery:@"select * from t_student;"];
    while ([result next]) {// 有记录时
        NSString *name = [result stringForColumn:@"name"];
        int age = [result intForColumn:@"age"];
        NSLog(@"name = %@, age = %d", name, age);
    }
}


@end
