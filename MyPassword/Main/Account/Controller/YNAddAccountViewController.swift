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
        view.addSubview(safeLabel)
        view.addSubview(safeSwitch)
        
        let  width = yn_screenWidth - 30
        
        accountTextField.frame = CGRect(x: 15, y: 100, width: width, height: 21);
        passwordTextField.frame = CGRect(x: 15, y: accountTextField.y + 50, width: width, height: 21)
        rePasswordTextField.frame = CGRect(x: 15, y: passwordTextField.y + 50, width: width, height: 21)
        
        safeLabel.frame = CGRect(x: 15, y: rePasswordTextField.y + 50, width: 100, height: 21)
        safeSwitch.x = safeLabel.right + 15;
        safeSwitch.centerY = safeLabel.centerY
        
    }
    
    //MARK: lazy method
    lazy var accountTextField: UITextField = {() -> UITextField in
        let account = UITextField()
        account.placeholder = "请输入账号"
        account.borderStyle = .roundedRect
        account.font = UIFont.systemFont(ofSize: 15)
        return account
    }()
    
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
    
    lazy var safeLabel: UILabel  = { () -> UILabel in
        let safeLab = UILabel()
       safeLab.text = "安全加密"
        return safeLab
    }()
    
    lazy var safeSwitch: UISwitch = { () -> UISwitch in
        let safeSwi = UISwitch()
        safeSwi.setOn(true, animated: true)
        return safeSwi;
    }()
    
    @objc
    func closeBtnClick(){
        dismiss(animated: true, completion: nil)
    }

}
