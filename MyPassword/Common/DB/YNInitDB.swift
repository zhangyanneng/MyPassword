//
//  YNInitDB.swift
//  MyPassword
//
//  Created by 张艳能 on 2018/2/5.
//  Copyright © 2018年 张艳能. All rights reserved.
//

import UIKit

class YNInitDB: NSObject {
    
    
    public func initDB () {
    
        if !YNAccountViewModel().isExistTabel() {
            YNAccountViewModel().createAccoutTableToDB()
        }
        
    
    }
    
}
