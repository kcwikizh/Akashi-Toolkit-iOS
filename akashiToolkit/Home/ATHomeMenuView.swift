//
//  ATHomeMenuView.swift
//  akashiToolkit
//
//  Created by LarrySue on 2017/10/25.
//  Copyright © 2017年 kcwikizh. All rights reserved.
//

import UIKit

class ATHomeMenuView: UIView {
    
    var itemList: [ATHomeMenuItemModel] = [] {
        didSet {
            for item in itemList {
                
            }
        }
    }

    override init(frame: CGRect) {
        super.init(frame: frame)
        
        backgroundColor = Constant.ui.color.darkForeground
        
        let logoView = UIImageView(image: UIImage(named: "appLogo"))
        
        addSubview(logoView)
        
        logoView.snp.makeConstraints { (make) in
            make.size.equalTo(CGSize(width: 75.0, height: 75.0))
            make.centerX.equalTo(self)
            make.top.equalTo(Constant.ui.size.topHeight)
        }
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}
