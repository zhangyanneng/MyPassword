//
//  YNAccountViewController.swift
//  MyPassword
//
//  Created by 张艳能 on 2018/1/17.
//  Copyright © 2018年 张艳能. All rights reserved.
//

import UIKit

class YNAccountViewController: BaseViewController {
    
    var accountArrays:NSArray = YNAccountViewModel.accountDatas()
    
    override func viewDidLoad() {
        super.viewDidLoad()

        initDefault()
       
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
        tableView.estimatedRowHeight = 60
        tableView.tableFooterView = UIView()
        return tableView;
    }()
    
}

extension YNAccountViewController: UITableViewDelegate,UITableViewDataSource {
    
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        
        return self.accountArrays.count;
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        var cell: YNAccountTableViewCell? = tableView.dequeueReusableCell(withIdentifier: "cell_identifier") as? YNAccountTableViewCell
        if cell == nil {
            cell = YNAccountTableViewCell (style: .subtitle, reuseIdentifier: "cell_identifier")
        }
        
        let vModel: YNAccountViewModel = self.accountArrays[indexPath.row] as! YNAccountViewModel;
        cell?.accountModel = vModel
        return cell!;
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        
        let vModel: YNAccountViewModel = self.accountArrays[indexPath.row] as! YNAccountViewModel;
        
        vModel.rowHeight = vModel.rowHeight < 100 ? 100 : 60
        
        tableView .reloadRows(at: [indexPath], with: .automatic)
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        let vModel: YNAccountViewModel = self.accountArrays[indexPath.row] as! YNAccountViewModel
        return vModel.rowHeight
    }
    
    
}



