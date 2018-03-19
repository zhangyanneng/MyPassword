//
//  RateViewController.swift
//  MyPassword
//
//  Created by 张艳能 on 2018/3/19.
//  Copyright © 2018年 张艳能. All rights reserved.
//

import UIKit
import Alamofire

class RateViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()

        self.view.backgroundColor = .white
        
        
        //获取汇率的接口： http://api.fixer.io/latest?base=USD
        
//         Alamofire.request("http://api.fixer.io/latest?base=USD")
        
        let request = Alamofire.request("https://api.fixer.io/latest?base=USD")
        
        request.responseJSON { (json) in
            
            YNLog(json)
        }
        
        
        
        
        
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */

}
