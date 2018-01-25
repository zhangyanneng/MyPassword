//
//  YNAccountViewController.swift
//  MyPassword
//
//  Created by 张艳能 on 2018/1/17.
//  Copyright © 2018年 张艳能. All rights reserved.
//

import UIKit

class YNAccountViewController: BaseViewController {
    
    var accountArrays:NSArray = YNAccountModel.accountDatas()
    
    override func viewDidLoad() {
        super.viewDidLoad()

        initDefault()
        
//        let str = "123456"
//        YNLog("md5:\(str.md5)")
//        YNLog("SHA1:\(str.sha1)")
//        YNLog("sha256:\(str.sha256)")
//        YNLog("sha512:\(str.sha512)")
//        YNLog("hmac:\(str.hmac(algorithm: .MD5, key: "ABFD"))")
       
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    

    fileprivate func initDefault() {
        title = "账号"
        
        navigationItem.rightBarButtonItem = UIBarButtonItem(title: "添加", style: .plain, target: self,  action: #selector(addClick))
        
        //UI
        view .addSubview(self.tableview)
        
    }
    
    
    @objc func addClick() {
        
        present(YNAddAccountViewController(), animated: true) {
            //TODO:
            
        }
    }
    

    fileprivate lazy var tableview: UITableView = {() -> UITableView in
        let tableView = UITableView(frame: view.bounds, style: .plain)
        tableView.delegate = self
        tableView.dataSource = self
        tableView.rowHeight = 60
        tableView.tableFooterView = UIView()
        return tableView;
    }()
    
}

extension YNAccountViewController: UITableViewDelegate,UITableViewDataSource {
    
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        
        return self.accountArrays.count;
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        var cell: UITableViewCell? = tableView.dequeueReusableCell(withIdentifier: "cell_identifier")
        if cell == nil {
            cell = UITableViewCell (style: .subtitle, reuseIdentifier: "cell_identifier")
        }
        
        let model: YNAccountModel = self.accountArrays[indexPath.row] as! YNAccountModel;
        
        cell?.textLabel?.text = model.account
        cell?.detailTextLabel?.text = model.password
        return cell!;
    }
    
    
    
}



