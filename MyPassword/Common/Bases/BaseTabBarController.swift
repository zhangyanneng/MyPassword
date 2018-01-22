//
//  BaseTabBarController.swift
//  YNMobileProject
//
//  Created by zyn on 2016/11/15.
//  Copyright © 2016年 张艳能. All rights reserved.
//

import UIKit

class BaseTabBarController: UITabBarController {

    override func viewDidLoad() {
        super.viewDidLoad()
        //添加控制器
        addChildViewController()
        
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

}

extension BaseTabBarController {
    
    fileprivate func addChildViewController() {
        
        addChildViewController(YNAccountViewController(), title: "账号", image: "icon_tabbar_component", selectImage: "icon_tabbar_component_selected")
        addChildViewController(YNToolboxViewController(), title: "工具", image: "icon_tabbar_lab", selectImage: "icon_tabbar_lab_selected")
        addChildViewController(YNSettingViewController(), title: "设置", image: "icon_tabbar_uikit", selectImage: "icon_tabbar_uikit_selected")
    
    }
    
    fileprivate func addChildViewController(_ childController: UIViewController,title: String, image: String, selectImage: String) {
        let nav = BaseNavigationController(rootViewController: childController)
        nav.title = title
        nav.tabBarItem = UITabBarItem(title: title, image:  UIImage(named: image), selectedImage: UIImage(named: selectImage))
        addChildViewController(nav);
    }
    
}
