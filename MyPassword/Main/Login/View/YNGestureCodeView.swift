//
//  YNGestureCodeView.swift
//  MyPassword
//
//  Created by 张艳能 on 2018/1/23.
//  Copyright © 2018年 张艳能. All rights reserved.
//

import UIKit

class YNGestureCodeView: UIView {

    var path:UIBezierPath =  UIBezierPath()
    
    //存储已经路过的点
    var pointsArr = [CGPoint]()
    //当前手指所在点
    var fingurePoint:CGPoint!

    var passwordArr : [Int] = [Int]()

    var password:String{
        get{
            var str = ""
            for p in passwordArr{
                str.append(String(p))
            }
            return str
        }
    }
    
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
            button.isUserInteractionEnabled = false
            button.tag = index
            
            self.addSubview(button)
        }
        //MARK: 初始化路径
        self.path.lineWidth = 10
        self.path.lineCapStyle = .round
        self.path.lineJoinStyle = .round
        
    }
    
    //MARK: 绘制
    override func draw(_ rect: CGRect) {
        self.path.removeAllPoints()
        for (index,point) in self.pointsArr.enumerated(){
            
            if index == 0{
                self.path.move(to: point)
            }else{
                self.path.addLine(to: point)
            }
            
        }
        //让画线跟随手指
        if self.fingurePoint != CGPoint.zero && self.pointsArr.count > 0{
            self.path.addLine(to: self.fingurePoint)
        }
        
        UIColor.lightGray.setStroke()
        self.path.stroke()
    }
}

extension YNGestureCodeView {
    
    func touchChanged(touch:UITouch){
        let point = touch.location(in: self)
        
        self.fingurePoint = point
        
        for button in self.subviews{
            
            if button.isKind(of: UIButton.self) && !self.pointsArr.contains(button.center) && button.frame.contains(point){
                
                self.passwordArr.append(button.tag)
                
                self.pointsArr.append(button.center)
                
                button.backgroundColor  =  UIColor.gray
            }
            
        }
        
        self.setNeedsDisplay()
    }
    
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        
        self.passwordArr.removeAll()
        
        self.touchChanged(touch: touches.first!)
    }
    
    override func touchesMoved(_ touches: Set<UITouch>, with event: UIEvent?) {
        self.touchChanged(touch: touches.first!)
    }
    
    override func touchesEnded(_ touches: Set<UITouch>, with event: UIEvent?) {
        
        if passwordBlock != nil {
            passwordBlock!(self.password)
        }
        
        self.path.removeAllPoints()
        self.pointsArr.removeAll()
//        self.passwordArr.removeAll()
        self.fingurePoint = CGPoint.zero
        self.setNeedsDisplay()
        for button in self.subviews{
            
            button.backgroundColor  =  UIColor.white
        }
    }
    
    override func touchesCancelled(_ touches: Set<UITouch>, with event: UIEvent?) {
        
        self.path.removeAllPoints()
        self.pointsArr.removeAll()
//        self.passwordArr.removeAll()
        self.fingurePoint = CGPoint.zero
        self.setNeedsDisplay()
        for button in self.subviews{
            
            button.backgroundColor  =  UIColor.white
        }
    }
    
    
    
}
