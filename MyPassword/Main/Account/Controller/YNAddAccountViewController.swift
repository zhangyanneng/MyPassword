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
        
        initUI()
        
        
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
    
    fileprivate func initUI() {
        
        view.addSubview(accountTextField)
        view.addSubview(passwordTextField)
        view.addSubview(rePasswordTextField)
        view.addSubview(markLabel)
        view.addSubview(markTextView)
        
        let  width = yn_screenWidth - 30
        
        accountTextField.frame = CGRect(x: 15, y: 60 + 20, width: width, height: 21);
        passwordTextField.frame = CGRect(x: 15, y: 111, width: width, height: 21)
        rePasswordTextField.frame = CGRect(x: 15, y: 141, width: width, height: 21);
        
    }
    
    //MARK: lazy method
//    lazy var accountLabel: UILabel = {() -> UILabel in
//        let accountLab = UILabel()
//        accountLab.text = "账号"
//        accountLab.textColor = UIColor.black
//
//        return accountLab
//    }()
    
    lazy var accountTextField: UITextField = {() -> UITextField in
        let account = UITextField()
        account.placeholder = "请输入账号"
        account.borderStyle = .roundedRect
        account.font = UIFont.systemFont(ofSize: 15)
        return account
    }()
    
//    lazy var passwordLabel: UILabel = {() -> UILabel in
//        let passwordLab = UILabel()
//
//        return passwordLab
//    }()
    
    lazy var passwordTextField: UITextField = {() -> UITextField in
        let password = UITextField()
        password.placeholder = "请输入密码"
        password.borderStyle = .roundedRect
        password.font = UIFont.systemFont(ofSize: 15)
        return password
    }()
    
    lazy var rePasswordTextField: UITextField = {() -> UITextField in
        let rePassword = UITextField()
        rePassword.placeholder = "请确认密码"
        rePassword.borderStyle = .roundedRect
        rePassword.font = UIFont.systemFont(ofSize: 15)
        return rePassword
    }()
    
    lazy var markLabel: UILabel = {() -> UILabel in
        let markLab = UILabel()
        
        return markLab
    }()
    
    lazy var markTextView: UITextView = {() -> UITextView in
        let mark = UITextView()
        
        return mark
    }()
    
    
    @objc
    func closeBtnClick(){
        dismiss(animated: true, completion: nil)
    }

}
