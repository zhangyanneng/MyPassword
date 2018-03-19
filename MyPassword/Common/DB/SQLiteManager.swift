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
        
        if sqlite3_open(cDBPath, &db) != SQLITE_OK {
            YNLog("打开数据库失败")
            return false
        }
        
        sqlite3_busy_handler(db, { (ptr,count) in
            
            usleep(500000)//如果获取不到锁，表示数据库繁忙，等待0.5秒
            print("sqlite is locak now,can not write/read.")
            return 1   //回调函数返回值为1，则将不断尝试操作数据库。
            
        }, &db)
        
        return true;
    }
    
    func closeDB() {
        sqlite3_close(db)
        db = nil
    }
    
    /// 执行数据库操作(不能解析data等类型的属性)
    /// - Parameter sql:  条件
    /// - Returns:  是否成功
    func execSql(sql:String)->Bool {
        
        objc_sync_enter(self)
        if  !self.openDB() {
            objc_sync_exit(self)
            return false
        }
        var err: UnsafeMutablePointer<Int8>? = nil
        if sqlite3_exec(db,sql.cString(using: String.Encoding.utf8)!,nil,nil,&err) != SQLITE_OK {
            if let error = String(validatingUTF8:sqlite3_errmsg(db)) {
                print("execute failed to execute  Error: \(error)")
            }
            objc_sync_exit(self)
            return false
        }
        
        objc_sync_exit(self)
        return true
    }
    
    public  func querySql(sql:String) -> [[String:Any]]? {
        objc_sync_enter(self)
        if  !self.openDB() {
            objc_sync_exit(self)
            return nil
        }
        var arr:[[String:Any]] = []
        var  statement: OpaquePointer? = nil
        if sqlite3_prepare_v2(db,sql.cString(using: String.Encoding.utf8)!,-1,&statement,nil) == SQLITE_OK {
            while sqlite3_step(statement) == SQLITE_ROW {
                let columns = sqlite3_column_count(statement)
                var row:[String:Any] = Dictionary()
                for i in 0..<columns {
                    let type = sqlite3_column_type(statement, i)
                    let chars = UnsafePointer<CChar>(sqlite3_column_name(statement, i))
                    let name =  String.init(cString: chars!, encoding: String.Encoding.utf8)
                    
                    var value: Any
                    switch type {
                    case SQLITE_INTEGER:
                        value = sqlite3_column_int(statement, i)
                    case SQLITE_FLOAT:
                        value = sqlite3_column_double(statement, i)
                    case SQLITE_TEXT:
                        let chars = UnsafePointer<CUnsignedChar>(sqlite3_column_text(statement, i))
                        value = String.init(cString: chars!)
                        
                    case SQLITE_BLOB:
                        let data = sqlite3_column_blob(statement, i)
                        let size = sqlite3_column_bytes(statement, i)
                        value = NSData(bytes:data, length:Int(size))
                    default:
                        value = ""
                        ()
                    }
                    
                    row.updateValue(value, forKey: "\(name!)")
                }
                arr.append(row)
            }
        }
        sqlite3_finalize(statement)
        
        objc_sync_exit(self)
        if arr.count == 0 {
            return nil
        }else{
            return arr
        }
        
    }
    
    /// 引入事务操作
    ///
    /// - Parameter exec: 事务回调
    public func doTransaction(exec: ((_ db:OpaquePointer)->())?) {
        objc_sync_enter(self)
        if  !self.openDB() {
            objc_sync_exit(self)
            return
        }
        if exec != nil {
            var err: UnsafeMutablePointer<Int8>? = nil
            if sqlite3_exec(db, "BEGIN TRANSACTION", nil, nil, &err) == SQLITE_OK {
                exec!(db!)
                if sqlite3_exec(db, "COMMIT TRANSACTION", nil, nil, &err) == SQLITE_OK {
                    print("提交事务成功")
                }else {
                    print("提交事务失败原因\(String(describing: err))")
                    if let error = String(validatingUTF8:sqlite3_errmsg(db)) {
                        print("execute failed to execute  Error: \(error)")
                    }
                    if sqlite3_exec(db, "ROLLBACK TRANSACTION", nil, nil, &err) == SQLITE_OK {
                        print("回滚事务成功")
                    }
                }
            }else {
                if sqlite3_exec(db, "ROLLBACK TRANSACTION", nil, nil, &err) == SQLITE_OK {
                    print("回滚事务成功")
                }
            }
            sqlite3_free(err)
            
        }
        
        objc_sync_exit(self)
    }
    
    /// 执行数据库的操作（主要解析表中带有data类型字段）
    ///
    /// - Parameters:
    ///   - sql: 条件
    ///   - params:  条件对应的value值
    /// - Returns: 条件影响的行数
    public func alltypeExecute(sql:String, params:[Any]?)->CInt {
        objc_sync_enter(self)
        var result:CInt = 0
        if let stmt = self.bindSqlType(sql:sql, params:params) {
            result = self.executeStepSql(stmt:stmt, sql:sql)
        }
        
        objc_sync_exit(self)
        return result
    }
    
    /// 判断操作数据库的方式
    ///
    /// - Parameters:
    ///   - stmt: 含有解析过sql条件的结构体
    ///   - sql: 原始条件
    /// - Returns: 所操作的好书
    private func executeStepSql(stmt:OpaquePointer, sql:String)->CInt {
        
        var result = sqlite3_step(stmt)
        if result != SQLITE_OK && result != SQLITE_DONE {
            sqlite3_finalize(stmt)
            if let error = String(validatingUTF8:sqlite3_errmsg(db)) {
                print("execute failed to execute  Error: \(error)")
            }
            return 0
        }
        
        let bigSql = sql.uppercased()
        if bigSql.hasPrefix("INSERT ") {
            result = CInt(sqlite3_last_insert_rowid(db))
        } else if bigSql.hasPrefix("DELETE") || bigSql.hasPrefix("UPDATE") {
            var count = sqlite3_changes(db)
            if count == 0 {
                count += 1
            }
            result = CInt(count)
        } else {
            result = 1
        }
        
        sqlite3_finalize(stmt)
        return result
    }
    
    /// 将sql中的数据类型解析
    ///
    /// - Parameters:
    ///   - sql: 条件
    ///   - params: 条件对应的value值
    /// - Returns: 解析结果绑定的结构体
    private func bindSqlType(sql:String, params:[Any]?) -> OpaquePointer? {
        
        if  !self.openDB() {
            return nil
        }
        
        var stmt:OpaquePointer? = nil
        let someCharChar = unsafeBitCast(-1, to:sqlite3_destructor_type.self)
        let result = sqlite3_prepare_v2(db, sql.cString(using: String.Encoding.utf8)!, -1, &stmt, nil)
        if result != SQLITE_OK {
            sqlite3_finalize(stmt)
            if let error = String(validatingUTF8:sqlite3_errmsg(db)) {
                print("execute failed to execute  Error: \(error)")
            }
            return nil
        }
        
        if let  params = params {
            
            let count = CInt(params.count)
            if sqlite3_bind_parameter_count(stmt)  == count {
                var result:CInt = 0
                
                for index in 1...count {
                    
                    if let txt = params[Int(index)-1] as? String {
                        result = sqlite3_bind_text(stmt, CInt(index), txt, -1, someCharChar)
                    } else if let data = params[Int(index)-1] as? NSData {
                        result = sqlite3_bind_blob(stmt, CInt(index), data.bytes, CInt(data.length), someCharChar)
                    }else if let val = params[Int(index)-1] as? Double {
                        result = sqlite3_bind_double(stmt, CInt(index), CDouble(val))
                    } else if let val = params[Int(index)-1] as? Int {
                        result = sqlite3_bind_int64(stmt, index, Int64(val))
                    } else {
                        result = sqlite3_bind_null(stmt, CInt(index))
                    }
                    
                    if result != SQLITE_OK {
                        sqlite3_finalize(stmt)
                        if let error = String(validatingUTF8:sqlite3_errmsg(db)) {
                            print("execute failed to execute  Error: \(error)")
                        }
                        return nil
                    }
                }
            }
            
        }
        return stmt
    }
    
    
    deinit {
        closeDB()
    }

}
