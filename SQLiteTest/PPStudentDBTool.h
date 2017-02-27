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


/**
 插入

 @param student 对象
 */
+ (void)insertWithStudent:(PPStudent *)student;

@end
