//
//  SQLiteManager.swift
//  MyPassword
//
//  Created by 张艳能 on 2018/1/22.
//  Copyright © 2018年 张艳能. All rights reserved.
//

import UIKit

class SQLiteManager: NSObject {
    
    static let instance = SQLiteManager()
    
    class func shareInstance() -> SQLiteManager {
        return instance
    }
    //MARK: - 数据库操作
    //定义数据库变量
    var db : OpaquePointer? = nil
    //打开数据库
    func openDB() -> Bool {
        //数据库文件路径
        let dicumentPath = NSSearchPathForDirectoriesInDomains(FileManager.SearchPathDirectory.documentDirectory, FileManager.SearchPathDomainMask.userDomainMask, true).last
        let DBPath = (dicumentPath! as NSString).appendingPathComponent("myPassword.db")
        let cDBPath = DBPath.cString(using: String.Encoding.utf8)
        //打开数据库
        //第一个参数:数据库文件路径  第二个参数:数据库对象
        if sqlite3_open(cDBPath, &db) != SQLITE_OK {
            YNLog("打开数据库失败")
            return false
        }
        return true;
    }
    
    //执行SQL语句
    func execSQL(SQL : String) -> Bool {
        // 1.将sql语句转成c语言字符串
        let cSQL = SQL.cString(using: String.Encoding.utf8)
        //错误信息
        let errmsg : UnsafeMutablePointer<UnsafeMutablePointer<Int8>?>? = nil
        if sqlite3_exec(db, cSQL, nil, nil, errmsg) == SQLITE_OK {
            return true
        }else{
            YNLog("SQL 语句执行出错 -> 错误信息: 一般是SQL语句写错了 \(String(describing: errmsg))")
            return false
        }
    }
    //执行查询语句
    func queryDBData(querySQL : String) -> [[String : AnyObject]]? {
        //定义游标对象
        var stmt : OpaquePointer? = nil
        
        //将需要查询的SQL语句转化为C语言
        if querySQL.lengthOfBytes(using: String.Encoding.utf8) > 0 {
            let cQuerySQL = (querySQL.cString(using: String.Encoding.utf8))!
            
            if sqlite3_prepare_v2(db, cQuerySQL, -1, &stmt, nil) == SQLITE_OK {
                //准备好之后进行解析
                var queryDataArrM = [[String : AnyObject]]()
                while sqlite3_step(stmt) == SQLITE_ROW {
                    //1.获取 解析到的列(字段个数)
                    let columnCount = sqlite3_column_count(stmt)
                    //2.遍历某行数据
                    var dict = [String : AnyObject]()
                    for i in 0..<columnCount {
                        // 取出i位置列的字段名,作为字典的键key
                        let cKey = sqlite3_column_name(stmt, i)
                        let key : String = String(validatingUTF8: cKey!)!
                        
                        //取出i位置存储的值,作为字典的值value
                        let cValue = sqlite3_column_text(stmt, i)
                        let value =  String(cString:cValue!)
                        dict[key] = value as AnyObject
                    }
                    queryDataArrM.append(dict)
                }
                return queryDataArrM
            }
        }
        return nil
    }

}
