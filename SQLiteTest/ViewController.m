//
//  ViewController.m
//  SQLiteTest
//
//  Created by Hongpeng Yu on 2017/2/21.
//  Copyright © 2017年 Hongpeng Yu. All rights reserved.
//

#import "ViewController.h"
#import <sqlite3.h>
#import "PPStudentDBTool.h"
#import "PPStudent.h"

@interface ViewController ()
{
    sqlite3 *_db;
}
@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
//    [self creatTable];
    
//    [self insert];
//    [self delete];
    
//    [self querySQl];
    
    
/**
 使用FMDB

 */
    
//    [self inserStudent];
//    [self inserStudent1];
//    [self inserStudent2];
//    
//    [self updateStudent];
    
    [self queryAll];
    
}

- (void)touchesBegan:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event {
    
}

/*=================使用FMDB=============================**/


#pragma mark 插入一条记录
- (void)inserStudent {
    PPStudent *student1 = [PPStudent new];
    student1.name = @"学生1";
    student1.age = @26;
    [PPStudentDBTool insertWithStudent:student1];
}


- (void)inserStudent1 {
    PPStudent *student1 = [PPStudent new];
    student1.name = @"小王八";
    student1.age = @19;
    [PPStudentDBTool insertWithStudent:student1];
}


- (void)inserStudent2 {
    PPStudent *student1 = [PPStudent new];
    student1.name = @"王大锤";
    student1.age = @27;
    [PPStudentDBTool insertWithStudent:student1];
}

#pragma mark 修改数据

- (void)updateStudent {
    PPStudent *student2 = [PPStudent new];
    student2.name = @"小子李";
    student2.age = @18;
    [PPStudentDBTool updateStudent:student2];
}

#pragma mark 查询

- (void)queryAll {
    [PPStudentDBTool queryAllStudent];
}

/*==================使用SQLite语句创建表===================**/

#pragma mark -
#pragma mark SQL使用

#pragma mark 创建表

/**
 使用C语言的函数，打开数据库之前会判断，如果没有就会创建
 */
- (void)creatTable {
    
    // 获取路径
    NSString *dbPath = [NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES).lastObject stringByAppendingPathComponent:@"my.db"];
    NSLog(@"dbPath = %@", dbPath);
    
    // 打开数据库
    int result = sqlite3_open(dbPath.UTF8String, &_db);
    
    if (result == SQLITE_OK) {
        // 建表
        
        
        NSString *createSQL = @"create table if not exists t_person(id integer primary key,name text not null,age integer not null);";
        
        /**
         创建表函数

         param1  数据的实例
         param2  创建表的sql语句
         param3 callback 回调,及回调参数
         return int值
         */
        
        char *error = NULL;
        sqlite3_exec(_db, createSQL.UTF8String, NULL, NULL, &error);
        
        if (error == NULL) {
            NSLog(@"创建表成功!");
        }
    }
}


#pragma mark 新增数据

- (void)insert {
    NSString *insertSQL = @"insert into t_person(name,age) values ('小草', 22);";
    char *error = NULL;
    sqlite3_exec(_db, insertSQL.UTF8String, NULL, NULL, &error);
    if (error == NULL) {
        NSLog(@"增加数据成功");
    }
}


#pragma mark 删除数据

- (void)delete {
    NSString *deleteSQL = @"delete from t_person where name = '小草';";
    char *error = NULL;
    sqlite3_exec(_db, deleteSQL.UTF8String, NULL, NULL, &error);
    if (error == NULL) {
        NSLog(@"delete success");
    }
}


#pragma mark -
#pragma mark 查询语句

- (void)querySQl {
    NSString *querySQL = @"select name,age from t_person;";
    
    
    /**
     查询函数

     param db 实例
     param zSql#> 查询的SQL语句 description#>
     param nByte#> 执行SQL的长度 一般传入 -1，自己计算长度#>
     param ppStmt#> 结果集 description#>
     param pzTail#> 指针 description#>
     return int 值
     */
    sqlite3_stmt *stmt = NULL;
    int result = sqlite3_prepare_v2(_db, querySQL.UTF8String, -1, &stmt, NULL);
    
    if (result == SQLITE_OK) { // 查询结果有值
        while (sqlite3_step(stmt) == SQLITE_ROW) {// 取出了一条记录
            // 取出每条记录的数据
            const unsigned char *cName = sqlite3_column_text(stmt, 0);
            NSString *name = [[NSString alloc] initWithCString:(const char *)cName encoding:NSUTF8StringEncoding];
            int age = sqlite3_column_int(stmt, 1);
            NSLog(@"结果为name = %@, age = %d", name, age);
        }
    }
}


#pragma mark -
#pragma mark 生成可执行的SQL文件


- (void)generateExecuteSQL {
    NSMutableString *mutableString = [NSMutableString string];
    for (NSInteger i = 0; i < 1000; i++) {
        int productIdValue = arc4random_uniform(1000);
        NSString *productNameValue = [NSString stringWithFormat:@"'iPhone_%d'",1 + arc4random_uniform(8)];
        CGFloat productPriceValue = 3000 + arc4random_uniform(1000);
        [mutableString appendFormat:@"insert into t_product(productId, productName, productPrice) values (%d, %@, %f); \r\n", productIdValue, productNameValue, productPriceValue];
        
    }
    
    NSLog(@"mutableString = %@", mutableString);
    // 写入文件
    [mutableString writeToFile:@"/Users/Apeng/work/Demo/Sqlite/products.sql" atomically:YES encoding:NSUTF8StringEncoding error:NULL];
}


- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


@end
