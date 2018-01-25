//
//  YNAccountModel.swift
//  MyPassword
//
//  Created by 张艳能 on 2018/1/19.
//  Copyright © 2018年 张艳能. All rights reserved.
//

import UIKit

enum YNSafeType {
    case NORMAL
    case SPECIAL
}


class YNAccountModel: NSObject {
    
    var name: String?
    var account: String?
    var password: String?
    var createDate: NSDate = NSDate()
    var type: YNSafeType = .NORMAL
    
    //字典转模型
    override init() {
        super.init()
    }
    
    init(dict:[String : AnyObject]) {
        super.init()
        
        setValuesForKeys(dict)
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func setValue(_ value: Any?, forUndefinedKey key: String) {
        
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
            
            arrM .add(account)
        }
        
        return arrM.copy() as! NSArray
    }
    
    
}
