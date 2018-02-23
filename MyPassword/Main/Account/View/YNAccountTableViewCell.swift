//
//  YNAccountTableViewCell.swift
//  MyPassword
//
//  Created by 张艳能 on 2018/1/26.
//  Copyright © 2018年 张艳能. All rights reserved.
//

import UIKit

class YNAccountTableViewCell: UITableViewCell {
    
    var _accountVModel:YNAccountViewModel?
    
    var accountModel:YNAccountViewModel? {
        get {
         
            return _accountVModel
        }
        set {
            _accountVModel = newValue
            
            self.titleLabel.text = _accountVModel?.accountModel?.account
            self.pwdLabel.text = _accountVModel?.accountModel?.password
            self.markLabel.text = _accountVModel?.accountModel?.mark
            
            self.pwdLabel.isHidden = !(_accountVModel?.rowHeight == 100)
        }
    }
    

    
    override init(style: UITableViewCellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        
        contentView.addSubview(titleLabel)
        contentView.addSubview(markLabel)
        contentView.addSubview(pwdLabel)
        
        __layoutSubviews()
        
        self.selectionStyle = .none
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    fileprivate func __layoutSubviews() {
        
        titleLabel.left = 15
        titleLabel.top = 10;
        titleLabel.width = yn_screenWidth - 2 * titleLabel.left
        titleLabel.height = 21
        
        markLabel.left = titleLabel.left
        markLabel.top = titleLabel.bottom + 5
        markLabel.width = titleLabel.width
        markLabel.height = 18
        
        pwdLabel.left = titleLabel.left
        pwdLabel.top = markLabel.bottom + 20
        pwdLabel.width = titleLabel.width
        pwdLabel.height = 21
        
    }
    
    
    
    lazy var titleLabel: UILabel = {() -> UILabel in
        let titleLab = UILabel()
        titleLab.font = UIFont.systemFont(ofSize: 16)
        
        
        return titleLab
        }()
    
    lazy var pwdLabel: UILabel = {() -> UILabel in
        let pwdLab = UILabel()
        pwdLab.font = UIFont.systemFont(ofSize: 14)
        
        
        return pwdLab
    }()
    
    lazy var markLabel: UILabel = {() -> UILabel in
        let markLab = UILabel()
        markLab.font = UIFont.systemFont(ofSize: 14)
        
        
        return markLab
    }()
    
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
