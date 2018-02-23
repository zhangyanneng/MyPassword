//
//  YNAccountViewModel.swift
//  MyPassword
//
//  Created by 张艳能 on 2018/1/26.
//  Copyright © 2018年 张艳能. All rights reserved.
//

import UIKit

class YNAccountViewModel: NSObject {
    
    var accountModel: YNAccountModel?
    
    var rowHeight:CGFloat = 0
    
    public func insertAccountModelToDB() {
        
        let sql = "insert "
        
        
        
        
    }
    
    public func createAccoutTableToDB() {
        let sql = "create table Account(" +
                    "id integer PRIMARY KEY autoincrement," +
                    "account varchar(500) NOT NULL," +
                    "name varchar(200)," +
                    "password varchar(500)," +
                    "createDate varchar(100)," +
                    "type int," +
                    "mark varchar(1000))"
        
       let _ = SQLiteManager.shareInstance().execSql(sql: sql)
    }
    
    public func isExistTabel() -> Bool {
        
        let sql = "SELECT name FROM sqlite_master where type='table' and name = 'Account'"
        
        let arr: NSArray? = SQLiteManager.shareInstance().querySql(sql: sql) as NSArray?
        
        if arr?.firstObject == nil {
            return false
        } else {
            return true
        }

    }
    
    public func deleteAccountTableToDB() {
        
    }
    
    public func selectAccountToDB(page: NSInteger, pageSize: NSInteger) -> NSArray {
        let arr = NSArray()
        
        
        return arr;
    }
    
    
    
    
    //设置示例数据
    class func accountDatas() -> NSArray {
        
        let arrM:NSMutableArray = NSMutableArray()
        
        for index in 0...8 {
            
            let account: YNAccountModel = YNAccountModel()
            account.account = "9999\(index+1)"
            account.password = "66666\(index)"
            account.type = .NORMAL
            account.name = "me"
            account.mark = "QQ"
            
            let accountVM:YNAccountViewModel = YNAccountViewModel()
            accountVM.accountModel = account;
            accountVM.rowHeight = 60;
            
            arrM.add(accountVM)
        }
        
        return arrM.copy() as! NSArray
    }
}
