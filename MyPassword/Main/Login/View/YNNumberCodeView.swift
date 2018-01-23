//
//  YNNumberCodeView.swift
//  MyPassword
//
//  Created by 张艳能 on 2018/1/23.
//  Copyright © 2018年 张艳能. All rights reserved.
//

import UIKit

class YNNumberCodeView: UIView {
    
    
    var passwordBlock:((String) -> Void)?

    override init(frame: CGRect) {
        super.init(frame: frame)
        self .setupUI()
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    fileprivate func setupUI() {
        // TODO: 创建视图
        self.backgroundColor = UIColor.white
        let colNum = 3
        var col = 0,row = 0
        
        let width:CGFloat = 60.0
        let height:CGFloat = width
        
        var x:CGFloat = 0
        var y:CGFloat = 0
        
        let space = (self.width - CGFloat(colNum) * width) / 4
        
        for index in 0..<9 {
            //计算当前所在行
            col = index % colNum
            row = index / colNum
            //计算坐标
            x = CGFloat(col) * width + CGFloat(col + 1) * space
            y = CGFloat(row) * width + CGFloat(row + 1) * space
            
            let button = UIButton(frame: CGRect(x: x, y: y, width: width, height: height))
            
            button.layer.borderColor = UIColor.black.cgColor
            button.layer.borderWidth = 4
            button.layer.cornerRadius = button.width * 0.5
            button.layer.masksToBounds = true
            button.tag = index
            button.titleLabel?.textAlignment = .center
            button.setTitle("\(index + 1)", for: .normal)
            button.setTitleColor(UIColor.black, for: .normal)
            
            self.addSubview(button)
        }
    }

}
