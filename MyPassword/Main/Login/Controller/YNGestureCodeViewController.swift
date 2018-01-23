//
//  YNGestureCodeViewController.swift
//  MyPassword
//
//  Created by 张艳能 on 2018/1/23.
//  Copyright © 2018年 张艳能. All rights reserved.
//

import UIKit

class YNGestureCodeViewController: BaseViewController {

    override func viewDidLoad() {
        super.viewDidLoad()

        view.addSubview(self.gestureView)
        
        self.gestureView.passwordBlock = { (str) in

            YNLog(str)
        }
        
    }
    
    lazy var gestureView: YNGestureCodeView =  {() -> YNGestureCodeView in
        let gView = YNGestureCodeView(frame: CGRect(x: 0, y: 100, width: yn_screenWidth, height: yn_screenWidth))
        
        return gView
    }()

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

}
