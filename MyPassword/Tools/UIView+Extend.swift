//
//  UIView+Extend.swift
//  MyPassword
//
//  Created by 张艳能 on 2018/1/23.
//  Copyright © 2018年 张艳能. All rights reserved.
//

import UIKit

extension UIView {
    
    var size:CGSize {
        get{
            return self.frame.size
        }
        set{
            self.frame.size = newValue
        }
    }
    
    var origin:CGPoint {
        get{
            return self.frame.origin
        }
        set{
            self.frame.origin = newValue
        }
    }
    
    var width:CGFloat {
        get {
            return self.frame.size.width
        }
        set {
            self.frame.size.width = newValue
        }
    }
    
    var height:CGFloat {
        get {
            return self.frame.size.height
        }
        set {
            self.frame.size.height = newValue
        }
    }
    
    var y:CGFloat {
        get {
            return self.frame.origin.y
        }
        set {
            self.frame.origin.y = newValue
        }
    }
    
    var x:CGFloat {
        get {
            return self.frame.origin.x
        }
        set {
            self.frame.origin.x = newValue
        }
    }
   
}
