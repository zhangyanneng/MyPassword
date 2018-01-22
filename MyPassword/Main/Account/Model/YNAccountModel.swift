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
    init(dict:[String : AnyObject]) {
        super.init()
        
        setValuesForKeys(dict)
    }
    
    override func setValue(_ value: Any?, forUndefinedKey key: String) {
        
    }

}
