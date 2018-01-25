//
//  YNToolboxViewController.swift
//  MyPassword
//
//  Created by 张艳能 on 2018/1/17.
//  Copyright © 2018年 张艳能. All rights reserved.
//

import UIKit

class YNToolboxViewController: BaseViewController {
    
    let kCellIdentifier = "toolbox_cell_identifier"
    
    let dataArray = ["手势密码","记账","汇率计算","拍照翻译","扫一扫"]

    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        title = "工具"
        
        view.addSubview(tableview)
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    

    fileprivate lazy var tableview: UITableView = {() -> UITableView in
        let tableView = UITableView(frame: view.bounds, style: .plain)
        tableView.delegate = self;
        tableView.dataSource = self;
        tableView.tableFooterView = UIView()
        tableView .register(UITableViewCell.self, forCellReuseIdentifier: kCellIdentifier)
        
        return tableView;
    }()

}

extension YNToolboxViewController: UITableViewDelegate,UITableViewDataSource {
    
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        
        return dataArray.count;
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: kCellIdentifier)
        cell?.textLabel?.text = dataArray[indexPath.row]
        return cell!;
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        
        if indexPath.row == 0 {
            self.navigationController?.pushViewController(YNGestureCodeViewController(), animated: true)
        }
    }
    
    
    
}
