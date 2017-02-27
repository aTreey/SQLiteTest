//
//  PPStudentDBTool.h
//  SQLiteTest
//
//  Created by Hongpeng Yu on 2017/2/27.
//  Copyright © 2017年 Hongpeng Yu. All rights reserved.
//

#import <Foundation/Foundation.h>
@class PPStudent;

@interface PPStudentDBTool : NSObject

/*新增一条数据*/
+ (void)insertWithStudent:(PPStudent *)student;


/*修改数据*/
+ (void)updateStudent:(PPStudent *)student;

/*查询数据*/
+ (void)queryAllStudent;

@end
