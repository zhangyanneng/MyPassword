//
//  YNAddAccountViewController.swift
//  MyPassword
//
//  Created by 张艳能 on 2018/1/18.
//  Copyright © 2018年 张艳能. All rights reserved.
//

import UIKit

class YNAddAccountViewController: BaseViewController {

    override func viewDidLoad() {
        super.viewDidLoad()

        initNavUI()
        
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    fileprivate func initNavUI() {
        
        let closeBtn = UIButton(type:.custom);
        closeBtn.frame = CGRect(x: 15, y: 30, width: 40, height: 20);
        closeBtn.setTitle("关闭", for: .normal);
        closeBtn.setTitleColor(UIColor.black, for: .normal)
        closeBtn.addTarget(self, action: #selector(closeBtnClick), for: .touchUpInside)
        
        view .addSubview(closeBtn);
        
    }
    
    @objc
    func closeBtnClick(){
        dismiss(animated: true, completion: nil)
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
