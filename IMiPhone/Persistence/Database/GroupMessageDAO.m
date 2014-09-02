////
////  GroupMessageDAO.m
////  IMiPhone
////
////  Created by 王 国良 on 14-8-28.
////  Copyright (c) 2014年 尹晓君. All rights reserved.
////
//
//#import "GroupMessageDAO.h"
//#import "DatabaseConfig.h"
//
//
//@implementation GroupMessageDAO
//
//
//NSString *const tableName = @"groupmessage";
//
//+(GroupMessageDAO*)sharedManager
//{
//    static GroupMessageDAO* sharedMyManager = nil;
//    static dispatch_once_t once;
//    dispatch_once(&once,
//                  ^{
//                      sharedMyManager = [[self alloc] init];
////                      [sharedMyManager createTableIfNotExist:tableName];
//                  }
//                  );
//    return sharedMyManager;
//}
//-(int) create:(GroupMessage *)model
//{
////    NSString *path = [self applicationDocumentsDirectoryFile];
////    
////    if(sqlite3_open([path UTF8String],&db) != SQLITE_OK)
////    {
////        NSAssert(NO, @"open database error");
////    }
////    else{
////        NSString *sqlStr = @"INSERT OR REPLACE INTO "
////    }
//    return 0;
//}
//
//@end
